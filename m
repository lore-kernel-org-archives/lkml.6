Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CE6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD3D217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="o5cvIZot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfBSGg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:36:59 -0500
Received: from ozlabs.org ([203.11.71.1]:38669 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfBSGg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:36:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443WHD1CT0z9sD4;
        Tue, 19 Feb 2019 17:36:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550558216;
        bh=sxFICXCGXsRnO9gq/AzHhqK8kUOhP9bPLvmixGd9Uy0=;
        h=Date:From:To:Cc:Subject:From;
        b=o5cvIZotTB8IB9F5bprU7Mb+ByByxDJ9uC4sOILDwxQp54gsvJMvzqlxux2wwHXlM
         3TZQVaAurKLgxuLguNiR1iPTa//xflANf2seFxz+DoJGsaIopY7jNmrVXJHNW6R8Sg
         rwDbO9CJ8T+BNsPL5i/YAkYcsgJtb10L4CXfM3UfOWEhJAi7ggfQ4vj5l1MMY0ZXta
         cYM+Ch8aHh0qKpU9H5R9EzmzlwoTeIXqvPDB6c2eU3qmFD60xDsZO4rCsOVF20XupO
         wYC5DgD4ZXgLrx8rzP/Tx+K2IOCaGRqt5hfFDBEb0CRaHrZX1ObbOq/SLymQIgeuxF
         RKJ9oORbNdAOA==
Date:   Tue, 19 Feb 2019 17:36:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hugo Lefeuvre <hle@owl.eu.com>
Subject: linux-next: build failure after merge of the asm-generic tree
Message-ID: <20190219173654.47e9bc36@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/erXL9gtqk3srxR_XUm_zKYo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/erXL9gtqk3srxR_XUm_zKYo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

After merging the asm-generic tree, today's linux-next build (powerpc
allnoconfig) failed like this:

arch/powerpc/kernel/iomap.c:18:14: error: conflicting types for 'ioread8'
 unsigned int ioread8(void __iomem *addr)
              ^~~~~~~
In file included from arch/powerpc/include/asm/io.h:653,
                 from include/linux/io.h:25,
                 from include/linux/irq.h:20,
                 from arch/powerpc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:9,
                 from include/linux/interrupt.h:11,
                 from include/linux/pci.h:32,
                 from arch/powerpc/kernel/iomap.c:7:
include/asm-generic/iomap.h:29:21: note: previous declaration of 'ioread8' =
was here
 extern unsigned int ioread8(const void __iomem *addr);
                     ^~~~~~~
arch/powerpc/kernel/iomap.c:22:14: error: conflicting types for 'ioread16'
 unsigned int ioread16(void __iomem *addr)
              ^~~~~~~~
In file included from arch/powerpc/include/asm/io.h:653,
                 from include/linux/io.h:25,
                 from include/linux/irq.h:20,
                 from arch/powerpc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:9,
                 from include/linux/interrupt.h:11,
                 from include/linux/pci.h:32,
                 from arch/powerpc/kernel/iomap.c:7:
include/asm-generic/iomap.h:30:21: note: previous declaration of 'ioread16'=
 was here
 extern unsigned int ioread16(const void __iomem *addr);
                     ^~~~~~~~
arch/powerpc/kernel/iomap.c:26:14: error: conflicting types for 'ioread16be'
 unsigned int ioread16be(void __iomem *addr)
              ^~~~~~~~~~
In file included from arch/powerpc/include/asm/io.h:653,
                 from include/linux/io.h:25,
                 from include/linux/irq.h:20,
                 from arch/powerpc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:9,
                 from include/linux/interrupt.h:11,
                 from include/linux/pci.h:32,
                 from arch/powerpc/kernel/iomap.c:7:
include/asm-generic/iomap.h:31:21: note: previous declaration of 'ioread16b=
e' was here
 extern unsigned int ioread16be(const void __iomem *addr);
                     ^~~~~~~~~~
arch/powerpc/kernel/iomap.c:30:14: error: conflicting types for 'ioread32'
 unsigned int ioread32(void __iomem *addr)
              ^~~~~~~~
In file included from arch/powerpc/include/asm/io.h:653,
                 from include/linux/io.h:25,
                 from include/linux/irq.h:20,
                 from arch/powerpc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:9,
                 from include/linux/interrupt.h:11,
                 from include/linux/pci.h:32,
                 from arch/powerpc/kernel/iomap.c:7:
