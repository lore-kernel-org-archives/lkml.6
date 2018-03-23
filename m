Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeCWC3g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 22:29:36 -0400
Received: from ozlabs.org ([103.22.144.67]:44997 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbeCWC3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 22:29:35 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 23 Mar 2018 13:28:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: build warning after merge of the tip tree
Message-ID: <20180323132853.67195c47@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yJu7wesszgLs6Fc3Q.9qCaA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yJu7wesszgLs6Fc3Q.9qCaA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

lib/swiotlb.c:748:13: warning: 'swiotlb_free_buffer' defined but not used [=
-Wunused-function]
 static bool swiotlb_free_buffer(struct device *dev, size_t size,
             ^~~~~~~~~~~~~~~~~~~
lib/swiotlb.c:706:1: warning: 'swiotlb_alloc_buffer' defined but not used [=
-Wunused-function]
 swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_hand=
le,
 ^~~~~~~~~~~~~~~~~~~~

Introduced by commit

  16e73adbca76 ("dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()")

These are now only used with CONFIG_DMA_DIRECT_OPS.

--=20
Cheers,
Stephen Rothwell

--Sig_/yJu7wesszgLs6Fc3Q.9qCaA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq0ZmUACgkQAVBC80lX
0GwnvQf/VilaxNYGNsf03m40RUOIMk913zVktU4IKXlCurYx5qJm961j47f5Bx5q
nslyhGmi2tb1AEVRYRstz4aUyNk7D6Hc1YzB8wTNBSEXIyIxBvT9kBp6eVK+Qgpf
oLMZaXbsszT8cNc7/vKDia/LbteWm4B0qibJUtmWAhgNiXUaHj0XZAU16kld+F+V
fDfdV8C8qe8UQaY759iwTU4cIjhp64FWJW0lR3Qk8Q8Z+X+GDD9MfGwSIzjw7+S3
+xG9tkQJOvcj+8U9AKUjgMFNVDP8h7j4t8l5znIHtQVeXc6ZPTY8JQypqSGYEhZD
ZLHI3TJyXUJA+FhrdgRVGuFc2Jo3xQ==
=4zGW
-----END PGP SIGNATURE-----

--Sig_/yJu7wesszgLs6Fc3Q.9qCaA--
