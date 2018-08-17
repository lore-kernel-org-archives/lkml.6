Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8D2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7838C21A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnzvP0qM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7838C21A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeHQUl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:41:57 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37214 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeHQUl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:41:57 -0400
Received: by mail-pl0-f65.google.com with SMTP id d5-v6so4031014pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OYCj+tEJCVvU+lRp5a4YyAbYClrNURDexaCKNDecAc0=;
        b=GnzvP0qMS8wFfCIfnWB61tonsJGxLBeK13eSzz1XJGxWrjhNsiWYWGLBeSeGb3+HIU
         MmTwe8FR2ULxvildw6rNg2xQNOU1JuwY6erHJ2GdXonyqgKZGpoKBWEdWVWiHm2yIur2
         5ZIh799OHvKILJbWwCU9Sviu54dsskFr9n2kW4fSsu3pTYgPr3eNh9MoF47tz/4Uv1q9
         XF1L7+tUqc06pf49vfIqumSGovWkdB9bXasAC/u/UMre4g6eSvOT+lWK2kaXVr8JJuGj
         Mc0nDDChjanePLoTrFQ2XJeU2r9Sx0jHWH2AwmhXudePPS6f1UQEsKZB74JNPT6avCff
         oeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OYCj+tEJCVvU+lRp5a4YyAbYClrNURDexaCKNDecAc0=;
        b=uXaGkFMqSEuNUKfjHw6zt0DA6d+B6iu1c4dvpZHu0b2+x19E4zxMWR7dGic5itHNzC
         fQY2ZJYHotob7AAcVUAPj4S/K8QW2DYXHHg5GLRQFBrH8YkUAtnGTufp9ZdM3biNdsuI
         Zud8YgCitokQXQ4YlsrEV1LW/LzYPiply0Ji1T9rT+r2ydNJUObh251AK936AE4giwYJ
         ak6PBfhm0zXTof3VKzqhHIMQ2QWyEI+Qnu1KW6tGw+MQ2CHm6q94ElgS77SBNunjF8/i
         FnWdzfXHwJ3it+XRmpUl2Gg2r87xnlL3C5Nh5Cw17g5QCxsvaYmxjYH9ZMCQ8uIT9cix
         MMMA==
X-Gm-Message-State: AOUpUlFWXdrcVISuVNAHH9lRQZZA4eRZPioF7yUoxZ793POnFjmPu/xy
        l6eY+oNjXgpC4d2rVBt553mVDdpLPBp3KXQB8Tp+2g==
X-Google-Smtp-Source: AA+uWPx9f0J5HBiyhtocNag4Lq334W2P/34S4A/J9GCDrenhctBTc6XlkcHyDl1TQE2FnX9CtGZDTu8EwRdkgZTGvco=
X-Received: by 2002:a17:902:934a:: with SMTP id g10-v6mr34600914plp.121.1534527460937;
 Fri, 17 Aug 2018 10:37:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 17 Aug 2018 10:37:20
 -0700 (PDT)
In-Reply-To: <000000000000de450605735060bd@google.com>
References: <000000000000de450605735060bd@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Aug 2018 10:37:20 -0700
Message-ID: <CACT4Y+ZO3BFSzHJYaA9HNmCcX1KGGcVOxzLq36rvRCiwa+x8ww@mail.gmail.com>
Subject: Re: general protection fault in send_sigio_to_task
To:     syzbot <syzbot+854a638985e121990c4c@syzkaller.appspotmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Bruce Fields <bfields@fieldses.org>, jlayton@kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 5:39 AM, syzbot
<syzbot+854a638985e121990c4c@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=164fecc4400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=18edf0289d1b5ab
> dashboard link: https://syzkaller.appspot.com/bug?extid=854a638985e121990c4c
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1306063c400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11eaa122400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+854a638985e121990c4c@syzkaller.appspotmail.com

#syz fix: signal: Don't send signals to tasks that don't exist

> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 1 PID: 4500 Comm: syz-executor081 Not tainted 4.18.0-next-20180813+ #37
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
> RIP: 0010:sigio_perm fs/fcntl.c:715 [inline]
> RIP: 0010:send_sigio_to_task+0x1ad/0x910 fs/fcntl.c:734
> Code: 4c 8d b3 00 ff ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d bf 58 06 00
> 00 4c 89 f2 48 c1 ea 03 c6 04 02 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85
> 1a 07 00 00 49 8b 87 58 06 00 00 4c 89 f2 48 c1
> RSP: 0018:ffff8801d9b5f878 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff8801d9b5f9f8 RCX: ffffffff81caeb13
> RDX: 00000000000000cb RSI: ffffffff81cae4e3 RDI: 0000000000000658
> RBP: ffff8801d9b5fa20 R08: ffff8801acfee500 R09: ffffed003b6246d6
> R10: ffffed003b6246d6 R11: ffff8801db1236b3 R12: ffff8801d98e3bc8
> R13: 0000000000000000 R14: ffff8801d9b5f8f8 R15: 0000000000000000
> FS:  00007fcc7bf1e700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcc7bf1de78 CR3: 00000001acdbc000 CR4: 00000000001406e0
> Call Trace:
>  send_sigio+0x36f/0x4a0 fs/fcntl.c:794
>  dnotify_handle_event+0x213/0x360 fs/notify/dnotify/dnotify.c:111
>  send_to_group fs/notify/fsnotify.c:234 [inline]
>  fsnotify+0x97d/0x14e0 fs/notify/fsnotify.c:374
>  fsnotify_access include/linux/fsnotify.h:185 [inline]
>  iterate_dir+0x4e3/0x5d0 fs/readdir.c:55
>  ksys_getdents64+0x228/0x450 fs/readdir.c:314
>  __do_sys_getdents64 fs/readdir.c:333 [inline]
>  __se_sys_getdents64 fs/readdir.c:330 [inline]
>  __x64_sys_getdents64+0x73/0xb0 fs/readdir.c:330
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4456b9
> Code: e8 ec b8 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fcc7bf1dd18 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
> RAX: ffffffffffffffda RBX: 00000000006dac48 RCX: 00000000004456b9
> RDX: 0000000000001000 RSI: 0000000020001380 RDI: 0000000000000003
> RBP: 00000000006dac40 R08: 00007fcc7bf1e700 R09: 0000000000000000
> R10: 00007fcc7bf1e700 R11: 0000000000000246 R12: 00000000006dac4c
> R13: 00007fcc7bf1dd20 R14: 0000000020000180 R15: 00000000006dad2c
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 9542b2f908ce9cfa ]---
> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
> RIP: 0010:sigio_perm fs/fcntl.c:715 [inline]
> RIP: 0010:send_sigio_to_task+0x1ad/0x910 fs/fcntl.c:734
> Code: 4c 8d b3 00 ff ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d bf 58 06 00
> 00 4c 89 f2 48 c1 ea 03 c6 04 02 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85
> 1a 07 00 00 49 8b 87 58 06 00 00 4c 89 f2 48 c1
> RSP: 0018:ffff8801d9b5f878 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff8801d9b5f9f8 RCX: ffffffff81caeb13
> RDX: 00000000000000cb RSI: ffffffff81cae4e3 RDI: 0000000000000658
> RBP: ffff8801d9b5fa20 R08: ffff8801acfee500 R09: ffffed003b6246d6
> R10: ffffed003b6246d6 R11: ffff8801db1236b3 R12: ffff8801d98e3bc8
> R13: 0000000000000000 R14: ffff8801d9b5f8f8 R15: 0000000000000000
> FS:  00007fcc7bf1e700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcc7bf1de78 CR3: 00000001acdbc000 CR4: 00000000001406e0
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
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000de450605735060bd%40google.com.
> For more options, visit https://groups.google.com/d/optout.
