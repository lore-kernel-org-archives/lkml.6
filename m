Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323C9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5A42084A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5A42084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbeKPV1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:27:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44546 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbeKPV1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:27:41 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2D69420D72; Fri, 16 Nov 2018 12:15:45 +0100 (CET)
Received: from qschulz (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2FEBC206D8;
        Fri, 16 Nov 2018 12:15:32 +0100 (CET)
Date:   Fri, 16 Nov 2018 12:15:31 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v2 3/5] phy: ocelot-serdes: convert to use eth phy mode
 and submode
Message-ID: <20181116111530.iqqcchtcnmlssvdp@qschulz>
References: <20181109234755.21687-1-grygorii.strashko@ti.com>
 <20181109234755.21687-4-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zjsxrk3dvxpgxdoc"
Content-Disposition: inline
In-Reply-To: <20181109234755.21687-4-grygorii.strashko@ti.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjsxrk3dvxpgxdoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grygorii,

On Fri, Nov 09, 2018 at 05:47:53PM -0600, Grygorii Strashko wrote:
> Convert ocelot-serdes PHY driver to use recently introduced
> PHY_MODE_ETHERNET and phy_set_mode_ext().
>=20

Thanks for the patch, it's annoying to have to map PHY_MODE_SGMII and
PHY_INTERFACE_MODE_SGMII :)

> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/mscc/ocelot.c   |  9 ++-------
>  drivers/phy/mscc/phy-ocelot-serdes.c | 14 ++++++++++----
>  2 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/ms=
cc/ocelot.c
> index 3238b9e..3edb608 100644
> --- a/drivers/net/ethernet/mscc/ocelot.c
> +++ b/drivers/net/ethernet/mscc/ocelot.c
> @@ -472,7 +472,6 @@ static int ocelot_port_open(struct net_device *dev)
>  {
>  	struct ocelot_port *port =3D netdev_priv(dev);
>  	struct ocelot *ocelot =3D port->ocelot;
> -	enum phy_mode phy_mode;
>  	int err;
> =20
>  	/* Enable receiving frames on the port, and activate auto-learning of
> @@ -484,12 +483,8 @@ static int ocelot_port_open(struct net_device *dev)
>  			 ANA_PORT_PORT_CFG, port->chip_port);
> =20
>  	if (port->serdes) {
> -		if (port->phy_mode =3D=3D PHY_INTERFACE_MODE_SGMII)
> -			phy_mode =3D PHY_MODE_SGMII;
> -		else
> -			phy_mode =3D PHY_MODE_QSGMII;
> -
> -		err =3D phy_set_mode(port->serdes, phy_mode);
> +		err =3D phy_set_mode_ext(port->serdes, PHY_MODE_ETHERNET,
> +				       port->phy_mode);
>  		if (err) {
>  			netdev_err(dev, "Could not set mode of SerDes\n");
>  			return err;
> diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-=
ocelot-serdes.c
> index c61a9890..f525a21 100644
> --- a/drivers/phy/mscc/phy-ocelot-serdes.c
> +++ b/drivers/phy/mscc/phy-ocelot-serdes.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/phy.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -116,8 +117,10 @@ struct serdes_mux {
>  	.mux =3D _mux,						\
>  }
> =20
> -#define SERDES_MUX_SGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_SGMII, m,=
 c)
> -#define SERDES_MUX_QSGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_QSGMII, =
m, c)
> +#define SERDES_MUX_SGMII(i, p, m, c) \
> +	SERDES_MUX(i, p, PHY_INTERFACE_MODE_SGMII, m, c)
> +#define SERDES_MUX_QSGMII(i, p, m, c) \
> +	SERDES_MUX(i, p, PHY_INTERFACE_MODE_QSGMII, m, c)
> =20
>  static const struct serdes_mux ocelot_serdes_muxes[] =3D {
>  	SERDES_MUX_SGMII(SERDES1G(0), 0, 0, 0),
> @@ -164,12 +167,15 @@ static int serdes_set_mode(struct phy *phy, enum ph=
y_mode mode, int submode)
>  	unsigned int i;
>  	int ret;
> =20
> +	if (mode !=3D PHY_MODE_ETHERNET)
> +		return -EINVAL;
> +

This works for now because we only support Ethernet muxes for now but
this IP also supports PHY_MODE_PCIE.

It seems weird to me that the day we'll add support for PCIE muxing we
will have in ocelot_serdes_muxes[i].mode either a PHY_INTERFACE_MODE_*
or a PHY_MODE_PCIE. This is not an issue for now since you do the mode
!=3D PHY_MODE_ETHERNET just above but once we get rid of this, we only
test for submode !=3D ocelot_serdes_muxes[i].mode and both
PHY_INTERFACE_MODE_1000BASEX and PHY_MODE_PCIE will have the same index
thus might be confused.

Should we add a submode to the SERDES_MUX macro, move PHY_MODE_*MII to
this submode and have PHY_MODE_ETHERNET/PCIE in the mode field?

Thanks,
Quentin

--zjsxrk3dvxpgxdoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlvuptIACgkQhLiadT7g
8aN3Hw/9Hd993cdBVgS3311aNV54CnV9yH1KIVpqt2eSYu0MM+UP8/nLt6caJdG8
ZPhCyLUH/M82vb16yDszb28/B4JfugZzuPRxuPUHRXJYGks7v15dDqryHfusJtSK
YOMAb5Hr1AUrMoP1O2hf8rh62C6N8yzxsvjCV+4kWKWLFwaYAq8BAuV4fPWm+twT
JI4U1l2UboLoLIK85ScuqXHoxJ9/gPFL3IT+zHxh67R7AOBnv8juZItHiNmaKoSs
CJUJIVZYKr0yhNEvVMG6Op6F94C1pV1VHk86UI3sCRSM7qawxjO/0vS9DyVZXwyS
R9l49u849cty+H+JIRiulImgWtF2BV6TB4hBEdo9Ujl8Qub8fkH8MwONAvJKQNIl
jaV7SkkUJBh4EIVFM7XVZ+N3x/EjIrvZH1esq2+0AGYZFpBFfaY3lt9akn6BZkBp
2rH8+XwiISHoRozOf6BQrUsYL3yc0zYkcZwP9c1NASPSkMTJQlrKnUIJuRxCLNW3
U6zjJRDitLtLBGyNcwghC/fa4u9NyMSUU5aPeblZA5dKL8Xb0oqIMu9+Czkpujo8
ujBsfHh2cu0+xY5qLlCe0HagflxkAy+W+nC3aErE9ndISNZ2kZi76eD3w/njgl/y
8LM5SLrnzMubfX1+Sa+yo/s6qWLDrUWOvZ1jfV241yUKkWPmzGw=
=C2cQ
-----END PGP SIGNATURE-----

--zjsxrk3dvxpgxdoc--
