Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1B8C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE63206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hr2a8MsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE63206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeIMTWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:22:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35441 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbeIMTWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:22:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so4767790edq.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3QLQfDm5VF69H7Q2hYpHsX9mmY/1TFk1cWsjUOfBZds=;
        b=Hr2a8MsUTDuX9e/eJNueROWaJdgQEPor+cokR8BBG7Py23BJkT+OvWt7ZxrX61t93q
         pCAPz9gDyCO89zPF+E09+rVpU3SIP5rZsINtuxQnl+qaGEpI7UucSwQWYBHGM62XW501
         OXphn/8OTU4ilOxhRd9Jf+CmagPmxpZsd6wiB+9O1Sj3qtIN1h7F6WlAiEEUeklQrFaM
         rI79Eg6V+StaYaxXPsCZYXj70DBke8t8Uq4PtMKaE000J+GLFeK+BmCfnaI0phR+5mEc
         vQBwszVBrlON3A1MKAdFhSccko4MV3ytII2HILOr32BYC+bIcjBGtVZ67lNQsCvU4Hlm
         uASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3QLQfDm5VF69H7Q2hYpHsX9mmY/1TFk1cWsjUOfBZds=;
        b=NgutOk2m1WoZ/2vV5yCIQLipeV1aQHakfkxOriFpsavLeNBaXX8shh4O6TqW09e4VJ
         afX/ijWVfke9TtVw8oC1QbxBsKF6PFsbQAe+9bQWopSS0Qq39XDiYu2JcJWqcGzUT3pO
         IKGlGMZF729GVJcUYkkl7YytYmBiRwLWDpuF5JXOKhk6IaG9e/XskPKQj1sFzLY3AVJy
         Jbsty4wGBKxTrWwyt7tUxLyuNqFw7bjm7/mx6FXMnFiR0w1Q8axxhanSNctiondNbESo
         TLS6Ip9atfaOMZZ+GNBYvbMNpYuLV/ZZyNDUAcESdleferRlldBPQBayy5uWljL1rSpm
         AEGA==
X-Gm-Message-State: APzg51D+s2LsMThSy59mHRS8qy0TmUlQQrVasLoGsjYdhhZ6oyx/bFCY
        NLqhPK11bnnUcYThEdWsp2EcN4nlWYZffSrAM4QpOQ==
X-Google-Smtp-Source: ANB0VdbTjtmSFlK6tlYl+Qn/ZZl1N7hMVzyVveZLj0dwWhspNlCh6tVCPviD35PIucCjYB/jcCwAvPSs/nbstYNNx8U=
X-Received: by 2002:aa7:d884:: with SMTP id u4-v6mr11182315edq.223.1536847969213;
 Thu, 13 Sep 2018 07:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004624c30575a9fd40@google.com> <CAG_fn=Vk2HMPCLJV3aj1dt0KkDmksasBRRfKGnCTRHjvQ6OnQg@mail.gmail.com>
 <7424e094-afda-084a-ad80-299f219ced92@gmail.com>
In-Reply-To: <7424e094-afda-084a-ad80-299f219ced92@gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 13 Sep 2018 16:12:38 +0200
Message-ID: <CAG_fn=WXPsQBWR1GDsprY3aL4oW0v6EGhNB5wrvPJCOMh_U7wQ@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in pppoe_rcv
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     syzbot+f5f6080811c849739212@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>, mostrows@earthlink.net,
        Networking <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 3:57 PM Eric Dumazet <eric.dumazet@gmail.com> wrote=
