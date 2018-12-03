Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F555C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2526720848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2526720848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeLCK4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:56:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58562 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbeLCK4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:56:45 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 886F920750; Mon,  3 Dec 2018 11:56:11 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 52F7120742;
        Mon,  3 Dec 2018 11:56:01 +0100 (CET)
Date:   Mon, 3 Dec 2018 11:56:01 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [RFC PATCH 04/10] dma-engine: sun4i: Add support for Allwinner
 suniv F1C100s
Message-ID: <20181203105601.mls67gdr4wu4sqvy@flea>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
 <df1e5fbb2b04b0e5d392ce988d04a39f1d8e5f8d.1543782328.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="immwmaskuc6nscn3"
Content-Disposition: inline
In-Reply-To: <df1e5fbb2b04b0e5d392ce988d04a39f1d8e5f8d.1543782328.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--immwmaskuc6nscn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 12:23:11AM +0300, Mesih Kilinc wrote:
> DMA of Allwinner suniv F1C100s is similar to sun4i. It has 4 NDMA, 4
> DDMA channels and endpoints are different. Also F1C100s has reset bit
> for DMA in CCU. Add support for it.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  drivers/dma/Kconfig     |  4 ++--
>  drivers/dma/sun4i-dma.c | 60 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 62 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index de511db..f8a65d2 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -163,8 +163,8 @@ config DMA_SA11X0
> =20
>  config DMA_SUN4I
>  	tristate "Allwinner A10 DMA SoCs support"
> -	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
> -	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I)
> +	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV
> +	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV)
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index d267ff9..c0452c9 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -36,7 +36,11 @@
>  #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode)	((mode) << 5)
>  #define SUN4I_DMA_CFG_SRC_DRQ_TYPE(type)	(type)
> =20
> +#define SUNIV_DMA_CFG_DST_DATA_WIDTH(width)	((width) << 24)
> +#define SUNIV_DMA_CFG_SRC_DATA_WIDTH(width)	((width) << 8)
> +
>  #define SUN4I_MAX_BURST	8
> +#define SUNIV_MAX_BURST	4
> =20
>  /** Normal DMA register values **/
> =20
> @@ -44,6 +48,9 @@
>  #define SUN4I_NDMA_DRQ_TYPE_SDRAM		0x16
>  #define SUN4I_NDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
> =20
> +#define SUNIV_NDMA_DRQ_TYPE_SDRAM		0x11
> +#define SUNIV_NDMA_DRQ_TYPE_LIMIT		(0x17 + 1)
> +
>  /** Normal DMA register layout **/
> =20
>  /* Dedicated DMA source/destination address mode values */
> @@ -57,6 +64,9 @@
>  #define SUN4I_NDMA_CFG_BYTE_COUNT_MODE_REMAIN	BIT(15)
>  #define SUN4I_NDMA_CFG_SRC_NON_SECURE		BIT(6)
> =20
> +#define SUNIV_NDMA_CFG_CONT_MODE		BIT(29)
> +#define SUNIV_NDMA_CFG_WAIT_STATE(n)		((n) << 26)
> +
>  /** Dedicated DMA register values **/
> =20
>  /* Dedicated DMA source/destination address mode values */
> @@ -69,6 +79,9 @@
>  #define SUN4I_DDMA_DRQ_TYPE_SDRAM		0x1
>  #define SUN4I_DDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
> =20
> +#define SUNIV_DDMA_DRQ_TYPE_SDRAM		0x1
> +#define SUNIV_DDMA_DRQ_TYPE_LIMIT		(0x9 + 1)
> +
>  /** Dedicated DMA register layout **/
> =20
>  /* Dedicated DMA configuration register layout */
> @@ -122,6 +135,11 @@
>  #define SUN4I_DMA_NR_MAX_VCHANS						\
>  	(SUN4I_NDMA_NR_MAX_VCHANS + SUN4I_DDMA_NR_MAX_VCHANS)
> =20
> +#define SUNIV_NDMA_NR_MAX_CHANNELS	4
> +#define SUNIV_DDMA_NR_MAX_CHANNELS	4
> +#define SUNIV_NDMA_NR_MAX_VCHANS	(24 * 2 - 1)
> +#define SUNIV_DDMA_NR_MAX_VCHANS	10
> +
>  /* This set of SUN4I_DDMA timing parameters were found experimentally wh=
ile
>   * working with the SPI driver and seem to make it behave correctly */
>  #define SUN4I_DDMA_MAGIC_SPI_PARAMETERS \
> @@ -236,6 +254,16 @@ static void set_src_data_width_a10(u32 *p_cfg, s8 da=
ta_width)
>  	*p_cfg |=3D SUN4I_DMA_CFG_SRC_DATA_WIDTH(data_width);
>  }
> =20
> +static void set_dst_data_width_f1c100s(u32 *p_cfg, s8 data_width)
> +{
> +	*p_cfg |=3D SUNIV_DMA_CFG_DST_DATA_WIDTH(data_width);
> +}
> +
> +static void set_src_data_width_f1c100s(u32 *p_cfg, s8 data_width)
> +{
> +	*p_cfg |=3D SUNIV_DMA_CFG_SRC_DATA_WIDTH(data_width);
> +}
> +
>  static int convert_burst_a10(u32 maxburst)
>  {
>  	if (maxburst > 8)
> @@ -245,6 +273,15 @@ static int convert_burst_a10(u32 maxburst)
>  	return (maxburst >> 2);
>  }
> =20
> +static int convert_burst_f1c100s(u32 maxburst)
> +{
> +	if (maxburst > 4)
> +		return -EINVAL;
> +
> +	/* 1 -> 0, 4 -> 1 */
> +	return (maxburst >> 2);
> +}
> +

This is essentially the same function than for the A10, with a
different limit. Like a was saying, use a bitmask for the supported
bursts length, and test whether the burst is supported against that
mask. You won't have to duplicate those functions anymore.

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--immwmaskuc6nscn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAULwQAKCRDj7w1vZxhR
xXM9AQCkIKWTdXxm4LCl/5nVIOZKIp6u/PbWWMqL+4KcPQ4ABgEAojRzWG8BVMQo
NKf61vkYE2EF634JjHR8VK2R8PGHMQU=
=vmM+
-----END PGP SIGNATURE-----

--immwmaskuc6nscn3--
