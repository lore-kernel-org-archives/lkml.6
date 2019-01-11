Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8571CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461B420872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfAKBVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:21:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:47010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfAKBVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:21:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A49E9ACC7;
        Fri, 11 Jan 2019 01:21:51 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     thirtythreeforty@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri, 11 Jan 2019 12:21:45 +1100
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v2 1/2] Move ralink-gdma to its own directory
In-Reply-To: <20190111004337.7223-1-thirtythreeforty@gmail.com>
References: <CACmrr9gHucWaWtz07kQms6AsquLKAHbK+_Q0kF=92RGo6HmAFA@mail.gmail.com> <20190111004337.7223-1-thirtythreeforty@gmail.com>
Message-ID: <874laggf9y.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10 2019, thirtythreeforty@gmail.com wrote:

> From: George Hilliard <thirtythreeforty@gmail.com>
>
> This is in preparation to allow it and the mt7621-dma drivers to be
> built separately.  They are completely independent pieces of software,
> and the Kconfig specifies very different requirements.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: devel@driverdev.osuosl.org
> Cc: Neil Brown <neil@brown.name>
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>

Hi,
 thanks for taking an interest in these drivers.
 I original submitted this code because I though I needed it for my
 mt7621 hardware, but I've subsequently realized that neither of these
 dma drivers are used in this hardware.
 Consequently I cannot test any changes you make.
 But maybe you can - which would be excellent!

 So this is just letting you and Greg know that despite my stated
 interest, I cannot actually review or test this.

Thanks,
NeilBrown


