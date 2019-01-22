Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FBDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EFD20861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ihYRm3Au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfAVECg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:02:36 -0500
Received: from ozlabs.org ([203.11.71.1]:55559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfAVECg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:02:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43kFB06pwtz9s7h;
        Tue, 22 Jan 2019 15:02:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548129753;
        bh=WZjtRUR+A4nS2WR4PNIqtjxrmPx0VoR3XlFlP7neZ5A=;
        h=Date:From:To:Cc:Subject:From;
        b=ihYRm3AuGU6aS+bbQ6nkMzEBNFziYeRpVUmE1fgdTd9Qwa5udFcr9ZYQMBUngCMdS
         hNiXQlFoKyjWp2m5ak2UtlODlVIa1RpB8tOzozs0LMMGbmBS8Xv4panKWKHKc8PGK8
         ZXT3TYpJvt2zf7CSwQ7SUb9dLWqZKp+s0iFvL+1Rb/ZYSI2gZEmu5aszOvcy9LqI05
         /QZHBcsUvONSdAJaGiBKJkcngdKbdkNyoUIs2hZt6oeCJbb0qx5GXoIid8knBfcCRg
         d0ZDglsQFtmxDa+/lmg3rWnWTTAN6g8Oj2gx+3Ew92HhgQBYRTvvk1wx2dWhr1yQLB
         jVx3pzAbEo+Zw==
Date:   Tue, 22 Jan 2019 15:02:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: linux-next: manual merge of the akpm tree with the kbuild tree
Message-ID: <20190122150231.0191e8d4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=T7=_vbGc._DhqQDGdMkICB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=T7=_vbGc._DhqQDGdMkICB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  Makefile

between commit:

  b57304bb03de ("kbuild: remove meaningless prepare2 target")

from the kbuild tree and patch:

  "locking/atomics: build atomic headers as required"

from the akpm tree.

I fixed it up (I hope - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Makefile
index 004a190e3ece,bd0f79d8295e..000000000000
--- a/Makefile
+++ b/Makefile
@@@ -1077,8 -1077,12 +1077,8 @@@ ifneq ($(KBUILD_SRC),
  	fi;
  endif
 =20
- prepare1: prepare3 outputmakefile asm-generic $(version_h) $(autoksyms_h)=
 \
- 						include/generated/utsrelease.h
 -# prepare2 creates a makefile if using a separate output directory.
 -# From this point forward, .config has been reprocessed, so any rules
 -# that need to depend on updated CONFIG_* values can be checked here.
 -prepare2: prepare3 outputmakefile asm-generic genheader
 -
 -prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelea=
se.h
++prepare1: prepare3 outputmakefile asm-generic genheader $(version_h) \
++				$(autoksyms_h) include/generated/utsrelease.h
  	$(cmd_crmodverdir)
 =20
  archprepare: archheaders archscripts prepare1 scripts

--Sig_/=T7=_vbGc._DhqQDGdMkICB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxGldcACgkQAVBC80lX
0GwVcQf+NDr4pxKcxmfrU0pD0/cvlui8s6dvsEysDP5i1sSYs8o9CjJgud2UPUgv
ACEk5Soih3OJT/ZJWIfa0JZ4y7PELyeYR0+k9GTp/6FEso/20mp6p5lef70l6N6R
WD65XZSbhv9g7WdrJQ7anfS+2g69/UHj512QxlLe2ohvh1Dx6yzwUyaEvKsytqQu
CXK9Wv3aPUum7RaYoPbe+OEyR48+V9awBvla7FLQM4gHqpcFMG8H+qbqjzCGShlv
4Nmg9hASHc22HMX4LqWwciuFQV8fqpCz7YQcsxPbJuiW5DY1jFYe8JGANSeP9QnI
8hkkENLoCdFT08vXI6atizgIsA8qLg==
=Duuv
-----END PGP SIGNATURE-----

--Sig_/=T7=_vbGc._DhqQDGdMkICB--
