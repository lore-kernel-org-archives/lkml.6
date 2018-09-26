Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B641C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC5D20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHstMU6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC5D20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeIZOFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:05:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54619 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeIZOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:05:02 -0400
Received: by mail-it1-f196.google.com with SMTP id f14-v6so1713539ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HlHo8BlxgTS1fRFj6hK8emWhRmoLMYOp5YN7VQ6Ibes=;
        b=YHstMU6uInU40pkIBy7OT7V8AxYYJ+t7g4SCcDqhoq9J4rKoipgnetmB1V9zEN8bkM
         tc55605sbuooXFus5KLibBqoVO0+BPnJpRXiGolWOP3uYCvK1fX00QEMS603ni0rbkU7
         5S1YOmZZMl1jX1cbUGt6UuR67VVGpwUpLSNXoQ6s8DJZQZbja6W7wyb8EupFJhnxwvq3
         oqPjmJsM0JvyezszMqAwxnf5GFlLL+803Bq6JBlXjyMPpxlMGsyQjGrGY6sc64v8gC2m
         qvH8VeUIJjFr8VEskNfd/AuhCADklCom57yrDwpIE/p1hHxwDX/1VfLRG1L4pq8gI+qH
         ULog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HlHo8BlxgTS1fRFj6hK8emWhRmoLMYOp5YN7VQ6Ibes=;
        b=i7OmlETu6aT63MPJU+VNXYxOC8nFCxArkLjcO22yrW9u2BnyL8Rtl9gQeDXqZ3YQGc
         gckPSEAn4rI5xvfs/iK5i73PltJ1W0jNRm3j+OO/n4SJp+qC4tMPU0Jv3grVcF/xE3Nv
         avA2FGV3nbBfnO94LvPV4S9QQ3WvYIwxbkaLzZMqy9MtV38t6y5Cre9rRX8h/r6pWC9L
         baXoee0YcoK5O9wbCJNdwkTG3M4FYM5s7IM4gJZXjYUpPSMt1Aa9P7XjnfxjVawxz5Lr
         wIN8lYIXBKYSL/sjdfc60LmPMP76JS+EycGsYy4Y/lg4t5Cdztkdf7a4+Fpmg/xzisuy
         2H3w==
X-Gm-Message-State: ABuFfoi4QIcyMSt4WK6pHvk1+H9ThVI+fP3YrJi38AHqRy+JDQjY5BvE
        zSS/XjtrOBSlRISYp8djmBPtmDYJIayWGS6jANqXlg==
X-Google-Smtp-Source: ACcGV62msznKcnJPXAPBmZmatJc8mxw7vad513WOUpbWfBgQstA/O7X1Bfq2oOXz6LRv7cbLaNdILf66Apvcf2zkFV0=
X-Received: by 2002:a24:c0c5:: with SMTP id u188-v6mr4137628itf.57.1537948402882;
 Wed, 26 Sep 2018 00:53:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 00:53:02
 -0700 (PDT)
In-Reply-To: <0000000000009581bf0576c16d3a@google.com>
References: <0000000000009581bf0576c16d3a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 26 Sep 2018 09:53:02 +0200
Message-ID: <CACT4Y+asi3NLZFCLVibcQAPEJn8ZkuaRopm+Eh8eFsW7PGLVWw@mail.gmail.com>
Subject: Re: general protection fault in integrity_inode_free
To:     syzbot <syzbot+4c0fa7d385ea5af34e91@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, zohar@linux.vnet.ibm.com,
        Matthew Garrett <mjg59@google.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        sudeep.holla@arm.com, jlayton@kernel.org,
        linux-security-module@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 9:47 AM, syzbot
<syzbot+4c0fa7d385ea5af34e91@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    846e8dd47c26 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a59d56400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
> dashboard link: https://syzkaller.appspot.com/bug?extid=4c0fa7d385ea5af34e91
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4c0fa7d385ea5af34e91@syzkaller.appspotmail.com

This was misattributed to net, +IMA maintainers.

