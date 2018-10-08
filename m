Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E04C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566372085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Zd0uf7np"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566372085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeJHK6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:58:18 -0400
Received: from ozlabs.org ([203.11.71.1]:59509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHK6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 06:58:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42T5tv2nNwz9s9J;
        Mon,  8 Oct 2018 14:48:39 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538970519;
        bh=MCmZSI+x8G3eZ625CvfAJRSjZ7mtqrv/80NWr+hppcs=;
        h=Date:From:To:Cc:Subject:From;
        b=Zd0uf7np3oFWDqc9P9QoBzO1PFsWyTEHVbcQEdzAemekFEOKG305feuiuhUb2ucX8
         6l0ZeRznqLX/jd/y2vqMI+iw2MqQEFMInTSfEdPdnoi2shd8OqocGA+6KmU7QBfCcC
         LCMbXwmeB0E/onHas1jDmer8uDVq1uT3n5HyF+0obQUH8mhZ0IwHKmpoZsvwLKbUAR
         zvLwwhXIIcvSatZK7QKozJatrvPYW/58OO3q/mBst6tHDFQQczB426eyeu1xR6y6ft
         MfbG/bCJvf9yru73zwYMVB3oGRy9tjSkBaYtM8EW4ZBkrY5GuvHNeEwbWfj8joTIpp
         lBAG80fpXY4OQ==
Date:   Mon, 8 Oct 2018 14:48:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the drivers-x86 tree with the tip tree
Message-ID: <20181008144838.60d8ad83@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/M7VLhcGUxPcnz2GqlmFUqhf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M7VLhcGUxPcnz2GqlmFUqhf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  drivers/platform/x86/intel_mid_powerbtn.c

between commit:

  f2c4db1bd807 ("x86/cpu: Sanitize FAM6_ATOM naming")

from the tip tree and commit:

  a8b60e484f3d ("platform/x86: intel_mid_powerbtn: Get rid of custom ICPU()=
 macro")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/platform/x86/intel_mid_powerbtn.c
index 5ad44204a9c3,a8c0fbb7f799..000000000000
--- a/drivers/platform/x86/intel_mid_powerbtn.c
+++ b/drivers/platform/x86/intel_mid_powerbtn.c
@@@ -121,12 -112,9 +112,9 @@@ static const struct mid_pb_ddata mrfld_
  	.setup	=3D mrfld_setup,
  };
 =20
- #define ICPU(model, ddata)	\
- 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (kernel_ulong_t)&ddata }
-=20
  static const struct x86_cpu_id mid_pb_cpu_ids[] =3D {
- 	ICPU(INTEL_FAM6_ATOM_SALTWELL_MID,		mfld_ddata),
- 	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID,	mrfld_ddata),
 -	INTEL_CPU_FAM6(ATOM_PENWELL,		mfld_ddata),
 -	INTEL_CPU_FAM6(ATOM_MERRIFIELD,		mrfld_ddata),
++	INTEL_CPU_FAM6(ATOM_SALTWELL_MID,	mfld_ddata),
++	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	mrfld_ddata),
  	{}
  };
 =20

--Sig_/M7VLhcGUxPcnz2GqlmFUqhf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu605YACgkQAVBC80lX
0Gy/ywf+JPsYvBPso7IaaUdSTrQmYtjcFcCJVpPZJKuqG9JLGQzOUhbGzDb9eoNi
RaXTmLFVfKZk/P6WoXMEpHTl3hegI7Yd2JXTrbjLR49nOly/fDuF5lsb9hQS0FYX
ZLTYd6Gjo4r6NvTsvui+dBib1cYrXzIyEIBSeqrbig0IMsBN/0BU6igPQtmJGwFc
9r17zCiU6qfUPhmckRQMp9NWretboihD4qIKVgU4sIaTOi3M10K4ueJbrcv2UZw6
Jc+yNGWHu5PhomlTeSox7n01DczYM5N6jZTAP4Ual8bTlv6SSp8zsZ5yuV1Pdmik
EnqUpWPvAGm8lJCqM9GaGB5du1c1nw==
=lCkY
-----END PGP SIGNATURE-----

--Sig_/M7VLhcGUxPcnz2GqlmFUqhf--
