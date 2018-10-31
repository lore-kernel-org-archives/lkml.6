Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B703FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8852120664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8852120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbeJaVoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:44:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52834 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbeJaVoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:44:04 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C68628083C; Wed, 31 Oct 2018 13:46:07 +0100 (CET)
Date:   Wed, 31 Oct 2018 13:46:09 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     James Cameron <quozl@laptop.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
Message-ID: <20181031124609.GA18100@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181015195612.GB29649@amd>
 <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
 <20181030100139.GB21529@amd>
 <20181030102610.GC21529@amd>
 <2761d7e31cf7118492e466a5249303c92f68049b.camel@v3.sk>
 <20181031033746.GF8698@us.netrek.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20181031033746.GF8698@us.netrek.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > https://github.com/hackerspace/olpc-xo175-buildroot/releases
> >=20
> > Here's a SD card image that works for me. The topmost commit in the
> > same repository is the build configuration that was used to generate
> > it:
> >=20
> > https://github.com/hackerspace/olpc-xo175-buildroot/commit/71783d599.pa=
tch
> >=20
> > Note it is only going to boot off the SD card, because the root=3D
> > argument is hardwired in the devicetree. Sorry about that -- I built
> > the image before I noticed you're booting off an USB stick and I don't
> > have the resources to regenerate the image at the moment.
>=20
> Your image does boot for me - after changing features on
> filesystem.
>=20
> 	http://dev.laptop.org/~quozl/y/1gHh5m.txt (dmesg)
>=20
> dumpe2fs of your image filesystem features; has_journal ext_attr
> resize_inode dir_index filetype flex_bg sparse_super large_file
> huge_file dir_nlink extra_isize metadata_csum, and flags;
> signed_directory_hash.
>=20
> dumpe2fs of my image filesystem features; has_journal ext_attr
> resize_inode dir_index filetype extent flex_bg sparse_super uninit_bg
> dir_nlink extra_isize, and flags; unsigned_directory_hash.
>=20
> Our OLPC OS builder uses "mkfs.ext4 -O dir_index,^huge_file", from
> e2fsprogs 1.42.5.
>=20
> I'll look at the microSD card errors; by trying another one.

Success, too... after re-doing the filesystem with local mkfs.

One thing I noticed: olpc-battery/voltage_max_design is lower than
voltage normally reported by voltage_now.

I'll play with it some more

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvZpBEACgkQMOfwapXb+vLY3gCguJBhkyJe+LYcAwtJ8cG8aki1
fukAnR4nEpnSiT8zFDKrrGvH04c9SfzX
=8caI
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
