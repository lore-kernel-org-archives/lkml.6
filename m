Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692FBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA922084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cOM5wuK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA922084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeKZLGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:06:40 -0500
Received: from ozlabs.org ([203.11.71.1]:60821 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbeKZLGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:06:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4336pw2fw6z9s29;
        Mon, 26 Nov 2018 11:14:16 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543191256;
        bh=ovhSnOJHxha8uL4oMi5dNreeBQkQViNwZVAzIF8fhws=;
        h=Date:From:To:Cc:Subject:From;
        b=cOM5wuK0a9mXJrzk0V9UAs03qaeibReCPJN6+SVNNrVmFQwYxcknKlyORk1MGbKQ+
         3t4EhjXPoxjvNuYsS6k/lQ/L5rlFJF3t7ytEBUohrEvUhl05a7fe2SHE3QrXBWuJt2
         AXO8NJqqDW2KG+7+WXSql5eNF/RJqHCjeCGztQAu9O3vGgvs/+KkAktpFUV+ZmQSJH
         jJ5Aogl0POQxU+u54pHSr1z58oy/Ec1zbt/o+oz1JEKo3EcAYUPAT6jlPcibtWMD3n
         XuNqpcWcYC09r0kxMi+zI2ejx4CdBOrIwzFdfs91pBv+cTZ1ClfudTbtT9wp166Sw6
         TqJSLLmkH6QSw==
Date:   Mon, 26 Nov 2018 11:14:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Kees Cook <keescook@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warnings after merge of the cifs tree
Message-ID: <20181126111415.5cf17f39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RUVevnnGZ=_EZC=qbx=0VoU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RUVevnnGZ=_EZC=qbx=0VoU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cifs tree, today's linux-next build (powerpc
ppc64_defconfig) produced these warnings:

fs/cifs/sess.c: In function 'cifs_select_sectype':
fs/cifs/sess.c:527:3: warning: this statement may fall through [-Wimplicit-=
fallthrough=3D]
   switch (requested) {
   ^~~~~~
fs/cifs/sess.c:540:2: note: here
  case CIFS_NEGFLAVOR_LANMAN:
  ^~~~
fs/cifs/connect.c: In function 'cifs_parse_mount_options':
fs/cifs/connect.c:1825:8: warning: this statement may fall through [-Wimpli=
cit-fallthrough=3D]
    if (!(tmp_end < end && tmp_end[1] =3D=3D delim)) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/cifs/connect.c:1832:3: note: here
   case Opt_pass:
   ^~~~

Exposed by my use of -Wimplicit-fallthrough

I am not sure why these only turned up now (as opposed to earlier today).

--=20
Cheers,
Stephen Rothwell

--Sig_/RUVevnnGZ=_EZC=qbx=0VoU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7OtcACgkQAVBC80lX
0Gz+Dgf+LpJcZbxKkKV6JW3gTcE1TrMo5YsVG7CfwlY93b+mDdBXBA9+RmbGHZVa
QzEaZjByfKxRfzhqAW2XCHAQcuLVqcoXaINWsZToDOFZ5aNEADXmcEO1IGfdr8rh
gDJCA7dKIcehREAQvCZZrnQrDvCWx62YNa3SEbiwTsgl+NZMfWjwWrbLdYct3N3b
sR7GMkd6UwDbJ4vxI8wEDJYcWaCigOT8krDfsIoR12RaxId2xzL+69eLZvTi49ev
7RNobIv8OZD4F18Q6ZBUmMVP0QOJUUtHMzs0T3Ob/WJiwAioEn1SKHnYi7BPw1Aj
tM2zVVg4BfV59GoLTeHO/cErnnWXGw==
=Ivdr
-----END PGP SIGNATURE-----

--Sig_/RUVevnnGZ=_EZC=qbx=0VoU--
