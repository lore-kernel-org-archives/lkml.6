Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD8C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BC420833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjdEAunk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BC420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeIZAxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:53:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36234 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeIZAxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:53:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id y13-v6so9945164wmi.1;
        Tue, 25 Sep 2018 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EpY4SVTS1sy1xkbwGxjzYhMdW9d6QkpXxsivG+L0lfY=;
        b=gjdEAunk6Fu0VwabMMc9bUYOXsUaH+Q/RVOhVFjV+kKcOYdCPfWGUvUECVFQicFs2r
         qmPQb8TqSqa5yyZTAAdwvxtsGulluqjE+2HYeoEEWxwE9IAt6pSyGZFag3a+1deZPpnJ
         9bCX5z1C2WXsWfe+23XCoEl5vAAIfrrs49VHMubl43nRPf3rQbagYVVpb2KAGlHf/Dzo
         PHrrDfQNYS7g3TACtL5DHIAWNwtSqJ/i0JW1ELZO6xDIkbHpNFohvQwJ9f2dZn/1RSzt
         cDajIibCo6/Y8a55JsFSCkLGhbbgg873tZ1pd1+pJ8xJz9p54SG2TkW1judanGfzrQS+
         nURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EpY4SVTS1sy1xkbwGxjzYhMdW9d6QkpXxsivG+L0lfY=;
        b=WSnJscMX3qpz3WUyYH05EfpMxE2MsN+5YDNFQX/HaVyirsFJAwOpQEVgYCXcAnzB0o
         l60DGR812R++a1UGtbqbbJFpBDFGO+CeA6mYrS3AmQQF2aYlc8IK4WD/vGAwyeCtA0dP
         yWHmbAk/WOAi57aFpg4+EaNr6KsHaCvGWJw11Tx8txIO6ChnhOd/ER0c9Oje+vaoPZJu
         F6xciJxvWnZeGjopDHMLDNzwE26kV95s3bfr51P7awAWOq1tORxvbIk80ksik075nZwx
         DCDmFaYGoVzrauRu5698+HN7g8RWAQbksTUfobck8zVJsZYkDwvltoQGfyN/QwjhBywe
         0vdQ==
X-Gm-Message-State: ABuFfogbrpngLmOKzUXNcoPmjJwSKNEzd0G0ZvtHwSP8TIvNSCh9mxKq
        ZswpQuuUB1NcSjhUPDbzO6ajKg4p8rA=
X-Google-Smtp-Source: ACcGV63LMzuJ2wXH9zOstYP+zMO5VKdNd6Au7Y3jzZZaBw9Bwnplc8nAVrq97fj66HYFbA91wwrz2g==
X-Received: by 2002:a1c:1a48:: with SMTP id a69-v6mr1838300wma.43.1537901067047;
        Tue, 25 Sep 2018 11:44:27 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bc0:ba00:4d53:63c8:9c2e:523a? (p200300EA8BC0BA004D5363C89C2E523A.dip0.t-ipconnect.de. [2003:ea:8bc0:ba00:4d53:63c8:9c2e:523a])
        by smtp.googlemail.com with ESMTPSA id j35-v6sm4616418wre.52.2018.09.25.11.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:44:26 -0700 (PDT)
Subject: Re: r8169 hang on 4.18
To:     =?UTF-8?Q?Ortwin_Gl=c3=bcck?= <odi@odi.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
References: <332fecce-3fab-1c92-1558-67a1d90d6372@odi.ch>
 <680acec6-f610-7f9d-5aa2-a03e878354d1@gmail.com>
 <4584fb8e-32f8-7375-8481-fe35c3cf693e@odi.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <9fb89abb-917a-44b6-5dff-9c4a0ed1fd6b@gmail.com>