>  __do_sys_sendmsg net/socket.c:2163 [inline]
>  __se_sys_sendmsg net/socket.c:2161 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> RIP: 0033:0x457579
> CPU: 0 PID: 8727 Comm: syz-executor3 Not tainted 4.19.0-rc5+ #33
> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RSP: 002b:00007f07f2e4bc78 EFLAGS: 00000246
> RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:168 [inline]
> RIP: 0010:rb_erase+0x306/0x3710 lib/rbtree.c:459
>  ORIG_RAX: 000000000000002e
> Code: c7 81 28 01 00 00 f2 f2 f2 f2 c7 81 2c 01 00 00 00 f2 f2 f2 48 89 f9
> 65 48 8b 1c 25 28 00 00 00 48 89 5d d0 31 db 48 c1 e9 03 <42> 80 3c 01 00 0f
> 85 41 1c 00 00 4c 8d 48 10 4c 8b 78 08 48 b9 00
> RAX: ffffffffffffffda RBX: 00007f07f2e4bc90 RCX: 0000000000457579
> RSP: 0018:ffff88018620e918 EFLAGS: 00010202
> RDX: 0000000000000000 RSI: 000000002000b000 RDI: 0000000000000003
> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f07f2e4c6d4
> RDX: 1ffff10030c41d2b RSI: ffffffff8b5a08a0 RDI: 0000000000000008
> R13: 00000000004c38e1 R14: 00000000004d5730 R15: 0000000000000004
> RBP: ffff88018620f320 R08: dffffc0000000000 R09: fffffbfff135d5c8
> kobject: 'loop5' (00000000eac6d22a): kobject_uevent_env
> R10: fffffbfff135d5c8 R11: ffffffff89aeae43 R12: ffff8801bacb38f0
> R13: dffffc0000000000 R14: ffff88018620f2f8 R15: ffff88018620f438
> overlayfs: unrecognized mount option "smackfstransmute=upperdir" or missing
> value
> FS:  00007ff9677ec700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b31324000 CR3: 00000001c2773000 CR4: 00000000001406f0
> Call Trace:
>  integrity_inode_free+0x12f/0x320 security/integrity/iint.c:150
>  security_inode_free+0x19/0x90 security/security.c:453
>  __destroy_inode+0x328/0x820 fs/inode.c:238
>  destroy_inode+0xda/0x200 fs/inode.c:265
>  evict+0x5e0/0x980 fs/inode.c:575
>  iput_final fs/inode.c:1547 [inline]
>  iput+0x679/0xa90 fs/inode.c:1573
>  swap_inode_boot_loader fs/ext4/ioctl.c:188 [inline]
>  ext4_ioctl+0x236f/0x4210 fs/ext4/ioctl.c:865
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457579
> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ff9677ebc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000457579
> RDX: 0000000000000000 RSI: 0000000000006611 RDI: 0000000000000003
> RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff9677ec6d4
> R13: 00000000004bf626 R14: 00000000004cf4c0 R15: 00000000ffffffff
> Modules linked in:
> ---[ end trace 6d41a32e43d56085 ]---
> RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:168 [inline]
> RIP: 0010:rb_erase+0x306/0x3710 lib/rbtree.c:459
> Code: c7 81 28 01 00 00 f2 f2 f2 f2 c7 81 2c 01 00 00 00 f2 f2 f2 48 89 f9
> 65 48 8b 1c 25 28 00 00 00 48 89 5d d0 31 db 48 c1 e9 03 <42> 80 3c 01 00 0f
> 85 41 1c 00 00 4c 8d 48 10 4c 8b 78 08 48 b9 00
> RSP: 0018:ffff88018620e918 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> RDX: 1ffff10030c41d2b RSI: ffffffff8b5a08a0 RDI: 0000000000000008
> RBP: ffff88018620f320 R08: dffffc0000000000 R09: fffffbfff135d5c8
> R10: fffffbfff135d5c8 R11: ffffffff89aeae43 R12: ffff8801bacb38f0
> R13: dffffc0000000000 R14: ffff88018620f2f8 R15: ffff88018620f438
> FS:  00007ff9677ec700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b31324000 CR3: 00000001c2773000 CR4: 00000000001406f0
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
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009581bf0576c16d3a%40google.com.
> For more options, visit https://groups.google.com/d/optout.
