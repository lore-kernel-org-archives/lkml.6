Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40112C6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDEB2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ovrowa8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDEB2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeJHH50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 03:57:26 -0400
Received: from ozlabs.org ([203.11.71.1]:56305 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHH50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 03:57:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42T1tg04ZJz9sCr;
        Mon,  8 Oct 2018 11:48:10 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538959691;
        bh=/7hdWEwoKT4HEqDL9FTnqJQ3b04pUcsnbQRFNO4797E=;
        h=Date:From:To:Cc:Subject:From;
        b=ovrowa8kA86pkAXGZGeB3QN1DuXJErZ77NMUKwRYvVGEsM5b0PHYQv0g4Eo2qLHOi
         KJDlxHPVnRwilDvbmo4cBbdutaxRrxZYgOgFr/XWkeQejfIivg7UTSWd2juGFKr3dJ
         d+Y6gzfP3BQVR8VvHvFlfFGqp3QhglgIGm5biQ7OWlJnEXOQoxbZ0UJfwU0B9ByLsj
         zOSpubI3095Lo2eiln3Z+1tV4iZPSO5tzWfxNjxgUwCT8JybifW2aD2XpLM5QGZXJt
         gXZRX7RUQVhDn+5UWcq8Djv760gCSIrUZ/ql+Qt7/eLCwuBmrZ0llVUQUfJGipkulL
         HI+uem4hM+m5w==
Date:   Mon, 8 Oct 2018 11:48:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: manual merge of the crypto tree with the
 compiler-attributes tree
Message-ID: <20181008114810.6ebbb337@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XXnT=3WqFicXpf1WwTseQTM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XXnT=3WqFicXpf1WwTseQTM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the crypto tree got a conflict in:

  include/linux/compiler_types.h

between commit:

  a3f8a30f3f00 ("Compiler Attributes: use feature checks instead of version=
 checks")

from the compiler-attributes tree and commit:

  f3569fd613f6 ("crypto: shash - Remove VLA usage in unaligned hashing")

from the crypto tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

A removed line was moved to a new file, so I have applied the following
merge fix patch from today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 8 Oct 2018 11:44:24 +1100
Subject: [PATCH] crypto: fixup for movement of __aligned_largest

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/compiler_attributes.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_a=
ttributes.h
index 6b28c1b7310c..9db94801c780 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -49,7 +49,6 @@
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.ht=
ml#index-aligned-variable-attribute
  */
 #define __aligned(x)                    __attribute__((__aligned__(x)))
-#define __aligned_largest               __attribute__((__aligned__))
=20
 /*
  * Note: users of __always_inline currently do not write "inline" themselv=
es,
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/XXnT=3WqFicXpf1WwTseQTM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu6qUoACgkQAVBC80lX
0Gx+4gf/SNH9A95PkGldA12AeMgCDgtiQRIL+gOwJwyjnrh9fURD4oYQ9cKCmGFF
gamZAib/dfFCcGwPec6CefSwSjqRuRzJzOe5FINCZabUSfkggb7rxPPN1eZcEUBn
lFEbItnYtU/DHSs4kDPXX1NjC85gGKeZ8zeX+H0M2U8h0mzExdVXoS6x9+t+XGQM
/lVx/qpjBUSohA6wdbLkRxcMRX2KIiFlUiEBDa+ovmazpwmZlP3GAzGSJ3M6IrNd
VSt7oy0W/pwxmJU5yhpyIhesnCCD7lXNWf9GUHMAd/Oo0UcNx1/fEHyitGxIlvL/
fkxp6KlplyHE2NsyHi5llA/JD5CQig==
=bMZN
-----END PGP SIGNATURE-----

--Sig_/XXnT=3WqFicXpf1WwTseQTM--
