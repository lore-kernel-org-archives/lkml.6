Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A09AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B688C20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B688C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbeHAWP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:15:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37301 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeHAWP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:15:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 68FF8806C8; Wed,  1 Aug 2018 22:28:25 +0200 (CEST)
Date:   Wed, 1 Aug 2018 22:28:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org
Subject: [PATCH] fix vibrations on Droid 4
Message-ID: <20180801202821.GB4033@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd>
 <20180716075926.GU99251@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <20180716075926.GU99251@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Vibration GPIOs don't have anything to do with wakeup. Move it to
normal section; this fixes vibrations on Droid 4.
   =20
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/o=
map4-droid4-xt894.dts
index c27fc87..7b82179 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -646,15 +646,6 @@
 		OMAP4_IOPAD(0x10c, PIN_INPUT | MUX_MODE1)	/* abe_mcbsp3_fsx */
 		>;
 	};
-};
-
-&omap4_pmx_wkup {
-	usb_gpio_mux_sel2: pinmux_usb_gpio_mux_sel2_pins {
-		/* gpio_wk0 */
-		pinctrl-single,pins =3D <
-		OMAP4_IOPAD(0x040, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
-		>;
-	};
=20
 	vibrator_direction_pin: pinmux_vibrator_direction_pin {
 		pinctrl-single,pins =3D <
@@ -669,6 +660,15 @@
 	};
 };
=20
+&omap4_pmx_wkup {
+	usb_gpio_mux_sel2: pinmux_usb_gpio_mux_sel2_pins {
+		/* gpio_wk0 */
+		pinctrl-single,pins =3D <
+		OMAP4_IOPAD(0x040, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
+		>;
+	};
+};
+
 /*
  * As uart1 is wired to mdm6600 with rts and cts, we can use the cts pin f=
or
  * uart1 wakeirq.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltiF+UACgkQMOfwapXb+vLU9gCguQsW/CgcTyDmuOhR5plML8qf
dA0An3eBzR8gVfUN4Ll2rgdoK6aopym5
=m5zH
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
