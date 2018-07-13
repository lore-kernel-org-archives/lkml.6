Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5DAECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F297A2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F297A2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbeGMWOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:14:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38950 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbeGMWOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:14:42 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 42913BAE;
        Fri, 13 Jul 2018 21:58:12 +0000 (UTC)
Date:   Fri, 13 Jul 2018 14:58:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com>
Cc:     adobriyan@gmail.com, gs051095@gmail.com, jhugo@codeaurora.org,
        jpoimboe@redhat.com, lauraa@codeaurora.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        mingo@kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        thomas.lendacky@amd.com
Subject: Re: unexpected kernel reboot (3)
Message-Id: <20180713145811.683ffd0043cac26a5a5af725@linux-foundation.org>
In-Reply-To: <000000000000eb546f0570e84e90@google.com>
References: <000000000000eb546f0570e84e90@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 14:39:02 -0700 syzbot <syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following crash on:

hm, I don't think I've seen an "unexpected reboot" report before.

Can you expand on specifically what happened here?  Did the machine
simply magically reboot itself?  Or did an external monitor whack it,
or...

Does this test distinguish from a kernel which simply locks up?

> HEAD commit:    1e4b044d2251 Linux 4.18-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17c6a6d0400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
> dashboard link: https://syzkaller.appspot.com/bug?extid=cce9ef2dd25246f815ee
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=165012c2400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1571462c400000

I assume the "C reproducer" is irrelevant here.

Is it reproducible?

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com
> 
> output_len: 0x00000000092459b0
> kernel_total_size: 0x000000000a505000
> trampoline_32bit: 0x000000000009d000
> 
> Decompressing Linux... Parsing ELF... done.
> Booting the kernel.
> [    0.000000] Linux version 4.18.0-rc4+ (syzkaller@ci) (gcc version 8.0.1  
> 20180413 (experimental) (GCC)) #138 SMP Mon Jul 9 10:45:11 UTC 2018
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz root=/dev/sda1  
> console=ttyS0 earlyprintk=serial vsyscall=native rodata=n  
> ftrace_dump_on_oops=orig_cpu oops=panic panic_on_warn=1 nmi_watchdog=panic  
> panic=86400 workqueue.watchdog_thresh=140 kvm-intel.nested=1  
>
> ...
>
> regulatory database
> [    4.519364] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    4.520839] platform regulatory.0: Direct firmware load for  
> regulatory.db failed with error -2
> [    4.522155] cfg80211: failed to load regulatory.db
> [    4.522185] ALSA device list:
> [    4.523499]   #0: Dummy 1
> [    4.523951]   #1: Loopback 1
> [    4.524389]   #2: Virtual MIDI Card 1
> [    4.825991] input: ImExPS/2 Generic Explorer Mouse as  
> /devices/platform/i8042/serio1/input/input4
> [    4.829533] md: Waiting for all devices to be available before autodetect
> [    4.830562] md: If you don't use raid, use raid=noautodetect
> [    4.835237] md: Autodetecting RAID arrays.
> [    4.835882] md: autorun ...
> [    4.836364] md: ... autorun DONE.

Can we assume that the failure occurred in or immediately after the MD code,
or might some output have been truncated?

It would be useful to know what the kernel was initializing immediately
after MD.  Do you have a kernel log for the same config when the kerenl
didn't fail?  Or maybe enable initcall_debug?

