Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF6C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1C82083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1C82083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeJAPwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:52:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50260 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbeJAPwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:52:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7D95E20828; Mon,  1 Oct 2018 11:15:43 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 23851206A2;
        Mon,  1 Oct 2018 11:15:43 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:15:43 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH net-next 2/7] net: phy: mscc: add support for VSC8584 PHY
Message-ID: <20181001091543.q4mshrpmbn7tlkdn@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914172754.GC3811@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hgwqmmf3egdwz2lm"
Content-Disposition: inline
In-Reply-To: <20180914172754.GC3811@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hgwqmmf3egdwz2lm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Sep 14, 2018 at 07:27:54PM +0200, Andrew Lunn wrote:
>=20
> >  struct vsc8531_private {
> >  	int rate_magic;
> >  	u16 supp_led_modes;
> > @@ -181,6 +354,7 @@ struct vsc8531_private {
> >  	struct vsc85xx_hw_stat *hw_stats;
> >  	u64 *stats;
> >  	int nstats;
> > +	bool pkg_init;
>=20
> > +/* bus->mdio_lock should be locked when using this function */
> > +static int vsc8584_cmd(struct mii_bus *bus, int phy, u16 val)
> > +{
> > +	unsigned long deadline;
> > +	u16 reg_val;
> > +
> > +	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,
> > +			MSCC_PHY_PAGE_EXTENDED_GPIO);
> > +
> > +	__mdiobus_write(bus, phy, MSCC_PHY_PROC_CMD, PROC_CMD_NCOMPLETED | va=
l);
>=20
> Hi Quentin
>=20
> All the __mdiobus_write() look a bit ugly.

I agree :)

> Maybe add bus and base_addr
> to the vsc8531_private structure. Then add helpers
> phy_write_base_phy(priv, reg, val) and phy_read_base_phy(priv, reg).
>=20

ACK.

> You could also add in:
>=20
>         if (unlikely(!mutex_is_locked(&priv->bus->mdio_lock))) {
>                 dev_err(bus->dev, "MDIO bus lock not held!\n");
>                 dump_stack();
>         }
>=20
> Having such code in the mv88e6xxx driver has found a few bugs for me.
>=20

ACK.

Thanks,
Quentin

--hgwqmmf3egdwz2lm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlux5b4ACgkQhLiadT7g
8aM6XBAAptT581qBE7XY42MTueijWuoRMYjMOlA7VzybiZ80bMxZtrhQMHZIvWiq
GMOU26VIK+N253/u3oQMKIO8eSX3lRRuG2Tp7UN44LNtIfeFX2LhTfeuvVkyAjvJ
JY/ZXxq4r9Vkos1QEHoJOR91/289iDB2JYdf1JZ01nXfmA677FSrIzbCm8iGO4aF
muMuW2i9X2gEaTZargBfM6JNsIwWZJlRimzPlOuzhQQB3R8o8DK2XABHrB8AoiTn
Q1r54EsLPlL2i4V7zUlRyybrU+O+6q0uYA+0Q2SGhBmX8SlTMwF7B1VZHZVyrITm
df1EMiOlnwqprzao36mClnOnvREz2/j/oh6nbxS2LD6tBR+hEa4cTL3TdZuAky6i
Omr400D3nedo9QMG9l2iHaVdHbaW3xWZINnA46SzmO+CcO0E0KQBwXgimoGRHkgE
Zlj/eD2hPVu1zZgeAtwiBjTl76nM6vo37OmVaOgiJaovz74VW/dzpOfICiAU5hza
jWdxHRyYcWJuRWCoYk9hiKP6pt2MkRaUHrANGlq+4X0Bfjw/E9yzo4qSlikN0INi
8RrfNCK61mSxZhjPzjs0iW/3jVIYUTi3xJ2iIAa7Il8tiNAp2ofTqA9xldfpKm6T
JeAAKcSgLZvRqpvNEAtgFsyOadGzzF7yu0xys5h5op9VKHDKHHk=
=xTTz
-----END PGP SIGNATURE-----

--hgwqmmf3egdwz2lm--
