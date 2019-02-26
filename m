Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC371C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6FF21848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G6jWRcPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfBZCsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 21:48:45 -0500
Received: from ozlabs.org ([203.11.71.1]:58141 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfBZCsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 21:48:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 447jtZ62mBz9s4V;
        Tue, 26 Feb 2019 13:48:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551149321;
        bh=o/Q5/PNuAtz7+8ihoibG7LV4HpTuMaTAsgmWpLhmfgA=;
        h=Date:From:To:Cc:Subject:From;
        b=G6jWRcPA2JF2nyXp8Udjdqds/JbmB0x73jU2j+xIrUgGx+WpSlcDKDfTrDE1EZlZA
         WIZdC4yCNHN4geXsxKjHy2CgA63jefI/kPKMgf0DuhbCp/tmIgQyxuyc7fJ9rqGJc9
         aDMiMCzehOwtXwKIX48Z0IVF3Z0PSf7qa3oSLqONvBvvAvBdWw9dig9le94rLZNUGQ
         ApXZr4tLZhihlFKzeI3zP45wn9ObWd3OGDTFANgh03bL6oGtZDi/dawWV+qwa8jdYJ
         GjXrQJYoRIxg6xMzDHwJ2aDp2+J+tdxcF4BvCtg1BFd2CbLvIXJ4cd+PGfBa6DZfyr
         qK53+jNQCs82w==
Date:   Tue, 26 Feb 2019 13:48:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: linux-next: manual merge of the tip tree with the kbuild tree
Message-ID: <20190226134835.35a51322@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yj77Klv+bFuYDbGji2MIpGq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yj77Klv+bFuYDbGji2MIpGq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  Kbuild

between commits:

  86948e2a69de ("scripts/gdb: delay generation of gdb constants.py")
  f4d5577af6d3 ("kbuild: remove unimportant comments from ./Kbuild")

from the kbuild tree and commit:

  8d32588077bd ("locking/atomics: Check generated headers are up-to-date")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Kbuild
index a07bbd62f052,4a4c47c38d1d..000000000000
--- a/Kbuild
+++ b/Kbuild
@@@ -50,5 -59,27 +50,18 @@@ quiet_cmd_syscalls =3D CALL    $
  missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
  	$(call cmd,syscalls)
 =20
+ #####
 -# 5) Check atomic headers are up-to-date
++# Check atomic headers are up-to-date
+ #
+=20
+ always +=3D old-atomics
+ targets +=3D old-atomics
+=20
+ quiet_cmd_atomics =3D CALL    $<
+       cmd_atomics =3D $(CONFIG_SHELL) $<
+=20
+ old-atomics: scripts/atomic/check-atomics.sh FORCE
+ 	$(call cmd,atomics)
+=20
 -#####
 -# 6) Generate constants for Python GDB integration
 -#
 -
 -extra-$(CONFIG_GDB_SCRIPTS) +=3D build_constants_py
 -
 -build_constants_py: $(timeconst-file) $(bounds-file)
 -	@$(MAKE) $(build)=3Dscripts/gdb/linux $@
 -
  # Keep these three files during make clean
  no-clean-files :=3D $(bounds-file) $(offsets-file) $(timeconst-file)

--Sig_/yj77Klv+bFuYDbGji2MIpGq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx0qQMACgkQAVBC80lX
0GwckAgAkonEJfSE3ilAxZo167WeHgtDGaKo5NfgtXgYnqxlFt2mZy4PGcD5bIHh
8KCFi8u4YmzFYxp4/YyLiuTDZanu8rIMtVL12xYWuG4X4cEhCrtMU6s2WHzhS9aM
/0NP8Oef5pMqYWjfqSMtj2UzFDPxorQNm/n2G2IZ5ZIgCrawnHC3MWMCU95Kt/J3
P/CaF+D3lrIghguhHdj6gA/OVHmgqQRbEAPxLt9KIe93LXkQGrcN1nFUGEV+Tx5F
6nJMmWHJYALHwrOzPNgmcVYZUWSlzPx8vFGPENbaP3w3fZ8kHayNL0lmX709RRKw
XeiOHlB3yO2KhQOKwxGoivFLVgzAJw==
=GwUK
-----END PGP SIGNATURE-----

--Sig_/yj77Klv+bFuYDbGji2MIpGq--
