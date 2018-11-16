Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0892C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9FF20892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S26Oo47k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9FF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeKQGyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:54:33 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40369 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeKQGyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:54:32 -0500
Received: by mail-it1-f194.google.com with SMTP id e11so36093613itl.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 12:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fhxbIykRLFy+Y/UP5iC5EQehOw/5UamEx+opfjpfEQY=;
        b=S26Oo47kVyrvJETaLCveApVwO6T9fzHJb/2pc+nC0/xMDAZLc+hhhz1KsNr5dzdYK8
         +BCHhuYa/XF/GioDf6LULHd2yJ6VAN/fcsA98Si+8Dhgrr6bBlHJm9m3mWYJ3TZ3Zsv4
         f6RciqdwB9qvLcAcogXi2Ce3k2D8p94/2/I323JTfed1rivBRmI44bYVjDPauD9Q8fQB
         gzMfrkpvUTRoS7KbIGIdLzH+PMoUpoFspd6fx2p50250kCPAmAc+0CqptluRQ4fn4ZaU
         fe452CFPrys9+EbxLOugMQZbcOTs2Q45RrflaQAWVpMPvMAcqGUcWiNA51HR8u+pUkw6
         cRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fhxbIykRLFy+Y/UP5iC5EQehOw/5UamEx+opfjpfEQY=;
        b=IpWdCyRVjeuVjnW3JlHLrQkemXhdoGR9hjOoqMpSD4p7bRSat+Jlnl1g/1mAsc/XZp
         UR0iHyvow7a0dlcVO5naBULm92vG55TqvPmDmAyOwSRVqXFcSgPC1VWqS+QWBGrqGgVO
         22JEI25jYUlqJf5RZocKzPwrDR7Droab6J5N6ZMiZGRxPvYnG24/pKnVjdNN53KIX2xY
         muPqaT1UDHnlxqgRlGajYMQs6hwK38SFHfXWwAj08ZYpC7lIjxDIbok+mfnM/KJwbkZ1
         QnZrdFwWDW6ORsu/ZPGnv8zv/4Ig+ijkH/pqoAhfugmlIXMrb4iD5vK1qDaqpnMJvzsG
         rTow==
X-Gm-Message-State: AGRZ1gLH/YxjyHrWwtKKCIs3Oz+ZtdDdmpGiSX6tgKYWUILccT9fsgSq
        CxPzAw4mjejfMnS2tQW57cieqrNFNh9JrqO9KWo7WQ==
X-Google-Smtp-Source: AJdET5eOwu/8tOJwDdG9RDJernia3wqyS/+a4VAX3lQlTZL65NxKdcjCewXRJSNq9yKRjwreVzCZgJtULmjZTBI47/0=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr10179246itl.144.1542400835168;
 Fri, 16 Nov 2018 12:40:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Fri, 16 Nov 2018 12:40:14
 -0800 (PST)
In-Reply-To: <000000000000fa9fb7057a679a42@google.com>
References: <000000000000fa9fb7057a679a42@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 16 Nov 2018 12:40:14 -0800
Message-ID: <CACT4Y+bazpjyYUGo-PBQ2rXG-y2x8SrBeQWs_5-dMmkSxicFCg@mail.gmail.com>
Subject: Re: BUG: corrupted list in locks_delete_block
To:     syzbot <syzbot+13eb7470890c56ce3f37@syzkaller.appspotmail.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 10:18 AM, syzbot
<syzbot+13eb7470890c56ce3f37@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b1262b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
> dashboard link: https://syzkaller.appspot.com/bug?extid=13eb7470890c56ce3f37
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107566a3400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b5fa2b400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+13eb7470890c56ce3f37@syzkaller.appspotmail.com

This is another manifestation of the following report, right?

#syz dup: KASAN: use-after-free Read in locks_delete_block

> list_del corruption. prev->next should be ffff8801c135f960, but was
> 0000000000000007
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:53!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 5972 Comm: syz-executor001 Not tainted 4.20.0-rc1-next-20181109+
> #110
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x4a lib/list_debug.c:51
> Code: fe 60 88 e8 72 9b d3 fd 0f 0b 48 89 de 48 c7 c7 40 00 61 88 e8 61 9b
> d3 fd 0f 0b 48 89 de 48 c7 c7 e0 ff 60 88 e8 50 9b d3 fd <0f> 0b 48 89 d9 48
> c7 c7 a0 00 61 88 e8 3f 9b d3 fd 0f 0b 48 89 f1
> RSP: 0018:ffff8801c135f750 EFLAGS: 00010286
> RAX: 0000000000000054 RBX: ffff8801c135f960 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8165ba15 RDI: 0000000000000005
> RBP: ffff8801c135f768 R08: ffff8801c11ce080 R09: ffffed003b5e5020
> R10: ffffed003b5e5020 R11: ffff8801daf28107 R12: ffff8801d945f3a0
> R13: ffff8801d945f3a0 R14: 0000000000000000 R15: ffff8801c135f838
> FS:  00007f96b449c700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000046aa40 CR3: 00000001b39ab000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __list_del_entry include/linux/list.h:117 [inline]
>  list_del_init include/linux/list.h:159 [inline]
>  __locks_delete_block fs/locks.c:683 [inline]
>  locks_delete_block+0xce/0x3d0 fs/locks.c:716
>  locks_mandatory_area+0x48b/0x6a0 fs/locks.c:1398
>  rw_verify_area+0x2f2/0x360 fs/read_write.c:386
>  do_iter_write+0x101/0x5f0 fs/read_write.c:954
>  vfs_writev+0x1f1/0x360 fs/read_write.c:1004
>  do_writev+0x11a/0x310 fs/read_write.c:1039
>  __do_sys_writev fs/read_write.c:1112 [inline]
>  __se_sys_writev fs/read_write.c:1109 [inline]
>  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x446619
> Code: e8 6c b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f96b449bda8 EFLAGS: 00000297 ORIG_RAX: 0000000000000014
> RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446619
> RDX: 0000000000000001 RSI: 0000000020000440 RDI: 0000000000000003
> RBP: 00000000006dbc30 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000297 R12: 00000000006dbc3c
> R13: 2f30656c69662f2e R14: 64663d736e617274 R15: 00000000006dbd2c
> Modules linked in:
> ---[ end trace efdc3057b60b19f3 ]---
> RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x4a lib/list_debug.c:51
> Code: fe 60 88 e8 72 9b d3 fd 0f 0b 48 89 de 48 c7 c7 40 00 61 88 e8 61 9b
> d3 fd 0f 0b 48 89 de 48 c7 c7 e0 ff 60 88 e8 50 9b d3 fd <0f> 0b 48 89 d9 48
> c7 c7 a0 00 61 88 e8 3f 9b d3 fd 0f 0b 48 89 f1
> RSP: 0018:ffff8801c135f750 EFLAGS: 00010286
> RAX: 0000000000000054 RBX: ffff8801c135f960 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8165ba15 RDI: 0000000000000005
> RBP: ffff8801c135f768 R08: ffff8801c11ce080 R09: ffffed003b5e5020
> R10: ffffed003b5e5020 R11: ffff8801daf28107 R12: ffff8801d945f3a0
> R13: ffff8801d945f3a0 R14: 0000000000000000 R15: ffff8801c135f838
> FS:  00007f96b449c700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000046aa40 CR3: 00000001b39ab000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000fa9fb7057a679a42%40google.com.
> For more options, visit https://groups.google.com/d/optout.
