Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9850C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1C02146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kxi65kUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfBTQ5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:57:45 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37030 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfBTQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:57:44 -0500
Received: by mail-it1-f193.google.com with SMTP id z124so17209952itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AeFUJWAPX0cp3TlR/Bl/I/BN8/f1s/bZd9Fwz0Uko6M=;
        b=Kxi65kUm9MafI1pEoaykhaba+/3zBLeS32CM2kzf6eo5GPJa0hGV9MY0i51E+pGeM0
         tWtEZIrwI0yGcYrBIng+k0Ow36WrbLwsVLgkeOznCbVOTIBFSY0896NkLQ75X6BxVh0T
         8kdBQsPQq4Q9YGIKLIPN18hZMbPQxMfYkYzK0SnX/f2axFIcOHPhqi0DlbTiPgqMtavQ
         /TwqrxagFE4dkRfiOYgXoaktcnPmcL0QbDh5eUV3RnsymqNT4qIZmodHgOv5D1aY4MRt
         n4C0h82jj0QjWFy8zehPo9el4Jcj6s808j2mIpojj+u+zXWdoB1ceXogdczxPNDonTW7
         FchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AeFUJWAPX0cp3TlR/Bl/I/BN8/f1s/bZd9Fwz0Uko6M=;
        b=lDXqyKh/dRBayJ4xP/L+kaVB5vp0BmCkRAg83UBtLN/zTxMFdBbJjAXWxLm4kAiqqe
         1SfqxMlUtE4FKwTekxNoNdhOQOOtmYyMfJG5M1LhVYx1Q6aLH6HM4xMmLSLzu1gIKPbz
         97KYNQRO516Xkt0ctp/b2y+zWNHUEywyiY+Qsp9uhmUjcIq3Jjc+TGn8BRXn8tSgtI4y
         5cv0lRWBJeM+LvbH/dx1fOWnaqcQ6k3LFtdf8FJEWC3Bn4HJ4LlOIhtM7wOm6xT3zjHs
         1PUWzcEI+xwAIwma7aMPYJoNzzhHO6XFmhWGbfX0Yn3ZGDu/btQuSV+scvyyAQxSdx1U
         2e/g==
X-Gm-Message-State: AHQUAubQJY5uJojn2z/DTqlqEqTmw5DFhvrDSUgcY2y8XHpkhe/qdNrW
        zQeGhIPdJxSLUjfG03NF1AEYwAjN3k2joXftsSZ2lg==
X-Google-Smtp-Source: AHgI3IZ6g4dt1xBOPc6PQalN29VM2uFMQGI1jRzXpyfUMIrVSzuVyr1GfpgflBhgzZhTddmbDkbugcrQjH8gWrmj7c4=
X-Received: by 2002:a24:7351:: with SMTP id y78mr5948931itb.12.1550681863149;
 Wed, 20 Feb 2019 08:57:43 -0800 (PST)
MIME-Version: 1.0
References: <000000000000739dd40575ac7d07@google.com>
In-Reply-To: <000000000000739dd40575ac7d07@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Feb 2019 17:57:32 +0100
Message-ID: <CACT4Y+Z=Ad+MoOS=puUGQkHQjdCejNYaN99jnmxW__xp5Uwj=w@mail.gmail.com>
Subject: Re: general protection fault in lockref_get
To:     syzbot <syzbot+5dc733a19636067b82fd@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 3:23 PM syzbot
<syzbot+5dc733a19636067b82fd@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    7c1b097f27bf Add linux-next specific files for 20180912
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1333df01400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5980033172920ec0
> dashboard link: https://syzkaller.appspot.com/bug?extid=5dc733a19636067b82fd
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5dc733a19636067b82fd@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: cc1: uninitialized urandom read (8 bytes read)
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 5580 Comm: syz-executor0 Not tainted 4.19.0-rc3-next-20180912+
> #72
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__lock_acquire+0x237/0x4ec0 kernel/locking/lockdep.c:3291

Let's do:

#syz dup: BUG: spinlock bad magic in lockref_get

Both in the same function and appeared exactly at the same time, but
the other one has a reproducer:
https://syzkaller.appspot.com/bug?id=59881761edbba4b3f7511eea9fe539c90a87f13c

> Code: 28 00 00 00 0f 85 aa 33 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f
> 5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f
> 85 6d 35 00 00 49 81 7d 00 20 90 9e 8a 0f 84 54 ff
> RSP: 0018:ffff8801d36ff430 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 1ffff1003a6dff03 RCX: 0000000000000000
> RDX: 0000000140000014 RSI: 0000000000000000 RDI: ffffffff89722928
> RBP: ffff8801d36ff7c0 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000a000000a0 R14: ffff8801b9cde100 R15: 0000000000000000
> FS:  0000000000db8940(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000482e00 CR3: 00000001b9d4f000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
>   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>   _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
>   lockref_get+0x15/0x50 include/linux/spinlock.h:329
>   dget include/linux/dcache.h:322 [inline]
>   mqueue_get_tree+0x101/0x2e0 ipc/mqueue.c:362
>   vfs_get_tree+0x1cb/0x5c0 fs/super.c:1787
>   mq_create_mount+0xe3/0x190 ipc/mqueue.c:415
>   mq_init_ns+0x15a/0x210 ipc/mqueue.c:1621
>   create_ipc_ns ipc/namespace.c:58 [inline]
>   copy_ipcs+0x3d2/0x580 ipc/namespace.c:84
>   create_new_namespaces+0x376/0x900 kernel/nsproxy.c:87
>   unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:206
>   ksys_unshare+0x79c/0x10b0 kernel/fork.c:2535
>   __do_sys_unshare kernel/fork.c:2603 [inline]
>   __se_sys_unshare kernel/fork.c:2601 [inline]
>   __x64_sys_unshare+0x31/0x40 kernel/fork.c:2601
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459d87
> Code: 00 00 00 b8 63 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 3d 8a fb ff c3
> 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 1d 8a fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffcccf0eee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459d87
> RDX: 0000000000000000 RSI: 00007ffcccf0eef0 RDI: 0000000008000000
> RBP: 0000000000930b28 R08: 0000000000000000 R09: 0000000000000018
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000010
> R13: 0000000000412cc0 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 404378fbbfe9896c ]---
> RIP: 0010:__lock_acquire+0x237/0x4ec0 kernel/locking/lockdep.c:3291
> Code: 28 00 00 00 0f 85 aa 33 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f
> 5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f
> 85 6d 35 00 00 49 81 7d 00 20 90 9e 8a 0f 84 54 ff
> RSP: 0018:ffff8801d36ff430 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 1ffff1003a6dff03 RCX: 0000000000000000
> RDX: 0000000140000014 RSI: 0000000000000000 RDI: ffffffff89722928
> RBP: ffff8801d36ff7c0 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000a000000a0 R14: ffff8801b9cde100 R15: 0000000000000000
> FS:  0000000000db8940(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000482e00 CR3: 00000001b9d4f000 CR4: 00000000001406e0
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000739dd40575ac7d07%40google.com.
> For more options, visit https://groups.google.com/d/optout.
