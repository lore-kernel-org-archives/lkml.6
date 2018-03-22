Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeCVUsJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:48:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36711 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeCVUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:48:07 -0400
Date: Thu, 22 Mar 2018 21:48:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5,5/5] ARM: dts: omap4-droid4: add soundcard
Message-ID: <20180322204804.GA26871@amd>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add sound support to Motorola Droid 4 using simple-soundcard
> and CPCAP's audio codec. This does not yet correctly represent
> the whole audio routing, since McBSP3 is also connected to
> Bluetooth and MDM6600 modem (and probably also 4G modem).
> These extra DAI links are not yet supported and have not been
> tested.

I applied the series on top v4.16-rc5, but I can't seem to get it
to work:

root@devuan:/sys/devices/platform/usb-phy@1# cat /proc/asound/cards
 0 [H58006000encode]: HDMI_58006000_e - HDMI 58006000.encoder
                       HDMI 58006000.encoder
root@devuan:/sys/devices/platform/usb-phy@1#
[   10.819122] ALSA device list:
[   10.832641]   #0: HDMI 58006000.encoder
[   10.842407] Waiting 10 sec before mounting root device...

I think I should have the required options enabled...=20

CONFIG_SND_OMAP_SOC=3Dy
CONFIG_SND_OMAP_SOC_DMIC=3Dy
CONFIG_SND_OMAP_SOC_MCBSP=3Dy
CONFIG_SND_OMAP_SOC_MCPDM=3Dy
CONFIG_SND_OMAP_SOC_HDMI_AUDIO=3Dy
# CONFIG_SND_OMAP_SOC_RX51 is not set
# CONFIG_SND_OMAP_SOC_N9 is not set
CONFIG_SND_OMAP_SOC_OMAP_TWL4030=3Dy
CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=3Dy
# CONFIG_SND_SOC_IMG is not set

#
# STMicroelectronics STM32 SOC audio support
#
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=3Dy
CONFIG_SND_SOC_CPCAP=3Dy

Any ideas?

Thanks,
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq0FoQACgkQMOfwapXb+vLRDQCfdMCTN0Ps3wd+sy9Si7gxD71x
r7YAoLAOf9meT+w8TFBgSlMMz5EuLHDg
=X8kF
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
