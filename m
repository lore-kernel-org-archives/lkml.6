Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63A4C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 16:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB44204EC
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 16:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4gHmmzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB44204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeIIVfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 17:35:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41198 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeIIVfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 17:35:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so9252553pgv.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sGdC9LtnnDdF+off4qdAk33645u+foKbRxGTs/UpT4g=;
        b=F4gHmmzQs6crM9uEkN7lU5aPlfcbABM4j9yKvB7GpuPzuQZX8q+WGKNBQgcI1vmILn
         zLp3gW5TN9BC/b8lEBXllvjDXL+5c22JmZuTsSrdtN/tkFYVEHKMfEbHXBW2/7+3p8tu
         UvpR6cFO5UnE9sXd2QT8nytTqSs86VA4d5GPQ5pz3VdDQor0hVR6zmIaJZChZ5bhCIqi
         s3ETEoCABi14ohbORPszUT0EnIIT7zXgVS8PVTTkeXuIKIDXGLcJNa3JvlyG7ks9Zh+4
         QbhZ+Fs7kK5hmrm5FPpmzGc7PDKHNo3+Ca5emigxHPJoRVyqSqYst8pbACwtUo/IkG46
         79pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sGdC9LtnnDdF+off4qdAk33645u+foKbRxGTs/UpT4g=;
        b=LLYFP3cc7VS4LRw6QhGss653LVgMvfDBpe1/4hLM/B9VnOKjimGI06X+HDTD6knx49
         SToxzaxmBXetA7ttYYEpf2NeiKVS/1Q4DMBcuXV7obxCKnkfWvaQnyvS6AAK5vCX3e1y
         SK6PYnb36szYufvHHwLYcfwzty/3DF5i/zzF3Z0ILCyxu9sPLFr3sHU7QVJ3gn5Tg5Kd
         HbDP6hjIr875kIJTxP+SEk5Tgwh6CrwmybGpGxSm3WaBjywe3LuWc7Xce00cCbUT33Z9
         SnkqLKcjlRB+En76YISUlwBuZx4wQTJ6903DJ3KvySarsI5vSAlvgQg5bbbDmcZE+hHM
         qVHQ==
X-Gm-Message-State: APzg51CJq1laDLtNrSyPPVJn4jCXxuzGxkDI1Kg9Sw1FmFertXAg86PP
        tE05eHMM7MSgV9m6qouzEKFcl2zGhYwMOWHpf5M9X34bYWs=
X-Google-Smtp-Source: ANB0VdZSUAidbpFqEDDYEpBJijh1zCj773QElr/lUitItRvc6DSbRQvpMXARkwo5tNC185TCTkAqo9EAjLGm1g+B0go=
X-Received: by 2002:a63:6501:: with SMTP id z1-v6mr18359755pgb.419.1536511521394;
 Sun, 09 Sep 2018 09:45:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Sun, 9 Sep 2018 09:45:00
 -0700 (PDT)
In-Reply-To: <00000000000043195b056dca3dad@google.com>
References: <00000000000043195b056dca3dad@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 9 Sep 2018 18:45:00 +0200
Message-ID: <CACT4Y+ZAgjK-oSRvJqsxqzZzMqRhG1JpVG3EiMtpCjRRM2JtqQ@mail.gmail.com>
Subject: Re: BUG: soft lockup in shrink_dcache_parent (2)
To:     syzbot <syzbot+be3179e6006280aaf174@syzkaller.appspotmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 7:31 AM, syzbot
<syzbot+be3179e6006280aaf174@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    325e14f97e0c Merge branch 'fixes' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=166329d7800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=968b0b23c7854c0b
> dashboard link: https://syzkaller.appspot.com/bug?extid=be3179e6006280aaf174
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+be3179e6006280aaf174@syzkaller.appspotmail.com

I guess this is also:

#syz fix: restore cond_resched() in shrink_dcache_parent()

since this also stopped happening around 90 days ago.


