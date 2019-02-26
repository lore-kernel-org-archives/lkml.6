Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B3FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A438020652
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfBZQHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:07:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43520 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:07:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5054027FE77
Received: by earth.universe (Postfix, from userid 1000)
        id DC2A73C0AE0; Tue, 26 Feb 2019 17:07:00 +0100 (CET)
Date:   Tue, 26 Feb 2019 17:07:00 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: cpcap: Remove unused vsel_shift from
 struct cpcap_regulator
Message-ID: <20190226160700.pb4zx4zukhef5j7e@earth.universe>
References: <20190226055230.25482-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2bngoyfqdnlj5mmc"
Content-Disposition: inline
In-Reply-To: <20190226055230.25482-1-axel.lin@ingics.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2bngoyfqdnlj5mmc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 26, 2019 at 01:52:29PM +0800, Axel Lin wrote:
> This driver uses regulator_get/set_voltage_sel_regmap so it does not use
> vsel_shift. Actually, vsel_shift can be calculated by vsel_mask setting.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/regulator/cpcap-regulator.c | 102 ++++++++++++++--------------
>  1 file changed, 50 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpca=
p-regulator.c
> index 2131457937b7..c15ced1b5968 100644
> --- a/drivers/regulator/cpcap-regulator.c
> +++ b/drivers/regulator/cpcap-regulator.c
> @@ -100,12 +100,11 @@ struct cpcap_regulator {
>  	struct regulator_desc rdesc;
>  	const u16 assign_reg;
>  	const u16 assign_mask;
> -	const u16 vsel_shift;
>  };
> =20
>  #define CPCAP_REG(_ID, reg, assignment_reg, assignment_mask, val_tbl,	\
> -		mode_mask, volt_mask, volt_shft,			\
> -		mode_val, off_val, volt_trans_time) {			\
> +		mode_mask, volt_mask, mode_val, off_val,		\
> +		volt_trans_time) {					\
>  	.rdesc =3D {							\
>  		.name =3D #_ID,						\
>  		.of_match =3D of_match_ptr(#_ID),				\
> @@ -127,7 +126,6 @@ struct cpcap_regulator {
>  	},								\
>  	.assign_reg =3D (assignment_reg),					\
>  	.assign_mask =3D (assignment_mask),				\
> -	.vsel_shift =3D (volt_shft),					\
>  }
> =20
>  struct cpcap_ddata {
> @@ -339,152 +337,152 @@ static const unsigned int vaudio_val_tbl[] =3D { =
0, 2775000, };
>  static struct cpcap_regulator omap4_regulators[] =3D {
>  	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
> -		  0, 0, 0, 0, 0, 0),
> +		  0, 0, 0, 0, 0),
>  	CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW2_SEL, unknown_val_tbl,
> -		  0, 0, 0, 0, 0, 0),
> +		  0, 0, 0, 0, 0),
>  	CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW3_SEL, unknown_val_tbl,
> -		  0, 0, 0, 0, 0, 0),
> +		  0, 0, 0, 0, 0),
>  	CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW4_SEL, unknown_val_tbl,
> -		  0, 0, 0, 0, 0, 0),
> +		  0, 0, 0, 0, 0),
>  	CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW5_SEL, sw5_val_tbl,
> -		  0x28, 0, 0, 0x20 | CPCAP_REG_OFF_MODE_SEC, 0, 0),
> +		  0x28, 0, 0x20 | CPCAP_REG_OFF_MODE_SEC, 0, 0),
>  	CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW6_SEL, unknown_val_tbl,
> -		  0, 0, 0, 0, 0, 0),
> +		  0, 0, 0, 0, 0),
>  	CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
> -		  0x87, 0x30, 4, 0x3, 0, 420),
> +		  0x87, 0x30, 0x3, 0, 420),
>  	CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
> -		  0x47, 0x10, 4, 0x43, 0x41, 350),
> +		  0x47, 0x10, 0x43, 0x41, 350),
>  	CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
> -		  0x87, 0x30, 4, 0x3, 0, 420),
> +		  0x87, 0x30, 0x3, 0, 420),
>  	CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
> -		  0x87, 0x30, 4, 0x82, 0, 420),
> +		  0x87, 0x30, 0x82, 0, 420),
>  	CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
> -		  0x80, 0xf, 0, 0x80, 0, 420),
> +		  0x80, 0xf, 0x80, 0, 420),
>  	CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
> -		  0x17, 0, 0, 0, 0x12, 0),
> +		  0x17, 0, 0, 0x12, 0),
>  	CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
> -		  0x87, 0x38, 3, 0x82, 0, 420),
> +		  0x87, 0x38, 0x82, 0, 420),
>  	CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
> -		  0x43, 0x18, 3, 0x2, 0, 420),
> +		  0x43, 0x18, 0x2, 0, 420),
>  	CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
> -		  0xac, 0x2, 1, 0x4, 0, 10),
> +		  0xac, 0x2, 0x4, 0, 10),
>  	CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
> -		  0x23, 0x8, 3, 0, 0, 10),
> +		  0x23, 0x8, 0, 0, 10),
>  	CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
> -		  0x23, 0x8, 3, 0, 0, 420),
> +		  0x23, 0x8, 0, 0, 420),
>  	CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
> -		  0x47, 0x10, 4, 0, 0, 420),
> +		  0x47, 0x10, 0, 0, 420),
>  	CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
> -		  0x20c, 0xc0, 6, 0x20c, 0, 420),
> +		  0x20c, 0xc0, 0x20c, 0, 420),
>  	CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
>  		  0xffff, vsim_val_tbl,
> -		  0x23, 0x8, 3, 0x3, 0, 420),
> +		  0x23, 0x8, 0x3, 0, 420),
>  	CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
>  		  0xffff, vsimcard_val_tbl,
> -		  0x1e80, 0x8, 3, 0x1e00, 0, 420),
> +		  0x1e80, 0x8, 0x1e00, 0, 420),
>  	CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
> -		  0x1, 0xc, 2, 0x1, 0, 500),
> +		  0x1, 0xc, 0x1, 0, 500),
>  	CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
> -		  0x11c, 0x40, 6, 0xc, 0, 0),
> +		  0x11c, 0x40, 0xc, 0, 0),
>  	CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
>  		  CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
> -		  0x16, 0x1, 0, 0x4, 0, 0),
> +		  0x16, 0x1, 0x4, 0, 0),
>  	{ /* sentinel */ },
>  };
> =20
>  static struct cpcap_regulator xoom_regulators[] =3D {
>  	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
> -		  0, 0, 0, 0, 0, 0),
> +		  0, 0, 0, 0, 0),
>  	CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW2_SEL, sw2_sw4_val_tbl,
> -		  0xf00, 0x7f, 0, 0x800, 0, 120),
> +		  0xf00, 0x7f, 0x800, 0, 120),
>  	CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW3_SEL, unknown_val_tbl,
> -		  0, 0, 0, 0, 0, 0),
> +		  0, 0, 0, 0, 0),
>  	CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW4_SEL, sw2_sw4_val_tbl,
> -		  0xf00, 0x7f, 0, 0x900, 0, 100),
> +		  0xf00, 0x7f, 0x900, 0, 100),
>  	CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW5_SEL, sw5_val_tbl,
> -		  0x2a, 0, 0, 0x22, 0, 0),
> +		  0x2a, 0, 0x22, 0, 0),
>  	CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_SW6_SEL, unknown_val_tbl,
> -		  0, 0, 0, 0, 0, 0),
> +		  0, 0, 0, 0, 0),
>  	CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
> -		  0x87, 0x30, 4, 0x7, 0, 420),
> +		  0x87, 0x30, 0x7, 0, 420),
>  	CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
> -		  0x47, 0x10, 4, 0x7, 0, 350),
> +		  0x47, 0x10, 0x7, 0, 350),
>  	CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
> -		  0x87, 0x30, 4, 0x3, 0, 420),
> +		  0x87, 0x30, 0x3, 0, 420),
>  	CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
> -		  0x87, 0x30, 4, 0x5, 0, 420),
> +		  0x87, 0x30, 0x5, 0, 420),
>  	CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
> -		  0x80, 0xf, 0, 0x80, 0, 420),
> +		  0x80, 0xf, 0x80, 0, 420),
>  	CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
> -		  0x17, 0, 0, 0x2, 0, 0),
> +		  0x17, 0, 0x2, 0, 0),
>  	CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
>  		  CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
> -		  0x87, 0x38, 3, 0x2, 0, 420),
> +		  0x87, 0x38, 0x2, 0, 420),
>  	CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
> -		  0x43, 0x18, 3, 0x1, 0, 420),
> +		  0x43, 0x18, 0x1, 0, 420),
>  	CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
> -		  0xac, 0x2, 1, 0xc, 0, 10),
> +		  0xac, 0x2, 0xc, 0, 10),
>  	CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
> -		  0x23, 0x8, 3, 0x3, 0, 10),
> +		  0x23, 0x8, 0x3, 0, 10),
>  	CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
> -		  0x23, 0x8, 3, 0x3, 0, 420),
> +		  0x23, 0x8, 0x3, 0, 420),
>  	CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
> -		  0x47, 0x10, 4, 0x5, 0, 420),
> +		  0x47, 0x10, 0x5, 0, 420),
>  	CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
> -		  0x20c, 0xc0, 6, 0x8, 0, 420),
> +		  0x20c, 0xc0, 0x8, 0, 420),
>  	CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
>  		  0xffff, vsim_val_tbl,
> -		  0x23, 0x8, 3, 0x3, 0, 420),
> +		  0x23, 0x8, 0x3, 0, 420),
>  	CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
>  		  0xffff, vsimcard_val_tbl,
> -		  0x1e80, 0x8, 3, 0x1e00, 0, 420),
> +		  0x1e80, 0x8, 0x1e00, 0, 420),
>  	CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
> -		  0x1, 0xc, 2, 0, 0x1, 500),
> +		  0x1, 0xc, 0, 0x1, 500),
>  	CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
>  		  CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
> -		  0x11c, 0x40, 6, 0xc, 0, 0),
> +		  0x11c, 0x40, 0xc, 0, 0),
>  	CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
>  		  CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
> -		  0x16, 0x1, 0, 0x4, 0, 0),
> +		  0x16, 0x1, 0x4, 0, 0),
>  	{ /* sentinel */ },
>  };
> =20
> --=20
> 2.17.1
>=20

