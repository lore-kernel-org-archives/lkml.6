Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB89C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0211921727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIyrnLJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0211921727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbeHNUX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:23:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43383 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbeHNUXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:23:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id a14-v6so9400212pgv.10;
        Tue, 14 Aug 2018 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vROZIL3cjnZVOMQ2fZq63XWf/+dZZAiCJ8dKrFGtfjY=;
        b=YIyrnLJXW9vGAnZSLlxb2sczdW1xwfPMnTelw8sy1mR+VCNyBQ0zgz/xS/gpf4vhEC
         KWxJ9gyt3h6fdM46mwknpPWF3CA6rD6QtYW3P8OiGAszCZ+cpx717BjMWLE4sqG3/F+A
         UcZ/Ije2oFzO+NjChP34hslN2fBadDtizG99cF1F7z4qIb75dPbpv+GrVUVCSAyOd6QT
         LRpO+PahaFgWqYdvDM82tgQ9r9wMeoQXBgVGfpX670fj0b82H0bNJClwqZbIYtybB8s0
         XL+ALMJEcAe/04liDW6sT7PGxtWYR3d7hTB0o3F1DunSmHjUV0BskqD35/Z5W210s0PE
         2sHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vROZIL3cjnZVOMQ2fZq63XWf/+dZZAiCJ8dKrFGtfjY=;
        b=nnyOeExpVNZVXPXlA05SCsEs2VzimQ+PAewvW92nc/dPMjYKeRjGehkOEF3Nsm4F3p
         LHBNP6EMoJFDwp51wKgfIqt+0mMiWWB0s3ixE5sFO/A+qlu/I/IHvsL3OyNALTFFEjD3
         Phh9OSWfghZghjlGkm2M+sHBoVBXPrBfw6q13VlPCDBfkFjN/4/awb3RildyDmXhk8vc
         oTO4dyj0EgeZB/RsRui991uskJPPND5oSFv+d/79eVT6hHGI9G1JXEFGY+11nQTfogxy
         cOfYgY9HoGKHXizqaQQba152Bi8Ua7lg6xb8DDSiOKT8fI4WvWy8bZf3SibdV56OvviU
         YHRg==
X-Gm-Message-State: AOUpUlFvd0rtW0ly/xbHn+uJ2PGsHkHuR139GyzFNDXPGucbSasw7bwC
        MiB71klMBNnvf4RWeRd5TDfvtitUswIabMdVmOI=
X-Google-Smtp-Source: AA+uWPzio0GYVO6qqzJpfKZHF2B+9QIx4rxH/g1U1eyTmuOYPHZn01zgqyZTsVoRm4w9hrARqDxW4JOo9UFZKkGzdLc=
X-Received: by 2002:a62:1b4a:: with SMTP id b71-v6mr23879420pfb.221.1534268116858;
 Tue, 14 Aug 2018 10:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043975f05735f33f0@google.com>
In-Reply-To: <00000000000043975f05735f33f0@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 14 Aug 2018 10:39:28 -0700
Message-ID: <CAM_iQpUzRUnnN=xkNiiAP_HJ1GRb1Fv3-CVMCka-6PNJEmtuPw@mail.gmail.com>
Subject: Re: possible deadlock in rhashtable_lookup_insert_fast
To:     syzbot+b66a5a554991a8ed027c@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        syzkaller-bugs@googlegroups.com, Tom Herbert <tom@herbertland.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 11:21 PM syzbot
<syzbot+b66a5a554991a8ed027c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    36d2f761b5aa cxgb4: update 1.20.8.0 as the latest firmware..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=134b323c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dbf55ebfa6bfd517
> dashboard link: https://syzkaller.appspot.com/bug?extid=b66a5a554991a8ed027c
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=103285f0400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12859d72400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b66a5a554991a8ed027c@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> netlink: 'syz-executor077': attribute type 8 has an invalid length.
>
> ============================================
> WARNING: possible recursive locking detected
> 4.18.0-rc8+ #179 Not tainted
> --------------------------------------------
> syz-executor077/4391 is trying to acquire lock:
> (____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at: spin_lock_bh
> include/linux/spinlock.h:315 [inline]
> (____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at: __rhashtable_insert_fast
> include/linux/rhashtable.h:596 [inline]
> (____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at:
> rhashtable_lookup_insert_fast.constprop.26+0x436/0x13a0
> include/linux/rhashtable.h:784
>
> but task is already holding lock:
> (____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at: spin_lock
> include/linux/spinlock.h:310 [inline]
> (____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at: ila_add_mapping
> net/ipv6/ila/ila_xlat.c:233 [inline]
> (____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at:
> ila_xlat_nl_cmd_add_mapping+0x6bb/0x17e0 net/ipv6/ila/ila_xlat.c:355
>
> other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&(&tlocks[i])->rlock);
>    lock(&(&tlocks[i])->rlock);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
> 3 locks held by syz-executor077/4391:
>   #0: (____ptrval____) (cb_lock){++++}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:636
>   #1: (____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at: spin_lock
> include/linux/spinlock.h:310 [inline]
>   #1: (____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at: ila_add_mapping
> net/ipv6/ila/ila_xlat.c:233 [inline]
>   #1: (____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at:
> ila_xlat_nl_cmd_add_mapping+0x6bb/0x17e0 net/ipv6/ila/ila_xlat.c:355
>   #2: (____ptrval____) (rcu_read_lock){....}, at: __rhashtable_insert_fast
> include/linux/rhashtable.h:579 [inline]
>   #2: (____ptrval____) (rcu_read_lock){....}, at:
> rhashtable_lookup_insert_fast.constprop.26+0x1d7/0x13a0
> include/linux/rhashtable.h:784
>
> stack backtrace:
> CPU: 1 PID: 4391 Comm: syz-executor077 Not tainted 4.18.0-rc8+ #179
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>   print_deadlock_bug kernel/locking/lockdep.c:1765 [inline]
>   check_deadlock kernel/locking/lockdep.c:1809 [inline]
>   validate_chain kernel/locking/lockdep.c:2405 [inline]
>   __lock_acquire.cold.65+0x1fb/0x486 kernel/locking/lockdep.c:3435
>   lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
>   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
>   _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
>   spin_lock_bh include/linux/spinlock.h:315 [inline]
>   __rhashtable_insert_fast include/linux/rhashtable.h:596 [inline]
>   rhashtable_lookup_insert_fast.constprop.26+0x436/0x13a0
> include/linux/rhashtable.h:784
>   ila_add_mapping net/ipv6/ila/ila_xlat.c:240 [inline]
>   ila_xlat_nl_cmd_add_mapping+0xafe/0x17e0 net/ipv6/ila/ila_xlat.c:355


Purely bogus warning introduced by commit
b893281715ab ("ila: Call library function alloc_bucket_locks").



>   genl_family_rcv_msg+0x8a3/0x1140 net/netlink/genetlink.c:601
>   genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
>   netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
>   genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
>   netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
>   netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
>   netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
>   sock_sendmsg_nosec net/socket.c:640 [inline]
>   sock_sendmsg+0xd5/0x120 net/socket.c:650
>   ___sys_sendmsg+0x7fd/0x930 net/socket.c:2133
>   __sys_sendmsg+0x11d/0x290 net/socket.c:2171
>   __do_sys_sendmsg net/socket.c:2180 [inline]
>   __se_sys_sendmsg net/socket.c:2178 [inline]
>   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2178
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4400e9
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffd14495758 EFLAG
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
