Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F3AC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819152170A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dNSsMETY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819152170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbeHCJZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:25:43 -0400
Received: from ozlabs.org ([203.11.71.1]:55311 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeHCJZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:25:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41hdxZ1vLNz9s2g;
        Fri,  3 Aug 2018 17:30:42 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533281442;
        bh=rWC6U2wmG+i5AKlLQ+wX60AUJNLFMPNHRJ4mjRLbZTw=;
        h=Date:From:To:Cc:Subject:From;
        b=dNSsMETYBWQcm33iEGPt2O/Cejo0BIKQG4a8NV/fQ0u82F+ZWE7pi8hyAABu/Nhbj
         6BIdNcm88VmtcoqzPomuTs6s3o57XztQT67Ml4gJyRHKOXh4RjLL/R2mH/DOdhGIUc
         YKI6oXdOQOOTHgkfvOuW3EeURrKzLT3SumfGFX24xg1j//ZjqV6az1MW0E0zpJ1/sl
         7IhUfA5gVgOX8o0amAEOexJgCfp05QvJ1Bu03k7WxOLNUQ24163lCebFKBn89x/yL+
         q6b1qvM9TPrR7Gz8+I0Z1J3gF3pMynyqtMcH1vwGtuvmBwk4Cw+/WZKks0uOpUSyu+
         uVcVpDmUCTksw==
Date:   Fri, 3 Aug 2018 17:30:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: manual merge of the kspp tree with the kbuild tree
Message-ID: <20180803173020.6ec4014b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m2GtnMjyRP9inw_CV6krOjD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m2GtnMjyRP9inw_CV6krOjD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

Today's linux-next merge of the kspp tree got a conflict in:

  arch/Kconfig

between commit:

  22471e1313f2 ("kconfig: use a menu in arch/Kconfig to reduce clutter")

from the kbuild tree and commit:

  45332b1bdfdc ("gcc-plugins: split out Kconfig entries to scripts/gcc-plug=
ins/Kconfig")

from the kspp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/Kconfig
index 6cf1b17a8df2,43f315b84c8f..000000000000
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@@ -984,4 -836,4 +847,6 @@@ config REFCOUNT_FUL
 =20
  source "kernel/gcov/Kconfig"
 =20
+ source "scripts/gcc-plugins/Kconfig"
++
 +endmenu

--Sig_/m2GtnMjyRP9inw_CV6krOjD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltkBIwACgkQAVBC80lX
0Gzfegf/VTsI9WALVx0KBWcF5tGdv5ZG4SEG9mLmguyn6Q5qOQQYKR0201wuG+I9
/lJI6bgK3QCLXRILt/5Eso6KAUkGRE5rXXquilHUViClvHGPBHRmb+M1XZy6GmlK
BwT2dDzifwHOdONfm8wu/W3JkAwE/pfwWheIJ1earW4OV0RDBfwjv5gnPrEMkygW
vWbuVhmH/abQnelHVH7QqhdoyFxCcoVTYHgaxYBua4xexYwFhrFruxJuClYYNaBg
9KD7VCasxCtFRhU8qh9CIWZUCBJbY+PJKBcgB5raLGezQK3DdOW1V5yrPZQ3XniH
fArKnRKojRhPR5B80oh7si8PO4HbQw==
=FnS+
-----END PGP SIGNATURE-----

--Sig_/m2GtnMjyRP9inw_CV6krOjD--
