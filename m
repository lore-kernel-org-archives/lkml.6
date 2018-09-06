Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B15C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36AD2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36AD2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeIGBxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:53:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59747 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIGBxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:53:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 126E6805A3; Thu,  6 Sep 2018 23:16:17 +0200 (CEST)
Date:   Thu, 6 Sep 2018 23:16:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: Add bindings for lm3697 driver
Message-ID: <20180906211617.GB16899@amd>
References: <20180906135005.6718-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20180906135005.6718-1-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add the device tree bindings for the lm3697
> LED driver for backlighting and display.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>=20
> v6 - Fix minor issues - https://lore.kernel.org/patchwork/patch/975387/
>=20
> v5 - Fix the comment for the example - https://lore.kernel.org/patchwork/=
patch/975060/
> v4 - Removed HVLED definition in favor of HVLED place definition - https:=
//lore.kernel.org/patchwork/patch/974812/
> v3 - Updated subject with prefered title - https://lore.kernel.org/patchw=
ork/patch/972337/
> v2 - Fixed subject and patch commit message - https://lore.kernel.org/pat=
chwork/patch/971326/
>=20
>  .../devicetree/bindings/leds/leds-lm3697.txt  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
>=20
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Doc=
umentation/devicetree/bindings/leds/leds-lm3697.txt
> new file mode 100644
> index 000000000000..3256dec21075
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> @@ -0,0 +1,86 @@
> +* Texas Instruments - LM3697 Highly Efficient White LED Driver
> +
> +The LM3697 11-bit LED driver provides high-
> +performance backlight dimming for 1, 2, or 3 series
> +LED strings while delivering up to 90% efficiency.

Hmm. We already have second set of bindings for 3697:

=2E/devicetree/bindings/mfd/ti-lmu.txt

(Sorry for not noticing that earlier). Advantage is that those have
had discussion with device tree people and have acks:

What to do there?

								Pavel
commit 287cce719d85311f61d1b6b7f7b0d93f7907cd46
Author: Milo Kim <milo.kim@ti.com>
Date:   Tue Feb 28 15:45:14 2017 +0900

    dt-bindings: mfd: Add TI LMU device binding information

    This patch describes overall binding for TI LMU MFD devices.

    Signed-off-by: Milo Kim <milo.kim@ti.com>
        Acked-by: Rob Herring <robh+dt@kernel.org>
	    Acked-by: Tony Lindgren <tony@atomide.com>
	        Signed-off-by: Lee Jones <lee.jones@linaro.org>
	=09

commit d774c7e447ac911e73a1b3c775e6d89f0422218c
Author: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Date:   Mon Aug 27 09:15:08 2018 -0700

    dt-bindings: mfd: ti-lmu: update for backlight
   =20
    Update binding to integrate the backlight feature directly into
    the main node, as suggested by Rob Herring.
   =20
    Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentati=
on/devicetree/bindings/mfd/ti-lmu.txt
index c885cf8..b3433e9 100644
--- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
@@ -28,10 +28,9 @@ Required properties:
=20
 Optional property:
   - enable-gpios: A GPIO specifier for hardware enable pin.
-
-Required node:
-  - backlight: All LMU devices have backlight child nodes.
-               For the properties, please refer to [1].
+  - pwm-names: Should be either "lmu-backlight" or unset
+  - pwm: This should be a PWM specifier following ../pwm/pwm.txt and must
+         only be specified, if the backlight should be used in PWM mode.
=20
 Optional nodes:
   - fault-monitor: Hardware fault monitoring driver for LM3633 and LM3697.
@@ -42,8 +41,31 @@ Optional nodes:
   - leds: LED properties for LM3633. Please refer to [2].
   - regulators: Regulator properties for LM3631 and LM3632.
                 Please refer to [3].
+  - bank0, bank1, bank2: This contains the backlight configuration
+                         for each backlight control bank.
+
+Required properties in the bank subnodes:
+  - label: A string describing the backlight. Should contain "keyboard"
+           for a keyboard backlight and "lcd" for LCD panel backlights.
+  - ti,led-sources: A list of channels, that should be driven. Each channel
+                    should only be driven by one bank.
+
+Optional properties in the bank subnodes:
+  - default-brightness-level: Backlight initial brightness value.
+                              Type is <u32>. It is set as soon as backlight
+			      device is created.
+			      0 ~ 2047 =3D LM3631, LM3632, LM3633, LM3695 and
+					 LM3697
+			      0 ~ 255  =3D LM3532
+  - ti,ramp-up-ms, ti,ramp-down-ms: Light dimming effect properties.
+				    Type is <u32>. Unit is millisecond.
+					0 ~ 65 ms    =3D LM3532
+					0 ~ 4000 ms  =3D LM3631
+					0 ~ 16000 ms =3D LM3633 and LM3697
+  - pwm-period: PWM period. Only valid in PWM brightness mode.
+                Type is <u32>. If this property is missing, then control
+		mode is set to I2C by default.
=20
-[1] ../leds/backlight/ti-lmu-backlight.txt
 [2] ../leds/leds-lm3633.txt
 [3] ../regulator/lm363x-regulator.txt
