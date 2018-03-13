Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934226AbeCMPg3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:36:29 -0400
Received: from mail.efficios.com ([167.114.142.138]:38036 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934189AbeCMPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:36:23 -0400
Date: Tue, 13 Mar 2018 11:29:54 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: syzbot <syzbot+4e9ae7fa46233396f64d@syzkaller.appspotmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        acme <acme@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        rostedt <rostedt@goodmis.org>, syzkaller-bugs@googlegroups.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Message-ID: <280278222.8876.1520954994543.JavaMail.zimbra@efficios.com>
In-Reply-To: <001a1140e0de15fc910567464190@google.com>
References: <001a1140e0de15fc910567464190@google.com>
Subject: Re: WARNING in tracepoint_probe_unregister (2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.6_GA_1906 (ZimbraWebClient - FF52 (Linux)/8.8.6_GA_1906)
Thread-Topic: WARNING in tracepoint_probe_unregister (2)
Thread-Index: MdCS0Kg6Q0i+oIRgJu0PDlbYHSDJ6w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 13, 2018, at 3:32 AM, syzbot syzbot+4e9ae7fa46233396f64d@syzkaller.appspotmail.com wrote:

> Hello,
> 
> syzbot hit the following crash on bpf-next commit
> 6d8cb045cde681e64a5ed80a2ab70be831a7f9b0 (Fri Mar 9 07:46:33 2018 +0000)
> bpf: comment why dots in filenames under BPF virtual FS are not allowed

Here is the splat on unregister. I suspect this is caused by trying to
unregister a tracepoint which is already unregistered (or not yet
registered).

Thanks,

Mathieu

> 
> So far this crash happened 2 times on bpf-next.
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4e9ae7fa46233396f64d@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> RAX: 0000000000000000 RBX: 00007f399ae5c6d4 RCX: 0000000000453e69
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000013
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000014
> R13: 0000000000000052 R14: 00000000006f0850 R15: 0000000000000000
> WARNING: CPU: 1 PID: 23319 at kernel/tracepoint.c:242
> tracepoint_remove_func kernel/tracepoint.c:242 [inline]
> WARNING: CPU: 1 PID: 23319 at kernel/tracepoint.c:242
> tracepoint_probe_unregister+0x6b3/0x870 kernel/tracepoint.c:323
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 1 PID: 23319 Comm: syz-executor6 Not tainted 4.16.0-rc4+ #28
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
> RIP: 0010:tracepoint_remove_func kernel/tracepoint.c:242 [inline]
> RIP: 0010:tracepoint_probe_unregister+0x6b3/0x870 kernel/tracepoint.c:323
> RSP: 0018:ffff8801c56a74d0 EFLAGS: 00010246
> RAX: 0000000000010000 RBX: 00000000fffffff4 RCX: ffffffff81735193
> RDX: 0000000000010000 RSI: ffffc900057fa000 RDI: 0000000000000286
> RBP: ffff8801c56a75e8 R08: 1ffff10038ad4ded R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801c1132dc0
> R13: 0000000000000000 R14: ffff8801c1132d90 R15: ffff8801c56a75c0
>  trace_event_reg+0xed/0x320 kernel/trace/trace_events.c:309
>  perf_trace_event_unreg.isra.2+0xad/0x1f0
> kernel/trace/trace_event_perf.c:155
>  perf_trace_destroy+0xbc/0x100 kernel/trace/trace_event_perf.c:236
>  tp_perf_event_destroy+0x15/0x20 kernel/events/core.c:7963
>  _free_event+0x3bd/0x10f0 kernel/events/core.c:4108
>  put_event+0x24/0x30 kernel/events/core.c:4191
>  perf_event_release_kernel+0x6e8/0xfc0 kernel/events/core.c:4297
>  perf_release+0x37/0x50 kernel/events/core.c:4307
>  __fput+0x327/0x7e0 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x199/0x270 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
>  exit_to_usermode_loop+0x275/0x2f0 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>  do_syscall_64+0x6ec/0x940 arch/x86/entry/common.c:292
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x453e69
> RSP: 002b:00007f399ae5bc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 00007f399ae5c6d4 RCX: 0000000000453e69
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000013
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000014
> R13: 0000000000000052 R14: 00000000006f0850 R15: 0000000000000000
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
