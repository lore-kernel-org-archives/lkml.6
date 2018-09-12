Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729F1C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D940206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BqpbDM1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D940206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeILPmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:42:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41808 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeILPmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:42:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so1343138edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ME/bd8zsPUXku27pWq4ci356d2TeK9sCNN08px21RWc=;
        b=BqpbDM1dXiXxvhES1E7MCzR3EBoiuknbIg08cN+7TL5qlQkx6v9sOI27605vLNb9P/
         UcVCCGE77jTUKmsJCITA8s9OlRLiLTchEZt2WkznI7MgAFwtUKVnkt0zwgkiEeqsAO+w
         2DDUEMAPcNwBKsyK37tHcy/yAD4UVqmQTWbc6asKRXFiB5psRAhGvvCTgG8uBz2G9SoV
         PLudm3cockiRXtzlN39d3+D8am0HaIbYkfFRcWeh0e2GVEVf+DSL+q7PxQHDs40QQIHR
         6I8lW/i2wBv/8zDFp6HYgxWIaUHgaI+LzycrtqQJGQjpnBsWLWTnbIGwYi+Nc5jw25GS
         +n3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ME/bd8zsPUXku27pWq4ci356d2TeK9sCNN08px21RWc=;
        b=GV+V7v5fAHtRgRNKrPoAWN/DoJAPMD2jG0GEbDxoyfpfJ85B09ItJYyGhMCDX3o7Bx
         ln2EjD4m4pzUz3pNsK3uCQOQkQZiJ8KXLh6nOut/waCc6ULjHgMS1NbaNtmkPQ4jGMnl
         UTwm2B69tVHle0zd8pL14wngvljvZtDkWR9800YtYLSXNwpRB0okPClB612zX6rRWwEo
         lQHoo8zzFQQ48NoEAgjJ4LyuHIJm3eLRGfGR9Io0CP273UPPozq9SpjS5cmPmbgOJSFS
         YLUUPojkSh1JqFeO6Ec94Pu0BkNwgvXl7BBeO9s6dsTIvs3mVQ14lFRYVJ9F+XLkqexa
         e2bQ==
X-Gm-Message-State: APzg51C5Q3kDk2Xz6QvosNd0mEaOv2tTE3YFtUcBf1F66FnX2wfxfNqt
        TpS0yIvT75HjQ3J6b5n1Xx+aWSzX6jViGi9WxOvS1w==
X-Google-Smtp-Source: ANB0VdY+P9VHdRzDqvloYXvI5x71i1YdTZAR/sjjhOU8VTRuU1yFjWX9zQMkiRw302tXPunvwd74oFJQzwtJFiKmKbk=
X-Received: by 2002:a05:6402:50a:: with SMTP id m10mr2042767edv.22.1536748716775;
 Wed, 12 Sep 2018 03:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004624c30575a9fd40@google.com>
In-Reply-To: <0000000000004624c30575a9fd40@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 12 Sep 2018 12:38:25 +0200
Message-ID: <CAG_fn=Vk2HMPCLJV3aj1dt0KkDmksasBRRfKGnCTRHjvQ6OnQg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in pppoe_rcv
To:     syzbot+f5f6080811c849739212@syzkaller.appspotmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>, mostrows@earthlink.net,
        Networking <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 12:24 PM syzbot
<syzbot+f5f6080811c849739212@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem pages
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1465fc3780000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D48f9de3384bcd=
0f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df5f6080811c8497=
39212
> compiler:       clang version 7.0.0 (trunk 329391)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14d6e607800=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10a15b5b80000=
0
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+f5f6080811c849739212@syzkaller.appspotmail.com
>
> IPVS: ftp: loaded support on port[0] =3D 21
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in __get_item drivers/net/ppp/pppoe.c:172 [inlin=
e]
> BUG: KMSAN: uninit-value in get_item drivers/net/ppp/pppoe.c:236 [inline]
> BUG: KMSAN: uninit-value in pppoe_rcv+0xcef/0x10e0
> drivers/net/ppp/pppoe.c:450
> CPU: 0 PID: 4543 Comm: syz-executor355 Not tainted 4.16.0+ #87
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:17 [inline]
>   dump_stack+0x185/0x1d0 lib/dump_stack.c:53
>   kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
>   __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
>   __get_item drivers/net/ppp/pppoe.c:172 [inline]
>   get_item drivers/net/ppp/pppoe.c:236 [inline]
>   pppoe_rcv+0xcef/0x10e0 drivers/net/ppp/pppoe.c:450
>   __netif_receive_skb_core+0x47df/0x4a90 net/core/dev.c:4562
>   __netif_receive_skb net/core/dev.c:4627 [inline]
>   netif_receive_skb_internal+0x49d/0x630 net/core/dev.c:4701
>   netif_receive_skb+0x230/0x240 net/core/dev.c:4725
>   tun_rx_batched drivers/net/tun.c:1555 [inline]
>   tun_get_user+0x740f/0x7c60 drivers/net/tun.c:1962
>   tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
>   call_write_iter include/linux/fs.h:1782 [inline]
>   new_sync_write fs/read_write.c:469 [inline]
>   __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
>   vfs_write+0x463/0x8d0 fs/read_write.c:544
>   SYSC_write+0x172/0x360 fs/read_write.c:589
>   SyS_write+0x55/0x80 fs/read_write.c:581
>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> RIP: 0033:0x4447c9
> RSP: 002b:00007fff64c8fc28 EFLAGS: 00000297 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004447c9
> RDX: 000000000000fd87 RSI: 0000000020000600 RDI: 0000000000000004
> RBP: 00000000006cf018 R08: 00007fff64c8fda8 R09: 00007fff00006bda
> R10: 0000000000005fe7 R11: 0000000000000297 R12: 00000000004020d0
> R13: 0000000000402160 R14: 0000000000000000 R15: 0000000000000000
>
> Uninit was created at:
>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
>   kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
>   kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
>   kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
>   slab_post_alloc_hook mm/slab.h:445 [inline]
>   slab_alloc_node mm/slub.c:2737 [inline]
>   __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
>   __kmalloc_reserve net/core/skbuff.c:138 [inline]
>   __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
>   alloc_skb include/linux/skbuff.h:984 [inline]
>   alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
>   sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
>   tun_alloc_skb drivers/net/tun.c:1532 [inline]
>   tun_get_user+0x2242/0x7c60 drivers/net/tun.c:1829
>   tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
>   call_write_iter include/linux/fs.h:1782 [inline]
>   new_sync_write fs/read_write.c:469 [inline]
>   __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
>   vfs_write+0x463/0x8d0 fs/read_write.c:544
>   SYSC_write+0x172/0x360 fs/read_write.c:589
>   SyS_write+0x55/0x80 fs/read_write.c:581
>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I did a little digging before sending the bug upstream.
If I add memset(obj, 0xfe, size) to __kmalloc_reserve(), these 0xfe
bytes are visible in __get_item() at the place where KMSAN reports an
error.

The problem is somehow related to tun_get_user() creating a fragmented
sk_buff - when I change the call to tun_alloc_skb() so that it
allocates a single buffer the bug goes away.

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
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/0000000000004624c30575a9fd40%40google.com.
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
