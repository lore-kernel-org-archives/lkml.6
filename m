Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05C8217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTP5wwAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfBRUCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:02:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44925 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBRUCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:02:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so9067993pfh.11;
        Mon, 18 Feb 2019 12:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFgsxDEhBwfM2MqFXqXjIFrj/EaFj9gvApxgTd2V2BQ=;
        b=XTP5wwATfYpjtbPoY1VJXLYU4bMsuAB8I4phE9pC6MAWFjqg6pEnCD0ffVxPdLO8lJ
         PbSee/RwLV1wX7uAzOxBZp30DtH4aeUu1L+Al4/xeXhU29PN4pjfasB6X/ujNrJppuj/
         ILFUumAvI1Ht7HDL9hO3d5XHpmEOwr5Y+ex4Pxcc5/0f0RifmLCGA/O8tMRYdPsUgLw4
         deJG4fpOksFf6YE1otVluym3ZphJ6NuSMlFJ7G6UytmFJJvekKV3/P4EHQAPtuObAjFU
         PR/ZsrJypHE+/kWAU7Be2VRUSYjUvyc6rSof0md7IHhJ3u7NOOfpAK8wGXxG80JV0GZf
         INaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFgsxDEhBwfM2MqFXqXjIFrj/EaFj9gvApxgTd2V2BQ=;
        b=rxml+7r2epfGRECzcFa0b3Akzq9cvXtQuoROH5GnFomFNLl8RV2/NKo72QRAVAWWri
         fhkLrBHNq0kBAM5ll8ZFPukIzrYVFU3CL9YO30DQfmOpo10tYnwa28IyWIfluxFPmWUJ
         a0XYH932GnU4lrdEm9VxkbkyrcxNbg26giPFCcugB23LzpuCQjkzsFX/D5FCXvfBjGch
         bXUlaGWem+0tCH4Be5HuCRSr0oM8Al9WqkHtrCbWhc4Lq24A744p56bTw/PG6ITBgcwj
         3w/vKnKW1h1MrdnZdcyI9NG2V9eaxXFKP7x1pn4wxPN3sThjIEGeyh4jSgyH7NLM+1pM
         +OkA==
X-Gm-Message-State: AHQUAuY3GCheVUxyoPYJJoNqfaY5Fj7hwSy3qlItBLIE5wyUsOyh3QE7
        hoZ0drGDLPm6cCbx5271Gzwm4QGC49g0fr06FD0=
X-Google-Smtp-Source: AHgI3IYKVc5e6/AzCq5zXip8GSSRkRM5M5WBaAax30YYNuKqDUIiZjCGb0gZ6rEy1n5kGzC+T8qqgTxbNa6BA+OUeyc=
X-Received: by 2002:a63:28c1:: with SMTP id o184mr6234260pgo.123.1550520159175;
 Mon, 18 Feb 2019 12:02:39 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006694750581ca4139@google.com>
In-Reply-To: <0000000000006694750581ca4139@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 18 Feb 2019 12:02:27 -0800
Message-ID: <CAM_iQpW656Aafj860Gen-KOg8Pojg=q9+hDTgPvoaSK8qsg79A@mail.gmail.com>
Subject: Re: general protection fault in tc_ctl_chain
To:     syzbot <syzbot+eff9cae063e4b633c6c1@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlad Buslov <vladbu@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc'ing Vlad, please fix it)

On Wed, Feb 13, 2019 at 9:56 AM syzbot
<syzbot+eff9cae063e4b633c6c1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    bd3606c29fcc rocker: Remove port_attr_bridge_flags_get ass..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=121bbf87400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8572a6e4661225f4
> dashboard link: https://syzkaller.appspot.com/bug?extid=eff9cae063e4b633c6c1
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cbd404c00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fc80d4c00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+eff9cae063e4b633c6c1@syzkaller.appspotmail.com
>
> audit: type=1800 audit(1550028783.638:30): pid=7517 uid=0 auid=4294967295
> ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)
> comm="startpar" name="rmnologin" dev="sda1" ino=2423 res=0
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 7669 Comm: syz-executor789 Not tainted 5.0.0-rc5+ #60
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__lock_acquire+0x8df/0x4700 kernel/locking/lockdep.c:3215
> Code: 28 00 00 00 0f 85 35 27 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f
> 5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f
> 85 dc 27 00 00 49 81 3c 24 20 45 9a 89 0f 84 03 f8
> RSP: 0018:ffff88808b44f180 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 000000000000000c RSI: 0000000000000000 RDI: 0000000000000060
> RBP: ffff88808b44f350 R08: 0000000000000001 R09: 0000000000000001
> R10: ffff88808b44f570 R11: 0000000000000001 R12: 0000000000000060
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880915d4680
> FS:  0000000001ef6880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000080 CR3: 0000000093549000 CR4: 00000000001406f0
> Call Trace:
>   lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
>   __mutex_lock_common kernel/locking/mutex.c:925 [inline]
>   __mutex_lock+0xf7/0x1310 kernel/locking/mutex.c:1072
>   mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
>   tc_ctl_chain+0x42f/0x11a0 net/sched/cls_api.c:2812
>   rtnetlink_rcv_msg+0x465/0xb00 net/core/rtnetlink.c:5192
>   netlink_rcv_skb+0x17a/0x460 net/netlink/af_netlink.c:2485
>   rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5210
>   netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
>   netlink_unicast+0x536/0x720 net/netlink/af_netlink.c:1336
>   netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1925
>   sock_sendmsg_nosec net/socket.c:621 [inline]
>   sock_sendmsg+0xdd/0x130 net/socket.c:631
>   ___sys_sendmsg+0x806/0x930 net/socket.c:2136
>   __sys_sendmsg+0x105/0x1d0 net/socket.c:2174
>   __do_sys_sendmsg net/socket.c:2183 [inline]
>   __se_sys_sendmsg net/socket.c:2181 [inline]
>   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2181
>   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4400d9
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffd09281608 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004400d9
> RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401960
> R13: 00000000004019f0 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 25ab48d993ef9249 ]---
> RIP: 0010:__lock_acquire+0x8df/0x4700 kernel/locking/lockdep.c:3215
> Code: 28 00 00 00 0f 85 35 27 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f
> 5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f
> 85 dc 27 00 00 49 81 3c 24 20 45 9a 89 0f 84 03 f8
> RSP: 0018:ffff88808b44f180 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 000000000000000c RSI: 0000000000000000 RDI: 0000000000000060
> RBP: ffff88808b44f350 R08: 0000000000000001 R09: 0000000000000001
> R10: ffff88808b44f570 R11: 0000000000000001 R12: 0000000000000060
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880915d4680
> FS:  0000000001ef6880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000080 CR3: 0000000093549000 CR4: 00000000001406f0
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
