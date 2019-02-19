Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9994C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781FA20818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Do2LxEaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfBSEeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:34:12 -0500
Received: from ozlabs.org ([203.11.71.1]:38295 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfBSEeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:34:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443SYW0KZ7z9s5c;
        Tue, 19 Feb 2019 15:34:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550550849;
        bh=6GNvg2qjAi/0TcTt/349vx7rQ2QcvbLKnPE/NZQh7fI=;
        h=Date:From:To:Cc:Subject:From;
        b=Do2LxEaJAPsd8l/cqq788TROaqXvO3//TjmLkdwf6hDJqMvsQ8TxGaUaecJdQbgAx
         01EXhH8+g8SjfNtMOu7gGsqk5fHIvLHO2CapPxt2Zt/qlh9roql8bVZMOByb7Hll13
         /IqUWXzCjvSBymFyTROXmlU0nsTGTmWvY90hWA2pAbojgO398uFGhPUQPwvdYsa2Z0
         +B119a4QV66CmBHBzpmPgHNVZ4Vq4KfZscyVgaFsV4gY/GAouwuE5tInHhu7+qnAa3
         B62guFIYF4jB6MU9SgMaDoEn+9mV6Z063JK57mrK0c8qktxkRKj4Il4fDaybZJ8hm4
         z5Wh6ENBYUTJQ==
Date:   Tue, 19 Feb 2019 15:34:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hugo Lefeuvre <hle@owl.eu.com>
Subject: linux-next: manual merge of the char-misc tree with the asm-generic
 tree
Message-ID: <20190219153406.5ed74b40@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4l9P=MH3XyGHQkandahlrn4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4l9P=MH3XyGHQkandahlrn4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  include/asm-generic/iomap.h

between commit:

  e377ce8bcba0 ("iomap: add missing function args identifier names")

from the asm-generic tree and commit:

  79bf0cbd86ac ("iomap: introduce io{read|write}64_{lo_hi|hi_lo}")

from the char-misc tree.

I fixed it up (see below - though I guess the new ioread... prototypes
introduced by the char-misc tree may want "const" added to their
arguments) and can carry the fix as necessary. This is now fixed as far
as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/asm-generic/iomap.h
index cd92d32a4d87,a008f504a2d0..000000000000
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@@ -26,26 -26,48 +26,48 @@@
   * in the low address range. Architectures for which this is not
   * true can't use this generic implementation.
   */
 -extern unsigned int ioread8(void __iomem *);
 -extern unsigned int ioread16(void __iomem *);
 -extern unsigned int ioread16be(void __iomem *);
 -extern unsigned int ioread32(void __iomem *);
 -extern unsigned int ioread32be(void __iomem *);
 +extern unsigned int ioread8(const void __iomem *addr);
 +extern unsigned int ioread16(const void __iomem *addr);
 +extern unsigned int ioread16be(const void __iomem *addr);
 +extern unsigned int ioread32(const void __iomem *addr);
 +extern unsigned int ioread32be(const void __iomem *addr);
  #ifdef CONFIG_64BIT
 -extern u64 ioread64(void __iomem *);
 -extern u64 ioread64be(void __iomem *);
 +extern u64 ioread64(const void __iomem *addr);
 +extern u64 ioread64be(const void __iomem *addr);
  #endif
 =20
+ #ifdef readq
+ #define ioread64_lo_hi ioread64_lo_hi
+ #define ioread64_hi_lo ioread64_hi_lo
+ #define ioread64be_lo_hi ioread64be_lo_hi
+ #define ioread64be_hi_lo ioread64be_hi_lo
+ extern u64 ioread64_lo_hi(void __iomem *addr);
+ extern u64 ioread64_hi_lo(void __iomem *addr);
+ extern u64 ioread64be_lo_hi(void __iomem *addr);
+ extern u64 ioread64be_hi_lo(void __iomem *addr);
+ #endif
+=20
 -extern void iowrite8(u8, void __iomem *);
 -extern void iowrite16(u16, void __iomem *);
 -extern void iowrite16be(u16, void __iomem *);
 -extern void iowrite32(u32, void __iomem *);
 -extern void iowrite32be(u32, void __iomem *);
 +extern void iowrite8(u8 value, void __iomem *addr);
 +extern void iowrite16(u16 value, void __iomem *addr);
 +extern void iowrite16be(u16 value, void __iomem *addr);
 +extern void iowrite32(u32 value, void __iomem *addr);
 +extern void iowrite32be(u32 value, void __iomem *addr);
  #ifdef CONFIG_64BIT
 -extern void iowrite64(u64, void __iomem *);
 -extern void iowrite64be(u64, void __iomem *);
 +extern void iowrite64(u64 value, void __iomem *addr);
 +extern void iowrite64be(u64 value, void __iomem *addr);
  #endif
 =20
+ #ifdef writeq
+ #define iowrite64_lo_hi iowrite64_lo_hi
+ #define iowrite64_hi_lo iowrite64_hi_lo
+ #define iowrite64be_lo_hi iowrite64be_lo_hi
+ #define iowrite64be_hi_lo iowrite64be_hi_lo
+ extern void iowrite64_lo_hi(u64 val, void __iomem *addr);
+ extern void iowrite64_hi_lo(u64 val, void __iomem *addr);
+ extern void iowrite64be_lo_hi(u64 val, void __iomem *addr);
+ extern void iowrite64be_hi_lo(u64 val, void __iomem *addr);
+ #endif
+=20
  /*
   * "string" versions of the above. Note that they
   * use native byte ordering for the accesses (on

--Sig_/4l9P=MH3XyGHQkandahlrn4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxrhz4ACgkQAVBC80lX
0GzV0wgAleV5S1teEikmp+kklJu+X1jnLVcRgXSid8HRh+PK/zETCL8op3MX8Ahp
rIG0Aoqub7IdWOKz+NZ4l63YwnQ5VdgB52dUP0t61EKqshZpsModGeSnxxLao8t/
MyXQZeACXmRbU3HdVdHE3d4wE6N4B2iOMIARjLzhA/KX1ti/zTTQVY+hI3qu687h
iPbJf9pY6PN1aphAxS0xubzZLro/hOniPg3+1/0Muvi+HOCyIrxbIT8q/7kvVHJX
Nuoy8cjf799N/VvTGNCIvvXnVk4U6F/EdbedBDzXY4YObZaNP9T9kyyRYpcrBNAM
18vvhOIENZXx1ldiMhgPSdTHdVAhyw==
=gztb
-----END PGP SIGNATURE-----

--Sig_/4l9P=MH3XyGHQkandahlrn4--
