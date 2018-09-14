Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2760CFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8FB20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8FB20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeINSbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:31:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42433 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbeINSbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:31:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 22364206EE; Fri, 14 Sep 2018 15:16:56 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id D7726206FF;
        Fri, 14 Sep 2018 15:16:45 +0200 (CEST)
Date:   Fri, 14 Sep 2018 15:16:45 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
Subject: Re: [PATCH net-next 1/5] net: phy: mscc: add ethtool statistics
 counters
Message-ID: <20180914131645.64k4w4h7ir3u5yuk@qschulz>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
 <e220fe75053e200f91554b752905d84b14b76eb6.1536913944.git-series.quentin.schulz@bootlin.com>
 <20180914130156.GB14865@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qoz4eytmgw74xsg3"
Content-Disposition: inline
In-Reply-To: <20180914130156.GB14865@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qoz4eytmgw74xsg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Sep 14, 2018 at 03:01:56PM +0200, Andrew Lunn wrote:
> Hi Quentin
>=20
> > +static struct vsc85xx_hw_stat vsc85xx_hw_stats[] =3D {
>=20
> You could add a const to that.
>=20

ACK.

> > +	{
> > +		.string	=3D "phy_receive_errors",
> > +		.reg	=3D MSCC_PHY_ERR_RX_CNT,
> > +		.page	=3D MSCC_PHY_PAGE_STANDARD,
> > +		.mask	=3D ERR_CNT_MASK,
> > +	}, {
> > +		.string	=3D "phy_false_carrier",
> > +		.reg	=3D MSCC_PHY_ERR_FALSE_CARRIER_CNT,
> > +		.page	=3D MSCC_PHY_PAGE_STANDARD,
> > +		.mask	=3D ERR_CNT_MASK,
> > +	}, {
> > +		.string	=3D "phy_cu_media_link_disconnect",
> > +		.reg	=3D MSCC_PHY_ERR_LINK_DISCONNECT_CNT,
> > +		.page	=3D MSCC_PHY_PAGE_STANDARD,
> > +		.mask	=3D ERR_CNT_MASK,
> > +	}, {
> > +		.string	=3D "phy_cu_media_crc_good_count",
> > +		.reg	=3D MSCC_PHY_CU_MEDIA_CRC_VALID_CNT,
> > +		.page	=3D MSCC_PHY_PAGE_EXTENDED,
> > +		.mask	=3D VALID_CRC_CNT_CRC_MASK,
> > +	}, {
> > +		.string	=3D "phy_cu_media_crc_error_count",
> > +		.reg	=3D MSCC_PHY_EXT_PHY_CNTL_4,
> > +		.page	=3D MSCC_PHY_PAGE_EXTENDED,
> > +		.mask	=3D ERR_CNT_MASK,
> > +	},
> > +};
>=20
> > +static u64 vsc85xx_get_stat(struct phy_device *phydev, int i)
> > +{
> > +	struct vsc8531_private *priv =3D phydev->priv;
> > +	int val;
> > +	u64 ret;
> > +
> > +	vsc85xx_phy_page_set(phydev, priv->hw_stats[i].page);
>=20
> I might of asked this before...
>=20
> Does changing the page effect registers in the lower range? It is
> possible for other operations to happen at the same time, and you
> don't want for example a status read to happen from some other
> extended page register because a statistics read is happening.
>=20

When you change a page, you basically can access only the registers in
this page so if there are two functions requesting different pages at
the same time or registers of different pages, it won't work well
indeed.

> phy_read_page() and phy_write_page() will do the needed locking if
> this is an issue.
>=20

That's awesome! Didn't know it existed. Thanks a ton!

Well, that means I should migrate the whole driver to use
phy_read/write_paged instead of the phy_read/write that is currently in
use.

That's impacting performance though as per phy_read/write_paged we read
the current page, set the desired page, read/write the register, set the
old page back. That's 4 times more operations. Couldn't we use the
phy_device mutex instead (as it's currently done in the whole driver)?
Or is it worse/comparable in performance to the suggested solution?

> > @@ -673,6 +782,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
> >  	vsc8531->rate_magic =3D rate_magic;
> >  	vsc8531->nleds =3D 2;
> >  	vsc8531->supp_led_modes =3D VSC85XX_SUPP_LED_MODES;
> > +	vsc8531->hw_stats =3D vsc85xx_hw_stats;
> > +	vsc8531->nstats =3D ARRAY_SIZE(vsc85xx_hw_stats);
> > +	vsc8531->stats =3D devm_kzalloc(&phydev->mdio.dev,
> > +				      sizeof(u64) * vsc8531->nstats,
> > +				      GFP_KERNEL);
>=20
> devm_kmalloc_array()? The security people prefer that.
>=20

ACK.

Thanks,
Quentin

--qoz4eytmgw74xsg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlubtL0ACgkQhLiadT7g
8aNThhAApqGEWbUsshj91CbZZTNW93G2+oI0B1ToahuJM/Wma1Ly8g2YsKRcam19
nUIczVou3EUqWAaqVFcEoy8hQ/bzXf029HapefofJJ31cVhqesftIhtfRqmY1MYI
p0LutCHvwjiMltoJP8fkr5F+9p6KSA0RXjdYxqaxstoM2X69VT8ePGi7aKJtYf5p
7mRqiINygtwDucPPGN5wQnmMgAwkVI9E/RbrfEvlTtPbTl3Q9FPLRYlDMmTFY2Od
XYNw0NB43T9uurzyh8HXp7IRQnLjBs8XLcdIdXkmDRNoD/eFzQNla4rXnCjlB/7n
gBIoHal9DKIjx8NRA/d1LZzYAZDeBo9GY44BBPuPOie5iFEf2qurAtS79CFmJjo9
IIPV7l2KZ4XnjrWtVRG++UyUi+5+7VNOnA+pbpHBIJHFSeSVE7+vjIYQE8IpcP9W
U+mpBzvfqSerJgnp2BE6cWPpogV+nifr7XdBufISy+qa0rm6RcWcpaf1tPwTpyQN
gLUldfnBn+KaLewvwplg4cI1o4CdQbAgp8OdkklRQuJMTnYjEUGwfgL6KNRwldWu
fwKMYU8HiXVJsijvxNBT6wovxIFtiINy7yUEBLRKIgAQq44Ik3zxxKHmWCXC0hIL
RjXOnF5WinafAyKhZCH72hb5pS7b5HD6n9YFV2Ng4vHczzhiL4I=
=9zyV
-----END PGP SIGNATURE-----

--qoz4eytmgw74xsg3--