--2bngoyfqdnlj5mmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlx1ZCEACgkQ2O7X88g7
+poxgA//fg/L8k6IpDJgZjC8pFzETDcyUpiTY2Cj3W4ZkMEZ6K5pEX+zw3HGJItU
dOh4Yf4tTJbmJU8kOgxiAh66KTOpevHSBCQfz5CIFmwoiDoqEahop5LImQfrjGct
5bU+CagyHt8nPEQdM7svL0/6Ne+IT6dzhdWtFBUch5mZF0QEUE6NXuMw+WUS5gac
ltlnQUi5rwfFvnAHHi6JIZQ7ifWX7HX/7DzPKWdDNZ4IWUrJ7/dfEhBXV/Sr36lo
EEoFuyE6xxdAkXy73ClyUwmHry6EBL3NDN6iGcYwNvnhV+cueaQGvWmDsx/BycWh
h0wOHdVBKSpeOK36cvP/uhol9Qbnhub+GLTgcOYeQbkV8LB/IAGaogvxbWDmwOBs
l2I4h1ya/PebDJQJRlqfmpP4J8cHfH9XwdD8DKtQ5tdLz8YbAi7YbMv4pOEsAbnM
z8H2aZShc7aqeargS4Pyia6Su1BAbm93pbjCrdHw6mcgEVktiaWgJc9AB4qTQfH0
Ct2UkeKBUaXKKpLH64+RLLOuLyJ2SuG4dB0ObW6m8+AMzJ11/fEgrk0DGCmupcIK
ay1aZxCA/+xfWIdAAwPLJHC6+dH2UETHVBr70wlmXBzYcaZWik/GRkhhSGG2I+On
umYEkLCQTE9NrOAfgKKVLaWlrU0w1wnACyO89OtzBBAIcKKlQ9U=
=XZFy
-----END PGP SIGNATURE-----

--2bngoyfqdnlj5mmc--
