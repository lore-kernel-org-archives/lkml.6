Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9184ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 02:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63538208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 02:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HzJeyr4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63538208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbeGNDEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 23:04:55 -0400
Received: from ozlabs.org ([203.11.71.1]:39417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbeGNDEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 23:04:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41SDc13jkLz9s29;
        Sat, 14 Jul 2018 12:47:29 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531536452;
        bh=bfvhLVNmxCMflu9cNNv3CmZB2N9k8z24ofsnjfUz11s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HzJeyr4m/iNf4/l4rjf3/qW3LgIGTpZ+SLYkUppXnXTch6dv8jvXSyjUvbxoVGr3J
         s6yohZcGedHWPyf6YRgzcubFTxlCfgyKT8uFhVn9/lLGo/Rdwzm4Ckb86LD8fBf+/g
         BtRmX6/OIEgQtD/AghX5brADPiJs7OlS3rz0zRIc7uqFtdwR8xhlzvljUnRCwI4RyN
         D4J2AN59mVhqtHbQemLChIzafjuzO3in3IZdJl++3POEsDdEzY1D7oJTAtED9TIkbh
         HPZ+W0q9YWwrIcV6+34P3zcPArl1ThOW/rZsgACEoZKOEfHbbDlbX+MI53FgaSHfx1
         RbDcH8jSHTd+A==
Date:   Sat, 14 Jul 2018 12:47:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        mhocko@suse.cz, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: Re: mmotm 2018-07-13-16-51 uploaded (PSI)
Message-ID: <20180714124728.562ff3af@canb.auug.org.au>
In-Reply-To: <cf4f5b65-6333-a1f0-6118-16fc0e5bc221@infradead.org>
References: <20180713235138.HoxHd%akpm@linux-foundation.org>
        <cf4f5b65-6333-a1f0-6118-16fc0e5bc221@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cSnV=4v+WpvU7pDVBd56S1W"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cSnV=4v+WpvU7pDVBd56S1W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 13 Jul 2018 18:41:40 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> On 07/13/2018 04:51 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2018-07-13-16-51 has been uploaded to
> >=20
> >    http://www.ozlabs.org/~akpm/mmotm/
> >=20
> > mmotm-readme.txt says
> >=20
> > README for mm-of-the-moment:
> >=20
> > http://www.ozlabs.org/~akpm/mmotm/
> >=20
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >=20
> > You will need quilt to apply these patches to the latest Linus release =
(4.x
> > or 4.x-rcY).  The series file is in broken-out.tar.gz and is duplicated=
 in
> > http://ozlabs.org/~akpm/mmotm/series
> >=20
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is =
to
> > be applied. =20
>=20
>=20
> ../include/linux/psi.h:12:13: error: conflicting types for 'psi_disabled'
> extern bool psi_disabled;
>=20
>=20
> choose one:)
>=20
> kernel/sched/psi.c:
> bool psi_disabled __read_mostly;
>=20
>=20
> include/linux/sched/stat.h:
> 	extern int psi_disabled;

I have added this to linux-next (in case Andrew doesn't have time to
revise mmotm):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sat, 14 Jul 2018 12:35:19 +1000
Subject: [PATCH]  psi-pressure-stall-information-for-cpu-memory-and-io-fix-=
fix-fix

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/sched/stat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index ac39435d1521..bd477b819237 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -31,7 +31,7 @@ static inline int sched_info_on(void)
 	if (delayacct_on)
 		return 1;
 #elif defined(CONFIG_PSI)
-	extern int psi_disabled;
+	extern bool psi_disabled;
 	if (!psi_disabled)
 		return 1;
 #endif
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/cSnV=4v+WpvU7pDVBd56S1W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltJZEAACgkQAVBC80lX
0GwK3wf+Os6pRMdZfpbKSD5a2x0xR30Pin0lr8kdsqUFegBcfJyZXbVOZO7j6KKX
ft08/CzR1yk/rVQ3VI4s3mX0VgzzrzSBnkGf4NCSyrQjHsPR2ZebjVBxPIav8Rfl
HQ94nNJ3HwuQtZDkSJfMljpA7LTUHzKFYazZQ3X825JtDLsaSM2HF2KT8t69wCTI
UDHBs8GJ1ZSQe6ug11fL41i5rnU8FiH7fTaIiAHVixgZ+KSAqFVJeUiFYULgAW4+
FRdfV8NVNqznNb/xZJJTWD5jzp8Bu9C/uMXsrTZW3EVPhZesaHFhYh03wqNyWa+W
93+ps8XDP04xptRpvFh0CE2h8ZpQqQ==
=xWxi
-----END PGP SIGNATURE-----

--Sig_/cSnV=4v+WpvU7pDVBd56S1W--
