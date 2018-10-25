Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8348C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3552075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vAt0qdU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3552075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeJYTHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:07:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36439 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJYTHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:07:37 -0400
Received: by mail-io1-f68.google.com with SMTP id o19-v6so5155605iod.3;
        Thu, 25 Oct 2018 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=HApCBrP3GUcUQzrqXjWtOUnbeF7cKGnNY5yardXuXDg=;
        b=vAt0qdU6s/EoYzvIYKXzTyL8a7YnPc1EXGa8YlVQtwtjbkNl7r1s2COiF+yQcLeORD
         jUWz8CecUHDWnplpiP0Jbm2vUJFhlG2uIh71ha2AChtct5aIqHN8RI/Oc6EZRk1AkWAL
         t/kQdW19TjqLpeCTgMxhWzAQXQXb4z/DBLwng3waoKtmRQQCsFXDde4VG0DHEX1piK7n
         L86POEzwd+IPtPZzP7gvrbbAXeK1+TS2oNs0D+dGv0ngjxPf73kO9pBIJX1v6Bsugjru
         YQjAT+X1PBaPDXsPnuyFWeG1oanRDf0dUrMu5uTSsXiNdh/z2UGkYS7cpHslIaEKdaLw
         NKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=HApCBrP3GUcUQzrqXjWtOUnbeF7cKGnNY5yardXuXDg=;
        b=JbN9hUzjWCDoBUeqIFQI6X6DtkOmygrBMkc67HVfrni1FZezEmsYt13tPOcKLM7fzV
         JJWaZwHqZq+P0RriY8ccbZKkAqAZMR1IgJJImRxxC/nbCaz/H/GSGWpvrdYKxPTTWZcP
         TQ2bg12OFgmOVVTO22s7llBefpZlQrHObvXv9Yc41BiIGTzfWtL0ctQDM9OvMntnqLxg
         dvkX+9PuDiet2qkXNYvHRVkPjXo31Zcdf1ql9NiIYwfS1lEM1156VsoYErP8RBDT7dRo
         LU1SRhixl1owSj2VijV34fJpp9HqFEEUMfZ0BBhZr/JspT2FJJ5i4NquF4zion8xGxxw
         EuJA==
X-Gm-Message-State: AGRZ1gJ9k4KWxxP+4iqzXJku/jGwjuS0ePy7awvsbqNMlFVgh+l+ffWF
        r358XB5eZBXT+iXVGly5QOMTLadSsaRk/BRdT0c=
X-Google-Smtp-Source: AJdET5eI+lJoQ/zMWb0ovNFf1gx3FnbHUzwJHAKxC7E24Osfev5VIaOh7jg1SF5gW862ONcoQJOT6P/UOu48ziG0Cjc=
X-Received: by 2002:a6b:8e90:: with SMTP id q138-v6mr651852iod.112.1540463727086;
 Thu, 25 Oct 2018 03:35:27 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Thu, 25 Oct 2018 06:35:15 -0400
Message-ID: <CAEAjamv0P63dTXEjzbDp6ahaNRuUiRPWTnj_N2RV7monBk4bHw@mail.gmail.com>
Subject: BUG: KMSAN: uninit-value in selinux_socket_bind, selinux_socket_connect_helper
To:     davem@davemloft.net
Cc:     lifeasageek@gmail.com, syzkaller@googlegroups.com,
        threeearcat@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report two crashes related (in v4.19-rc8) :
"BUG: KMSAN: uninit-value in selinux_socket_bind"
"BUG: KMSAN: uninit-value in selinux_socket_connect_helper=E2=80=9D

kernel config: https://kt0755.github.io/etc/config-4.19-rc2.kmsan
repro: https://kt0755.github.io/etc/repro.b0e55.c

Since both crashes share the same issue, we just explain one of the two.
When the third argument of bind() (i.e., addrlen) is zero, in __sys_bind(),
data copy from user sockaddr to kernel sockaddr does not occur
(net/socket.c:186).
However, a subsequent function selinux_socket_bind() tries to read
the kernel sockaddr (address->sa_family) that was not initialized at all.

