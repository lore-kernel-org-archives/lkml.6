Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D27C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A1422433
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9obegh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A1422433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeHJSwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:52:12 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34678 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbeHJSwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:52:12 -0400
Received: by mail-qt0-f194.google.com with SMTP id m13-v6so10870321qth.1;
        Fri, 10 Aug 2018 09:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TAJLSO0pB8obQmwavca3XYZwliLAemsMM0QeKFwffIw=;
        b=X9obegh2yzfGeRD7mRKhbzT5FQd56iHva0PfSYPaKJKOGTuPgyfjbVww5qGD/Rvcc1
         O8rm+KilG4DrmnjCr/468zyAAIoXw8aZTuqOQzZILJb3ysGIqW63IidHg0Zi5svR46sl
         /JwsjEG735NyDxXaBaTTqkZHBxOblonWXtrmkTF0i+VuuVDtdY4+UY5bWj++kciajmCc
         AgmwyG9hpxK8zcg9f18rY1YgN52i05klELaTyATwyTL+qbEVLYmZ2xInVBeCRzoP0YfS
         ge+NQfGv/m5dqBVes7XQ1YZOO5GqlefxAIlFKVq7/JGEECpD2dp5AhASz+XV5IWP1slK
         wmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TAJLSO0pB8obQmwavca3XYZwliLAemsMM0QeKFwffIw=;
        b=pcJcKyhDq69pBoyXPWH0XWwyWM6Hg68FFNEhOPpiRJVw/gZWaSybIoI0si9EeNxenl
         NR9MKe1SralsEQsybADVQAbIyBFW3jYzdXL7RDvn4iRxQTcMIysoTPDDx4P/ud6qetmt
         50D+9VYfCPcaPeSwm9Sfhhc4TZyJIsxpOOAxCC8Nb5sFyfeDgiU7janY5zrO67Xsj+Ie
         0KTPKvOMJAKqtI+OhhBB4R4F3L2gyP3zGN3PR+6AJBtgdKsNcmwbsRLdHkUbFYlUc9q3
         jywchnO3FWKr7VdlY3M6ioEGl4Saq10gJyLxbA6c3MsUNtKNJlFVlMfrWoQkBQkQfR/z
         RAJw==
X-Gm-Message-State: AOUpUlH6LN7UpKqcCojVETqu2jsGrIE0m73h/ScQ0mHAyE1H5Cs4KLJY
        udllINwDEMPU8JoyNpxAcm0pLcBwCf1hG9kuhYI=
X-Google-Smtp-Source: AA+uWPzo60ZjELht6uyIRNza784y0lJ+VmYazvREoFMRCDeGxf0sLiVhDwkfKepqiTOA5+mbTLRPPUjxQLVhnShu3zQ=
X-Received: by 2002:aed:3aa4:: with SMTP id o33-v6mr7050628qte.359.1533918099628;
 Fri, 10 Aug 2018 09:21:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:23e8:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 09:20:59
 -0700 (PDT)
In-Reply-To: <0000000000005012b605731594e3@google.com>
References: <0000000000005012b605731594e3@google.com>
From:   William Tu <u9012063@gmail.com>
Date:   Fri, 10 Aug 2018 09:20:59 -0700
Message-ID: <CALDO+SYTKcmnzKTKMY5Fapskv4bbkdmNwSUz1C4i_c4m5GT=OQ@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in ip_tunnel_xmit (2)
To:     syzbot <syzbot+4a2c52677a8a1aa283cb@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 7:30 AM, syzbot
<syzbot+4a2c52677a8a1aa283cb@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    80ecacc456c1 kmsan: fix CONFIG_KMSAN=n build
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=163b7794400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=93d57043084eee38
> dashboard link: https://syzkaller.appspot.com/bug?extid=4a2c52677a8a1aa283cb
> compiler:       clang version 7.0.0 (trunk 334104)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17cec9dc400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145dcf0c400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4a2c52677a8a1aa283cb@syzkaller.appspotmail.com
>
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> ==================================================================
> BUG: KMSAN: uninit-value in ip_tunnel_xmit+0x63a/0x3b10 net/ipv4/ip_tunnel.c:645


