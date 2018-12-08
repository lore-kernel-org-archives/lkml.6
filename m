Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9054AC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B42C2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B42C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeLHPFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:05:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57759 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbeLHPFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:05:40 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5BC20207F0; Sat,  8 Dec 2018 16:05:37 +0100 (CET)
Received: from qschulz (lfbn-1-2071-46.w90-76.abo.wanadoo.fr [90.76.137.46])
        by mail.bootlin.com (Postfix) with ESMTPSA id F006E20510;
        Sat,  8 Dec 2018 16:05:26 +0100 (CET)
Date:   Sat, 8 Dec 2018 16:05:26 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181208150526.uceviwfwqskfwovm@qschulz>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
 <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
 <20181207192237.GK26661@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="umq566xyw5pxyboh"
Content-Disposition: inline
In-Reply-To: <20181207192237.GK26661@dell>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--umq566xyw5pxyboh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Fri, Dec 07, 2018 at 07:22:37PM +0000, Lee Jones wrote:
> On Fri, 07 Dec 2018, Vasily Khoruzhick wrote:
>=20
> > On Fri, Dec 7, 2018 at 8:40 AM Lee Jones <lee.jones@linaro.org> wrote:
> >=20
> > > My OCD-dar is going crazy.
> > >
> > > Why haven't you used the same alignment as is already there?
> > >
> > > If it starts to run over 80-chars then bring the others back.
> > >
> > > Also why is there a single liner shoved in the middle of the
> > > multi-line entries?  Please move the singles to the top or the
> > > bottom.
> >=20
> > Hi Lee,
> >=20
> > Could you please reformat it in the way that makes your OCD-dar happy?
> > It would be really nice to get
>=20
> I'm afraid not, for a multitude of reasons.
>=20
> The most important of which surround testing.
>=20
> > AC and battery support for APX8x3 merged -- it'll make Pinebook and
> > Teres-I pretty well supported by mainline kernel.
>=20
> That's great.  A worthy cause indeed.  So I'm sure you guys will want
> to turn the patch around in short order so that it's applied in time
> for the next merge window.
>=20

Aren't the MFD cells probed in order?

In that case, it makes little sense to short order them for this
particular device (X-Powers PMICs in general). It will just make the
system boot slower because of probe deferring.

Why? As explained by Chen-Yu in v3[1], axp-gpios can be muxed as
regulators, thus should be probed before axp-regulators. axp-adc is
often used by axp-battery, axp-usb-power, axp-ac-power, thus should be
probed beforehand as well.

For the alignment that also triggered your OCD, I can send you a patch
the day you merge this one if it can help. I sent a few patches for this
driver that didn't respect the alignment so I'm fine fixing the mfd
cells (and eventually re-order them as I saw a few axp-gpio cells being
declared after axp-regulators).

Does that make this patch OK for you, Lee?

Thanks,
Quentin

[1] https://lkml.org/lkml/2018/10/11/338

--umq566xyw5pxyboh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlwL3bYACgkQhLiadT7g
8aMzDQ//SP/WNuKOA5RABdv9owyD0gfaSWiEML1W6ovmeEBPfxP6euZcHgnRsgEw
errjVUNOrlUy1Dn7cDLMhhCYlZuXBjfqlakVRAZpzhI1n0C4jHcERSB5e7Qck9uf
UwUSmi5rRZF0s2Tk034O/ycv/BkbRbXwPKN9K5j9zsyGYXBjWlw7Vr695E4O9pSc
69dTwRq1eYUFXlOk6Z8jBwAbMfPq38MgT7TbOq6OhxfW7efsPF4GinGyFfmhYmd/
C8uJtc+NxXn3XOySpObEAIbl5XL+ugpwT/zVhGz+IdNBX+aJNLWrzpyfK/9U9DEd
TQye0ezWR8n4navDsuYfYMaPXToXRZRWc/m1yvM+mSkDOAiXBhNZ1+oUPRTiKtnS
fxx+THTvpUwmNACctbUNRoU5u4QHfyL5A4I3uuiPyU9x3c9WYnB/ycHBxgMVx/0A
QrH7czW0VeqI598UV7hfNmDwV74ZxcJvCdROQLr5i9KWqknjTYAizvJdK/76MxSh
fAkA+SHO55y22ivHeJsCha6cIOtbbOVzVjFLeDRm+1MiHNFkacNHglNtC030hE1Z
LYjKE2hdG8zlL1Ak78Fpam9mZrOtHpwbS+AJpNsdZFA455iqZQfsLI6CY7o/N6E5
t739gtE19+hwYyaK2cNG9F4eZkVrtnOyNkOMxX1yIUkeMoRHUAE=
=BKmW
-----END PGP SIGNATURE-----

--umq566xyw5pxyboh--
