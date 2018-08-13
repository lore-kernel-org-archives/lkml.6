Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840ECC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CCA217DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NtvzFySr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CCA217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeHMKdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:33:19 -0400
Received: from ozlabs.org ([203.11.71.1]:57131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbeHMKdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:33:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41pnxh5njcz9s0n;
        Mon, 13 Aug 2018 17:52:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534146730;
        bh=5lkbejGbl/CGb1/CT71mdkvD3LosGW/0I2l26ZJN9Ho=;
        h=Date:From:To:Cc:Subject:From;
        b=NtvzFySrjp0J/jgyNI3oQrYIOnCV1+pmF1ciRyc2VYszWuDkpkwyaph23y4w4gMLu
         7BQnI4asBzu7kgej7MucAsSwHchd4hG+5VN1XPpfoh9tU9yK0x8ieFWO34scP7z0CL
         lIufxDbQ2+hsiFJrAumwP8GkmI72tRCylDYPuFM1MnfTT0V9Nn5AALdfSCDuFOnewu
         jNma7hIKksK/SPliX888GmgjdbBtpvk2FiCpSjSE2W6qaDxVPwMNFU5bPaY9W8/CTQ
         mGwTCibDxDvOcagD+2whQQRFsS6kf6gj98b9BduLkLkUG6g1GUTpkV23Z26+a05a1n
         hfr0A+TMiUaXQ==
Date:   Mon, 13 Aug 2018 17:51:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coly Li <colyli@suse.de>
Subject: linux-next: manual merge of the akpm-current tree with the block
 tree
Message-ID: <20180813175159.36ac9d4b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3xpNZz+aZJ.spS6dSKHENiH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3xpNZz+aZJ.spS6dSKHENiH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got conflicts in:

  drivers/md/bcache/Kconfig
  drivers/md/bcache/util.h

between commits:

  bc81b47e828a ("bcache: prefer 'help' in Kconfig")
  fc2d5988b597 ("bcache: add identifier names to arguments of function defi=
nitions")

from the block tree and commit:

  fbb43f40e27b ("bcache: use routines from lib/crc64.c for CRC64 calculatio=
n")

from the akpm-current tree.

I fixed it up (see below, and the latter removed some fo the lines changed
by fc2d5988b597) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/md/bcache/Kconfig
index 817b9fba50db,af247298409a..000000000000
--- a/drivers/md/bcache/Kconfig
+++ b/drivers/md/bcache/Kconfig
@@@ -1,7 -1,8 +1,8 @@@
 =20
  config BCACHE
  	tristate "Block device as cache"
+ 	select CRC64
 -	---help---
 +	help
  	Allows a block device to be used as cache for other devices; uses
  	a btree for indexing and the layout is optimized for SSDs.
 =20
diff --cc drivers/md/bcache/util.h
index 4e0ed19e32d3,a1579e28049f..000000000000
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@@ -543,11 -543,26 +544,27 @@@ dup:								=09
  #define RB_PREV(ptr, member)						\
  	container_of_or_null(rb_prev(&(ptr)->member), typeof(*ptr), member)
 =20
+ static inline uint64_t bch_crc64(const void *p, size_t len)
+ {
+ 	uint64_t crc =3D 0xffffffffffffffffULL;
+=20
+ 	crc =3D crc64_be(crc, p, len);
+ 	return crc ^ 0xffffffffffffffffULL;
+ }
+=20
+ static inline uint64_t bch_crc64_update(uint64_t crc,
+ 					const void *p,
+ 					size_t len)
+ {
+ 	crc =3D crc64_be(crc, p, len);
+ 	return crc;
+ }
+=20
  /* Does linear interpolation between powers of two */
 -static inline unsigned fract_exp_two(unsigned x, unsigned fract_bits)
 +static inline unsigned int fract_exp_two(unsigned int x,
 +					 unsigned int fract_bits)
  {
 -	unsigned fract =3D x & ~(~0 << fract_bits);
 +	unsigned int fract =3D x & ~(~0 << fract_bits);
 =20
  	x >>=3D fract_bits;
  	x   =3D 1 << x;

--Sig_/3xpNZz+aZJ.spS6dSKHENiH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltxOJ8ACgkQAVBC80lX
0GzhLgf/YwenefNkdfPupRsyfFi1WWskIrr6txGnLQEVD0xJtox55DEvrVAMg/15
6q/7i4N6pQyUzOPPTXw2XZnIM9Df5s41AD7YxtFVJA+mjhD0dChMFTxjHvnunwmP
rTSu85uOianwSS2niES/UVGFyselHdxseZvMPKVi5efGU9Edv3fH1DFf8wVTla7H
UjpjG1FaDRkQjjPApZRwWOGwt2WjJDwGJGNFcJn2l0T8WtZs+8a7Md6l+y9ZRgTA
4FP0U5mGUaGEPHcdbv37/W0RzwiRKo1nW6qzPKpwWrCpfSjUIUYxqGAsOUf7LcT8
1Woo0S39vIT5WCLGgBVohtM6mr+/7g==
=kJRt
-----END PGP SIGNATURE-----

--Sig_/3xpNZz+aZJ.spS6dSKHENiH--