Date:   Tue, 25 Sep 2018 20:44:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4584fb8e-32f8-7375-8481-fe35c3cf693e@odi.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.2018 11:53, Ortwin Glück wrote:
> On 24.09.18 22:21, Heiner Kallweit wrote:
>> Thanks for the report. Here come a few inquiries:
>>
>> You say the box has one on-board network port and four network ports on
>> an extension card, all five driven by r8169. The on-board chip is a
>> RTL8168h, what's the type of the chips on the extension card?
> 
> This is the card:
> 03:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 0c)
>         Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:0123]
>         Flags: bus master, fast devsel, latency 0, IRQ 17
>         I/O ports at d000 [size=256]
>         Memory at f7300000 (64-bit, non-prefetchable) [size=4K]
>         Memory at f0300000 (64-bit, prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [70] Express Endpoint, MSI 01
>         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
>         Capabilities: [d0] Vital Product Data
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Virtual Channel
>         Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
>         Capabilities: [170] Latency Tolerance Reporting
>         Kernel driver in use: r8169
> 
> 04:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 0c)
>         Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:0123]
>         Flags: bus master, fast devsel, latency 0, IRQ 18
>         I/O ports at c000 [size=256]
>         Memory at f7200000 (64-bit, non-prefetchable) [size=4K]
>         Memory at f0200000 (64-bit, prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [70] Express Endpoint, MSI 01
>         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
>         Capabilities: [d0] Vital Product Data
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Virtual Channel
>         Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
>         Capabilities: [170] Latency Tolerance Reporting
>         Kernel driver in use: r8169
> 
> 05:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 0c)
>         Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:0123]
>         Flags: bus master, fast devsel, latency 0, IRQ 19
>         I/O ports at b000 [size=256]
>         Memory at f7100000 (64-bit, non-prefetchable) [size=4K]
>         Memory at f0100000 (64-bit, prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [70] Express Endpoint, MSI 01
>         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
>         Capabilities: [d0] Vital Product Data
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Virtual Channel
>         Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
>         Capabilities: [170] Latency Tolerance Reporting
>         Kernel driver in use: r8169
> 
> 06:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 0c)
>         Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:0123]
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         I/O ports at a000 [size=256]
>         Memory at f7000000 (64-bit, non-prefetchable) [size=4K]
>         Memory at f0000000 (64-bit, prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [70] Express Endpoint, MSI 01
>         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
>         Capabilities: [d0] Vital Product Data
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Virtual Channel
>         Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
>         Capabilities: [170] Latency Tolerance Reporting
>         Kernel driver in use: r8169
> 

Unfortunately the lspci info doesn't allow to determine the exact chip type.
Relevant would be the syslog info as you provided it in your first mail:
r8169 0000:07:00.0 eth4: RTL8168h/8111h, 50:9a:4c:2e:92:be, XID 54100800, IRQ 16
Are the chips on the extension card the same as the on-board chip?

> 
> 
>> I'm asking because r8169 supports ~ 50 chip variants of the RTL8169/8
>> family.
>> Are the problems the same on all five ports?
> 
> Yes, I see the WARN_ON also on the other ports. Here is one from the separate card:
> [Mon Sep 24 15:47:21 2018] ------------[ cut here ]------------
> [Mon Sep 24 15:47:21 2018] NETDEV WATCHDOG: lan (r8169): transmit queue 0 timed out
> [Mon Sep 24 15:47:21 2018] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:461 dev_watchdog+0x215/0x220
> [Mon Sep 24 15:47:21 2018] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.18.8 #70
> [Mon Sep 24 15:47:21 2018] Hardware name: Dell Inc. OptiPlex 3050/0W0CHX, BIOS 1.6.5 09/09/2017
> [Mon Sep 24 15:47:21 2018] RIP: 0010:dev_watchdog+0x215/0x220
> [Mon Sep 24 15:47:21 2018] Code: 49 63 4c 24 e8 eb 8c 4c 89 ef c6 05 1a 19 ca 00 01 e8 5f 52 fd ff 89 d9 4c 89 ee 48 c7 c7 78 ab 67 af 48 89 c2 e8 1b 2b 49 ff <0f> 0b eb be 0f 1f 80 00 00 00 00 41 57 45 89 cf 41 56 49 89 d6 41
> [Mon Sep 24 15:47:21 2018] RSP: 0018:ffff8a205dd03e98 EFLAGS: 00010282
> [Mon Sep 24 15:47:21 2018] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
> [Mon Sep 24 15:47:21 2018] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8a205dd15350
> [Mon Sep 24 15:47:21 2018] RBP: ffff8a2045de041c R08: 0000000000000001 R09: 0000000000000763
> [Mon Sep 24 15:47:21 2018] R10: 0000000000000082 R11: 0000000000000000 R12: ffff8a2045de0438
> [Mon Sep 24 15:47:21 2018] R13: ffff8a2045de0000 R14: 0000000000000001 R15: ffff8a20455e1480
> [Mon Sep 24 15:47:21 2018] FS:  0000000000000000(0000) GS:ffff8a205dd00000(0000) knlGS:0000000000000000
> [Mon Sep 24 15:47:21 2018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Mon Sep 24 15:47:21 2018] CR2: 00007ff598642c38 CR3: 000000001f80a004 CR4: 00000000003606e0
> [Mon Sep 24 15:47:21 2018] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [Mon Sep 24 15:47:21 2018] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [Mon Sep 24 15:47:21 2018] Call Trace:
> [Mon Sep 24 15:47:21 2018]  <IRQ>
> [Mon Sep 24 15:47:21 2018]  ? pfifo_fast_reset+0x130/0x130
> [Mon Sep 24 15:47:21 2018]  ? pfifo_fast_reset+0x130/0x130
> [Mon Sep 24 15:47:21 2018]  call_timer_fn+0x11/0x70
> [Mon Sep 24 15:47:21 2018]  expire_timers+0x8e/0xa0
> [Mon Sep 24 15:47:21 2018]  run_timer_softirq+0xb9/0x160
> [Mon Sep 24 15:47:21 2018]  ? __hrtimer_run_queues+0x135/0x1a0
> [Mon Sep 24 15:47:21 2018]  ? hw_breakpoint_pmu_read+0x10/0x10
> [Mon Sep 24 15:47:21 2018]  ? ktime_get+0x39/0x90
> [Mon Sep 24 15:47:21 2018]  ? lapic_next_event+0x20/0x20
> [Mon Sep 24 15:47:21 2018]  __do_softirq+0xcb/0x1f8
> [Mon Sep 24 15:47:21 2018]  irq_exit+0xa9/0xb0
> [Mon Sep 24 15:47:21 2018]  smp_apic_timer_interrupt+0x59/0x90
> [Mon Sep 24 15:47:21 2018]  apic_timer_interrupt+0xf/0x20
> [Mon Sep 24 15:47:21 2018]  </IRQ>
> [Mon Sep 24 15:47:21 2018] RIP: 0010:cpuidle_enter_state+0x129/0x200
> [Mon Sep 24 15:47:21 2018] Code: 45 00 89 c3 e8 d8 3b 55 ff 65 8b 3d b1 eb 45 51 e8 8c 3a 55 ff 31 ff 49 89 c4 e8 72 43 55 ff fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 89 e1 4c 29 e9 48 89 c8 48 c1 f9 3f 48 f7 ea b8 ff ff ff 7f 48
> [Mon Sep 24 15:47:21 2018] RSP: 0018:ffff9f46806e7ea8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
> [Mon Sep 24 15:47:21 2018] RAX: ffff8a205dd1f800 RBX: 0000000000000004 RCX: 000000000000001f
> [Mon Sep 24 15:47:21 2018] RDX: 20c49ba5e353f7cf RSI: 00000000258f0602 RDI: 0000000000000000
> [Mon Sep 24 15:47:21 2018] RBP: ffff8a205dd25ee0 R08: 00000000000003ee R09: 00000000ffffffff
> [Mon Sep 24 15:47:21 2018] R10: ffff9f46806e7e90 R11: 00000000000003d5 R12: 00000752028ec2d0
> [Mon Sep 24 15:47:21 2018] R13: 000007520282ea18 R14: 0000000000000004 R15: 0000000000000000
> [Mon Sep 24 15:47:21 2018]  ? cpuidle_enter_state+0x11e/0x200
> [Mon Sep 24 15:47:21 2018]  do_idle+0x1c0/0x200
> [Mon Sep 24 15:47:21 2018]  cpu_startup_entry+0x6a/0x70
> [Mon Sep 24 15:47:21 2018]  start_secondary+0x18a/0x1c0
> [Mon Sep 24 15:47:21 2018]  secondary_startup_64+0xa5/0xb0
> [Mon Sep 24 15:47:21 2018] ---[ end trace 7ea59db719c41930 ]---
> [Mon Sep 24 15:47:21 2018] r8169 0000:06:00.0 lan: link up
> 
> 
>> Can you reproduce the problem (how)? Any specific network usage
>> triggering the problem?
> 
> Actually the WARN_ON seems not to be causing the hang but to be rather a side effect of an "unstable" port. The WARN_ON occurs every few days but the port works fine most of the time. But when the port hangs (no more traffic) only a reboot fixes it.
> 
> These looks suspicious:
> 
> [ 8048.829832] r8169 0000:06:00.0 lan: link up
> [64114.535455] r8169 0000:07:00.0 wan: link up
> [74726.396319] r8169 0000:07:00.0 wan: link up
> 
> The ports seem to go up at random times (without "link down" message). This is also what we saw with MSI enabled: links thrashing in down/up cycles.
> 
>> The root cause of the problem not necessarily is in r8169, some other
>> change could have broken it too. Can you test using r8169 from 4.18
>> on top of 4.17?
> 
> Unfortunately I am not able to do that.
> 
>> When stating "behaves erratic" you refer to the network hangs
>> mentioned before? Or to some other issue?
> 
> please see above: links thrashing in down/up cycles.
> I see that MSI/MSI-X has been disabled on quite a few chip versions (e.g. lately commit 72a579b8).
> Does pci=nomsi disable MSI-X as well, or just MSI?
Kernel treats MSI-X as a sub-feature of MSI, therefore nomsi disables MSI-X too.

> I could try adding my chip versions to these quirk sections. I couldn't find a way to disable MSI/MSI-X per device.
> 
It turned out that the MSI-X problems are caused by a nasty small bug in certain PCI bridges.
As soon as the fix for it appears in mainline we'll revert the workarounds in r8169.
And the MSI-X issue resulted in non-functional network after resume from suspend, therefore
I think your problem isn't related.

>> A similar report is here:
>> https://bugzilla.kernel.org/show_bug.cgi?id=201109
> 
> Also that report has the "link up" message after the WARN_ON.
> 
>> There the problem seems to start with the upgrade from 4.18.4 to 4.18.5.
>> Can you try with 4.18.4 ?
>>
>> The diff between 4.18.4 and 4.18.5 shows nothing related to r8169.
> 
> Exactly. I think the incident is just so rare that correlating it with a specific upgrade is hard.
> 
As I said, you could try running 4.18.4 instead of 4.18.8 for a while (if you have this option).
You faced the hang roughly once per day, so after a few days you should be sure.

> Thanks,
> 
> Ortwin
> 
Rgds, Heiner
