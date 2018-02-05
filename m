Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeBEIZJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:25:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54285 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeBEIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:24:48 -0500
Date: Mon, 5 Feb 2018 09:24:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com,
        bhumirks@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pali.rohar@gmail.com, sre@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Subject: [PATCHv3] tlv320dac33: Add device tree bindings
Message-ID: <20180205082445.GA18274@amd>
References: <20180129230539.GA18280@amd>
 <20180131190112.GA31608@amd>
 <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This adds device tree bindings for tlv320dac33.c.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Docu=
mentation/devicetree/bindings/sound/tlv320dac33.txt
new file mode 100644
index 0000000..aee0a87
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
@@ -0,0 +1,32 @@
+Texas Instruments - tlv320dac33 Codec module
+
+The tlv320dac33 serial control bus communicates through I2C protocols.
+
+Required properties:
+
+- compatible - "ti,tlv320dac33"
+- reg - I2C slave address
+- ti,burst-bclkdiv - BCLK divider value in burst mode. Valid range is 1..2=
55.
+
+Optional properties:
+
+- reset-gpios      - gpio pin to power the device, active high.
+
+- interrupts       - The interrupt output from the device.
+- interrupt-parent - The parent interrupt controller.
+
+- ti,keep-bclk     - Keep the BCLK running in FIFO modes.
+
+Example:
+
+tlv320dac33: audio-codec@19 {
+	compatible =3D "ti,tlv320dac33";
+	reg =3D <0x19>;
+
+	interrupt-parent =3D <&gpio2>;
+	interrupts =3D <21 1>; /* gpio_53, IRQF_TRIGGER_RISING */
+	reset-gpios =3D <&gpio2 28 0>; /* gpio_60 */
+
+	ti,keep-bclk;
+	ti,burst-bclkdiv =3D <3>;
+};

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp4FM0ACgkQMOfwapXb+vJT6ACfZrAjoIfkKc9TKF1tlIzEA8Sk
cKYAnAv9gqLDfOA72y09pHSPWQbczpjH
=w2H9
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
