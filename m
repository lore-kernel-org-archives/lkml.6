Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8208DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451CD213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551166842;
	bh=YUcisd80iFb7q9JwO/4mPuqV2bi19JyOswgO1k2KTRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p7i+YZClGdCiMe4c58xJtvxIPGCvtScGufWJCSTp7zMta4QJaJNIxuJNaOd0jJ0TA
	 qO/1hjaVXMyqdLE+ouTP1bCoFHeFUNvCfgG5NtrobVRVoOmBMd/TGCCL7y9EjiSbZa
	 +oKrl6sQM3nKw6I3otstTWgDCb2lDh11uqfY/FkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfBZHkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:40:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfBZHkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:40:40 -0500
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net [107.3.167.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1AC213A2;
        Tue, 26 Feb 2019 07:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551166838;
        bh=YUcisd80iFb7q9JwO/4mPuqV2bi19JyOswgO1k2KTRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itcfsFEi9xOlZ/sx8X0b0JYwhRSlHMo1QkJ/rdkDCpgneemYIScNKVt4JJMRiOjsb
         TU8PwNI756TDeqjHJWNvUVeV8IfU+ydYsstpaznYgQ4ppLc/O7N39aXOfMfz2axcRN
         SZVMk8CJRtNaj+lDAAVL0ojC5OrdMLdbtdlmerI0=
Date:   Mon, 25 Feb 2019 23:40:36 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+54bcc120da8da091d609@syzkaller.appspotmail.com>
Cc:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in tls_push_sg
Message-ID: <20190226074036.GE676@sol.localdomain>
References: <0000000000006a3ec5056f0c25cb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006a3ec5056f0c25cb@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:34:01PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ba4dbdedd3ed Merge tag 'jfs-4.18' of git://github.com/klei..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=112e9ce4400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f390986c4f7cd566
> dashboard link: https://syzkaller.appspot.com/bug?extid=54bcc120da8da091d609
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+54bcc120da8da091d609@syzkaller.appspotmail.com
> 
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor0'.
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 1 PID: 27979 Comm: syz-executor6 Not tainted 4.18.0-rc1+ #109
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
> RIP: 0010:compound_head include/linux/page-flags.h:142 [inline]
> RIP: 0010:put_page include/linux/mm.h:911 [inline]
> RIP: 0010:tls_push_sg+0x2a3/0x880 net/tls/tls_main.c:142
> Code: fa 4d 39 e5 75 a2 e8 bc 50 f1 fa 48 8b 85 08 ff ff ff 49 8d 7f 08 48
> b9 00 00 00 00 00 fc ff df c6 00 00 48 89 f8 48 c1 e8 03 <80> 3c 08 00 0f 85
> 50 05 00 00 48 8b 85 08 ff ff ff 49 8b 5f 08 80
> RSP: 0018:ffff8801c5776d90 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: ffffffff868a59e4 RDI: 0000000000000008
> RBP: ffff8801c5776eb0 R08: ffff88018e4fc6c0 R09: ffff8801c5776668
> R10: 0000000000000003 R11: 0000000000000002 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f2d08c17700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000001ffffcc0 CR3: 0000000188ce8000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  tls_push_record+0xaec/0x1400 net/tls/tls_sw.c:264
>  tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:276
>  tls_handle_open_record net/tls/tls_main.c:164 [inline]
>  tls_sk_proto_close+0x74c/0xae0 net/tls/tls_main.c:264
>  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
>  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
>  __sock_release+0xd7/0x260 net/socket.c:603
>  sock_close+0x19/0x20 net/socket.c:1186
>  __fput+0x35b/0x8b0 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x1b08/0x2750 kernel/exit.c:865
>  do_group_exit+0x177/0x440 kernel/exit.c:968
>  get_signal+0x88e/0x1970 kernel/signal.c:2468
>  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
>  exit_to_usermode_loop+0x2de/0x370 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455b29
> Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f2d08c16ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 000000000072bec8 RCX: 0000000000455b29
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bec8
> RBP: 000000000072bec8 R08: 0000000000000033 R09: 000000000072bea0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000a3e81f R14: 00007f2d08c179c0 R15: 0000000000000000
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace d9dfd7279b1a9c99 ]---
> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
> RIP: 0010:compound_head include/linux/page-flags.h:142 [inline]
> RIP: 0010:put_page include/linux/mm.h:911 [inline]
> RIP: 0010:tls_push_sg+0x2a3/0x880 net/tls/tls_main.c:142
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
> 

(As with the other reports of this...)

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
