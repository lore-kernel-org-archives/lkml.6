Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbeD3NWg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:22:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752110AbeD3NWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:22:35 -0400
Date: Mon, 30 Apr 2018 15:22:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+b109633ea805cac54a61@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, ldv@altlinux.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING in task_participate_group_stop (2)
Message-ID: <20180430132232.GA7990@redhat.com>
References: <0000000000001490fb056affabd8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001490fb056affabd8@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29, syzbot wrote:
>
> RIP: 0010:task_participate_group_stop+0x205/0x260 kernel/signal.c:351
> RSP: 0018:ffff8801ae7b7880 EFLAGS: 00010093
> RAX: ffff8801d96200c0 RBX: 0000000000000000 RCX: ffffffff81498b5b
> RDX: 0000000000000000 RSI: ffffffff81498c75 RDI: 0000000000000005
> RBP: ffff8801ae7b78a0 R08: ffff8801d96200c0 R09: ffffed0036c48971
> R10: ffffed0036c48971 R11: ffff8801b6244b8b R12: ffff8801d926ecd8
> R13: ffff8801d926ec40 R14: 0000000000040000 R15: dffffc0000000000
>  do_signal_stop+0x502/0xa20 kernel/signal.c:2176
>  get_signal+0x9b4/0x1960 kernel/signal.c:2353
>  do_signal+0x98/0x2040 arch/x86/kernel/signal.c:810
>  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Thanks... I need to think and recall how this code works, but at first glance
zap_other_threads() needs task_clear_jobctl_pending(current).

I am almost sure the warning should go away, but iiuc there are more problems
and it is not clear to me what can we do...

Oleg.
