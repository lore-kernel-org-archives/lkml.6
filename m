Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39D0C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794952146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794952146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeINAeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:34:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36889 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727383AbeINAeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:34:31 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g0XDD-0005u2-Km; Thu, 13 Sep 2018 20:23:35 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g0XDD-0004rx-6s; Thu, 13 Sep 2018 20:23:35 +0100
Message-ID: <455ac03b7e23c8361b197a62a8f4dcbfde2d1452.camel@decadent.org.uk>
Subject: Re: 4.19-rc3: bindeb-pkg target is failing on ppc64
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Sep 2018 20:23:26 +0100
In-Reply-To: <CALjTZvZFT5Ku+e8CD6mQv5Pbo5TU9cWQfmEnxJ_atRrfaoM94g@mail.gmail.com>
References: <CALjTZvb4hOY_Hew-jEUtpyhkGbmh4Tgb0doPC6EaGtz_rMGt7A@mail.gmail.com>
         <eb1fe15c9ced6950d6a38c901278b8196ae4938d.camel@decadent.org.uk>
         <CALjTZvYcKOycB=XeF-Eqtmq3ADh2be+gfWGiw0jbSgEUo6q8Dw@mail.gmail.com>
         <0dbcdd4d81ed965915ccf2471dd4d5a3d025c93b.camel@decadent.org.uk>
         <CALjTZvZFT5Ku+e8CD6mQv5Pbo5TU9cWQfmEnxJ_atRrfaoM94g@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-DMIUeLyXeFMGsNn3e7S5"
User-Agent: Evolution 3.29.92-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DMIUeLyXeFMGsNn3e7S5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-09-13 at 19:32 +0100, Rui Salvaterra wrote:
> On Thu, 13 Sep 2018 at 16:49, Ben Hutchings <ben@decadent.org.uk> wrote:
> >=20
> > Like I said, please send the error messages; we're not going to guess.
> >=20
> > Ben.
> >=20
> > --
> > Ben Hutchings
> > Computers are not intelligent.  They only think they are.
>=20
> I'm an idiot. Turns out it's something completely unrelated. Here's
> the relevant part of the build failure:
>=20
> [snip]
>=20
> In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:23=
3,
>                  from arch/powerpc/boot/decompress.c:42:
> arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
> linux/crc32poly.h: No such file or directory
>  #include <linux/crc32poly.h>
>           ^~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[4]: *** [arch/powerpc/boot/Makefile:217:
> arch/powerpc/boot/decompress.o] Error 1
> make[3]: *** [arch/powerpc/Makefile:288: zImage] Error 2
>=20
> [snip]
>=20
> It's the xz kernel compression option which is failing, gzip builds
> fine (but it's still pointless, powerpc kernels seem to be always
> installed uncompressed). Broken .config attached, if relevant.
>=20
> Sorry for the misdirection.

Oh right, I totally forgot about that breakage.  This is fixed by <
https://patchwork.ozlabs.org/patch/963258/>.

Ben.

--=20
Ben Hutchings
Computers are not intelligent.	They only think they are.


--=-DMIUeLyXeFMGsNn3e7S5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAluauS4ACgkQ57/I7JWG
EQlnSA//edXE/okED4iMMMhvZ5fLBd5USlSZE5s9QXYTswfyIp4WyzD62F+78cAv
M9IlP4tlPmO4ZUlXf+oAFLpidU+Q39heF6egkdYJ1dAQqPdkm6T3tPshXeqPWQBS
Psvp1t4jLp16JoHeQFBRZAVvbZFCAVVZ5VbmMItQ+pozAZ4hZMM+d5Czn6CZcwML
opXcvbeo0y8NaCdLb7DBjbEMOy0B3NbhxBgxKoiRCeQKkLdHtRsnUkHVzrjiIV2k
vwYVDOxfoG6yXhQmaGASWPtWVgZU60foBmjBXEerpdo4HicjuOzN9EWNCwrKMPeI
m7z38yYJZDNd5NxMNi3ik1awnZROPmfWKOLL1XbGQztt+kALL1upwJrKNdOgh7+G
dFk0Vjq+6FuYEADuLO79SPHLu+KVSXynvpAYKIO2WVQvFoh9ufURRhXCz4xhlLol
nLuHaUrMrkY1Y8NsLkpC2W3fXwO1u3o+HbDD7++I+jdeezWRgxzuOHHpZ6sGEqBV
Y4LQt8FA3VFcGQiGj2va+n3tntunJL2bT+1smgFbthFUDJ5ht5M8DKoUkQZofUX6
E1uO4Bey85gpaAUgLXqm7TeBJ9pnFPdRzYbir+dx1v35Cm0M3LZHHFnSBZ/M370T
pYmsdJVNgn5hPYxbwAT4hLeqWLIexaPqGK7TcTtBy+QFfrquNoo=
=FaQL
-----END PGP SIGNATURE-----

--=-DMIUeLyXeFMGsNn3e7S5--
