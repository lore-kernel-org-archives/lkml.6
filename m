Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71D6C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A036920835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/PaWOEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392386AbfBMOlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:41:08 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42559 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390248AbfBMOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:41:07 -0500
Received: by mail-ua1-f65.google.com with SMTP id d21so838426uap.9;
        Wed, 13 Feb 2019 06:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A83HwLkscd+n/ThJxRWxJ32yY+Lg5D0jBF/2KpDB3qY=;
        b=r/PaWOEgaZqRchY5b+f2Aqpg3NUrIWco/uoRwXLcLhwB8B5qxyiDnFz9uo/U11TGio
         DLiYX102zjFQJuOVt+VmeaDlP9sWXmdSM0sr4W8/95cKua5UW4jLkzRmx0GNOJh3cXHp
         Smkp6lUiv/O9736wsh1aY7pkMqcaJlNMKV5puOBAk0lQUBjCbKz5NS5TwmBxg8kA5+SW
         ecmblUU10D37/LSTNzre+sDf3PpicU9xKYrlfz3vDLgu7Rx6bpBhPGlCgg7WFntkxPcn
         ZENXkhbUqyCnPm24fUhWVa3nqsxNXr8tPIES5eAJIhnAdyN9ioZcYclnNgOKi+RX2+PD
         qqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A83HwLkscd+n/ThJxRWxJ32yY+Lg5D0jBF/2KpDB3qY=;
        b=D6pJ99STplA2qgzrDKkPPe9e7C5Y902a5vWwI9h8Wtjs5sbSIGa9fwOVWeP4pSE5tB
         NV1BisKRDWMgwOdC2CAEhkqfrgbHRYAVVHoTeE0YJeRe9Xqj4grmchTJOKifT/SFdstO
         Y+vRH7M14pNWdrZ+yq3yEWce6t/Y/PgLI2mJ658rc/YgCWwFpNQBq85WuPOAGOfqnau0
         12Kd7kYoVcbjpI1nrb7I5Q5zTNmP28gPTwDiEo4jwPgJdnOd7l0ZIloRX/22mf408/vK
         i9UAVGXz8g3sChxAZlOCA7fvI/9L+4zxjo7bkCBZIsuayjhotRofzBpqvux+sP1is85O
         1nVA==
X-Gm-Message-State: AHQUAubFAsc5WUSrwN9oYZ2RKIF9oRHbOF11QhSvsVETel3iaofyAElm
        ZZNU2Km80F3lc02il7ReOtUqwM3Yfd03rnbrJ+o=
X-Google-Smtp-Source: AHgI3Ia8V3vK8w1HHishMyZgGE6WARkR4czKUI8KdC5YbgaGPvh4Jl4j9OCo3NSLG+r2yx7/j4YxjsW/FIswodfTXps=
X-Received: by 2002:ab0:5a71:: with SMTP id m46mr316889uad.123.1550068866332;
 Wed, 13 Feb 2019 06:41:06 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLgaDJm27nECxq1jtny=+ixt=GPf2C7zyDsVgbsLvtDarA@mail.gmail.com>
 <6183c865-2e90-5fb9-9e10-1339ae491b71@codeaurora.org>
In-Reply-To: <6183c865-2e90-5fb9-9e10-1339ae491b71@codeaurora.org>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 13 Feb 2019 20:10:55 +0530
Message-ID: <CAOuPNLgUvECE6XBjszFggY3efmEBKywzKNWupjfQ2svsCMqd7w@mail.gmail.com>
Subject: Re: BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:65
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, linux-mm@kvack.org,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        "Xenomai@xenomai.org" <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 3:21 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Pintu,
>
> On 2/13/2019 2:04 PM, Pintu Agarwal wrote:
> >
> > This is the complete logs at the time of crash:
> >
> > [   21.681020] VFS: Mounted root (ext4 filesystem) readonly on device 8:6.
> > [   21.690441] devtmpfs: mounted
> > [   21.702517] Freeing unused kernel memory: 6528K
> > [   21.766665] BUG: sleeping function called from invalid context at
> > kernel/locking/rwsem.c:65
> > [   21.775108] in_atomic(): 0, irqs_disabled(): 128, pid: 1, name: init
> > [   21.781532] ------------[ cut here ]------------
> > [   21.786209] kernel BUG at kernel/sched/core.c:8490!
> > [   21.791157] ------------[ cut here ]------------
> > [   21.795831] kernel BUG at kernel/sched/core.c:8490!
> > [   21.800763] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > [   21.806319] Modules linked in:
> > [   21.809474] CPU: 0 PID: 1 Comm: init Not tainted 4.9.103+ #115
> > [   21.815375] Hardware name: Qualcomm Technologies, Inc. MSM XXXX
> > [   21.822584] task: ffffffe330440080 task.stack: ffffffe330448000
> > [   21.828584] PC is at ___might_sleep+0x140/0x188
> > [   21.833175] LR is at ___might_sleep+0x128/0x188
> > [   21.837759] pc : [<ffffff88b8ce65a8>] lr : [<ffffff88b8ce6590>]
> > pstate: 604001c5
>
> <snip...>
>
> > 0000000000000000 ffffffe33044b8d0
> > [   22.135279] bac0: 0000000000000462 0000000000000006
> > [   22.140224] [<ffffff88b8ce65a8>] ___might_sleep+0x140/0x188
> > [   22.145862] [<ffffff88b8ce6648>] __might_sleep+0x58/0x90
> > [   22.151249] [<ffffff88b9d43f84>] down_write_killable+0x2c/0x80
> > [   22.157155] [<ffffff88b8e53cd8>] setup_arg_pages+0xb8/0x208
> > [   22.162792] [<ffffff88b8eb7534>] load_elf_binary+0x434/0x1298
> > [   22.168600] [<ffffff88b8e55674>] search_binary_handler+0xac/0x1f0
> > [   22.174763] [<ffffff88b8e560ec>] do_execveat_common.isra.15+0x504/0x6c8
> > [   22.181452] [<ffffff88b8e562f4>] do_execve+0x44/0x58
> > [   22.186481] [<ffffff88b8c84030>] run_init_process+0x38/0x48
> > [   22.192122] [<ffffff88b9d3db1c>] kernel_init+0x8c/0x108
> > [   22.197411] [<ffffff88b8c83f00>] ret_from_fork+0x10/0x50
> > [   22.202790] Code: b9453800 0b000020 6b00027f 540000c1 (d4210000)
> > [   22.208965] ---[ end trace d775a851176a61ec ]---
> > [   22.220051] Kernel panic - not syncing: Attempted to kill init!
> > exitcode=0x0000000b
> >
>
> This might be the work of CONFIG_PANIC_ON_SCHED_BUG which is extra debug
> option enabled in *sdm845_defconfig*. You can disable it or better
> I would suggest to use *sdm845-perf_defconfig* instead of
> sdm845_defconfig since there are a lot of debug options enabled
> in the latter which may be not compatible when IPIPE patches
> are applied.

OK thanks for your suggestions. sdm845-perf_defconfig did not work for
me. The target did not boot.
However, disabling CONFIG_PANIC_ON_SCHED_BUG works, and I got a root
shell at least.
This at least proves that there is no issue in core ipipe patches, and
I can proceed.

But this seems to be a work around.
I still get a back trace in kernel logs from many different places.
So, it looks like there is some code in qualcomm specific drivers that
is calling a sleeping method from invalid context.
How to find that...
If this fix is already available in latest version, please let me know.

Thanks,
Pintu
