Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E08C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5130C20854
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PfP5Lb/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5130C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeKQG67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:58:59 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45781 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKQG66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:58:58 -0500
Received: by mail-io1-f68.google.com with SMTP id w7so10380672iom.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 12:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KBR4jaWgwruxtEdm+vCzwP7HSzxwFnP8SZQv5RV1uhE=;
        b=PfP5Lb/xGJ+6T+gmA0w7hAWkL0658s21PKNYYl6SCG2CBVadkV7tC9RN/7jWI0hkv0
         stBg6+ntq4vIrcurV1131d7zv5X18IHImQd+9d0TyO7VICogQ3Aj7BlojKYd56Z81PwE
         IMDKh5crQl6jmZb++BvSuvDIWm+WIa1fUY7Tb/eNJv53+KR4rvezSHWJwdxSBBwkYXPT
         cVPodBOOorh5gOcsh4EjGLXsFiRcIMYteff4I9Thm8XUsx1bBAxgwMLFYkXEBSvaELUd
         ZWZ7UcUvUiZc2dfpkP3EnaNMlQMJs8k0ZnEWKx8jaeDAwCc2TV5rDTyu+2/ixXKSQKbF
         ovRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KBR4jaWgwruxtEdm+vCzwP7HSzxwFnP8SZQv5RV1uhE=;
        b=sttUARNA4bEcmKwZVroFbbQ/ApG/o8ffiIYZltFQasjS6yxX1clnOWxjHctNDHk5uI
         hPQaWj3FFg4CcPB43BGeh2BmdZE3pjO37CZegISHsCfpOrFEifN15B1qYOh1+2lcO/vf
         phychNKytqZKE0pOkdkNb3h9pJSlwDa2YoryvWaDEGyi0/nA9d1dy+1tF6jlCliPev2y
         BwNkUn4TfykixHNh5mEVNa+PRJIeEKinosXQe42WMAIhkUWEsVgS4d43usITuAyoFRvZ
         Gbk5w6EnrpGcvEo04mN9pewVEp/I4FNC4W8IVFe4Ql+FcpjfZthmaEib/8vptG29mLGp
         BMRg==
X-Gm-Message-State: AA+aEWY3FhrNCgCbqV2z2jRDPHxkDLWESPHKOjAj3MyYyDGB+rrxvWYE
        x64HJtxN6PhcCE7uq1euRcrcNhE6NLatUl6xSgquFA==
X-Google-Smtp-Source: AFSGD/U/ve+xn8UIRqq1KjfhJplZsO7Lrc3ycsRzSy8g6GBXFsJdG/rRfjoZQDPjkz2mz9DadRNF2P0FEed7Nu13l58=
X-Received: by 2002:a6b:f104:: with SMTP id e4mr3782798iog.271.1542401101602;
 Fri, 16 Nov 2018 12:45:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Fri, 16 Nov 2018 12:44:41
 -0800 (PST)
In-Reply-To: <0000000000009d6000057a147f19@google.com>
References: <000000000000da5443057a0c047e@google.com> <0000000000009d6000057a147f19@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 16 Nov 2018 12:44:41 -0800
Message-ID: <CACT4Y+YtT9zmusUuj4-bUzoWLEEgPDWzeVDZ7wqgKbz-MCBUYA@mail.gmail.com>
Subject: Re: general protection fault in locks_remove_flock
To:     syzbot <syzbot+2400c924363a9a43d116@syzkaller.appspotmail.com>
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

On Wed, Nov 7, 2018 at 7:09 AM, syzbot
<syzbot+2400c924363a9a43d116@syzkaller.appspotmail.com> wrote:
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    d881de30d29e Add linux-next specific files for 20181107
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10a0102b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=caa433e1c8778437
> dashboard link: https://syzkaller.appspot.com/bug?extid=2400c924363a9a43d116
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b42f5b400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151777e5400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2400c924363a9a43d116@syzkaller.appspotmail.com


Assuming this is another manifestation of the following report.

#syz dup: KASAN: use-after-free Read in locks_delete_block



> audit: type=1800 audit(1541602996.121:30): pid=5502 uid=0 auid=4294967295
> ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)
> comm="startpar" name="rmnologin" dev="sda1" ino=2423 res=0
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 5657 Comm: syz-executor710 Not tainted 4.20.0-rc1-next-20181107+
> #107
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:locks_remove_flock+0x216/0x350 fs/locks.c:2567
> Code: 00 0f 85 3a 01 00 00 48 8b 5b 98 48 85 db 74 3a e8 1f 41 92 ff 48 8d
> 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85
> 17 01 00 00 48 8b 5b 08 48 85 db 74 0d e8 f2 40
> RSP: 0018:ffff8801b9dc72c0 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 1ffff100373b8e89 RCX: ffffffff81ed555d
> RDX: 03fffe2006e771d2 RSI: ffffffff81ed5c71 RDI: 1ffff100373b8e91
> RBP: ffff8801b9dc74a0 R08: ffff8801b9dbc480 R09: ffffed003b5e5b67
> R10: ffffed003b5e5b67 R11: ffff8801daf2db3b R12: ffff8801d88f9c80
> R13: ffff8801b9dc7338 R14: 1ffff100373b8e5b R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000002001d000 CR3: 000000000946a000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  locks_remove_file+0x148/0x5c0 fs/locks.c:2607
>  __fput+0x2f0/0xa70 fs/file_table.c:271
>  ____fput+0x15/0x20 fs/file_table.c:312
>  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x1ad1/0x26d0 kernel/exit.c:867
>  do_group_exit+0x177/0x440 kernel/exit.c:970
>  __do_sys_exit_group kernel/exit.c:981 [inline]
>  __se_sys_exit_group kernel/exit.c:979 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x43ede8
> Code: Bad RIP value.
> RSP: 002b:00007ffe7a46fe78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ede8
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00000000004beea8 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace a84b3ae501385451 ]---
> RIP: 0010:locks_remove_flock+0x216/0x350 fs/locks.c:2567
> Code: 00 0f 85 3a 01 00 00 48 8b 5b 98 48 85 db 74 3a e8 1f 41 92 ff 48 8d
> 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85
> 17 01 00 00 48 8b 5b 08 48 85 db 74 0d e8 f2 40
> RSP: 0018:ffff8801b9dc72c0 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 1ffff100373b8e89 RCX: ffffffff81ed555d
> RDX: 03fffe2006e771d2 RSI: ffffffff81ed5c71 RDI: 1ffff100373b8e91
> RBP: ffff8801b9dc74a0 R08: ffff8801b9dbc480 R09: ffffed003b5e5b67
> R10: ffffed003b5e5b67 R11: ffff8801daf2db3b R12: ffff8801d88f9c80
> R13: ffff8801b9dc7338 R14: 1ffff100373b8e5b R15: dffffc0000000000
> FS:  000000000229b880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000043edbe CR3: 000000000946a000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009d6000057a147f19%40google.com.
>
> For more options, visit https://groups.google.com/d/optout.
