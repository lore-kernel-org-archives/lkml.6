Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5835AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185D82089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185D82089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeJQAjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:39:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:55508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727159AbeJQAjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:39:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF41FACBA;
        Tue, 16 Oct 2018 16:48:28 +0000 (UTC)
Message-ID: <0611161a74bf9f91471bb13bf93cd1e8cc36c7d0.camel@suse.de>
Subject: Re: [PATCH 6/9] ASoC: dt-bindings: bcm2835-rpi: add onboard audio
 bindings
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>, gregkh@linuxfoundation.org
Cc:     eric@anholt.net, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, tiwai@suse.de
Date:   Tue, 16 Oct 2018 18:48:26 +0200
In-Reply-To: <4039d99c-5e57-c9d3-3af5-bc160e1adb57@i2se.com>
References: <20181016150228.16994-1-nsaenzjulienne@suse.de>
         <20181016150228.16994-7-nsaenzjulienne@suse.de>
         <4039d99c-5e57-c9d3-3af5-bc160e1adb57@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pzOGa/p4ojwCAlUileCs"
X-Mailer: Evolution 3.28.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pzOGa/p4ojwCAlUileCs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan, thanks for the review,

On Tue, 2018-10-16 at 17:56 +0200, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 16.10.2018 um 17:02 schrieb Nicolas Saenz Julienne:
> > Adds a device tree binding file for Raspberry pi's Headphones and
> > HDMI
> > audio output devices.
> >=20
> > Based on raspberry's downstream kernel implementation:
> >=20

https://github.com/raspberrypi/linux/blob/rpi-4.14.y/arch/arm/boot/dts/bcm2=
708-rpi.dtsi
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  .../bindings/sound/brcm,bcm2835-audio.txt         | 15
> > +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/sound/brcm,bcm2835-audio.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-
> > audio.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-
> > audio.txt
> > new file mode 100644
> > index 000000000000..ee6fa085aaa9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-
> > audio.txt
> > @@ -0,0 +1,15 @@
> > +Broadcom BCM283x audio device
> > +
> > +Required properties:
> > +
> > +- compatible: Should be "brcm,bcm2835-audio"
> > +- brcm,pwm-channels: number of PWM channels, they are behind RPi's
> > Video Core
> > +		     IV, not actual Linux PWM devices.
> > +
> > +Example:
> > +
> > +audio: audio {
> > +	compatible =3D "brcm,bcm2835-audio";
> > +	brcm,pwm-channels =3D <8>;
> > +};
> > +
>=20
> i apologize but it seems to me that the TODO mentioned in the cover
> letter isn't update to date anymore.
>=20
> Phil Elwell posted an important bugfix for vchiq before [1], but only
> the driver part has been applied yet. After applying the DT changes
> i'm
> not sure if it still works.
>=20
> AFAIK the audio driver uses VCHIQ as a software interface and the
> binding doesn't describe the real hardware.
>=20
> Since the camera driver will be registered as a platform device [2],
> i
> prefer this way for the audio driver, too.
>=20
> I'm actually working on this here [3] (currently only compile
> tested).
>=20

Fair enough. I wasn't feeling too good about the bindings myself. I
only went with them because I saw something similar was happening
between "raspberrypi,bcm2835-power" and "raspberrypi,bcm2835-firmware".=20
I'll be glad to review & test your patches whenever they are ready.

This makes commits 6 to 9 useless. Do you want me to send a v2? I can
throw in an extra change Takashi suggested and update the TODO file.

Regards,
Nicolas

--=-pzOGa/p4ojwCAlUileCs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlvGFloACgkQlfZmHno8
x/5qVQgAj9SdQqpYnOnEuYDmgSJAupqxLFXc3HZ4ULk1UQcLNbC41OZ3z22M37Np
NyeDRMs0xnSU/a7uF+Oec6Qj/T/12fc8EbBz3yDz2llBBWaLB4+bRk3UPZv8iWML
KJv4dLlXm5iT56VGaqgrZYn4J4Wyt0Y2KNgqIPfmMWiyuTq0BMP5jYmsyRUI+vIS
n4DQt0fizz3YJUpyLHsefocRp9Ab49riEsWVWEJaKKRFEcCzLarJPgISq7dXEMZG
LrCno7d4WZvJ+elyMC0kI0TFV6VPKcdyt/dBCwFPWhnb3vtx6+zu5Ur+Uqgpzhfh
gDrfzA+TIQ7OtA5pHB1bUcVeDvrt1A==
=BQDU
-----END PGP SIGNATURE-----

--=-pzOGa/p4ojwCAlUileCs--

