Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932472AbeCKX47 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 19:56:59 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36614 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932417AbeCKX45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 19:56:57 -0400
X-Google-Smtp-Source: AG47ELuhug6W65fCbodZg/nwNqmHPhT8S5QjO2jGNbsr4hyPzI6DRTXdeVCCBHLBxDjcWpD2z4DutA==
Date: Sun, 11 Mar 2018 16:56:53 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        syzbot
        <bot+f00b2fc1cf284703bf4107c0ea565aafd9b536d0@syzkaller.appspotmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in tracepoint_probe_unregister
Message-ID: <20180311235653.GC2267@zzz.localdomain>
References: <001a114089d6731471055d37cb25@google.com>
 <CACT4Y+Z7HAx4S-MUYPME1HiNNxAmTuaBOkJXmZ7s065xxyzwuA@mail.gmail.com>
 <c25941df-7d3f-a5db-4fbc-160b105674f6@kernel.dk>
 <CACT4Y+aDXnM5mmNjB-5UByNEKYNFTBDfk8jVCqYyBZyW=VfRsQ@mail.gmail.com>
 <1e1d21d2-e8b2-7543-a915-2681dbcc1281@kernel.dk>
 <CACT4Y+bUJs_1JUoXJNmsHbss4tipT4cg20qVjiEHA0WGCMz8XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bUJs_1JUoXJNmsHbss4tipT4cg20qVjiEHA0WGCMz8XQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2017 at 09:06:40AM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Tue, Nov 7, 2017 at 7:08 PM, Jens Axboe <axboe@kernel.dk> wrote:
> > On 11/07/2017 11:06 AM, Dmitry Vyukov wrote:
> >> On Sun, Nov 5, 2017 at 4:47 PM, Jens Axboe <axboe@kernel.dk> wrote:
> >>> On 11/05/2017 01:09 AM, Dmitry Vyukov wrote:
> >>>> On Sun, Nov 5, 2017 at 11:05 AM, syzbot
> >>>> <bot+f00b2fc1cf284703bf4107c0ea565aafd9b536d0@syzkaller.appspotmail.com>
> >>>> wrote:
> >>>>> Hello,
> >>>>>
> >>>>> syzkaller hit the following crash on
> >>>>> 36ef71cae353f88fd6e095e2aaa3e5953af1685d
> >>>>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> >>>>> compiler: gcc (GCC) 7.1.1 20170620
> >>>>> .config is attached
> >>>>> Raw console output is attached.
> >>>>> C reproducer is attached
> >>>>> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> >>>>> for information about syzkaller reproducers
> >>>>>
> >>>>>
> >>>>> WARNING: CPU: 1 PID: 2992 at kernel/tracepoint.c:243 tracepoint_remove_func
> >>>>> kernel/tracepoint.c:243 [inline]
> >>>>> WARNING: CPU: 1 PID: 2992 at kernel/tracepoint.c:243
> >>>>> tracepoint_probe_unregister+0x6b3/0x870 kernel/tracepoint.c:324
> >>>>> Kernel panic - not syncing: panic_on_warn set ...
> >>>>>
> >>>>> CPU: 1 PID: 2992 Comm: syzkaller812809 Not tainted 4.14.0-rc5-next-20171018+
> >>>>> #8
> >>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> >>>>> Call Trace:
> >>>>>  __dump_stack lib/dump_stack.c:16 [inline]
> >>>>>  dump_stack+0x194/0x257 lib/dump_stack.c:52
> >>>>>  panic+0x1e4/0x41c kernel/panic.c:183
> >>>>>  __warn+0x1c4/0x1e0 kernel/panic.c:546
> >>>>>  report_bug+0x211/0x2d0 lib/bug.c:183
> >>>>>  fixup_bug+0x40/0x90 arch/x86/kernel/traps.c:177
> >>>>>  do_trap_no_signal arch/x86/kernel/traps.c:211 [inline]
> >>>>>  do_trap+0x260/0x390 arch/x86/kernel/traps.c:260
> >>>>>  do_error_trap+0x120/0x390 arch/x86/kernel/traps.c:297
> >>>>>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:310
> >>>>>  invalid_op+0x18/0x20 arch/x86/entry/entry_64.S:905
> >>>>> RIP: 0010:tracepoint_remove_func kernel/tracepoint.c:243 [inline]
> >>>>> RIP: 0010:tracepoint_probe_unregister+0x6b3/0x870 kernel/tracepoint.c:324
> >>>>> RSP: 0018:ffff8800397df890 EFLAGS: 00010293
> >>>>> RAX: ffff88003982e8c0 RBX: 00000000fffffffe RCX: ffffffff81710233
> >>>>> RDX: 0000000000000000 RSI: ffffffff85b679c0 RDI: 0000000000000282
> >>>>> RBP: ffff8800397df9a8 R08: 0000000000000001 R09: 1ffff100072fbe6e
> >>>>> R10: ffff8800397df880 R11: 0000000000000001 R12: ffffffff8175b5e0
> >>>>> R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8800397df980
> >>>>>  unregister_trace_block_rq_remap include/trace/events/block.h:602 [inline]
> >>>>>  blk_unregister_tracepoints+0x1e/0x160 kernel/trace/blktrace.c:1079
> >>>>>  blk_trace_cleanup+0x28/0x30 kernel/trace/blktrace.c:336
> >>>>>  blk_trace_remove+0x55/0x80 kernel/trace/blktrace.c:348
> >>>>>  sg_ioctl+0x5eb/0x2d90 drivers/scsi/sg.c:1098
> >>>>>  vfs_ioctl fs/ioctl.c:45 [inline]
> >>>>>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:685
> >>>>>  SYSC_ioctl fs/ioctl.c:700 [inline]
> >>>>>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
> >>>>>  entry_SYSCALL_64_fastpath+0x1f/0xbe
> >>>>> RIP: 0033:0x4396a9
> >>>>> RSP: 002b:00007ffd4d3facb8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> >>>>> RAX: ffffffffffffffda RBX: 00000000006ccac0 RCX: 00000000004396a9
> >>>>> RDX: 000000002002d000 RSI: 4000000000001276 RDI: 0000000000000004
> >>>>> RBP: 0000000000000082 R08: 00000000000000fe R09: 0000000000000000
> >>>>> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000038
> >>>>> R13: ffffffffffffffff R14: 0000000000401eb0 R15: 0000000000000000
> >>>>> Dumping ftrace buffer:
> >>>>>    (ftrace buffer empty)
> >>>>> Kernel Offset: disabled
> >>>>> Rebooting in 86400 seconds..
> >>>>
> >>>>
> >>>> Jens, this has the same root cause as "WARNING in
> >>>> tracepoint_probe_register_prio":
> >>>> https://groups.google.com/forum/#!msg/syzkaller-bugs/9IolqTA_NUk/LgLFZ6hQAQAJ
> >>>> right?
> >>>
> >>> Yep, it is - can/did you check the patch I sent out yesterday for this?
> >>> Here it is again.
> >>
> >> I re-run the attached reproducer and it does not trigger the warning
> >> with the patch:
> >>
> >> Tested-by: Dmitry Vyukov <dvyukov@google.com>
> >
> > Great, thanks for testing!
> 
> 
> Please also follow this part on the patch reaches any of the trees:
> 
> > syzbot will keep track of this bug report.
> > Once a fix for this bug is committed, please reply to this email with:
> > #syz fix: exact-commit-title
> > Note: all commands must start from beginning of the line.
> 
> This will greatly help keeping the whole process running and report
> new bugs in future.
> 

A bit late, but the fix seems to have been committed as a6da0024ffc19, so
telling syzbot:

#syz fix: blktrace: fix unlocked registration of tracepoints

(Actually, syzbot is still hitting this same WARNING, but it appears to be a
different cause, involving perf_trace_event_unreg().  It should get reported as
a new bug shortly...)

- Eric
