Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC780C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB742403A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCfdXq8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB742403A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeGEQR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:17:59 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36151 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbeGEQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:17:57 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so1484056plp.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gb6eSxd/axPEA5otzwtAXPRp7Xn0NbCD3ytC5/IcHD8=;
        b=uCfdXq8wQ3acIDvZqH6jDcWKiJj2x16VVf0/wj4BebhbW8FJMWRDQqUpF/1C3IiaC1
         Vd+fTulZM/8OGUj/M3RNMTzXvMJblZxysjlEnY17oZ+pYgkS6kdZ9axNDrqgh4FSlLTU
         9oNUSwkPQ5XpUEa4bf8nxtZlkgS8CRIW9r2fkOOlS0pWLDbqZos6VvlYHt9YjksvjtCJ
         suUmboyJuU9uSENSo6/xpf2O0PYxjWtfBnfuT2VI5r55qXaOMAAplFnLe/zagiN70vkX
         B3qgGEnrGJCOONBz2xqru3+93zvX6dSid8M0gOQabsFw0yr9l+LbCkEt2RKYWbffGdeL
         nKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gb6eSxd/axPEA5otzwtAXPRp7Xn0NbCD3ytC5/IcHD8=;
        b=mRGzpCVgfEM7Q3sE9VaP3mJnRqosUwxGzVfE4Y/vK3LD8HcgbG7yhLRaeGd4lhSCUb
         OMhC8WvNxp+s3dc+trRvfNJ3zWfAsS4vwWGe3+QDR+S1tX9nnjP1tpLkOOmEsrSu6Uqn
         EM23V0X7dFsTdP4tNLnxuDvYZsN/IyXGGq6CriQrrVy+zM+L2M+fskIF3+TDi8olyDHU
         UK0uBEc5Vk+Lht+UrdMF8jqTmdIN0Iu5jpGiYEOAGjDO3bgGWB13z/bxMyqxQ3GMaw4l
         fRq0TljYAIudGSlMe7KdDv7cwJe/2PfcZ52NkK/5BrhE17wXuDhWicwYPRoQ7/L+vUtC
         24rg==
X-Gm-Message-State: APt69E1Qj++fpoIil+SToQsowu0cCDuOoNAFB9WnJzw755O0Dj73ptQv
        m96KGwRtZBwHuZFQcIDJeuG5gi8SgBnmp+MX9P+/+w==
X-Google-Smtp-Source: AAOMgpcJTRM2Ru36CyDtGpkhDX0UIz6aIvhfXnyzdgCH+Hc53BhDDdAi1lNSNRe0gLbAp4LmiWyQhOZFAkfzhpSln68=
X-Received: by 2002:a17:902:7782:: with SMTP id o2-v6mr6832758pll.93.1530807476282;
 Thu, 05 Jul 2018 09:17:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Thu, 5 Jul 2018 09:17:35
 -0700 (PDT)
In-Reply-To: <0000000000007a0552057039afc8@google.com>
References: <0000000000007a0552057039afc8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Jul 2018 18:17:35 +0200
Message-ID: <CACT4Y+a4AUcdkfb5dSuArQytC_0EfA2Ko_0Ma1LiPXavCJoc5A@mail.gmail.com>
Subject: Re: general protection fault in smap_list_map_remove
To:     syzbot <syzbot+ef78105c1713053fa8bb@syzkaller.appspotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 7:19 AM, syzbot
<syzbot+ef78105c1713053fa8bb@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12192e0c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
> dashboard link: https://syzkaller.appspot.com/bug?extid=ef78105c1713053fa8bb
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16b40858400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112ab052400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ef78105c1713053fa8bb@syzkaller.appspotmail.com

#syz dup: KASAN: stack-out-of-bounds Read in timerqueue_add

> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 0 PID: 4456 Comm: syz-executor610 Not tainted 4.18.0-rc3+ #45
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:do_raw_spin_lock+0x27/0x200 kernel/locking/spinlock_debug.c:111
> Code: 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 41 55 41 54
> 53 48 89 fb 48 83 c7 04 48 89 fa 48 c1 ea 03 48 83 ec 08 <0f> b6 14 02 48 89
> f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7b
> RSP: 0018:ffff8801ac2df9c0 EFLAGS: 00010286
> RAX: dffffc0000000000 RBX: 0000000000000230 RCX: 0000000000000000
> RDX: 0000000000000046 RSI: 0000000000000000 RDI: 0000000000000234
> RBP: ffff8801ac2df9e8 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffed0035724fa6 R11: ffff8801ab927d33 R12: dffffc0000000000
> R13: ffff8801abf962c0 R14: 0000000000000220 R15: 0000000000000000
> FS:  00007fcd332e0700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff2b4fcd5c CR3: 00000001d1f19000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
>  _raw_spin_lock_bh+0x39/0x40 kernel/locking/spinlock.c:168
>  spin_lock_bh include/linux/spinlock.h:315 [inline]
>  smap_list_map_remove+0x96/0x350 kernel/bpf/sockmap.c:1670
>  sock_map_ctx_update_elem.isra.21+0x3ab/0x570 kernel/bpf/sockmap.c:1981
>  sock_map_update_elem+0x1b9/0x3b0 kernel/bpf/sockmap.c:2072
>  map_update_elem+0x5c4/0xc90 kernel/bpf/syscall.c:765
>  __do_sys_bpf kernel/bpf/syscall.c:2296 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:2267 [inline]
>  __x64_sys_bpf+0x32d/0x510 kernel/bpf/syscall.c:2267
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x445d19
> Code: e8 2c b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fcd332dfce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 0000000000445d19
> RDX: 0000000000000020 RSI: 0000000020000180 RDI: 0000000000000002
> RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd667bb2bf R14: 00007fcd332e09c0 R15: 0000000000000005
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace fbe082eee969c5a2 ]---
> RIP: 0010:do_raw_spin_lock+0x27/0x200 kernel/locking/spinlock_debug.c:111
> Code: 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 41 55 41 54
> 53 48 89 fb 48 83 c7 04 48 89 fa 48 c1 ea 03 48 83 ec 08 <0f> b6 14 02 48 89
> f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7b
> RSP: 0018:ffff8801ac2df9c0 EFLAGS: 00010286
> RAX: dffffc0000000000 RBX: 0000000000000230 RCX: 0000000000000000
> RDX: 0000000000000046 RSI: 0000000000000000 RDI: 0000000000000234
> RBP: ffff8801ac2df9e8 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffed0035724fa6 R11: ffff8801ab927d33 R12: dffffc0000000000
> R13: ffff8801abf962c0 R14: 0000000000000220 R15: 0000000000000000
> FS:  00007fcd332e0700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff2b4fcd5c CR3: 00000001d1f19000 CR4: 00000000001406f0
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
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000007a0552057039afc8%40google.com.
> For more options, visit https://groups.google.com/d/optout.
