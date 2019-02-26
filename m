Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEC1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC74A217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551166083;
	bh=YiAEy09uFHLJOE7uVpKgH+MtlFTJ5wbfmIu6/1/ceGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ndqARjOsjJ2T3gkq9byC9/nLupQ1WDAaF9ZlP/rZ3GbtDh+S7Egh+ibpZHarFQw8J
	 z0FVpopg5jumRaD9UZ84Z0deYnu5NC/9edEfATkEIL0DsfBRFIOWgO/hK2kC455LqQ
	 vpidzmjMcUWRp4JmEXYgdJgwnq+GXqNYDEIKZVNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBZH2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfBZH2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:28:01 -0500
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net [107.3.167.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 518B4213A2;
        Tue, 26 Feb 2019 07:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551166079;
        bh=YiAEy09uFHLJOE7uVpKgH+MtlFTJ5wbfmIu6/1/ceGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INlJAOf+F3ESuap1h9C+iFsgfei2IrxHDv0EEeS2K/vaD7CH77n7SisOS1iPzAKge
         BFzt4lwZDOXgeGPWB5limeztwcltbo+xAz1ahL6BdFvlHaKeRtzhLE7mHPG1DL/WlR
         LBetZW5L+RZkDhKbHD3BELzRAdEMgBnZt1DX326s=
Date:   Mon, 25 Feb 2019 23:27:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+3225ce21c0e9929bb9cf@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: kernel BUG at include/linux/mm.h:LINE! (2)
Message-ID: <20190226072755.GB676@sol.localdomain>
References: <000000000000b5f145056e2121a4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b5f145056e2121a4@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:11:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7170e6045a6a strparser: Add __strp_unpause and use it in k..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=114236af800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a601a80fec461d44
> dashboard link: https://syzkaller.appspot.com/bug?extid=3225ce21c0e9929bb9cf
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10f44fdf800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110f636f800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3225ce21c0e9929bb9cf@syzkaller.appspotmail.com
> 
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 0000000000000000 0000000000000000 00000000ffffff80
> raw: ffffea0006b29220 ffff88021fffac18 0000000000000003 0000000000000000
> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) <= 0)
> ------------[ cut here ]------------
> kernel BUG at include/linux/mm.h:853!
> invalid opcode: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 1 PID: 4545 Comm: syz-executor492 Not tainted 4.17.0-rc7+ #82
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:get_page include/linux/mm.h:853 [inline]
> RIP: 0010:do_tcp_sendpages+0x1879/0x1e60 net/ipv4/tcp.c:1002
> RSP: 0018:ffff8801c2a06f88 EFLAGS: 00010203
> RAX: 0000000000000000 RBX: ffff8801d972d580 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81a66c25 RDI: ffffed0038540de0
> RBP: ffff8801c2a071e8 R08: ffff8801b11d2480 R09: 0000000000000006
> R10: ffff8801b11d2480 R11: 0000000000000000 R12: 000000000000301d
> R13: ffffea0006b2621c R14: ffff8801ae5a6040 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020008000 CR3: 0000000008c6a000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  tls_push_sg+0x25b/0x860 net/tls/tls_main.c:126
>  tls_push_record+0xae5/0x13e0 net/tls/tls_sw.c:266
>  tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:276
>  tls_handle_open_record net/tls/tls_main.c:164 [inline]
>  tls_sk_proto_close+0x734/0xad0 net/tls/tls_main.c:264
>  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
>  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
>  sock_release+0x96/0x1b0 net/socket.c:594
>  sock_close+0x16/0x20 net/socket.c:1149
>  __fput+0x34d/0x890 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x1e4/0x290 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x1aee/0x2730 kernel/exit.c:865
>  do_group_exit+0x16f/0x430 kernel/exit.c:968
>  __do_sys_exit_group kernel/exit.c:979 [inline]
>  __se_sys_exit_group kernel/exit.c:977 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x43f368
> RSP: 002b:00007ffd03500578 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f368
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00000000004bf448 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
> Code: ff ff 41 89 86 cc 08 00 00 e8 e4 07 05 00 e9 2c eb ff ff e8 ca 4b 27
> fb 48 8b bd b8 fd ff ff 48 c7 c6 40 0c 54 88 e8 77 72 54 fb <0f> 0b 48 89 85
> b8 fd ff ff e8 a9 4b 27 fb 48 8b 85 b8 fd ff ff
> RIP: get_page include/linux/mm.h:853 [inline] RSP: ffff8801c2a06f88
> RIP: do_tcp_sendpages+0x1879/0x1e60 net/ipv4/tcp.c:1002 RSP:
> ffff8801c2a06f88
> ---[ end trace 500a6e4fab99629c ]---
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
> 

AFAICS this was fixed by this commit:

	commit d829e9c4112b52f4f00195900fd4c685f61365ab
	Author: Daniel Borkmann <daniel@iogearbox.net>
	Date:   Sat Oct 13 02:45:59 2018 +0200

	    tls: convert to generic sk_msg interface

So telling syzbot:

#syz fix: tls: convert to generic sk_msg interface

The issue was that described in this comment in tls_sw_sendmsg():

                /* Open records defined only if successfully copied, otherwise
                 * we would trim the sg but not reset the open record frags.
                 */
                tls_ctx->pending_open_record_frags = true;

Basically, on sendmsg() to a TLS socket, if the message buffer was partially
unmapped, a TLS record would be marked as pending (and then tried to be sent at
sock_release() time) even though it had actually been discarded.

- Eric
