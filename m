Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92A0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74687208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74687208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeH0VeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbeH0VeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:34:03 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7364C2088E;
        Mon, 27 Aug 2018 17:46:28 +0000 (UTC)
Date:   Mon, 27 Aug 2018 13:46:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     syzbot <syzbot+1ec5c5ec949c4adaa0c4@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: WARNING in format_decode (2)
Message-ID: <20180827134626.1b943593@gandalf.local.home>
In-Reply-To: <000000000000e12d4105746dcb0d@google.com>
References: <000000000000e12d4105746dcb0d@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 10:10:04 -0700
syzbot <syzbot+1ec5c5ec949c4adaa0c4@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    2ad0d5269970 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b8efba400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79e695838ce7a210
> dashboard link: https://syzkaller.appspot.com/bug?extid=1ec5c5ec949c4adaa0c4
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1626f761400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1ec5c5ec949c4adaa0c4@syzkaller.appspotmail.com
> 
> **                                                      **
> **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> **********************************************************
> ------------[ cut here ]------------
> Please remove unsupported %WARNING: CPU: 0 PID: 6453 at lib/vsprintf.c:2149 format_decode+0x8fc/0xaf0  
> lib/vsprintf.c:2149
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 0 PID: 6453 Comm: syz-executor7 Not tainted 4.18.0+ #190
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>   panic+0x238/0x4e7 kernel/panic.c:184
>   __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>   report_bug+0x252/0x2d0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:178 [inline]
>   do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>   do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
> RIP: 0010:format_decode+0x8fc/0xaf0 lib/vsprintf.c:2149
> Code: e8 59 59 c9 fa 41 c6 04 24 12 e9 94 fd ff ff e8 4a 59 c9 fa 0f be f3  
> 48 c7 c7 60 bc 89 87 c6 05 28 aa d2 01 01 e8 e4 e9 93 fa <0f> 0b 4d 8b 7d  
> c0 e9 56 fe ff ff 48 8b bd 68 ff ff ff e8 cd 4f 08
> RSP: 0018:ffff8801b6b27688 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff816422b1 RDI: ffff8801b6b27378
> RBP: ffff8801b6b27730 R08: ffff8801b69a0040 R09: 0000000000000006
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801b6b277a8
> R13: ffff8801b6b27708 R14: 0000000000000000 R15: ffff8801b6b27b04
>   vsnprintf+0x185/0x1b60 lib/vsprintf.c:2245
>   vscnprintf+0x2d/0x80 lib/vsprintf.c:2396
>   __trace_array_vprintk.part.60+0xc7/0x330 kernel/trace/trace.c:2990
>   __trace_array_vprintk kernel/trace/trace.c:3021 [inline]
>   trace_array_vprintk kernel/trace/trace.c:3021 [inline]
>   trace_vprintk+0x5f/0x90 kernel/trace/trace.c:3059
>   __trace_printk+0xce/0x120 kernel/trace/trace_printk.c:237
>   ____bpf_trace_printk kernel/trace/bpf_trace.c:274 [inline]

Looks like a bug in the bpf trace printk code.

-- Steve

>   bpf_trace_printk+0xb16/0xc30 kernel/trace/bpf_trace.c:166
>   bpf_prog_e51deac1441bc083+0x94a/0x1000
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

