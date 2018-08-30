Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071D0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702FF20645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOVOrUeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702FF20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeH3K11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:27:27 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55737 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeH3K11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:27:27 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so1120802itj.5;
        Wed, 29 Aug 2018 23:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=V6SYZg9+dO61+zHuGtivmqFMBKt3u/JUDqzNwqowGlw=;
        b=VOVOrUeuafZXeHxThRSPVwim7JYzzcftZHUXJbmvfyRG0B87M4cZGGBmMzy0iFAx1d
         mZx9XnABBp+Ytj/UMgnncI4H+lYDIkkSfyBAxcEbzwBCcbA6D51EFF5wjfkZAj+M8tP3
         gFNSW7A0GGiKZWUSuFtEsXIycc/QGffPv+cLb1rpwmcn76cLTpfh2pggldFyJ9fDtJJZ
         aoiIh72WxFsiD7p3k7t67H5xV2rbT6cx433pNqRxyJmKMTVw5o+RF6fQfkyHGuNteFqs
         d8i3I1Uh3Z+pP+vwm1RPSGx1FLZJJdYxOO5xSNbWphAsqETpAzezWr3c9uQInRzyhcN3
         NQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=V6SYZg9+dO61+zHuGtivmqFMBKt3u/JUDqzNwqowGlw=;
        b=mHNzD0S8EhT1r1emuTExrVGESVz6kWoCfhgUwwI7LLJYAWNbbW/MGMe9iziUHbA58n
         Ng9C38qk4JrlPbnBoVmBmsRg5F7ToPCnrGg+8qKex+am89RPAuLPc6lcjqFf6w7GSBmw
         Pj4S/YiWwzuLimWuNidKkWkpjsesvDjFl39Nwnt7x8BPlyZHWVljXYBwpmCm+dqZr1Hd
         rJAeeLYTH4S602dSCfUAL8YOKyHwdcQvhlSRsmsWCQ7Ta/1bJzUl8AsToJZEkLNdWVTz
         Hr1bEoLkV9eetAWHSyjqG6B2/Xk2MWN0+Vlg6KYVp5h6vKOadT4A59egf8qfdrl2cUEB
         Rlcg==
X-Gm-Message-State: APzg51A3mMEAHS/OnduEkcIhMno12K9+hNkZH7P+7bdvJPyxhLbhb6YW
        zeVH+D5FLYYYnY+hKN1pJmk=
X-Google-Smtp-Source: ANB0VdaYLqIOK6FNuXcALjw9zHmnPkrGDjD7o+NtGDJcBOCR2B6ri57ygzWyaTAXgqgnYTjLRG1MjQ==
X-Received: by 2002:a24:85d7:: with SMTP id r206-v6mr925911itd.143.1535610412712;
        Wed, 29 Aug 2018 23:26:52 -0700 (PDT)
Received: from [0.0.0.0] (96.45.178.72.16clouds.com. [96.45.178.72])
        by smtp.gmail.com with ESMTPSA id 80-v6sm502758itk.14.2018.08.29.23.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 23:26:51 -0700 (PDT)
Subject: Re: mmotm 2018-08-23-17-26 uploaded
To:     Jia He <hejianet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180824002731.XMNCl%akpm@linux-foundation.org>
 <049c3fa9-f888-6a2d-413b-872992b269f9@gmail.com>
 <20180829162213.fa1c7c54c801a036e64bacd2@linux-foundation.org>
 <7ae81ca1-46ca-af47-8260-c52736aa4453@gmail.com>
From:   Jia He <hejianet@gmail.com>
Message-ID: <cf4acbb6-2815-56e2-829c-4e4c3a549e21@gmail.com>
Date:   Thu, 30 Aug 2018 14:26:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7ae81ca1-46ca-af47-8260-c52736aa4453@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

