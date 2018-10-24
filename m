Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA35C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673102081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673102081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJXRuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:50:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49493 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJXRuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:50:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 16837807ED; Wed, 24 Oct 2018 11:23:28 +0200 (CEST)
Date:   Wed, 24 Oct 2018 11:23:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, lee.jones@linaro.org, tony@atomide.com
Subject: Re: [PATCH v4 5/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3633
Message-ID: <20181024092328.GD24997@amd>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-5-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <20181023170623.31820-5-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-10-23 12:06:21, Dan Murphy wrote:
> The LM3633 is a single function LED driver. The single function LED
> driver needs to reside in the LED directory as a dedicated LED driver
> and not as a MFD device.  The device does have common brightness and ramp
> features and those can be accomodated by a TI LMU framework.
>=20
> The LM3633 dt binding needs to be moved from the ti-lmu.txt and a dedicat=
ed
> LED dt binding needs to be added.  The new LM3633 LED dt binding will then
> reside in the Documentation/devicetree/bindings/leds directory and follow=
 the
> current LED and general bindings guidelines.

What?

>  .../devicetree/bindings/leds/leds-lm3633.txt  | 102 ++++++++++++++++++
>  .../devicetree/bindings/mfd/ti-lmu.txt        |  48 ---------
>  2 files changed, 102 insertions(+), 48 deletions(-)
>  create mode 100644
>  Documentation/devicetree/bindings/leds/leds-lm3633.txt

> index 920f910be4e9..573e88578d3d 100644
> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> @@ -7,7 +7,6 @@ TI LMU driver supports lighting devices below.
>    LM3532       Backlight
>    LM3631       Backlight and regulator
>    LM3632       Backlight and regulator
> -  LM3633       Backlight, LED and fault monitor
>    LM3695       Backlight

Are you seriously proposing to take one binding and split it into 6
copy&pasted ones?

That's not the way we do development. NAK.

We don't want to have copy & pasted code. We also don't want to have
copy & pasted bindings. Nor changelogs, for that matter.

Thank you,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvQOhAACgkQMOfwapXb+vJo+ACgjcf+/VFQI8XyvZ7qw6P8d9IZ
DR0AoJLjzsQ8ywIndhcVH39N07UNYZFu
=Rmvw
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
