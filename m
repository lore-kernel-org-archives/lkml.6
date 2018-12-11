Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4622EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B99020672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PRU25KpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B99020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbeLKGCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:02:48 -0500
Received: from ozlabs.org ([203.11.71.1]:40683 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbeLKGCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:02:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43DTr33MPVz9s4s;
        Tue, 11 Dec 2018 17:02:43 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544508164;
        bh=3qdwzQuAX/NJAV/44f2h+ZYbA0jg3ZzUOjG+2hJ4bjE=;
        h=Date:From:To:Cc:Subject:From;
        b=PRU25KpBRDBdmYww1APc5kwh5mlqvs6gC8209Djm8Ogh86+rBGKfd4FJ2vgEHnqB4
         ZeFX8xp602GKIw3W33CBZVWsZcFPIkcLW06VfJb+Ox6Ac7IK7Q9GXU+mqunFfAVDrB
         r2wCjnLiST0J3IbjEWTpHj1ewnj8//LD8gA5LXzErhT1GJG9+AbtMidZd4o73TAJRS
         jml9WUHtPJOQxh0b9Dr2Zisn/5n2ZiJm89h1EoVea0Nb9H1jfDWhkgVEatPiIobN9u
         pDVC5Zg5juVSWQSDTWngOVovJfr4r1fqCtEapuHZlXj6ji+uWLOHAVm9PX9v4mw1V6
         y91ITdrlMCDJw==
Date:   Tue, 11 Dec 2018 17:02:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Andrey Konovalov <andreyknvl@google.com>
Subject: linux-next: manual merge of the akpm-current tree with the arm64
 tree
Message-ID: <20181211170242.21fd4594@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D=xEj0+=rKQhB8Pr7lnnvVH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D=xEj0+=rKQhB8Pr7lnnvVH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/arm64/include/asm/memory.h

between commit:

  6e8830674ea7 ("arm64: kasan: Increase stack size for KASAN_EXTRA")

from the arm64 tree and commit:

  2a4689e7f69c ("kasan, arm64: adjust shadow size for tag-based mode")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/include/asm/memory.h
index f771452d08c4,1235fa492307..000000000000
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@@ -77,19 -65,13 +68,18 @@@
  #define KERNEL_END        _end
 =20
  /*
-  * KASAN requires 1/8th of the kernel virtual address space for the shadow
-  * region. KASAN can bloat the stack significantly, so double the (minimu=
m)
-  * stack size when KASAN is in use, and then double it again if KASAN_EXT=
RA is
-  * on.
+  * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel vir=
tual
+  * address space for the shadow region respectively. They can bloat the s=
tack
 - * significantly, so double the (minimum) stack size when they are in use.
++ * significantly, so double the (minimum) stack size when they are in use,
++ * and then double it again if KASAN_EXTRA is on.
   */
  #ifdef CONFIG_KASAN
- #define KASAN_SHADOW_SCALE_SHIFT 3
  #define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 +#ifdef CONFIG_KASAN_EXTRA
 +#define KASAN_THREAD_SHIFT	2
 +#else
  #define KASAN_THREAD_SHIFT	1
 +#endif /* CONFIG_KASAN_EXTRA */
  #else
  #define KASAN_SHADOW_SIZE	(0)
  #define KASAN_THREAD_SHIFT	0

--Sig_/D=xEj0+=rKQhB8Pr7lnnvVH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwPUwIACgkQAVBC80lX
0GxCNQf7BUr3FPrTJZVK1pi1yISZ1JBh0+TKDPhB9VzEVmvsWCHzqdO9u0vMpfOW
lAnEhuu2sT7qOL7QpAMzF6UghD++4l5G6laOeaOuw9m+BUB2agIb+HHMJiIix607
msj94mkO+MiNOvtPK5DXN8UhFTFjoWBqocC8s0BlgiobBVqkJA9uc1N3JF7UuTic
3SbkYYIGvXBJcyvXGJhNQLFO+J1xAGuS11u4Ti7dhSXoD3RoS21m3IFJKRoysQCj
ElqN+1M2dTLlBTgu+hVgGfaYRiBFri1Tx/g99DAahMrgR0/GHqPijXM4kOjsAMJa
9ARioobPDG9j+EvkLV8ur5WMDRMzPg==
=XrEz
-----END PGP SIGNATURE-----

--Sig_/D=xEj0+=rKQhB8Pr7lnnvVH--