> ---
>  drivers/staging/Kconfig                                   | 2 ++
>  drivers/staging/Makefile                                  | 1 +
>  drivers/staging/mt7621-dma/Kconfig                        | 6 ------
>  drivers/staging/mt7621-dma/Makefile                       | 1 -
>  drivers/staging/ralink-gdma/Kconfig                       | 6 ++++++
>  drivers/staging/ralink-gdma/Makefile                      | 3 +++
>  drivers/staging/{mt7621-dma =3D> ralink-gdma}/ralink-gdma.c | 0
>  7 files changed, 12 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/staging/ralink-gdma/Kconfig
>  create mode 100644 drivers/staging/ralink-gdma/Makefile
>  rename drivers/staging/{mt7621-dma =3D> ralink-gdma}/ralink-gdma.c (100%)
>
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index e4f608815c05..b4cfde38e856 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -110,6 +110,8 @@ source "drivers/staging/mt7621-spi/Kconfig"
>=20=20
>  source "drivers/staging/mt7621-dma/Kconfig"
>=20=20
> +source "drivers/staging/ralink-gdma/Kconfig"
> +
>  source "drivers/staging/mt7621-mmc/Kconfig"
>=20=20
>  source "drivers/staging/mt7621-eth/Kconfig"
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index 5868631e8f1b..e095f427177c 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_SOC_MT7621)	+=3D mt7621-pci/
>  obj-$(CONFIG_SOC_MT7621)	+=3D mt7621-pinctrl/
>  obj-$(CONFIG_SOC_MT7621)	+=3D mt7621-spi/
>  obj-$(CONFIG_SOC_MT7621)	+=3D mt7621-dma/
> +obj-$(CONFIG_SOC_MT7621)	+=3D ralink-gdma/
>  obj-$(CONFIG_SOC_MT7621)	+=3D mt7621-mmc/
>  obj-$(CONFIG_SOC_MT7621)	+=3D mt7621-eth/
>  obj-$(CONFIG_SOC_MT7621)	+=3D mt7621-dts/
> diff --git a/drivers/staging/mt7621-dma/Kconfig b/drivers/staging/mt7621-=
dma/Kconfig
> index 2423c40099d1..b6e48a682c44 100644
> --- a/drivers/staging/mt7621-dma/Kconfig
> +++ b/drivers/staging/mt7621-dma/Kconfig
> @@ -1,9 +1,3 @@
> -config DMA_RALINK
> -	tristate "RALINK DMA support"
> -	depends on RALINK && !SOC_RT288X
> -	select DMA_ENGINE
> -	select DMA_VIRTUAL_CHANNELS
> -
>  config MTK_HSDMA
>  	tristate "MTK HSDMA support"
>  	depends on RALINK && SOC_MT7621
> diff --git a/drivers/staging/mt7621-dma/Makefile b/drivers/staging/mt7621=
-dma/Makefile
> index d3152d45cf45..c9e3e1619ab0 100644
> --- a/drivers/staging/mt7621-dma/Makefile
> +++ b/drivers/staging/mt7621-dma/Makefile
> @@ -1,4 +1,3 @@
> -obj-$(CONFIG_DMA_RALINK) +=3D ralink-gdma.o
>  obj-$(CONFIG_MTK_HSDMA) +=3D mtk-hsdma.o
>=20=20
>  ccflags-y +=3D -I$(srctree)/drivers/dma
> diff --git a/drivers/staging/ralink-gdma/Kconfig b/drivers/staging/ralink=
-gdma/Kconfig
> new file mode 100644
> index 000000000000..a12b2c672d48
> --- /dev/null
> +++ b/drivers/staging/ralink-gdma/Kconfig
> @@ -0,0 +1,6 @@
> +config DMA_RALINK
> +	tristate "RALINK DMA support"
> +	depends on RALINK && !SOC_RT288X
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +
> diff --git a/drivers/staging/ralink-gdma/Makefile b/drivers/staging/ralin=
k-gdma/Makefile
> new file mode 100644
> index 000000000000..5d917e0729bb
> --- /dev/null
> +++ b/drivers/staging/ralink-gdma/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_DMA_RALINK) +=3D ralink-gdma.o
> +
> +ccflags-y +=3D -I$(srctree)/drivers/dma
> diff --git a/drivers/staging/mt7621-dma/ralink-gdma.c b/drivers/staging/r=
alink-gdma/ralink-gdma.c
> similarity index 100%
> rename from drivers/staging/mt7621-dma/ralink-gdma.c
> rename to drivers/staging/ralink-gdma/ralink-gdma.c
> --=20
> 2.20.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlw376kACgkQOeye3VZi
gbnmiQ//eMYbf9WonxmqZa+ulnHF6Sx9FYGQHDgT0ru2uy1nAd1wT9d5/p4JwhdF
Uxpv4A/ZbZp7wJfX3FHOT7eAX5NpxjP6rcfSPnl80InBY81NOi/92AMTiHZhj21r
eqtfbPE6o1wQCAOaE7mFFhvbTamAWOzgVRq/aHO1djRY5FR6L/tRFTB4UwIZIkjB
vj0EFFGtYVqpKd/grvS0sf1JpgDW+n5/lIwbNCQXCOEelNjy2rgue7O8K3BrM4DY
zhY9bM4lvCp1JmeIHy2Ji0MMqJdsJepmcUujO4YCAxkd8syXyexHBDb5+xKEoTaL
wKlBC2B53B90m1SMnVFRi0tiP+Oaak9Iy/zesUQ4ErWsJcdqBaOoy/ek3FXC1KYh
YMtVCqo3VManf0h42/6qfuupVuX54kSXpfctt/bEUsUrVUk2Zkc/DTp/EdUE5rG2
cw49PABzD77C4weyWexgTQOvJRxrIvtSGGWRpnEmmK5CEKgII0MIZ8Dq3IVCQrUo
RMe3p0WjyEt4doUI5fEXA8SZCk8tCoTjIZ5f9CsICmXq7MSoPfw6PvgCCi0Ln5yB
T02Yj/NzeA9Yujw+zdDvxQzmiPUYnuR+GwKRK7OQbvdHLgyU8dO36gIlJh2XoTPB
UnWt7GcHSCXuX3iI1rxgKsdI0AbPgjppVW2quzhBRvwnqUiaEe8=
=qbnY
-----END PGP SIGNATURE-----
--=-=-=--
