Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31720C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2FE21479
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YlOsAgGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2FE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeJDMKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 08:10:45 -0400
Received: from ozlabs.org ([203.11.71.1]:41803 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbeJDMKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 08:10:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Qh592n6gz9s5c;
        Thu,  4 Oct 2018 15:19:09 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538630352;
        bh=HjfiBft+b3+JErvfzP5cwxZ09e6NNWllBLxdcheoWmQ=;
        h=Date:From:To:Cc:Subject:From;
        b=YlOsAgGqc+v4arZvKXoI34rtAeONsO4ZGRApC/VV+c362yyY+nKbBU3jD+rMbugHl
         AWyEB0Hp+i7MhY6G3ciCvCjEHB8uwbPeasN8DBH7diF1qo8B4dHxEVWtg3qcgcdTnW
         nAEUf8aXwgpZowcfq6MWqro1fqV3P+KuWk67k1j0+xgsRSiesogPQOMKdxH4/sg5yP
         bcJm8fzzMf8/sDkiOlq05qvI1tpT/htU791yJYUKatjGyzR5/8YnoYiXT+Pz6cXvB9
         VBjXtLME0e4HUzLP+KBNVWZvhwWUym68uCsel4dTONCXE+B+WmDpE2qLzCw5IoaQxZ
         Nl+uAbWnhjVYA==
Date:   Thu, 4 Oct 2018 15:19:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Sakoman <steve@sakoman.com>,
        Andreas Steinmetz <ast@domdv.de>,
        Eric Gallimore <egallimore@ucsd.edu>
Subject: linux-next: build failure after merge of the tty tree
Message-ID: <20181004151501.280d8282@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CPcBv77g2c0ccP.LnFwiQsO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CPcBv77g2c0ccP.LnFwiQsO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tty tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/tty/serial/samsung.c: In function 's3c24xx_serial_rx_enable':
drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define rx_enabled(port) ((port)->unused[1])
                                         ^
drivers/tty/serial/samsung.c:138:2: note: in expansion of macro 'rx_enabled'
  rx_enabled(port) =3D 1;
  ^~~~~~~~~~
drivers/tty/serial/samsung.c: In function 's3c24xx_serial_rx_disable':
drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define rx_enabled(port) ((port)->unused[1])
                                         ^
drivers/tty/serial/samsung.c:153:2: note: in expansion of macro 'rx_enabled'
  rx_enabled(port) =3D 0;
  ^~~~~~~~~~
drivers/tty/serial/samsung.c: In function 's3c24xx_serial_stop_tx':
drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define tx_enabled(port) ((port)->unused[0])
                                         ^
drivers/tty/serial/samsung.c:165:7: note: in expansion of macro 'tx_enabled'
  if (!tx_enabled(port))
       ^~~~~~~~~~
drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define tx_enabled(port) ((port)->unused[0])
                                         ^
drivers/tty/serial/samsung.c:185:2: note: in expansion of macro 'tx_enabled'
  tx_enabled(port) =3D 0;
  ^~~~~~~~~~
drivers/tty/serial/samsung.c: In function 's3c24xx_serial_start_tx':
drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define tx_enabled(port) ((port)->unused[0])
                                         ^
drivers/tty/serial/samsung.c:343:7: note: in expansion of macro 'tx_enabled'
  if (!tx_enabled(port)) {
       ^~~~~~~~~~
drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define tx_enabled(port) ((port)->unused[0])
                                         ^
drivers/tty/serial/samsung.c:347:3: note: in expansion of macro 'tx_enabled'
   tx_enabled(port) =3D 1;
   ^~~~~~~~~~
drivers/tty/serial/samsung.c: In function 's3c24xx_serial_stop_rx':
drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define rx_enabled(port) ((port)->unused[1])
                                         ^
drivers/tty/serial/samsung.c:392:6: note: in expansion of macro 'rx_enabled'
  if (rx_enabled(port)) {
      ^~~~~~~~~~
drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define rx_enabled(port) ((port)->unused[1])
                                         ^
drivers/tty/serial/samsung.c:399:3: note: in expansion of macro 'rx_enabled'
   rx_enabled(port) =3D 0;
   ^~~~~~~~~~
drivers/tty/serial/samsung.c: In function 's3c24xx_serial_rx_drain_fifo':
drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define rx_enabled(port) ((port)->unused[1])
                                         ^
drivers/tty/serial/samsung.c:621:8: note: in expansion of macro 'rx_enabled'
    if (rx_enabled(port)) {
        ^~~~~~~~~~
drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define rx_enabled(port) ((port)->unused[1])
                                         ^
drivers/tty/serial/samsung.c:623:6: note: in expansion of macro 'rx_enabled'
      rx_enabled(port) =3D 0;
      ^~~~~~~~~~
drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define rx_enabled(port) ((port)->unused[1])
                                         ^
drivers/tty/serial/samsung.c:631:6: note: in expansion of macro 'rx_enabled'
      rx_enabled(port) =3D 1;
      ^~~~~~~~~~
drivers/tty/serial/samsung.c: In function 's3c24xx_serial_shutdown':
drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define tx_enabled(port) ((port)->unused[0])
                                         ^
drivers/tty/serial/samsung.c:981:3: note: in expansion of macro 'tx_enabled'
   tx_enabled(port) =3D 0;
   ^~~~~~~~~~
drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define rx_enabled(port) ((port)->unused[1])
                                         ^
drivers/tty/serial/samsung.c:990:3: note: in expansion of macro 'rx_enabled'
   rx_enabled(port) =3D 0;
   ^~~~~~~~~~
drivers/tty/serial/samsung.c: In function 's3c24xx_serial_startup':
drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define rx_enabled(port) ((port)->unused[1])
                                         ^
drivers/tty/serial/samsung.c:1015:2: note: in expansion of macro 'rx_enable=
d'
  rx_enabled(port) =3D 1;
  ^~~~~~~~~~
drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define tx_enabled(port) ((port)->unused[0])
                                         ^
drivers/tty/serial/samsung.c:1029:2: note: in expansion of macro 'tx_enable=
d'
  tx_enabled(port) =3D 1;
  ^~~~~~~~~~
drivers/tty/serial/samsung.c: In function 's3c64xx_serial_startup':
drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define rx_enabled(port) ((port)->unused[1])
                                         ^
drivers/tty/serial/samsung.c:1080:2: note: in expansion of macro 'rx_enable=
d'
  rx_enabled(port) =3D 1;
  ^~~~~~~~~~
drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define tx_enabled(port) ((port)->unused[0])
                                         ^
drivers/tty/serial/samsung.c:1082:2: note: in expansion of macro 'tx_enable=
d'
  tx_enabled(port) =3D 0;
  ^~~~~~~~~~
drivers/tty/serial/samsung.c: In function 's3c24xx_serial_resume_noirq':
drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define tx_enabled(port) ((port)->unused[0])
                                         ^
drivers/tty/serial/samsung.c:1966:8: note: in expansion of macro 'tx_enable=
d'
    if (tx_enabled(port))
        ^~~~~~~~~~
drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither arr=
ay nor pointer nor vector
 #define rx_enabled(port) ((port)->unused[1])
                                         ^
drivers/tty/serial/samsung.c:1968:8: note: in expansion of macro 'rx_enable=
d'
    if (rx_enabled(port))
        ^~~~~~~~~~

Caused by commit

  c550f01c810f ("serial:serial_core: Allow use of CTS for PPS line discipli=
ne")

Looks like a suprise from some "interesting" previous development.

I have used the tty tree from next-20181003 for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/CPcBv77g2c0ccP.LnFwiQsO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu1oswACgkQAVBC80lX
0GzIsAf/YANxSqKdX4JozQDID2JC/cQzYBu7YCtNVFA5nK0ZGuUlMNqai0LpWew7
brtp/xBJiEfHsBceWVl2zHQjqOMBRjbr6O1och5DWotwmF8YEmkWh/jEHRsGaJBR
jMJdbgNjGrijlkGn41/dMMoOfcMXdjH4Hl2JYuytKfOTArzLeiz+I9aDqmD4MNn+
2RRosjOtIkVB+F0/kmpvhNyx4Ql7j3T4bl8CnY4TvdjCxV9NU+Zo5Q6lsXi6vR7a
oA8bJZpas0J82lp01cn04kfwcrTkFjFsHe9fReKBdk2eYCoGyQjQw1yA1ks9BXWx
zqhcHKj8Z7w4tZDidER/SIo4GI0v+w==
=8Mqa
-----END PGP SIGNATURE-----

--Sig_/CPcBv77g2c0ccP.LnFwiQsO--
