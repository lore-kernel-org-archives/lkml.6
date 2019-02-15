Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECF3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1014B206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PZ2iUB8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbfBOCUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:20:25 -0500
Received: from ozlabs.org ([203.11.71.1]:49491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732722AbfBOCUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:20:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 440xmw3NKTz9s5c;
        Fri, 15 Feb 2019 13:20:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550197219;
        bh=cJ1StWJoYoxwNVVgd5wB4XJ2CTXeotSiQXqKEV6/I9M=;
        h=Date:From:To:Cc:Subject:From;
        b=PZ2iUB8Sjhstog8ujLPizGCLDDDF1Hpl4yraRDABSBth5TUyufPcnMK1/LGZqICRv
         JC0oB+Xgyd+sU5aVU4KNPVzp4eLJ2N3pMGK1aFHZGBUu2+Q2w7R1mlFPV02aEVmROt
         I72hgYJzofoeTd0PoAMu7TRYQ9m3O+G6Vvyn8pJ2w2xmVSdxlqq/sIok725DyEsv7Y
         0SeUXVdBE0OKi9dwbiqsMamoAslPWopQeucVH+l46mF4KCnDEvNh5W++9l4LKu9VeG
         XteoC8dzTDEg5WvUc56cPU9hxl5UsPhpkZ0Vd1KV3nhdX18KV0T8pnkzIaKS3aDNsk
         ZHcmiU8s9ZqJw==
Date:   Fri, 15 Feb 2019 13:20:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: linux-next: manual merge of the tip tree with the net-next tree
Message-ID: <20190215132010.4de0a147@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9FWfBac/dO6B=nET7GE3zPN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9FWfBac/dO6B=nET7GE3zPN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  include/uapi/linux/time.h

between commits:

  bcb3fc3247e5 ("arch: sparc: Override struct __kernel_old_timeval")
  ca5e9aba753e ("time: Add time_types.h")

from the net-next tree and commit:

  c70a772fda11 ("y2038: remove struct definition redirects")

from the tip tree.

I fixed it up (I used the net-next tree version of this file and applied
the following patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 15 Feb 2019 13:16:41 +1100
Subject: [PATCH] time: fix up for "y2038: remove struct definition redirect=
s"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/uapi/linux/time_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/uapi/linux/time_types.h b/include/uapi/linux/time_type=
s.h
index 459070c61d47..27bfc8fc6904 100644
--- a/include/uapi/linux/time_types.h
+++ b/include/uapi/linux/time_types.h
@@ -4,19 +4,15 @@
=20
 #include <linux/types.h>
=20
-#ifndef __kernel_timespec
 struct __kernel_timespec {
 	__kernel_time64_t       tv_sec;                 /* seconds */
 	long long               tv_nsec;                /* nanoseconds */
 };
-#endif
=20
-#ifndef __kernel_itimerspec
 struct __kernel_itimerspec {
 	struct __kernel_timespec it_interval;    /* timer period */
 	struct __kernel_timespec it_value;       /* timer expiration */
 };
-#endif
=20
 /*
  * legacy timeval structure, only embedded in structures that
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/9FWfBac/dO6B=nET7GE3zPN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxmIdoACgkQAVBC80lX
0GwjRgf/dAIpzTvcmRj5TSKxqsYb4hZrVGnPeFSXLsolv4QMrF1yxPEFMQToVjSy
E10VDWFqmu3K901yrM0g+Rqu8TT9zvuTCrf/96bUhDNBZfDvYG92MEZtPoVeMACK
mddlPRuRymhLw/PBHwEZ5q3fcJdBNL/kV4qE0xyz5Wh8r3uA8v9DYw5xnbRKqyD0
NUYMrVkoGJgCAY4h4tICC+DQ2+h47ATbkno4qWTnMvNU73e019tcOaOFqGFsGjyh
MOG9B7lGbchUoIfd8on4J6GiTnaq3bVATdbUhWwUTy1fesQ8xuzVhKnSCT7JH/n6
hsAZAJG+R9MY7ARqTyjHh/pqPORzJw==
=Rzu9
-----END PGP SIGNATURE-----

--Sig_/9FWfBac/dO6B=nET7GE3zPN--