On 8/30/2018 9:00 AM, Jia He Wrote:
> 
> 
> On 8/30/2018 7:22 AM, Andrew Morton Wrote:
>> On Tue, 28 Aug 2018 12:20:46 +0800 Jia He <hejianet@gmail.com> wrote:
>>
>>> Hi Andrew
>>> FYI,I watched a lockdep warning based on your mmotm master branch[1]
>>
>> Thanks.  We'll need help from ARM peeps on this please.
>>
>>> [    6.692731] ------------[ cut here ]------------
>>> [    6.696391] DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
>>> [    6.696404] WARNING: CPU: 3 PID: 320 at kernel/locking/lockdep.c:3845
>>> check_flags.part.38+0x9c/0x16c
>>> [    6.711082] Modules linked in:
>>> [    6.714101] CPU: 3 PID: 320 Comm: modprobe Not tainted 4.18.0-rc4-mm1+ #56
>>> [    6.720956] Hardware name: WIWYNN HXT REP-1 System H001-00001-0/HXT REP-1
>>> CRB, BIOS 0ACJA530 03/20/2018
>>> [    6.730332] pstate: 60400085 (nZCv daIf +PAN -UAO)
>>> [    6.735106] pc : check_flags.part.38+0x9c/0x16c
>>> [    6.739619] lr : check_flags.part.38+0x9c/0x16c
>>> [    6.744133] sp : ffff80178536fbf0
>>> [    6.747432] x29: ffff80178536fbf0 x28: ffff8017905a1b00
>>> [    6.752727] x27: 0000000000000002 x26: 0000000000000000
>>> [    6.758022] x25: ffff000008abeb14 x24: 0000000000000000
>>> [    6.763317] x23: 0000000000000001 x22: 0000000000000001
>>> [    6.768612] x21: 0000000000000001 x20: 0000000000000000
>>> [    6.773908] x19: ffff00000a041000 x18: 0000000000000000
>>> [    6.779202] x17: 0000000000000000 x16: 0000000000000000
>>> [    6.784498] x15: 0000000000000000 x14: 0000000000000000
>>> [    6.789793] x13: ffff000008d6b190 x12: 752ce9eb60de3f00
>>> [    6.795088] x11: ffff80178536f7f0 x10: ffff80178536f7f0
>>> [    6.800383] x9 : 00000000ffffffd0 x8 : 0000000000000000
>>> [    6.805678] x7 : ffff00000816fe48 x6 : ffff801794ba62b8
>>> [    6.810973] x5 : 0000000000000000 x4 : 0000000000000000
>>> [    6.816269] x3 : ffffffffffffffff x2 : ffff0000091ed988
>>> [    6.821564] x1 : 752ce9eb60de3f00 x0 : 752ce9eb60de3f00
>>> [    6.826859] Call trace:
>>> [    6.829290]  check_flags.part.38+0x9c/0x16c
>>> [    6.833457]  lock_acquire+0x12c/0x280
>>> [    6.837104]  down_read_trylock+0x78/0x98
>>> [    6.841011]  do_page_fault+0x150/0x480
>>> [    6.844742]  do_translation_fault+0x74/0x80
>>> [    6.848909]  do_mem_abort+0x60/0x108
>>> [    6.852467]  el0_da+0x24/0x28
>>> [    6.855418] irq event stamp: 250
>>> [    6.858633] hardirqs last  enabled at (249): [<ffff00000830e518>]
>>> mem_cgroup_commit_charge+0x9c/0x13c
>>> [    6.867833] hardirqs last disabled at (250): [<ffff000008095f40>]
>>> el0_svc_handler+0xc4/0x16c
>>> [    6.876252] softirqs last  enabled at (242): [<ffff000008081c48>]
>>> __do_softirq+0x2f8/0x554
>>> [    6.884501] softirqs last disabled at (229): [<ffff0000080f1bec>]
>>> irq_exit+0x180/0x194
>>> [    6.892399] ---[ end trace b45768f94a7b7d9f ]---
>>> [    6.896998] possible reason: unannotated irqs-on.
>>> [    6.901685] irq event stamp: 250
>>> [    6.904898] hardirqs last  enabled at (249): [<ffff00000830e518>]
>>> mem_cgroup_commit_charge+0x9c/0x13c
>>> [    6.914100] hardirqs last disabled at (250): [<ffff000008095f40>]
>>> el0_svc_handler+0xc4/0x16c
>>> [    6.922519] softirqs last  enabled at (242): [<ffff000008081c48>]
>>> __do_softirq+0x2f8/0x554
>>> [    6.930766] softirqs last disabled at (229): [<ffff0000080f1bec>]
>>> irq_exit+0x180/0x194
>>> [    7.023827] Initialise system trusted keyrings
>>> [    7.027414] workingset: timestamp_bits=45 max_order=25 bucket_order=0
>>
>> Lockdep says current->hardirqs_enabled is false and that is indeed an
>> error.  arch/arm64/kernel/entry.S:el0_da does enable_daif which might
>> be an attempt to enable hardirqs, but how does that get propagated into
>> lockdep's ->hardirqs_enabled?  By calling
>> local_irq_enable()->trace_hardirqs_on(), but that's C, not assembler.
>>
>> And what changed to cause this?
>>
>> I dunno anything.  Help!
>>
>>> I thought the root cause might be at [2] which seems not in your branch yet.
>>>
>>> [1] http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git
>>> [2]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=efd112
>>
>> I agree, that doesn't look like the culprit.  But something may well
>> have gone wrong in "the recent conversion of the syscall entry/exit
>> code to C".
> Sorry for my unclearly previously description.
> 1. no such lockdep warning in latest mainline kernel git tree.
> 2. there is a 100% producible warning based on your latest mmotm tree
> 3. after applying the commit efd112 based on your mmotm tree, the warning
> disappearred
> 
> I will do some further digging to answer your question if no other experts' help
> 
1. in el0_svc->el0_svc_common, without commit efd112
		local_daif_mask();   //disable the irq and trace irq off
		flags = current_thread_info()->flags;
		if (!has_syscall_work(flags))
			------------    //1
			return;
If el0_svc_common enters the logic at line 1, the irq is disabled and
current->hardirqs_enabled is 0.

2. then it goes to el0_da
in el0_da, it enables the irq without changing current->hardirqs_enabled to 1

3. goes to el0_da->do_mem_abort->... the lockdep warning happens

The commit efd112 fixes it by invoking trace_hardirqs_off at line 1.
It closes the inconsistency window.

Cheers,
Jia

-- 
Cheers,
Jia
