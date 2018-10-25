Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E502C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418572075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpWs0BtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418572075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJYTjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:39:55 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42771 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJYTjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:39:54 -0400
Received: by mail-vs1-f66.google.com with SMTP id e126so5208587vsc.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iCvPs9qFDcy3QsF3utDxIdDhj9/aA//khmUR4t/yu6A=;
        b=JpWs0BtJyud2XyyQu4Np9aFQy3M5EXKBMoJCnUhFVpAqW+MJHvfMkn9sd7BpeWnoeW
         IsoHpspuVNdpx84omxhYxkE/ZzRbpeMiXra2N/uVZO9kUqfavDHNhAK2DsJtjibv2UN9
         7CA9vr6PCax/fpJx2giloS6QWAaQ6zl8RMjv26sTQIxxEzIi6FtDjgsdS9zB5npiP5C+
         A9yDWEPnya7WQ7FxXbJIw+1PROuzTHOplJA1kvvl29kBQtcMKiRbpig6vlMYJKiIvjh5
         LRG1oxj9Eq5nfN1qjDaTWAHeA0Y53d0pe07S0Ren/6GJe8MUjRSHeFHGVL61bkV6f8Ox
         RhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iCvPs9qFDcy3QsF3utDxIdDhj9/aA//khmUR4t/yu6A=;
        b=LpQqmwKVvwJ68v161WWcT5ffD0Iv38rRkD1kUoQ2/NTxQN0oPidESDeDq8u7RKVLxU
         IjUxIfJs9WkANmcKD78BiO3GmyjreOJCkqrJXQ2TGCl4zi/haWDLZoe0lOC7LwnIM788
         kgUmDkML6q5p6/U3NyPnTlO12YSCaBG6G3quAoyihMLWCeSioqua0YAJoonfsRNGkqMU
         P4skFLSjI43dzfA6Kao0ARq4xuTTcqtHGpRwytRd6D4pn6WuXiyrgwBKMFQF5cE2YkJv
         T1iUrWDGrjV6cq98bh4vGXpSyN3uuHyowWRf/dRST90FpvZv+HmIxNgRVB0vrJKqDMBx
         DfcQ==
X-Gm-Message-State: AGRZ1gI30g7DFdetl8B5/cG9FxCNkJgINRV/B3CrONMmiI5K9BYOheFE
        7tp7AHidWPV31SX2SVaVuIGEYesHoVw6I1uMUeQ1FA==
X-Google-Smtp-Source: AJdET5c4CzCPg/uZ10CGoRnRDJrDV0OEwg9qulAXea9lNA3ub9SSJeQn5H5EMbreRG6owMaVlE/VGp6Mzaq+WpsgyV0=
X-Received: by 2002:a67:2704:: with SMTP id n4mr462235vsn.209.1540465656905;
 Thu, 25 Oct 2018 04:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamv0P63dTXEjzbDp6ahaNRuUiRPWTnj_N2RV7monBk4bHw@mail.gmail.com>
In-Reply-To: <CAEAjamv0P63dTXEjzbDp6ahaNRuUiRPWTnj_N2RV7monBk4bHw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 25 Oct 2018 13:07:25 +0200
Message-ID: <CAG_fn=XKKZcXq2615Ubn-sFNLvJXSPJvtsKr-zHU=pAP29FTcQ@mail.gmail.com>
Subject: Re: BUG: KMSAN: uninit-value in selinux_socket_bind, selinux_socket_connect_helper
To:     kt0755@gmail.com
Cc:     David Miller <davem@davemloft.net>, lifeasageek@gmail.com,
        syzkaller@googlegroups.com, threeearcat@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, alexey.kodanev@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:35 PM Kyungtae Kim <kt0755@gmail.com> wrote:
