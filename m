Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF1DC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2A420872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfAKOBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:01:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:39468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725803AbfAKOBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:01:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90185AD7F;
        Fri, 11 Jan 2019 14:01:12 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH v2] xen: Fix x86 sched_clock() interface for
 xen
To:     Hans van Kranenburg <hans@knorrie.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     sstabellini@kernel.org, stable@vger.kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, boris.ostrovsky@oracle.com,
        tglx@linutronix.de
References: <20190111120805.24852-1-jgross@suse.com>
 <74aafdff-c7d5-b9aa-c3fb-3787d36c7bbe@knorrie.org>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8ec039c6-d0fc-c7f4-72a4-ae677c9bbb68@suse.com>
Date:   Fri, 11 Jan 2019 15:01:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <74aafdff-c7d5-b9aa-c3fb-3787d36c7bbe@knorrie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2019 14:12, Hans van Kranenburg wrote:
> Hi,
> 
> On 1/11/19 1:08 PM, Juergen Gross wrote:
>> Commit f94c8d11699759 ("sched/clock, x86/tsc: Rework the x86 'unstable'
>> sched_clock() interface") broke Xen guest time handling across
>> migration:
>>
>> [  187.249951] Freezing user space processes ... (elapsed 0.001 seconds) done.
>> [  187.251137] OOM killer disabled.
>> [  187.251137] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>> [  187.252299] suspending xenstore...
>> [  187.266987] xen:grant_table: Grant tables using version 1 layout
>> [18446743811.706476] OOM killer enabled.
>> [18446743811.706478] Restarting tasks ... done.
>> [18446743811.720505] Setting capacity to 16777216
>>
>> Fix that by setting xen_sched_clock_offset at resume time to ensure a
>> monotonic clock value.
>>
>> [...]
> 
> I'm throwing around a PV domU over a bunch of test servers with live
> migrate now, and in between the kernel logging, I'm seeing this:
> 
> [Fri Jan 11 13:58:42 2019] Freezing user space processes ... (elapsed
> 0.002 seconds) done.
> [Fri Jan 11 13:58:42 2019] OOM killer disabled.
> [Fri Jan 11 13:58:42 2019] Freezing remaining freezable tasks ...
> (elapsed 0.000 seconds) done.
> [Fri Jan 11 13:58:42 2019] suspending xenstore...
> [Fri Jan 11 13:58:42 2019] ------------[ cut here ]------------
> [Fri Jan 11 13:58:42 2019] Current state: 1
> [Fri Jan 11 13:58:42 2019] WARNING: CPU: 3 PID: 0 at
> kernel/time/clockevents.c:133 clockevents_switch_state+0x48/0xe0
> [Fri Jan 11 13:58:42 2019] Modules linked in:
> [Fri Jan 11 13:58:42 2019] CPU: 3 PID: 0 Comm: swapper/3 Not tainted
> 4.19.14+ #1
> [Fri Jan 11 13:58:42 2019] RIP: e030:clockevents_switch_state+0x48/0xe0
> [Fri Jan 11 13:58:42 2019] Code: 8b 0c cd 40 ee 00 82 e9 d6 5b d1 00 80
> 3d 8e 8d 43 01 00 75 17 89 c6 48 c7 c7 92 62 1f 82 c6 05 7c 8d 43 01 01
> e8 f8 22 f8 ff <0f> 0b 5b 5d f3 c3 83 e2 01 74 f7 48 8b 47 48 48 85 c0
> 74 69 48 89
> [Fri Jan 11 13:58:42 2019] RSP: e02b:ffffc90000787e30 EFLAGS: 00010082
> [Fri Jan 11 13:58:42 2019] RAX: 0000000000000000 RBX: ffff88805df94d80
> RCX: 0000000000000006
> [Fri Jan 11 13:58:42 2019] RDX: 0000000000000007 RSI: 0000000000000001
> RDI: ffff88805df963f0
> [Fri Jan 11 13:58:42 2019] RBP: 0000000000000004 R08: 0000000000000000
> R09: 0000000000000119
> [Fri Jan 11 13:58:42 2019] R10: 0000000000000020 R11: ffffffff82af4e2d
> R12: ffff88805df9ca40
> [Fri Jan 11 13:58:42 2019] R13: 0000000dd28d6ca6 R14: 0000000000000000
> R15: 0000000000000000
> [Fri Jan 11 13:58:42 2019] FS:  00007f34193ce040(0000)
> GS:ffff88805df80000(0000) knlGS:0000000000000000
> [Fri Jan 11 13:58:42 2019] CS:  e033 DS: 002b ES: 002b CR0: 0000000080050033
> [Fri Jan 11 13:58:42 2019] CR2: 00007f6220be50e1 CR3: 000000005ce5c000
> CR4: 0000000000002660
> [Fri Jan 11 13:58:42 2019] Call Trace:
> [Fri Jan 11 13:58:42 2019]  tick_program_event+0x4b/0x70
> [Fri Jan 11 13:58:42 2019]  hrtimer_try_to_cancel+0xa8/0x100
> [Fri Jan 11 13:58:42 2019]  hrtimer_cancel+0x10/0x20
> [Fri Jan 11 13:58:42 2019]  __tick_nohz_idle_restart_tick+0x45/0xd0
> [Fri Jan 11 13:58:42 2019]  tick_nohz_idle_exit+0x93/0xa0
> [Fri Jan 11 13:58:42 2019]  do_idle+0x149/0x260
> [Fri Jan 11 13:58:42 2019]  cpu_startup_entry+0x6a/0x70
> [Fri Jan 11 13:58:42 2019] ---[ end trace 519c07d1032908f8 ]---
> [Fri Jan 11 13:58:42 2019] xen:grant_table: Grant tables using version 1
> layout
> [Fri Jan 11 13:58:42 2019] OOM killer enabled.
> [Fri Jan 11 13:58:42 2019] Restarting tasks ... done.
> [Fri Jan 11 13:58:42 2019] Setting capacity to 6291456
> [Fri Jan 11 13:58:42 2019] Setting capacity to 10485760
> 
> This always happens on every *first* live migrate that I do after
> starting the domU.

Yeah, its a WARN_ONCE().

And you didn't see it with v1 of the patch?

On the first glance this might be another bug just being exposed by
my patch.

I'm investigating further, but this might take some time. Could you
meanwhile verify the same happens with kernel 5.0-rc1? That was the
one I tested with and I didn't spot that WARN.


Juergen
