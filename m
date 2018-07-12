Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CBFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDD7213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVTteLv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDD7213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbeGLNqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:46:10 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36606 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbeGLNqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:46:09 -0400
Received: by mail-ua0-f194.google.com with SMTP id y8-v6so18415250uan.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2CT3LYQQzLqgEKWx5Y9tPVAoava6CJ+59DF0ZLzo8rs=;
        b=GVTteLv2PhkroZrubuRajyYGamQhEzqrcf23+gyloNIrRvXIs9mK62Hmsrc8qZV/3j
         wrdFxaX0PFKS2YTYU8x+q59OZNIda1IftyXV0QLCnRxc7tVu232CT789oBEIY5UksvR8
         BhwLbfZwxBgykwJgdZ5eZoUv26ERE00a9s1LmM4u5CY/W6AHEZZZKOU8nSINz37T0Mp0
         3JGTxk+RnK+HhnmG7gaqUTookYTthOf+RfUymOURRV470ZDl2DuOZojtzt4+8AvgZyRu
         FUELk9mriKo1TmbKMR+wYOdVeRyZjmm3iEXLL0CwHUZN87lhebHTnV7IzA/DRyrIbJX+
         IwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2CT3LYQQzLqgEKWx5Y9tPVAoava6CJ+59DF0ZLzo8rs=;
        b=bnHQNkuijKStoW4tJjZCX3ISnr1b4VhLZ8AvQgWngCSCVrar7RWBY8YDpPbvJ9udgM
         TxHf/tjmmVK+YV9PWteSQftdB0RvktxRuaGx+u/9oXY51GWPFf4Zf0AaqB2xeIchspuA
         bFDyVw9A6dxqFQQMg3ut/9HQrZe13YyUip/2bpvlUY7SwFoGjII6gEmS2oKgLcDan9VO
         whQrKfONXfYdjazcRNMFkEPLEkurws6Cbyk1+aEFaid0GmDN1VlszaJTAvEIqtffGQry
         x0ZtiYY6/dlR9cagl0aG2SKeIZyFSHKI4jsPBTMQAX0rt0CHBqwwhton0dQLsjsgFf4S
         Iu7g==
X-Gm-Message-State: AOUpUlEIhihCZ8pE/4BLRoisSaiowe3rZIgMR3MIJq9PPkw1/1jIKBt0
        VSVPeekZ7SsD4Zv5VNDdwqLH7Hr30UkLV1lPC92GfQ==
X-Google-Smtp-Source: AAOMgpfMG6H57UetgJbVRKlpqgtwv8KQowIe4CTNZhQ2F1ES8P5wWUypob9ZqWSVRH6i3R8fDXt6Q0tPxRa17tezxhc=
X-Received: by 2002:ab0:d94:: with SMTP id i20-v6mr1396068uak.67.1531402592849;
 Thu, 12 Jul 2018 06:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c541110570a978a4@google.com> <00000000000077da4b0570c9eccc@google.com>
In-Reply-To: <00000000000077da4b0570c9eccc@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Jul 2018 15:36:21 +0200
Message-ID: <CAG_fn=XDS-HTNQnzLixYHVFmg0EZkiFvZosOCALjoCMeNxYwWQ@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in p9_client_rpc
To:     syzbot+4de40388f584432bf004@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>, ericvh@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, lucho@ionkov.net,
        Networking <netdev@vger.kernel.org>, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 11:24 AM syzbot
<syzbot+4de40388f584432bf004@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    b64f7ec04e12 kmsan: implement kmsan_memmove_shadow() and =
k..
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12f6791c40000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D93d57043084ee=
e38
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4de40388f584432=
bf004
> compiler:       clang version 7.0.0 (trunk 334104)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=3D147c36dc400=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14e8704440000=
0
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+4de40388f584432bf004@syzkaller.appspotmail.com
>
> FS-Cache: O-key=3D[10] '34323934373135343132'
> FS-Cache: N-cookie c=3D(____ptrval____) [p=3D(____ptrval____) fl=3D2 nc=
=3D0 na=3D1]
> FS-Cache: N-cookie d=3D(____ptrval____) n=3D(____ptrval____)
> FS-Cache: N-key=3D[10] '34323934373135343132'
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in p9_client_rpc+0x194c/0x1dc0 net/9p/client.c:8=
18
> CPU: 1 PID: 4620 Comm: syz-executor262 Not tainted 4.18.0-rc4+ #24
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x185/0x1e0 lib/dump_stack.c:113
>   kmsan_report+0x195/0x2c0 mm/kmsan/kmsan.c:1092
>   __msan_warning_32+0x7d/0xe0 mm/kmsan/kmsan_instr.c:640
>   p9_client_rpc+0x194c/0x1dc0 net/9p/client.c:818
>   p9_client_attach+0x35b/0xc30 net/9p/client.c:1147
>   v9fs_session_init+0x24b9/0x2970 fs/9p/v9fs.c:449
>   v9fs_mount+0x107/0x11b0 fs/9p/vfs_super.c:135
>   mount_fs+0x29b/0x780 fs/super.c:1277
>   vfs_kern_mount+0x222/0x990 fs/namespace.c:1037
>   do_new_mount fs/namespace.c:2518 [inline]
>   do_mount+0xd30/0x5310 fs/namespace.c:2848
>   ksys_mount+0x32e/0x3d0 fs/namespace.c:3064
>   __do_sys_mount fs/namespace.c:3078 [inline]
>   __se_sys_mount fs/namespace.c:3075 [inline]
>   __x64_sys_mount+0x157/0x1c0 fs/namespace.c:3075
>   do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x445f79
> Code: e8 cc e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 3b 0d fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffb83104da8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00000000006dbc3c RCX: 0000000000445f79
> RDX: 0000000020000180 RSI: 00000000200000c0 RDI: 0000000000000000
> RBP: 00000000006dbc38 R08: 00000000200001c0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0030656c69662f2e
> R13: 64663d736e617274 R14: 7974697275636573 R15: 0000000000000001
>
> Local variable description: ----ecode.i@p9_client_rpc
> Variable was created at:
>   p9_client_rpc+0x183/0x1dc0 net/9p/client.c:750
>   p9_client_attach+0x35b/0xc30 net/9p/client.c:1147
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
FWIW the bug occurs here:
https://elixir.bootlin.com/linux/latest/source/net/9p/client.c#L560

  } else {
    err =3D p9pdu_readf(req->rc, c->proto_version, "d", &ecode);
    err =3D -ecode;

    p9_debug(P9_DEBUG_9P, "<<< RLERROR (%d)\n", -ecode);
  }

When p9pdu_readf() fails with -EFAULT, |ecode| may remain uninitialized.
We need to check the value of |err| before assigning |-ecode| to it.

> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000077da4b0570c9eccc%40google.com.
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