include/asm-generic/iomap.h:32:21: note: previous declaration of 'ioread32'=
 was here
 extern unsigned int ioread32(const void __iomem *addr);
                     ^~~~~~~~
arch/powerpc/kernel/iomap.c:34:14: error: conflicting types for 'ioread32be'
 unsigned int ioread32be(void __iomem *addr)
              ^~~~~~~~~~
In file included from arch/powerpc/include/asm/io.h:653,
                 from include/linux/io.h:25,
                 from include/linux/irq.h:20,
                 from arch/powerpc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:9,
                 from include/linux/interrupt.h:11,
                 from include/linux/pci.h:32,
                 from arch/powerpc/kernel/iomap.c:7:
include/asm-generic/iomap.h:33:21: note: previous declaration of 'ioread32b=
e' was here
 extern unsigned int ioread32be(const void __iomem *addr);
                     ^~~~~~~~~~
arch/powerpc/kernel/iomap.c:142:6: error: conflicting types for 'ioread8_re=
p'
 void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
      ^~~~~~~~~~~
In file included from arch/powerpc/include/asm/io.h:653,
                 from include/linux/io.h:25,
                 from include/linux/irq.h:20,
                 from arch/powerpc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:9,
                 from include/linux/interrupt.h:11,
                 from include/linux/pci.h:32,
                 from arch/powerpc/kernel/iomap.c:7:
include/asm-generic/iomap.h:82:13: note: previous declaration of 'ioread8_r=
ep' was here
 extern void ioread8_rep(const void __iomem *port, void *buf, unsigned long=
 count);
             ^~~~~~~~~~~
arch/powerpc/kernel/iomap.c:146:6: error: conflicting types for 'ioread16_r=
ep'
 void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
      ^~~~~~~~~~~~
In file included from arch/powerpc/include/asm/io.h:653,
                 from include/linux/io.h:25,
                 from include/linux/irq.h:20,
                 from arch/powerpc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:9,
                 from include/linux/interrupt.h:11,
                 from include/linux/pci.h:32,
                 from arch/powerpc/kernel/iomap.c:7:
include/asm-generic/iomap.h:83:13: note: previous declaration of 'ioread16_=
rep' was here
 extern void ioread16_rep(const void __iomem *port, void *buf, unsigned lon=
g count);
             ^~~~~~~~~~~~
arch/powerpc/kernel/iomap.c:150:6: error: conflicting types for 'ioread32_r=
ep'
 void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
      ^~~~~~~~~~~~
In file included from arch/powerpc/include/asm/io.h:653,
                 from include/linux/io.h:25,
                 from include/linux/irq.h:20,
                 from arch/powerpc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:9,
                 from include/linux/interrupt.h:11,
                 from include/linux/pci.h:32,
                 from arch/powerpc/kernel/iomap.c:7:
include/asm-generic/iomap.h:84:13: note: previous declaration of 'ioread32_=
rep' was here
 extern void ioread32_rep(const void __iomem *port, void *buf, unsigned lon=
g count);
             ^~~~~~~~~~~~

Caused by commit

  8e074c243ed3 ("iomap: add missing const to ioread*/iowrite addr arg")

The const qualifiers are also missing in:

arch/parisc/lib/iomap.c
arch/sh/kernel/iomap.c

I have reverted that commit for today.

BTW, that commit only added the const to the ioread* functions ...
--=20
Cheers,
Stephen Rothwell

--Sig_/erXL9gtqk3srxR_XUm_zKYo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxrpAYACgkQAVBC80lX
0Gxx1wf+O0ZHOKq4GG22Nbh/5mbDKPOYSrn6Zu2VPdTzoZxZFR7F7BMdoYv9s4ir
KrVYUCIFs+2fRr9fV1iD4bQg1ka6kO5TEsE8s89Y+7sruYy8sdblcKKNc4ak14ge
BfP+2a6n8CHvWanozOAM82+nOJqfD4Itv/pMbyfwGvBymonLUlfJY5NCTDO2QOIw
Inq9zAZfBH16+56RRtXPwMLIOSGJcXksa/AcYRXZea7Zw/sD1ARILJb5GKX0+rI6
yFKJq2VFOcT4BrDHUGqlkCYRzR+Mf0M7TaRoV/ilyH45A9a0AUhD79JOUT9QmPSA
0ry4saWfXKNDvn9WR6pOr1MfdaG6Rw==
=NwSv
-----END PGP SIGNATURE-----

--Sig_/erXL9gtqk3srxR_XUm_zKYo--
