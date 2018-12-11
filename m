Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFED2C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B96F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VenwsXVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B96F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeLKGLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:11:05 -0500
Received: from ozlabs.org ([203.11.71.1]:45831 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeLKGLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:11:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43DV1f4M9qz9s4s;
        Tue, 11 Dec 2018 17:11:02 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544508663;
        bh=HVGzfCIdHN1Drlr2gRagZ8FmLFlLkoQJ0tTCRPW0Ok4=;
        h=Date:From:To:Cc:Subject:From;
        b=VenwsXVxUCT73R1+83tZSdvkV7Rzsd2r6wb56E1tuJofh1c5qHmVMCWGLwQVMPuu4
         9evAsbg3NUfN15vIsDe6ncC22RLYsd7emq1M9qnvqoikeSgv23WvuAF8IWi53mrn5v
         KHMeethn/RhOCIgnMcWuuwBP91UaD8uE4pMivlULrvY+pHuCjxQB/edHW+gOP4gnIC
         OzA0z9MRY9gHjyMj+zgYTPuVnGZxSdfswfSfgNVFwQM0nb0lR42xdAtNfP53w/c+7l
         AabN0MeCJHXFzibcFrFLm9ARRDS0YRY7BAE9vly6DYgvLeyUjYGRRKDoI49pcn2/7E
         qSSwREKBJIenw==
Date:   Tue, 11 Dec 2018 17:11:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Steve Capper <steve.capper@arm.com>
Subject: linux-next: manual merge of the akpm-current tree with the FIXME
 tree
Message-ID: <20181211171102.14c0be9f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_6DsOEMbDGiGD8wJ4fTT/S3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_6DsOEMbDGiGD8wJ4fTT/S3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/arm64/mm/proc.S

between commits:

  67e7fdfcc682 ("arm64: mm: introduce 52-bit userspace support")
  68d23da4373a ("rm64: Kconfig: Re-jig CONFIG options for 52-bit VA")

from the FIXME tree and commit:

  089dc516f651 ("kasan, arm64: enable top byte ignore for the kernel")

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

diff --cc arch/arm64/mm/proc.S
index e05b3ce1db6b,d861f208eeb1..73886a5f1f30
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@@ -449,16 -451,8 +455,16 @@@ ENTRY(__cpu_setup
  	 */
  	ldr	x10, =3DTCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
  			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
- 			TCR_TBI0 | TCR_A1
+ 			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
 -	tcr_set_idmap_t0sz	x10, x9
 +
 +#ifdef CONFIG_ARM64_USER_VA_BITS_52
 +	ldr_l		x9, vabits_user
 +	sub		x9, xzr, x9
 +	add		x9, x9, #64
 +#else
 +	ldr_l		x9, idmap_t0sz
 +#endif
 +	tcr_set_t0sz	x10, x9
 =20
  	/*
  	 * Set the IPS bits in TCR_EL1.

--Sig_/_6DsOEMbDGiGD8wJ4fTT/S3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwPVPYACgkQAVBC80lX
0GzVtAf9Eaut33wucTUGl69ArkhPad21vdoNubcCXRS17OZazCsJ+IoWpU0ZJS+V
PrOeG/TelQa9OqJT8cGlEw85AYO8XfsaRKjQjDiISiOr9SizB6Wg26eOQKAGUC03
4BM/ZuOBYPTATUsDk5FcJmfC12QEBAnMTdiYyL1miRmSziKRbLx5FqF7EK3ALQoC
jJsNfPxU8ddhOLef5jD+E5LkYfzqZFrQMVoza3axyNAEPdNV9UrH8cVnyyDjRHlD
WSRyMAbwrcU3tS/H6PvMDRVBHNl1m2YMoNwD3qZWl3Utz9J5sJqwt0C8LFS34ZVl
pzPSxFt4otqJz/n3vywT300aT2RgNg==
=0/st
-----END PGP SIGNATURE-----

--Sig_/_6DsOEMbDGiGD8wJ4fTT/S3--