> watchdog: BUG: soft lockup - CPU#1 stuck for 134s! [syz-executor4:4588]
> Modules linked in:
> irq event stamp: 76609500
> hardirqs last  enabled at (76609499): [<ffffffff81c66ccf>]
> seqcount_lockdep_reader_access include/linux/seqlock.h:83 [inline]
> hardirqs last  enabled at (76609499): [<ffffffff81c66ccf>]
> read_seqcount_begin include/linux/seqlock.h:164 [inline]
> hardirqs last  enabled at (76609499): [<ffffffff81c66ccf>] read_seqbegin
> include/linux/seqlock.h:433 [inline]
> hardirqs last  enabled at (76609499): [<ffffffff81c66ccf>]
> read_seqbegin_or_lock include/linux/seqlock.h:529 [inline]
> hardirqs last  enabled at (76609499): [<ffffffff81c66ccf>]
> d_walk+0x80f/0xc80 fs/dcache.c:1248
> hardirqs last disabled at (76609500): [<ffffffff87800905>]
> interrupt_entry+0xb5/0xf0 arch/x86/entry/entry_64.S:625
> softirqs last  enabled at (468244): [<ffffffff87a00778>]
> __do_softirq+0x778/0xaf5 kernel/softirq.c:311
> softirqs last disabled at (468177): [<ffffffff814762c1>] invoke_softirq
> kernel/softirq.c:365 [inline]
> softirqs last disabled at (468177): [<ffffffff814762c1>]
> irq_exit+0x1d1/0x200 kernel/softirq.c:405
> CPU: 1 PID: 4588 Comm: syz-executor4 Not tainted 4.17.0-rc7+ #81
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783
> [inline]
> RIP: 0010:seqcount_lockdep_reader_access include/linux/seqlock.h:83 [inline]
> RIP: 0010:read_seqcount_begin include/linux/seqlock.h:164 [inline]
> RIP: 0010:read_seqbegin include/linux/seqlock.h:433 [inline]
> RIP: 0010:read_seqbegin_or_lock include/linux/seqlock.h:529 [inline]
> RIP: 0010:d_walk+0x840/0xc80 fs/dcache.c:1248
> RSP: 0018:ffff880183f5f9f8 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> RAX: ffff8801b0d3c680 RBX: 0000000000000293 RCX: 1ffff100361a79e5
> RDX: 0000000000000000 RSI: ffffffff81c66cfb RDI: 0000000000000293
> RBP: ffff880183f5fb78 R08: ffff8801b0d3ceb8 R09: 0000000000000006
> R10: ffff8801b0d3c680 R11: 0000000000000000 R12: 0000000000000200
> R13: dffffc0000000000 R14: 1ffff100307ebf82 R15: ffff880183f5fb50
> FS:  000000000217c940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffca8309eac CR3: 0000000183eb2000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  shrink_dcache_parent+0x179/0x230 fs/dcache.c:1486
>  vfs_rmdir+0x202/0x470 fs/namei.c:3855
>  do_rmdir+0x523/0x610 fs/namei.c:3916
>  __do_sys_rmdir fs/namei.c:3934 [inline]
>  __se_sys_rmdir fs/namei.c:3932 [inline]
>  __x64_sys_rmdir+0x36/0x40 fs/namei.c:3932
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455777
> RSP: 002b:00007ffca830a5b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000054
> RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 0000000000455777
> RDX: 0000000000000000 RSI: 00007ffca830c360 RDI: 00007ffca830c360
> RBP: 00007ffca830c360 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000006 R11: 0000000000000206 R12: 000000000217d940
> R13: 0000000000000000 R14: 0000000000000198 R15: 000000000001f12d
> Code: 88 48 89 f8 48 c1 e8 03 42 80 3c 28 00 0f 85 1e 04 00 00 48 83 3d 78
> 20 0b 07 00 0f 84 29 02 00 00 e8 e5 d7 b2 ff 48 89 df 57 9d <0f> 1f 44 00 00
> e8 d6 d7 b2 ff 49 8d 5f 80 48 c1 eb 03 4c 01 eb
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 4581 Comm: syz-executor6 Not tainted 4.17.0-rc7+ #81
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:select_collect+0x249/0x5f0 fs/dcache.c:1443
> RSP: 0018:ffff880189947908 EFLAGS: 00000286
> RAX: 0000000000000000 RBX: ffffed0031328f24 RCX: ffffffff81c5c3b4
> RDX: 0000000000000000 RSI: ffffffff81c5c4fa RDI: ffff880189947c28
> RBP: ffff8801899479e8 R08: ffff88018993e5c0 R09: ffffed0039dde7a4
> R10: ffffed0039dde7a4 R11: ffff8801ceef3d23 R12: 0000000000000000
> R13: 1ffff10031328f28 R14: ffff880189947c18 R15: dffffc0000000000
> FS:  0000000001790940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffebea69e9c CR3: 000000018989f000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  d_walk+0x3c3/0xc80 fs/dcache.c:1276
>  shrink_dcache_parent+0x179/0x230 fs/dcache.c:1486
>  vfs_rmdir+0x202/0x470 fs/namei.c:3855
>  do_rmdir+0x523/0x610 fs/namei.c:3916
>  __do_sys_rmdir fs/namei.c:3934 [inline]
>  __se_sys_rmdir fs/namei.c:3932 [inline]
>  __x64_sys_rmdir+0x36/0x40 fs/namei.c:3932
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455777
> RSP: 002b:00007ffebea6a5a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000054
> RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 0000000000455777
> RDX: 0000000000000000 RSI: 00007ffebea6c350 RDI: 00007ffebea6c350
> RBP: 00007ffebea6c350 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000006 R11: 0000000000000202 R12: 0000000001791940
> R13: 0000000000000000 R14: 0000000000000192 R15: 000000000001f12b
> Code: 0f b6 e4 41 83 c4 01 e8 e6 7f b3 ff 48 b8 00 00 00 00 00 fc ff df 48
> 01 c3 44 89 e0 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 <c7> 43 10 00 00
> 00 00 48 81 c4 b8 00 00 00 5b 41 5c 41 5d 41 5e
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
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000043195b056dca3dad%40google.com.
> For more options, visit https://groups.google.com/d/optout.