:
>
>
>
> On 09/12/2018 03:38 AM, Alexander Potapenko wrote:
> > On Wed, Sep 12, 2018 at 12:24 PM syzbot
> > <syzbot+f5f6080811c849739212@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem pages
> >> git tree:       https://github.com/google/kmsan.git/master
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1465fc3780=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D48f9de3384=
bcd0f
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df5f6080811c8=
49739212
> >> compiler:       clang version 7.0.0 (trunk 329391)
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14d6e607=
800000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10a15b5b80=
0000
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the com=
mit:
> >> Reported-by: syzbot+f5f6080811c849739212@syzkaller.appspotmail.com
> >>
> >> IPVS: ftp: loaded support on port[0] =3D 21
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> BUG: KMSAN: uninit-value in __get_item drivers/net/ppp/pppoe.c:172 [in=
line]
> >> BUG: KMSAN: uninit-value in get_item drivers/net/ppp/pppoe.c:236 [inli=
ne]
> >> BUG: KMSAN: uninit-value in pppoe_rcv+0xcef/0x10e0
> >> drivers/net/ppp/pppoe.c:450
> >> CPU: 0 PID: 4543 Comm: syz-executor355 Not tainted 4.16.0+ #87
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S
> >> Google 01/01/2011
> >> Call Trace:
> >>   __dump_stack lib/dump_stack.c:17 [inline]
> >>   dump_stack+0x185/0x1d0 lib/dump_stack.c:53
> >>   kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
> >>   __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
> >>   __get_item drivers/net/ppp/pppoe.c:172 [inline]
> >>   get_item drivers/net/ppp/pppoe.c:236 [inline]
> >>   pppoe_rcv+0xcef/0x10e0 drivers/net/ppp/pppoe.c:450
> >>   __netif_receive_skb_core+0x47df/0x4a90 net/core/dev.c:4562
> >>   __netif_receive_skb net/core/dev.c:4627 [inline]
> >>   netif_receive_skb_internal+0x49d/0x630 net/core/dev.c:4701
> >>   netif_receive_skb+0x230/0x240 net/core/dev.c:4725
> >>   tun_rx_batched drivers/net/tun.c:1555 [inline]
> >>   tun_get_user+0x740f/0x7c60 drivers/net/tun.c:1962
> >>   tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
> >>   call_write_iter include/linux/fs.h:1782 [inline]
> >>   new_sync_write fs/read_write.c:469 [inline]
> >>   __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
> >>   vfs_write+0x463/0x8d0 fs/read_write.c:544
> >>   SYSC_write+0x172/0x360 fs/read_write.c:589
> >>   SyS_write+0x55/0x80 fs/read_write.c:581
> >>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
> >>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> >> RIP: 0033:0x4447c9
> >> RSP: 002b:00007fff64c8fc28 EFLAGS: 00000297 ORIG_RAX: 0000000000000001
> >> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004447c9
> >> RDX: 000000000000fd87 RSI: 0000000020000600 RDI: 0000000000000004
> >> RBP: 00000000006cf018 R08: 00007fff64c8fda8 R09: 00007fff00006bda
> >> R10: 0000000000005fe7 R11: 0000000000000297 R12: 00000000004020d0
> >> R13: 0000000000402160 R14: 0000000000000000 R15: 0000000000000000
> >>
> >> Uninit was created at:
> >>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
> >>   kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
> >>   kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
> >>   kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
> >>   slab_post_alloc_hook mm/slab.h:445 [inline]
> >>   slab_alloc_node mm/slub.c:2737 [inline]
> >>   __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
> >>   __kmalloc_reserve net/core/skbuff.c:138 [inline]
> >>   __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
> >>   alloc_skb include/linux/skbuff.h:984 [inline]
> >>   alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
> >>   sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
> >>   tun_alloc_skb drivers/net/tun.c:1532 [inline]
> >>   tun_get_user+0x2242/0x7c60 drivers/net/tun.c:1829
> >>   tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
> >>   call_write_iter include/linux/fs.h:1782 [inline]
> >>   new_sync_write fs/read_write.c:469 [inline]
> >>   __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
> >>   vfs_write+0x463/0x8d0 fs/read_write.c:544
> >>   SYSC_write+0x172/0x360 fs/read_write.c:589
> >>   SyS_write+0x55/0x80 fs/read_write.c:581
> >>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
> >>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > I did a little digging before sending the bug upstream.
> > If I add memset(obj, 0xfe, size) to __kmalloc_reserve(), these 0xfe
> > bytes are visible in __get_item() at the place where KMSAN reports an
> > error.
> >
> > The problem is somehow related to tun_get_user() creating a fragmented
> > sk_buff - when I change the call to tun_alloc_skb() so that it
> > allocates a single buffer the bug goes away.
> >
>
> I guess the following patch would fix the issue
>
> (I will submit it more formally)
No, as far as I can see it doesn't.
Saving sid before __skb_pull() is still a good idea, but in this
particular case |ph| doesn't change.
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index ce61231e96ea5fe27f512fbd0d80d4609997e508..333e967ed968ea3ff2dda2528=
9f7f657263db2b9 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -423,6 +423,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_=
device *dev,
>         struct pppoe_hdr *ph;
>         struct pppox_sock *po;
>         struct pppoe_net *pn;
> +       __be16 sid;
>         int len;
>
>         skb =3D skb_share_check(skb, GFP_ATOMIC);
> @@ -434,6 +435,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_=
device *dev,
>
>         ph =3D pppoe_hdr(skb);
>         len =3D ntohs(ph->length);
> +       sid =3D ph->sid;
>
>         skb_pull_rcsum(skb, sizeof(*ph));
>         if (skb->len < len)
> @@ -447,7 +449,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_=
device *dev,
>         /* Note that get_item does a sock_hold(), so sk_pppox(po)
>          * is known to be safe.
>          */
> -       po =3D get_item(pn, ph->sid, eth_hdr(skb)->h_source, dev->ifindex=
);
> +       po =3D get_item(pn, sid, eth_hdr(skb)->h_source, dev->ifindex);
>         if (!po)
>                 goto drop;
>
>
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/7424e094-afda-084a-ad80-299f219ced92%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