It complains about
 644         dst = tnl_params->daddr;
 645         if (dst == 0) {

I guess at __gre_tunnel_init, we have to zero the tunne->parms.iph.

I will test it to see if the issue go away.

Thanks
William

> CPU: 1 PID: 4603 Comm: syz-executor712 Not tainted 4.18.0-rc4+ #27
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x185/0x1e0 lib/dump_stack.c:113
>  kmsan_report+0x195/0x2c0 mm/kmsan/kmsan.c:982
>  __msan_warning+0x7d/0xe0 mm/kmsan/kmsan_instr.c:645
>  ip_tunnel_xmit+0x63a/0x3b10 net/ipv4/ip_tunnel.c:645
>  __gre_xmit net/ipv4/ip_gre.c:449 [inline]
>  ipgre_xmit+0xe16/0xef0 net/ipv4/ip_gre.c:701
>  __netdev_start_xmit include/linux/netdevice.h:4148 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4157 [inline]
>  xmit_one net/core/dev.c:3034 [inline]
>  dev_hard_start_xmit+0x60f/0xcc0 net/core/dev.c:3050
>  __dev_queue_xmit+0x3060/0x3c70 net/core/dev.c:3569
>  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3602
>  packet_snd net/packet/af_packet.c:2919 [inline]
>  packet_sendmsg+0x8469/0x9010 net/packet/af_packet.c:2944
>  sock_sendmsg_nosec net/socket.c:641 [inline]
>  sock_sendmsg net/socket.c:651 [inline]
>  ___sys_sendmsg+0xed9/0x1350 net/socket.c:2125
>  __sys_sendmsg net/socket.c:2163 [inline]
>  __do_sys_sendmsg net/socket.c:2172 [inline]
>  __se_sys_sendmsg net/socket.c:2170 [inline]
>  __x64_sys_sendmsg+0x3b0/0x520 net/socket.c:2170
>  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x4412f9
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffdc77f10d8 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004412f9
> RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000003
> RBP: 00000000006cc018 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000020 R11: 0000000000000213 R12: 0000000000402260
> R13: 00000000004022f0 R14: 0000000000000000 R15: 0000000000000000
>
> Uninit was created at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
>  kmsan_internal_poison_shadow+0xc8/0x1d0 mm/kmsan/kmsan.c:181
>  kmsan_kmalloc+0xa1/0x120 mm/kmsan/kmsan_hooks.c:91
>  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan_hooks.c:100
>  slab_post_alloc_hook mm/slab.h:446 [inline]
>  slab_alloc_node mm/slub.c:2720 [inline]
>  __kmalloc_node_track_caller+0xb48/0x11d0 mm/slub.c:4353
>  __kmalloc_reserve net/core/skbuff.c:138 [inline]
>  __alloc_skb+0x2cb/0x9e0 net/core/skbuff.c:206
>  alloc_skb include/linux/skbuff.h:988 [inline]
>  alloc_skb_with_frags+0x1e6/0xb80 net/core/skbuff.c:5271
>  sock_alloc_send_pskb+0xb59/0x11e0 net/core/sock.c:2095
>  packet_alloc_skb net/packet/af_packet.c:2776 [inline]
>  packet_snd net/packet/af_packet.c:2867 [inline]
>  packet_sendmsg+0x68cb/0x9010 net/packet/af_packet.c:2944
>  sock_sendmsg_nosec net/socket.c:641 [inline]
>  sock_sendmsg net/socket.c:651 [inline]
>  ___sys_sendmsg+0xed9/0x1350 net/socket.c:2125
>  __sys_sendmsg net/socket.c:2163 [inline]
>  __do_sys_sendmsg net/socket.c:2172 [inline]
>  __se_sys_sendmsg net/socket.c:2170 [inline]
>  __x64_sys_sendmsg+0x3b0/0x520 net/socket.c:2170
>  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
