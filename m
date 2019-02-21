Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A69320823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C48jI7pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBUWZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:25:16 -0500
Received: from ozlabs.org ([203.11.71.1]:51469 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfBUWZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:25:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4458DT4BCMz9s6w;
        Fri, 22 Feb 2019 09:25:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550787913;
        bh=eAXJr57ufS6P2ldxEApeayAtZo9CDAi9SD3WmE6B3V4=;
        h=Date:From:To:Cc:Subject:From;
        b=C48jI7peM0j7sj0JAWVlpboLaEv0JeQB8dLW5JGBIe0p+23BCaNBWaYeK3nibEaTI
         ZMhAt9mjdYqDFrJR73vZghvUIOz44NSFsHNlG7Xt0rF+1vfVLNraxVbgIoXsuFcjXU
         B+7e9FY6qa8doKR7eQGNaIfdihF2lFwAq2go6YwJdJA2SrUW2GcTQfAYgSMtJVkhG8
         CdomUd+Mq46QlbmQbD2nBVS636AiyxUFGHMdEQUvf1eMbqE1IzYr338hIDpaRnkAyp
         jFrZvumJLDlShIgGI0/oh5+x2C3Ftyp+wWiQeoVlzTeqed8EvhdgbjBJ9SMuzldmQy
         JhYrDokk9BYpA==
Date:   Fri, 22 Feb 2019 09:25:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the powerpc tree with the dma-mapping
 tree
Message-ID: <20190222092513.6fc2a708@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zNp4Tra4Z_ikkK3FNtEyRzz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zNp4Tra4Z_ikkK3FNtEyRzz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  kernel/dma/Kconfig

between commits:

  ff4c25f26a71 ("dma-mapping: improve selection of dma_declare_coherent ava=
ilability")

from the dma-mapping tree and commit:

  11ddce15451e ("dma-mapping, powerpc: simplify the arch dma_set_mask overr=
ide")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/dma/Kconfig
index 212aac7c675f,0711d18645de..000000000000
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@@ -16,13 -16,10 +16,16 @@@ config ARCH_DMA_ADDR_T_64BI
  config ARCH_HAS_DMA_COHERENCE_H
  	bool
 =20
+ config ARCH_HAS_DMA_SET_MASK
+ 	bool
+=20
 -config HAVE_GENERIC_DMA_COHERENT
 +config DMA_DECLARE_COHERENT
 +	bool
 +
 +config ARCH_HAS_SETUP_DMA_OPS
 +	bool
 +
 +config ARCH_HAS_TEARDOWN_DMA_OPS
  	bool
 =20
  config ARCH_HAS_SYNC_DMA_FOR_DEVICE

--Sig_/zNp4Tra4Z_ikkK3FNtEyRzz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxvJUkACgkQAVBC80lX
0GxiSwf/QpkrhZ2Ci6hLUg8KmKSjZGbd/tA2zE9R7AFWwQhExWsOJ0iHhdHxF2lG
KzY5YGEURbnEca9Q3pIUg4IUn14Fk97/ZK2S/EClyMku95wszM2eZL3gZOFBM5ZZ
ByaXE3Z+AUrJhov73SDJrC6Am9akrCR4WERVle66mNZ4GsoGVqOvRmS8R/yxZgC9
1pVkcru/IMaLW3uq2SlPwadUNcl4nv0rYZKGPUThraKz4zjWgpuEScbvCzvaIeLC
+IrLVQU+RIqOzWleqUaO0PrV5jevcsvsUl2AoxDEZWN/W/evx7P6+oDy2/J5sRCH
iyGDSsdCrp4K5fYtdmULWLi59xrBxg==
=bKYM
-----END PGP SIGNATURE-----

--Sig_/zNp4Tra4Z_ikkK3FNtEyRzz--
