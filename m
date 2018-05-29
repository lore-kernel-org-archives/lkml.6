Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932583AbeE2JIx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:08:53 -0400
Received: from ozlabs.org ([203.11.71.1]:40651 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932081AbeE2JIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:08:49 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 19:08:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnacek@gmail.com>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20180529190846.764421ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KHhFPrq2P4XRRlTrsX5N.H0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KHhFPrq2P4XRRlTrsX5N.H0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

After merging the crypto tree, today's linux-next build (powerpc
allyesconfig) failed like this:

/home/sfr/next/next/crypto/morus640_glue.c:24:10: fatal error: asm/fpu/api.=
h: No such file or directory
 #include <asm/fpu/api.h>
          ^~~~~~~~~~~~~~~
/home/sfr/next/next/crypto/morus1280_glue.c:24:10: fatal error: asm/fpu/api=
.h: No such file or directory
 #include <asm/fpu/api.h>
          ^~~~~~~~~~~~~~~

Caused by commit

  56e8e57fc3a7 ("crypto: morus - Add common SIMD glue code for MORUS")

I have marked them as broken for now:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 29 May 2018 18:59:17 +1000
Subject: [PATCH] crypto: make common SIMD glue code for MORUS as BROKEN for
 now

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 crypto/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 75f5efde9aa3..ad69785dc9d3 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -342,6 +342,7 @@ config CRYPTO_MORUS640
=20
 config CRYPTO_MORUS640_GLUE
 	tristate "MORUS-640 AEAD algorithm (glue for SIMD optimizations)"
+	depends on BROKEN
 	select CRYPTO_AEAD
 	select CRYPTO_CRYPTD
 	help
@@ -351,6 +352,7 @@ config CRYPTO_MORUS640_GLUE
 config CRYPTO_MORUS640_SSE2
 	tristate "MORUS-640 AEAD algorithm (x86_64 SSE2 implementation)"
 	depends on X86 && 64BIT
+	depends on BROKEN
 	select CRYPTO_AEAD
 	select CRYPTO_MORUS640_GLUE
 	help
@@ -364,6 +366,7 @@ config CRYPTO_MORUS1280
=20
 config CRYPTO_MORUS1280_GLUE
 	tristate "MORUS-1280 AEAD algorithm (glue for SIMD optimizations)"
+	depends on BROKEN
 	select CRYPTO_AEAD
 	select CRYPTO_CRYPTD
 	help
@@ -373,6 +376,7 @@ config CRYPTO_MORUS1280_GLUE
 config CRYPTO_MORUS1280_SSE2
 	tristate "MORUS-1280 AEAD algorithm (x86_64 SSE2 implementation)"
 	depends on X86 && 64BIT
+	depends on BROKEN
 	select CRYPTO_AEAD
 	select CRYPTO_MORUS1280_GLUE
 	help
@@ -382,6 +386,7 @@ config CRYPTO_MORUS1280_SSE2
 config CRYPTO_MORUS1280_AVX2
 	tristate "MORUS-1280 AEAD algorithm (x86_64 AVX2 implementation)"
 	depends on X86 && 64BIT
+	depends on BROKEN
 	select CRYPTO_AEAD
 	select CRYPTO_MORUS1280_GLUE
 	help
--=20
2.17.0

--=20
Cheers,
Stephen Rothwell

--Sig_/KHhFPrq2P4XRRlTrsX5N.H0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsNGJ4ACgkQAVBC80lX
0Gzdrwf8DU2Wc62pa1uvj8/ve0euPcyeCjQAw4LNKAjdHyJe1tIPSoTYWAQiUf7O
ei1eNwKK4B4/3KGPMrUnPCKJbl7JqsVcZITAyXEJjVUzSD6hMlTOPGXPG8anqvm8
4lJy9mdYN0z+ONXjyUQMuVlDD4NykFKjOGoiDCDwUlJOflpxVnyRmstRriWQf7ka
UdLQqfmmlQztneOpQr0bz+wWuQ16OoXCfOCv31pz9NmNtXso6Wy3IwCTWato+7LJ
oAtEeFaaLFhHm5G2jS5Ycu6RYsOzL6MyzRoDiMUWSISzUI8DxjWdw9ZPBbY9Sesv
FLIdj9FYUzPlFCa696MslQYorC8qpQ==
=Ag3E
-----END PGP SIGNATURE-----

--Sig_/KHhFPrq2P4XRRlTrsX5N.H0--