>
> We report two crashes related (in v4.19-rc8) :
> "BUG: KMSAN: uninit-value in selinux_socket_bind"
> "BUG: KMSAN: uninit-value in selinux_socket_connect_helper=E2=80=9D
>
> kernel config: https://kt0755.github.io/etc/config-4.19-rc2.kmsan
> repro: https://kt0755.github.io/etc/repro.b0e55.c
>
> Since both crashes share the same issue, we just explain one of the two.
> When the third argument of bind() (i.e., addrlen) is zero, in __sys_bind(=
),
> data copy from user sockaddr to kernel sockaddr does not occur
> (net/socket.c:186).
> However, a subsequent function selinux_socket_bind() tries to read
> the kernel sockaddr (address->sa_family) that was not initialized at all.
>
> Crash log1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in selinux_socket_bind+0x61b/0x1040
> security/selinux/hooks.c:4643
> CPU: 0 PID: 19070 Comm: syz-executor6 Not tainted 4.19.0-rc8+ #18
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2=
011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x305/0x460 lib/dump_stack.c:113
>  kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
>  __msan_warning+0x7d/0xe0 mm/kmsan/kmsan_instr.c:500
>  selinux_socket_bind+0x61b/0x1040 security/selinux/hooks.c:4643
>  security_socket_bind+0x127/0x200 security/security.c:1390
>  __sys_bind+0x577/0x7e0 net/socket.c:1479
>  __do_sys_bind net/socket.c:1494 [inline]
>  __se_sys_bind+0x8d/0xb0 net/socket.c:1492
>  __x64_sys_bind+0x4a/0x70 net/socket.c:1492
>  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x4497b9
> Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fdddf1e9c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
> RAX: ffffffffffffffda RBX: 00007fdddf1ea6cc RCX: 00000000004497b9
> RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000013
> RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000000004c8 R14: 00000000006e8568 R15: 00007fdddf1ea700
>
> Local variable description: ----address@__sys_bind
> Variable was created at:
>  __sys_bind+0x89/0x7e0 net/socket.c:1470
>  __do_sys_bind net/socket.c:1494 [inline]
>  __se_sys_bind+0x8d/0xb0 net/socket.c:1492
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Crash log2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in selinux_socket_connect_helper+0x55c/0x960
> security/selinux/hooks.c:4775
> CPU: 0 PID: 8234 Comm: syz-executor2 Not tainted 4.19.0-rc8+ #18
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2=
011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x305/0x460 lib/dump_stack.c:113
>  kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
>  __msan_warning+0x7d/0xe0 mm/kmsan/kmsan_instr.c:500
>  selinux_socket_connect_helper+0x55c/0x960 security/selinux/hooks.c:4775
>  selinux_socket_connect+0xbe/0x180 security/selinux/hooks.c:4834
>  security_socket_connect+0x127/0x200 security/security.c:1395
>  __sys_connect+0x577/0x850 net/socket.c:1660
>  __do_sys_connect net/socket.c:1675 [inline]
>  __se_sys_connect+0x8d/0xb0 net/socket.c:1672
>  __x64_sys_connect+0x4a/0x70 net/socket.c:1672
>  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x4497b9
> Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ff660d67c68 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> RAX: ffffffffffffffda RBX: 00007ff660d686cc RCX: 00000000004497b9
> RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000013
> RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 0000000000000ae0 R14: 00000000006e8b80 R15: 00007ff660d68700
>
> Local variable description: ----address@__sys_connect
> Variable was created at:
>  __sys_connect+0x89/0x850 net/socket.c:1647
>  __do_sys_connect net/socket.c:1675 [inline]
>  __se_sys_connect+0x8d/0xb0 net/socket.c:1672
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> We provide a simple patch below to stop them.
> There are a few more lines that invoke move_addr_to_kernel(), but the
> two of them
> (bind and connect) seem to be the only cases to be corrected.
>
>
> diff --git a/net/socket.c b/net/socket.c
> index 390a8ec..de0931c2 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1475,7 +1475,7 @@ int __sys_bind(int fd, struct sockaddr __user
> *umyaddr, int addrlen)
>         sock =3D sockfd_lookup_light(fd, &err, &fput_needed);
>         if (sock) {
>                 err =3D move_addr_to_kernel(umyaddr, addrlen, &address);
> -               if (err >=3D 0) {
> +               if (err > 0) {
>                         err =3D security_socket_bind(sock,
>                                                    (struct sockaddr *)&ad=
dress,
>                                                    addrlen);
> @@ -1653,7 +1653,7 @@ int __sys_connect(int fd, struct sockaddr __user
> *uservaddr, int addrlen)
>         if (!sock)
>                 goto out;
>         err =3D move_addr_to_kernel(uservaddr, addrlen, &address);
> -       if (err < 0)
> +       if (err <=3D 0)
>                 goto out_put;
>
>         err =3D
I believe a better fix would be to add an |addrlen| check to
selinux_socket_bind(), which is illegally assuming
|address->sa_family| contains any reasonable data regardless of actual
address length.
I suspect the bug has been introduced in
https://github.com/torvalds/linux/commit/0f8db8cc73df60b3de9a5eebd8f117b56e=
ff5b03
>
> Thanks,
> Kyungtae Kim
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller+unsubscribe@googlegroups.com.
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