Crash log1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KMSAN: uninit-value in selinux_socket_bind+0x61b/0x1040
security/selinux/hooks.c:4643
CPU: 0 PID: 19070 Comm: syz-executor6 Not tainted 4.19.0-rc8+ #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/201=
1
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x305/0x460 lib/dump_stack.c:113
 kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
 __msan_warning+0x7d/0xe0 mm/kmsan/kmsan_instr.c:500
 selinux_socket_bind+0x61b/0x1040 security/selinux/hooks.c:4643
 security_socket_bind+0x127/0x200 security/security.c:1390
 __sys_bind+0x577/0x7e0 net/socket.c:1479
 __do_sys_bind net/socket.c:1494 [inline]
 __se_sys_bind+0x8d/0xb0 net/socket.c:1492
 __x64_sys_bind+0x4a/0x70 net/socket.c:1492
 do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fdddf1e9c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007fdddf1ea6cc RCX: 00000000004497b9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000004c8 R14: 00000000006e8568 R15: 00007fdddf1ea700

Local variable description: ----address@__sys_bind
Variable was created at:
 __sys_bind+0x89/0x7e0 net/socket.c:1470
 __do_sys_bind net/socket.c:1494 [inline]
 __se_sys_bind+0x8d/0xb0 net/socket.c:1492
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Crash log2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KMSAN: uninit-value in selinux_socket_connect_helper+0x55c/0x960
security/selinux/hooks.c:4775
CPU: 0 PID: 8234 Comm: syz-executor2 Not tainted 4.19.0-rc8+ #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/201=
1
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x305/0x460 lib/dump_stack.c:113
 kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
 __msan_warning+0x7d/0xe0 mm/kmsan/kmsan_instr.c:500
 selinux_socket_connect_helper+0x55c/0x960 security/selinux/hooks.c:4775
 selinux_socket_connect+0xbe/0x180 security/selinux/hooks.c:4834
 security_socket_connect+0x127/0x200 security/security.c:1395
 __sys_connect+0x577/0x850 net/socket.c:1660
 __do_sys_connect net/socket.c:1675 [inline]
 __se_sys_connect+0x8d/0xb0 net/socket.c:1672
 __x64_sys_connect+0x4a/0x70 net/socket.c:1672
 do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff660d67c68 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007ff660d686cc RCX: 00000000004497b9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000ae0 R14: 00000000006e8b80 R15: 00007ff660d68700

Local variable description: ----address@__sys_connect
Variable was created at:
 __sys_connect+0x89/0x850 net/socket.c:1647
 __do_sys_connect net/socket.c:1675 [inline]
 __se_sys_connect+0x8d/0xb0 net/socket.c:1672
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

We provide a simple patch below to stop them.
There are a few more lines that invoke move_addr_to_kernel(), but the
two of them
(bind and connect) seem to be the only cases to be corrected.


diff --git a/net/socket.c b/net/socket.c
index 390a8ec..de0931c2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1475,7 +1475,7 @@ int __sys_bind(int fd, struct sockaddr __user
*umyaddr, int addrlen)
        sock =3D sockfd_lookup_light(fd, &err, &fput_needed);
        if (sock) {
                err =3D move_addr_to_kernel(umyaddr, addrlen, &address);
-               if (err >=3D 0) {
+               if (err > 0) {
                        err =3D security_socket_bind(sock,
                                                   (struct sockaddr *)&addr=
ess,
                                                   addrlen);
@@ -1653,7 +1653,7 @@ int __sys_connect(int fd, struct sockaddr __user
*uservaddr, int addrlen)
        if (!sock)
                goto out;
        err =3D move_addr_to_kernel(uservaddr, addrlen, &address);
-       if (err < 0)
+       if (err <=3D 0)
                goto out_put;

        err =3D


Thanks,
Kyungtae Kim
