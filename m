Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7103C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3B22145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=odi.ch header.i=@odi.ch header.b="kuYT2J9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3B22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=odi.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeIYQAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:00:24 -0400
Received: from vie01a-dmta-ch02-2.mx.upcmail.net ([84.116.36.95]:34818 "EHLO
        vie01a-dmta-ch02-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727617AbeIYQAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:00:24 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-ch02.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <odi@odi.ch>)
        id 1g4k2D-0005tG-Av
        for linux-kernel@vger.kernel.org; Tue, 25 Sep 2018 11:53:37 +0200
Received: from gandalf.odi.ch ([IPv6:2001:470:25:65c::2])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id fltb1y00y0tAtQp01ltdLh; Tue, 25 Sep 2018 11:53:37 +0200
X-SourceIP: 2001:470:25:65c::2
X-Authenticated-Sender: odi.ch@hispeed.ch
Received: from [10.11.1.254] (unknown [81.7.230.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gandalf.odi.ch (Postfix) with ESMTPSA id 578A04600A3;
        Tue, 25 Sep 2018 11:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=odi.ch; s=mail;
        t=1537869215; bh=ZX5/x3oBASE3Wk51YG112r23TjyWpr2B2dtx8qbD9H4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=kuYT2J9dVzG8p0snZmQb9eDAEhK1hwo4Lk9uqi3jNFdJGoqZ911JeFy3t49I9poPV
         Iw+A4XCDR1EGgvbM+GsKGpph8Bhk0bSiSV3JtIObbFbLjO6Bmk0ovjTaQqstEM4tNb
         /T3GI1SZaURClyX4jIvqO4LZfv20PWTFQHwjABaw=
Subject: Re: r8169 hang on 4.18
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
References: <332fecce-3fab-1c92-1558-67a1d90d6372@odi.ch>
 <680acec6-f610-7f9d-5aa2-a03e878354d1@gmail.com>
From:   =?UTF-8?Q?Ortwin_Gl=c3=bcck?= <odi@odi.ch>
Message-ID: <4584fb8e-32f8-7375-8481-fe35c3cf693e@odi.ch>
Date:   Tue, 25 Sep 2018 11:53:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <680acec6-f610-7f9d-5aa2-a03e878354d1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.18 22:21, Heiner Kallweit wrote:
> Thanks for the report. Here come a few inquiries:
> 
> You say the box has one on-board network port and four network ports on
> an extension card, all five driven by r8169. The on-board chip is a
> RTL8168h, what's the type of the chips on the extension card?

This is the card:
03:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express 
Gigabit Ethernet Controller [10ec:8168] (rev 0c)
         Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet 
Controller [10ec:0123]
         Flags: bus master, fast devsel, latency 0, IRQ 17
         I/O ports at d000 [size=256]
         Memory at f7300000 (64-bit, non-prefetchable) [size=4K]
         Memory at f0300000 (64-bit, prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
         Capabilities: [70] Express Endpoint, MSI 01
         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
         Capabilities: [d0] Vital Product Data
         Capabilities: [100] Advanced Error Reporting
         Capabilities: [140] Virtual Channel
         Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
         Capabilities: [170] Latency Tolerance Reporting
         Kernel driver in use: r8169

04:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express 
Gigabit Ethernet Controller [10ec:8168] (rev 0c)
         Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet 
Controller [10ec:0123]
         Flags: bus master, fast devsel, latency 0, IRQ 18
         I/O ports at c000 [size=256]
         Memory at f7200000 (64-bit, non-prefetchable) [size=4K]
         Memory at f0200000 (64-bit, prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
         Capabilities: [70] Express Endpoint, MSI 01
         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
         Capabilities: [d0] Vital Product Data
         Capabilities: [100] Advanced Error Reporting
         Capabilities: [140] Virtual Channel
         Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
         Capabilities: [170] Latency Tolerance Reporting
         Kernel driver in use: r8169

05:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express 
Gigabit Ethernet Controller [10ec:8168] (rev 0c)
         Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet 
Controller [10ec:0123]
         Flags: bus master, fast devsel, latency 0, IRQ 19
         I/O ports at b000 [size=256]
         Memory at f7100000 (64-bit, non-prefetchable) [size=4K]
         Memory at f0100000 (64-bit, prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
         Capabilities: [70] Express Endpoint, MSI 01
         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
         Capabilities: [d0] Vital Product Data
         Capabilities: [100] Advanced Error Reporting
         Capabilities: [140] Virtual Channel
         Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
         Capabilities: [170] Latency Tolerance Reporting
         Kernel driver in use: r8169

06:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express 
Gigabit Ethernet Controller [10ec:8168] (rev 0c)
         Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet 
Controller [10ec:0123]
         Flags: bus master, fast devsel, latency 0, IRQ 16
         I/O ports at a000 [size=256]
         Memory at f7000000 (64-bit, non-prefetchable) [size=4K]
         Memory at f0000000 (64-bit, prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
         Capabilities: [70] Express Endpoint, MSI 01
         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
         Capabilities: [d0] Vital Product Data
         Capabilities: [100] Advanced Error Reporting
         Capabilities: [140] Virtual Channel
         Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
         Capabilities: [170] Latency Tolerance Reporting
         Kernel driver in use: r8169



> I'm asking because r8169 supports ~ 50 chip variants of the RTL8169/8
> family.
> Are the problems the same on all five ports?

Yes, I see the WARN_ON also on the other ports. Here is one from the separate card:
[Mon Sep 24 15:47:21 2018] ------------[ cut here ]------------
[Mon Sep 24 15:47:21 2018] NETDEV WATCHDOG: lan (r8169): transmit queue 0 timed out
[Mon Sep 24 15:47:21 2018] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:461 
dev_watchdog+0x215/0x220
[Mon Sep 24 15:47:21 2018] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.18.8 #70
[Mon Sep 24 15:47:21 2018] Hardware name: Dell Inc. OptiPlex 3050/0W0CHX, BIOS 1.6.5 09/09/2017
[Mon Sep 24 15:47:21 2018] RIP: 0010:dev_watchdog+0x215/0x220
[Mon Sep 24 15:47:21 2018] Code: 49 63 4c 24 e8 eb 8c 4c 89 ef c6 05 1a 19 ca 00 01 e8 5f 52 fd ff 
89 d9 4c 89 ee 48 c7 c7 78 ab 67 af 48 89 c2 e8 1b 2b 49 ff <0f> 0b eb be 0f 1f 80 00 00 00 00 41 57 
45 89 cf 41 56 49 89 d6 41
[Mon Sep 24 15:47:21 2018] RSP: 0018:ffff8a205dd03e98 EFLAGS: 00010282
[Mon Sep 24 15:47:21 2018] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
[Mon Sep 24 15:47:21 2018] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8a205dd15350
[Mon Sep 24 15:47:21 2018] RBP: ffff8a2045de041c R08: 0000000000000001 R09: 0000000000000763
[Mon Sep 24 15:47:21 2018] R10: 0000000000000082 R11: 0000000000000000 R12: ffff8a2045de0438
[Mon Sep 24 15:47:21 2018] R13: ffff8a2045de0000 R14: 0000000000000001 R15: ffff8a20455e1480
[Mon Sep 24 15:47:21 2018] FS:  0000000000000000(0000) GS:ffff8a205dd00000(0000) knlGS:0000000000000000
[Mon Sep 24 15:47:21 2018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mon Sep 24 15:47:21 2018] CR2: 00007ff598642c38 CR3: 000000001f80a004 CR4: 00000000003606e0
[Mon Sep 24 15:47:21 2018] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[Mon Sep 24 15:47:21 2018] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[Mon Sep 24 15:47:21 2018] Call Trace:
[Mon Sep 24 15:47:21 2018]  <IRQ>
[Mon Sep 24 15:47:21 2018]  ? pfifo_fast_reset+0x130/0x130
[Mon Sep 24 15:47:21 2018]  ? pfifo_fast_reset+0x130/0x130
[Mon Sep 24 15:47:21 2018]  call_timer_fn+0x11/0x70
[Mon Sep 24 15:47:21 2018]  expire_timers+0x8e/0xa0
[Mon Sep 24 15:47:21 2018]  run_timer_softirq+0xb9/0x160
[Mon Sep 24 15:47:21 2018]  ? __hrtimer_run_queues+0x135/0x1a0
[Mon Sep 24 15:47:21 2018]  ? hw_breakpoint_pmu_read+0x10/0x10
[Mon Sep 24 15:47:21 2018]  ? ktime_get+0x39/0x90
[Mon Sep 24 15:47:21 2018]  ? lapic_next_event+0x20/0x20
[Mon Sep 24 15:47:21 2018]  __do_softirq+0xcb/0x1f8
[Mon Sep 24 15:47:21 2018]  irq_exit+0xa9/0xb0
[Mon Sep 24 15:47:21 2018]  smp_apic_timer_interrupt+0x59/0x90
[Mon Sep 24 15:47:21 2018]  apic_timer_interrupt+0xf/0x20
[Mon Sep 24 15:47:21 2018]  </IRQ>
[Mon Sep 24 15:47:21 2018] RIP: 0010:cpuidle_enter_state+0x129/0x200
[Mon Sep 24 15:47:21 2018] Code: 45 00 89 c3 e8 d8 3b 55 ff 65 8b 3d b1 eb 45 51 e8 8c 3a 55 ff 31 
ff 49 89 c4 e8 72 43 55 ff fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 89 e1 4c 29 e9 48 89 c8 48 c1 f9 3f 
48 f7 ea b8 ff ff ff 7f 48
[Mon Sep 24 15:47:21 2018] RSP: 0018:ffff9f46806e7ea8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
[Mon Sep 24 15:47:21 2018] RAX: ffff8a205dd1f800 RBX: 0000000000000004 RCX: 000000000000001f
[Mon Sep 24 15:47:21 2018] RDX: 20c49ba5e353f7cf RSI: 00000000258f0602 RDI: 0000000000000000
[Mon Sep 24 15:47:21 2018] RBP: ffff8a205dd25ee0 R08: 00000000000003ee R09: 00000000ffffffff
[Mon Sep 24 15:47:21 2018] R10: ffff9f46806e7e90 R11: 00000000000003d5 R12: 00000752028ec2d0
[Mon Sep 24 15:47:21 2018] R13: 000007520282ea18 R14: 0000000000000004 R15: 0000000000000000
[Mon Sep 24 15:47:21 2018]  ? cpuidle_enter_state+0x11e/0x200
[Mon Sep 24 15:47:21 2018]  do_idle+0x1c0/0x200
[Mon Sep 24 15:47:21 2018]  cpu_startup_entry+0x6a/0x70
[Mon Sep 24 15:47:21 2018]  start_secondary+0x18a/0x1c0
[Mon Sep 24 15:47:21 2018]  secondary_startup_64+0xa5/0xb0
[Mon Sep 24 15:47:21 2018] ---[ end trace 7ea59db719c41930 ]---
[Mon Sep 24 15:47:21 2018] r8169 0000:06:00.0 lan: link up


> Can you reproduce the problem (how)? Any specific network usage
> triggering the problem?

Actually the WARN_ON seems not to be causing the hang but to be rather a side effect of an 
"unstable" port. The WARN_ON occurs every few days but the port works fine most of the time. But 
when the port hangs (no more traffic) only a reboot fixes it.

These looks suspicious:

[ 8048.829832] r8169 0000:06:00.0 lan: link up
[64114.535455] r8169 0000:07:00.0 wan: link up
[74726.396319] r8169 0000:07:00.0 wan: link up

The ports seem to go up at random times (without "link down" message). This is also what we saw with 
MSI enabled: links thrashing in down/up cycles.

> The root cause of the problem not necessarily is in r8169, some other
> change could have broken it too. Can you test using r8169 from 4.18
> on top of 4.17?

Unfortunately I am not able to do that.

> When stating "behaves erratic" you refer to the network hangs
> mentioned before? Or to some other issue?

please see above: links thrashing in down/up cycles.
I see that MSI/MSI-X has been disabled on quite a few chip versions (e.g. lately commit 72a579b8).
Does pci=nomsi disable MSI-X as well, or just MSI?
I could try adding my chip versions to these quirk sections. I couldn't find a way to disable 
MSI/MSI-X per device.

> A similar report is here:
> https://bugzilla.kernel.org/show_bug.cgi?id=201109

Also that report has the "link up" message after the WARN_ON.

> There the problem seems to start with the upgrade from 4.18.4 to 4.18.5.
> Can you try with 4.18.4 ?
> 
> The diff between 4.18.4 and 4.18.5 shows nothing related to r8169.

Exactly. I think the incident is just so rare that correlating it with a specific upgrade is hard.

Thanks,

Ortwin