=20
@@ -53,14 +75,11 @@ lm3532@38 {
=20
 	enable-gpios =3D <&pioC 2 GPIO_ACTIVE_HIGH>;
=20
-	backlight {
-		compatible =3D "ti,lm3532-backlight";
-
-		lcd {
-			led-sources =3D <0 1 2>;
-			ramp-up-msec =3D <30>;
-			ramp-down-msec =3D <0>;
-		};
+	bank0 {
+		label =3D "lcd";
+		led-sources =3D <0 1 2>;
+		ramp-up-msec =3D <30>;
+		ramp-down-msec =3D <0>;
 	};
 };
=20
@@ -105,13 +124,10 @@ lm3631@29 {
 		};
 	};
=20
-	backlight {
-		compatible =3D "ti,lm3631-backlight";
-
-		lcd_bl {
-			led-sources =3D <0 1>;
-			ramp-up-msec =3D <300>;
-		};
+	bank0 {
+		label =3D "lcd_bl";
+		led-sources =3D <0 1>;
+		ramp-up-msec =3D <300>;
 	};
 };
=20
@@ -147,16 +163,13 @@ lm3632@11 {
 		};
 	};
=20
-	backlight {
-		compatible =3D "ti,lm3632-backlight";
-
-		pwms =3D <&pwm0 0 10000 0>; /* pwm number, period, polarity */
-		pwm-names =3D "lmu-backlight";
+	pwms =3D <&pwm0 0 10000 0>; /* pwm number, period, polarity */
+	pwm-names =3D "lmu-backlight";
=20
-		lcd {
-			led-sources =3D <0 1>;
-			pwm-period =3D <10000>;
-		};
+	bank0 {
+		label =3D "lcd";
+		led-sources =3D <0 1>;
+		pwm-period =3D <10000>;
 	};
 };
=20
@@ -166,22 +179,18 @@ lm3633@36 {
=20
 	enable-gpios =3D <&pioC 2 GPIO_ACTIVE_HIGH>;
=20
-	backlight {
-		compatible =3D "ti,lm3633-backlight";
-
-		main {
-			label =3D "main_lcd";
-			led-sources =3D <1 2>;
-			ramp-up-msec =3D <500>;
-			ramp-down-msec =3D <500>;
-		};
+	bank0 {
+		label =3D "main_lcd";
+		led-sources =3D <1 2>;
+		ramp-up-msec =3D <500>;
+		ramp-down-msec =3D <500>;
+	};
=20
-		front {
-			label =3D "front_lcd";
-			led-sources =3D <0>;
-			ramp-up-msec =3D <1000>;
-			ramp-down-msec =3D <0>;
-		};
+	bank1 {
+		label =3D "front_lcd";
+		led-sources =3D <0>;
+		ramp-up-msec =3D <1000>;
+		ramp-down-msec =3D <0>;
 	};
=20
 	leds {
@@ -211,13 +220,9 @@ lm3695@63 {
=20
 	enable-gpios =3D <&pioC 2 GPIO_ACTIVE_HIGH>;
=20
-	backlight {
-		compatible =3D "ti,lm3695-backlight";
-
-		lcd {
-			label =3D "bl";
-			led-sources =3D <0 1>;
-		};
+	bank0 {
+		label =3D "lcd_bl";
+		led-sources =3D <0 1>;
 	};
 };
=20
@@ -227,14 +232,10 @@ lm3697@36 {
=20
 	enable-gpios =3D <&pioC 2 GPIO_ACTIVE_HIGH>;
=20
-	backlight {
-		compatible =3D "ti,lm3697-backlight";
-
-		lcd {
-			led-sources =3D <0 1 2>;
-			ramp-up-msec =3D <200>;
-			ramp-down-msec =3D <200>;
-		};
+	bank0 {
+		led-sources =3D <0 1 2>;
+		ramp-up-msec =3D <200>;
+		ramp-down-msec =3D <200>;
 	};
=20
 	fault-monitor {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluRmSEACgkQMOfwapXb+vJvYQCcDGC+DkNW4KrswdxW+W8NkNyM
n18An3gqyPdKTPwSc/oMcDs/26fx2ZKv
=/9XA
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
