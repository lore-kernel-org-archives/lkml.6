Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C140C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC36C222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DbeJkqB8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Lk0Cf7eE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfBMJvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:51:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfBMJvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:51:43 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 008616087F; Wed, 13 Feb 2019 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550051501;
        bh=Vs+50u4QSysEwvPfccTmoCqeFX05ffDTaj3MJz0B670=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=DbeJkqB8CWvtXbT/uiWeOO2OGvim56PFn/yFWnQdTg3pLYMEID8CSPEhOBaM+/Qod
         PakfJVzDlrbOdz40za6Ai4tAUnchk/DdSZEq0yUpO3i0U/cqIkJGHLlTdKqdStxmuR
         4ZivRsfCMaIm89/d5aDYo4DoMCZmC8hagJfd1aAk=
Received: from [10.79.128.39] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9CDC26087F;
        Wed, 13 Feb 2019 09:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550051498;
        bh=Vs+50u4QSysEwvPfccTmoCqeFX05ffDTaj3MJz0B670=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Lk0Cf7eE02GVh2/hv2jM4yg7+BAET8jRgyBDoHlgNTzh/153Uc7pmhY5uRJ0Q9mvu
         FKuFpUYBecuDyepAqDygn+goftI6OKmxRfjqcqMl07dJlyxem1PeGoZpbFMlTC2IHx
         KRvs0sqn9+Bw679Hz1JK4nqAFFpOXRbgP0J6AGGE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CDC26087F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/locking/rwsem.c:65
To:     Pintu Agarwal <pintu.ping@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, linux-mm@kvack.org,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        "Xenomai@xenomai.org" <xenomai@xenomai.org>
References: <CAOuPNLgaDJm27nECxq1jtny=+ixt=GPf2C7zyDsVgbsLvtDarA@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <6183c865-2e90-5fb9-9e10-1339ae491b71@codeaurora.org>
Date:   Wed, 13 Feb 2019 15:21:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAOuPNLgaDJm27nECxq1jtny=+ixt=GPf2C7zyDsVgbsLvtDarA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pintu,

On 2/13/2019 2:04 PM, Pintu Agarwal wrote:
> 
> This is the complete logs at the time of crash:
> 
> [   21.681020] VFS: Mounted root (ext4 filesystem) readonly on device 8:6.
> [   21.690441] devtmpfs: mounted
> [   21.702517] Freeing unused kernel memory: 6528K
> [   21.766665] BUG: sleeping function called from invalid context at
> kernel/locking/rwsem.c:65
> [   21.775108] in_atomic(): 0, irqs_disabled(): 128, pid: 1, name: init
> [   21.781532] ------------[ cut here ]------------
> [   21.786209] kernel BUG at kernel/sched/core.c:8490!
> [   21.791157] ------------[ cut here ]------------
> [   21.795831] kernel BUG at kernel/sched/core.c:8490!
> [   21.800763] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [   21.806319] Modules linked in:
> [   21.809474] CPU: 0 PID: 1 Comm: init Not tainted 4.9.103+ #115
> [   21.815375] Hardware name: Qualcomm Technologies, Inc. MSM XXXX
> [   21.822584] task: ffffffe330440080 task.stack: ffffffe330448000
> [   21.828584] PC is at ___might_sleep+0x140/0x188
> [   21.833175] LR is at ___might_sleep+0x128/0x188
> [   21.837759] pc : [<ffffff88b8ce65a8>] lr : [<ffffff88b8ce6590>]
> pstate: 604001c5

<snip...>

> 0000000000000000 ffffffe33044b8d0
> [   22.135279] bac0: 0000000000000462 0000000000000006
> [   22.140224] [<ffffff88b8ce65a8>] ___might_sleep+0x140/0x188
> [   22.145862] [<ffffff88b8ce6648>] __might_sleep+0x58/0x90
> [   22.151249] [<ffffff88b9d43f84>] down_write_killable+0x2c/0x80
> [   22.157155] [<ffffff88b8e53cd8>] setup_arg_pages+0xb8/0x208
> [   22.162792] [<ffffff88b8eb7534>] load_elf_binary+0x434/0x1298
> [   22.168600] [<ffffff88b8e55674>] search_binary_handler+0xac/0x1f0
> [   22.174763] [<ffffff88b8e560ec>] do_execveat_common.isra.15+0x504/0x6c8
> [   22.181452] [<ffffff88b8e562f4>] do_execve+0x44/0x58
> [   22.186481] [<ffffff88b8c84030>] run_init_process+0x38/0x48
> [   22.192122] [<ffffff88b9d3db1c>] kernel_init+0x8c/0x108
> [   22.197411] [<ffffff88b8c83f00>] ret_from_fork+0x10/0x50
> [   22.202790] Code: b9453800 0b000020 6b00027f 540000c1 (d4210000)
> [   22.208965] ---[ end trace d775a851176a61ec ]---
> [   22.220051] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> 

This might be the work of CONFIG_PANIC_ON_SCHED_BUG which is extra debug 
option enabled in *sdm845_defconfig*. You can disable it or better
I would suggest to use *sdm845-perf_defconfig* instead of
sdm845_defconfig since there are a lot of debug options enabled
in the latter which may be not compatible when IPIPE patches
are applied.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
