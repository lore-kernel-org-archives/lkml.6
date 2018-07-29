Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970CBC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0126D20892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0126D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeG2UAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 16:00:02 -0400
Received: from bues.ch ([80.190.117.144]:42830 "EHLO bues.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbeG2UAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 16:00:02 -0400
Received: by bues.ch with esmtpsa (Exim 4.89)
        (envelope-from <m@bues.ch>)
        id 1fjqQr-0004rp-5g; Sun, 29 Jul 2018 20:28:41 +0200
Date:   Sun, 29 Jul 2018 20:27:18 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL RFC PATCH] Kconfigs - reduce use of "depends on
 EXPERT"
Message-ID: <20180729202718.2fbc4592@wiggum>
In-Reply-To: <350ebd4172e21efc02d972420b9dbb06e506a014.camel@perches.com>
References: <27780ceb2056b871d746803a2ac23464396f3026.camel@perches.com>
        <20180729134202.5ab56762@wiggum>
        <350ebd4172e21efc02d972420b9dbb06e506a014.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/WQ/rVo99v1PhX1U1frRX42m"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WQ/rVo99v1PhX1U1frRX42m
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 29 Jul 2018 11:16:37 -0700
Joe Perches <joe@perches.com> wrote:

> (removing a bunch of cc's)
>=20
> On Sun, 2018-07-29 at 13:42 +0200, Michael B=C3=BCsch wrote:
> > On Sat, 28 Jul 2018 15:13:00 -0700
> > Joe Perches <joe@perches.com> wrote:
> >  =20
> > >  config SSB_SILENT
> > > -	bool "No SSB kernel messages"
> > > -	depends on SSB && EXPERT
> > > +	bool "No SSB kernel messages" if EXPERT
> > > +	depends on SSB
> > >  	help
> > >  	  This option turns off all Sonics Silicon Backplane printks.
> > >  	  Note that you won't be able to identify problems, once =20
> >=20
> >=20
> > What about removing this option entirely?
> > We would just have to remove it from Kconfig and from its only use in
> > drivers/ssb/ssb_private.h
> > I don't think anybody uses (or should use) this option anyway.
> > That would reduce the EXPERT dependencies by one, which is a good
> > thing. :) =20
>=20
> I'm fine with that, but it was originally your code from
> the first ssb commit in 2007:
>=20
> 	This might only be desired for production kernels on
> 	embedded devices to reduce the kernel size.
>=20
> Presumably for ddwrt and such.

Yeah, but it doesn't make sense to do this in ssb only.
And it only saves a couple of k at best.

> Removal could simplify the ssb_<foo> printk logic a bit too.
>=20
> Perhaps something like the below,
> but your code, your decisions...:


This is great!
Thanks.

Reviewed-by: Michael Buesch <m@bues.ch>


--=20
Michael

--Sig_/WQ/rVo99v1PhX1U1frRX42m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAlteBwcACgkQ9TK+HZCN
iw6pLg/+NPUBBRpFH/Uq4dZt6iPBPvvmXntY5Gs+/r8mUv/eeEAnZizJF5r6X5mO
a61uXw4XQJ1GXvb8iIxG2zAcMp0RuJ22xRsuERtN0JJuLxy8dFC5kxXW9xv6Q85l
2M/11ksfzPIBL/Md5HEb9F+cQZRNw62lDKcvElOWFICYze7tbSB315KevxSIohh5
q5qVGChn42gXSFkIc30poc0cu3ImG3IlPDghxXeF70TyBqj7jlFSQRJXNWixvH83
CMTqiBA6eUwIBcgGnZK4GL5Bvsd60nRjATD9dlYLIw17gdGFyQugSy3UZe1eZCMx
zxHB/dWUIw78sszT9aiZU6uJuZzgIyRMtP7EeCnnGj25cggXghXflpZfwh+m941o
jG05GOxVSyi7oovqjfviGm/Or+eW1IzCslfI1Wc2b88WBIJ2srCeV2HkwYb1Gvpm
S7MPZJTHBGCS1lbLA+45WsgOh/qbFE+NNV6QAwvZ5JesA7ofX5p0e6pCX8G74B31
Juwmt6TNyF2rxw3pbtak9iqAS7Ej4uVs9m0uEwyewVL+C/r7QgEW/IJwfv2/Ffg9
D+1aPOHKN31wRFzMWHjy9QaH2lgqSSJh67kOFmxZlVzOagTYSmk+QoW9q3oVxMgq
EHxQ7iAlDwc3x3aRFLHJr/Q7RqmemR2Gqb3ewDx5j/BJ9AyVbf4=
=5G4x
-----END PGP SIGNATURE-----

--Sig_/WQ/rVo99v1PhX1U1frRX42m--
