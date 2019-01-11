Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7883C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A1C20675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbfAKP53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:57:29 -0500
Received: from syrinx.knorrie.org ([82.94.188.77]:57842 "EHLO
        syrinx.knorrie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbfAKP53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:57:29 -0500
Received: from [10.200.4.80] (unknown [85.146.242.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id 77BA634A27B85;
        Fri, 11 Jan 2019 16:57:26 +0100 (CET)
Subject: Re: [Xen-devel] [PATCH v2] xen: Fix x86 sched_clock() interface for
 xen
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     sstabellini@kernel.org, stable@vger.kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, boris.ostrovsky@oracle.com,
        tglx@linutronix.de
References: <20190111120805.24852-1-jgross@suse.com>
 <74aafdff-c7d5-b9aa-c3fb-3787d36c7bbe@knorrie.org>
 <8ec039c6-d0fc-c7f4-72a4-ae677c9bbb68@suse.com>
From:   Hans van Kranenburg <hans@knorrie.org>
Openpgp: preference=signencrypt
Autocrypt: addr=hans@knorrie.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cceafa86-e7b7-6e8d-851c-1c21ada0f445@knorrie.org>
Date:   Fri, 11 Jan 2019 16:57:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <8ec039c6-d0fc-c7f4-72a4-ae677c9bbb68@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en_US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 3:01 PM, Juergen Gross wrote:
> On 11/01/2019 14:12, Hans van Kranenburg wrote:
>> Hi,
>>
>> On 1/11/19 1:08 PM, Juergen Gross wrote:
>>> Commit f94c8d11699759 ("sched/clock, x86/tsc: Rework the x86 'unstable'
>>> sched_clock() interface") broke Xen guest time handling across
>>> migration:
>>>
>>> [  187.249951] Freezing user space processes ... (elapsed 0.001 seconds) done.
>>> [  187.251137] OOM killer disabled.
>>> [  187.251137] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>>> [  187.252299] suspending xenstore...
>>> [  187.266987] xen:grant_table: Grant tables using version 1 layout
>>> [18446743811.706476] OOM killer enabled.
>>> [18446743811.706478] Restarting tasks ... done.
>>> [18446743811.720505] Setting capacity to 16777216
>>>
>>> Fix that by setting xen_sched_clock_offset at resume time to ensure a
>>> monotonic clock value.
>>>
>>> [...]
>>
>> I'm throwing around a PV domU over a bunch of test servers with live
>> migrate now, and in between the kernel logging, I'm seeing this:
>>
>> [Fri Jan 11 13:58:42 2019] Freezing user space processes ... (elapsed
>> 0.002 seconds) done.
>> [Fri Jan 11 13:58:42 2019] OOM killer disabled.
>> [Fri Jan 11 13:58:42 2019] Freezing remaining freezable tasks ...
>> (elapsed 0.000 seconds) done.
>> [Fri Jan 11 13:58:42 2019] suspending xenstore...
>> [Fri Jan 11 13:58:42 2019] ------------[ cut here ]------------
>> [Fri Jan 11 13:58:42 2019] Current state: 1
>> [Fri Jan 11 13:58:42 2019] WARNING: CPU: 3 PID: 0 at
>> kernel/time/clockevents.c:133 clockevents_switch_state+0x48/0xe0
>> [Fri Jan 11 13:58:42 2019] Modules linked in:
>> [Fri Jan 11 13:58:42 2019] CPU: 3 PID: 0 Comm: swapper/3 Not tainted
>> 4.19.14+ #1
>> [Fri Jan 11 13:58:42 2019] RIP: e030:clockevents_switch_state+0x48/0xe0
>> [Fri Jan 11 13:58:42 2019] Code: 8b 0c cd 40 ee 00 82 e9 d6 5b d1 00 80
>> 3d 8e 8d 43 01 00 75 17 89 c6 48 c7 c7 92 62 1f 82 c6 05 7c 8d 43 01 01
>> e8 f8 22 f8 ff <0f> 0b 5b 5d f3 c3 83 e2 01 74 f7 48 8b 47 48 48 85 c0
>> 74 69 48 89
>> [Fri Jan 11 13:58:42 2019] RSP: e02b:ffffc90000787e30 EFLAGS: 00010082
>> [Fri Jan 11 13:58:42 2019] RAX: 0000000000000000 RBX: ffff88805df94d80
>> RCX: 0000000000000006
>> [Fri Jan 11 13:58:42 2019] RDX: 0000000000000007 RSI: 0000000000000001
>> RDI: ffff88805df963f0
>> [Fri Jan 11 13:58:42 2019] RBP: 0000000000000004 R08: 0000000000000000
>> R09: 0000000000000119
>> [Fri Jan 11 13:58:42 2019] R10: 0000000000000020 R11: ffffffff82af4e2d
>> R12: ffff88805df9ca40
>> [Fri Jan 11 13:58:42 2019] R13: 0000000dd28d6ca6 R14: 0000000000000000
>> R15: 0000000000000000
>> [Fri Jan 11 13:58:42 2019] FS:  00007f34193ce040(0000)
>> GS:ffff88805df80000(0000) knlGS:0000000000000000
>> [Fri Jan 11 13:58:42 2019] CS:  e033 DS: 002b ES: 002b CR0: 0000000080050033
>> [Fri Jan 11 13:58:42 2019] CR2: 00007f6220be50e1 CR3: 000000005ce5c000
>> CR4: 0000000000002660
>> [Fri Jan 11 13:58:42 2019] Call Trace:
>> [Fri Jan 11 13:58:42 2019]  tick_program_event+0x4b/0x70
>> [Fri Jan 11 13:58:42 2019]  hrtimer_try_to_cancel+0xa8/0x100
>> [Fri Jan 11 13:58:42 2019]  hrtimer_cancel+0x10/0x20
>> [Fri Jan 11 13:58:42 2019]  __tick_nohz_idle_restart_tick+0x45/0xd0
>> [Fri Jan 11 13:58:42 2019]  tick_nohz_idle_exit+0x93/0xa0
>> [Fri Jan 11 13:58:42 2019]  do_idle+0x149/0x260
>> [Fri Jan 11 13:58:42 2019]  cpu_startup_entry+0x6a/0x70
>> [Fri Jan 11 13:58:42 2019] ---[ end trace 519c07d1032908f8 ]---
>> [Fri Jan 11 13:58:42 2019] xen:grant_table: Grant tables using version 1
>> layout
>> [Fri Jan 11 13:58:42 2019] OOM killer enabled.
>> [Fri Jan 11 13:58:42 2019] Restarting tasks ... done.
>> [Fri Jan 11 13:58:42 2019] Setting capacity to 6291456
>> [Fri Jan 11 13:58:42 2019] Setting capacity to 10485760
>>
>> This always happens on every *first* live migrate that I do after
>> starting the domU.
> 
> Yeah, its a WARN_ONCE().
> 
> And you didn't see it with v1 of the patch?

No.

> On the first glance this might be another bug just being exposed by
> my patch.
> 
> I'm investigating further, but this might take some time. Could you
> meanwhile verify the same happens with kernel 5.0-rc1? That was the
> one I tested with and I didn't spot that WARN.

I have Linux 5.0-rc1 with v2 on top now, which gives me this on live
migrate:

[   51.845967] xen:grant_table: Grant tables using version 1 layout
[   51.871076] BUG: unable to handle kernel NULL pointer dereference at
0000000000000098
[   51.871091] #PF error: [normal kernel read fault]
[   51.871100] PGD 0 P4D 0
[   51.871109] Oops: 0000 [#1] SMP NOPTI
[   51.871117] CPU: 0 PID: 36 Comm: xenwatch Not tainted 5.0.0-rc1 #1
[   51.871132] RIP: e030:blk_mq_map_swqueue+0x103/0x270
[   51.871141] Code: 41 39 45 30 76 97 8b 0a 85 c9 74 ed 89 c1 48 c1 e1
04 49 03 8c 24 c0 05 00 00 48 8b 09 42 8b 3c 39 49 8b 4c 24 58 48 8b 0c
f9 <4c> 0f a3 b1 98 00 00 00 72 c5 f0 4c 0f ab b1 98 00 00 00 44 0f b7
[   51.871161] RSP: e02b:ffffc900008afca8 EFLAGS: 00010282
[   51.871173] RAX: 0000000000000000 RBX: ffffffff82541728 RCX:
0000000000000000
[   51.871184] RDX: ffff88805d0fae70 RSI: ffff88805deaa940 RDI:
0000000000000001
[   51.871196] RBP: ffff88805be8b720 R08: 0000000000000001 R09:
ffffea0001699900
[   51.871206] R10: 0000000000000000 R11: 0000000000000001 R12:
ffff88805be8b218
[   51.871217] R13: ffff88805d0fae68 R14: 0000000000000001 R15:
0000000000000004
[   51.871237] FS:  00007faa50fac040(0000) GS:ffff88805de00000(0000)
knlGS:0000000000000000
[   51.871252] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.871261] CR2: 0000000000000098 CR3: 000000005c6e6000 CR4:
0000000000002660
[   51.871275] Call Trace:
[   51.871285]  blk_mq_update_nr_hw_queues+0x2fd/0x380
[   51.871297]  blkfront_resume+0x200/0x3f0
[   51.871307]  xenbus_dev_resume+0x48/0xf0
[   51.871317]  ? xenbus_dev_probe+0x120/0x120
[   51.871326]  dpm_run_callback+0x3c/0x160
[   51.871336]  device_resume+0xce/0x1d0
[   51.871344]  dpm_resume+0x115/0x2f0
[   51.871352]  ? find_watch+0x40/0x40
[   51.871360]  dpm_resume_end+0x8/0x10
[   51.871370]  do_suspend+0xef/0x1b0
[   51.871378]  shutdown_handler+0x123/0x150
[   51.871387]  xenwatch_thread+0xbb/0x160
[   51.871397]  ? wait_woken+0x80/0x80
[   51.871406]  kthread+0xf3/0x130
[   51.871416]  ? kthread_create_worker_on_cpu+0x70/0x70
[   51.871427]  ret_from_fork+0x35/0x40
[   51.871435] Modules linked in:
[   51.871443] CR2: 0000000000000098
[   51.871452] ---[ end trace 84a3a6932d70aa71 ]---
[   51.871461] RIP: e030:blk_mq_map_swqueue+0x103/0x270
[   51.871471] Code: 41 39 45 30 76 97 8b 0a 85 c9 74 ed 89 c1 48 c1 e1
04 49 03 8c 24 c0 05 00 00 48 8b 09 42 8b 3c 39 49 8b 4c 24 58 48 8b 0c
f9 <4c> 0f a3 b1 98 00 00 00 72 c5 f0 4c 0f ab b1 98 00 00 00 44 0f b7
[   51.871491] RSP: e02b:ffffc900008afca8 EFLAGS: 00010282
[   51.871501] RAX: 0000000000000000 RBX: ffffffff82541728 RCX:
0000000000000000
[   51.871512] RDX: ffff88805d0fae70 RSI: ffff88805deaa940 RDI:
0000000000000001
[   51.871523] RBP: ffff88805be8b720 R08: 0000000000000001 R09:
ffffea0001699900
[   51.871533] R10: 0000000000000000 R11: 0000000000000001 R12:
ffff88805be8b218
[   51.871545] R13: ffff88805d0fae68 R14: 0000000000000001 R15:
0000000000000004
[   51.871562] FS:  00007faa50fac040(0000) GS:ffff88805de00000(0000)
knlGS:0000000000000000
[   51.871573] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.871582] CR2: 0000000000000098 CR3: 000000005c6e6000 CR4:
0000000000002660

When starting it on another test dom0 to see if the direction of
movement matters, it mostly fails to boot with:

[Fri Jan 11 16:16:34 2019] BUG: unable to handle kernel paging request
at ffff88805c61e9f0
[Fri Jan 11 16:16:34 2019] #PF error: [PROT] [WRITE]
[Fri Jan 11 16:16:34 2019] PGD 2410067 P4D 2410067 PUD 2c00067 PMD
5ff26067 PTE 801000005c61e065
[Fri Jan 11 16:16:34 2019] Oops: 0003 [#1] SMP NOPTI
[Fri Jan 11 16:16:34 2019] CPU: 3 PID: 1943 Comm: apt-get Not tainted
5.0.0-rc1 #1
[Fri Jan 11 16:16:34 2019] RIP: e030:move_page_tables+0x669/0x970
[Fri Jan 11 16:16:34 2019] Code: 8a 00 48 8b 03 31 ff 48 89 44 24 18 e8
c6 ab e7 ff 66 90 48 89 c6 48 89 df e8 c3 cc e7 ff 66 90 48 8b 44 24 18
b9 0c 00 00 00 <48> 89 45 00 48 8b 44 24 08 f6 40 52 40 0f 85 69 02 00
00 48 8b 44
[Fri Jan 11 16:16:34 2019] RSP: e02b:ffffc900008c7d70 EFLAGS: 00010282
[Fri Jan 11 16:16:34 2019] RAX: 0000000cb064b067 RBX: ffff88805c61ea58
RCX: 000000000000000c
[Fri Jan 11 16:16:34 2019] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 0000000000000201
[Fri Jan 11 16:16:34 2019] RBP: ffff88805c61e9f0 R08: 0000000000000000
R09: 00000000000260a0
[Fri Jan 11 16:16:34 2019] R10: 0000000000007ff0 R11: ffff88805fd23000
R12: ffffea00017187a8
[Fri Jan 11 16:16:34 2019] R13: ffffea00017187a8 R14: 00007f04e9800000
R15: 00007f04e9600000
[Fri Jan 11 16:16:34 2019] FS:  00007f04ef355100(0000)
GS:ffff88805df80000(0000) knlGS:0000000000000000
[Fri Jan 11 16:16:34 2019] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[Fri Jan 11 16:16:34 2019] CR2: ffff88805c61e9f0 CR3: 000000005c5fc000
CR4: 0000000000002660
[Fri Jan 11 16:16:34 2019] Call Trace:
[Fri Jan 11 16:16:34 2019]  move_vma.isra.34+0xd1/0x2d0
[Fri Jan 11 16:16:34 2019]  __x64_sys_mremap+0x1b3/0x370
[Fri Jan 11 16:16:34 2019]  do_syscall_64+0x49/0x100
[Fri Jan 11 16:16:34 2019]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Fri Jan 11 16:16:34 2019] RIP: 0033:0x7f04ee2e227a
[Fri Jan 11 16:16:34 2019] Code: 73 01 c3 48 8b 0d 1e fc 2a 00 f7 d8 64
89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 19
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ee fb 2a 00 f7 d8
64 89 01 48
[Fri Jan 11 16:16:34 2019] RSP: 002b:00007fffb3da3e38 EFLAGS: 00000246
ORIG_RAX: 0000000000000019
[Fri Jan 11 16:16:34 2019] RAX: ffffffffffffffda RBX: 000056533fa1bf50
RCX: 00007f04ee2e227a
[Fri Jan 11 16:16:34 2019] RDX: 0000000001a00000 RSI: 0000000001900000
RDI: 00007f04e95ac000
[Fri Jan 11 16:16:34 2019] RBP: 0000000001a00000 R08: 2e8ba2e8ba2e8ba3
R09: 0000000000000040
[Fri Jan 11 16:16:34 2019] R10: 0000000000000001 R11: 0000000000000246
R12: 00007f04e95ac060
[Fri Jan 11 16:16:34 2019] R13: 00007f04e95ac000 R14: 000056533fa45d73
R15: 000056534024bd10
[Fri Jan 11 16:16:34 2019] Modules linked in:
[Fri Jan 11 16:16:34 2019] CR2: ffff88805c61e9f0
[Fri Jan 11 16:16:34 2019] ---[ end trace 443702bd9ba5d6b2 ]---
[Fri Jan 11 16:16:34 2019] RIP: e030:move_page_tables+0x669/0x970
[Fri Jan 11 16:16:34 2019] Code: 8a 00 48 8b 03 31 ff 48 89 44 24 18 e8
c6 ab e7 ff 66 90 48 89 c6 48 89 df e8 c3 cc e7 ff 66 90 48 8b 44 24 18
b9 0c 00 00 00 <48> 89 45 00 48 8b 44 24 08 f6 40 52 40 0f 85 69 02 00
00 48 8b 44
[Fri Jan 11 16:16:34 2019] RSP: e02b:ffffc900008c7d70 EFLAGS: 00010282
[Fri Jan 11 16:16:34 2019] RAX: 0000000cb064b067 RBX: ffff88805c61ea58
RCX: 000000000000000c
[Fri Jan 11 16:16:34 2019] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 0000000000000201
[Fri Jan 11 16:16:34 2019] RBP: ffff88805c61e9f0 R08: 0000000000000000
R09: 00000000000260a0
[Fri Jan 11 16:16:34 2019] R10: 0000000000007ff0 R11: ffff88805fd23000
R12: ffffea00017187a8
[Fri Jan 11 16:16:34 2019] R13: ffffea00017187a8 R14: 00007f04e9800000
R15: 00007f04e9600000
[Fri Jan 11 16:16:34 2019] FS:  00007f04ef355100(0000)
GS:ffff88805df80000(0000) knlGS:0000000000000000
[Fri Jan 11 16:16:34 2019] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[Fri Jan 11 16:16:34 2019] CR2: ffff88805c61e9f0 CR3: 000000005c5fc000
CR4: 0000000000002660

I can log in over ssh, but a command like ps afxu hangs. Oh, it seems
that 5.0-rc1 is doing this all the time. Next time it's after 500
seconds uptime.

xl destroy and trying again, it boots. 1st live migrate successful (and
no clockevents_switch_state complaints), second one explodes with
blk_mq_update_nr_hw_queues again.

Hmok, as long as I live migrate the 5.0-rc1 domU around between dom0s
with Xen 4.11.1-pre from commit 5acdd26fdc (the one we had in debian
until yesterday) and Linux 4.19.9 in the dom0, it works. As soon as I
live migrate to the one box running the new Xen 4.11.1 package from
Debian unstable, and Linux 4.19.12, then I get the
blk_mq_update_nr_hw_queues.

If I do the same with 4.19 in the domU, I don't get
blk_mq_update_nr_hw_queues.

Now, back to 4.19.14 + guard_hole + v2, I can't seem to reproduce the
clockevents_switch_state any more. I'll take a break and then see to
find out if I'm doing anything different than earlier today when I could
reproduce it 100% consistently.

O_o :)

Hans
