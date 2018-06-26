Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67535C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EF720A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="g3p/SQNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EF720A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeFZJEg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:04:36 -0400
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:52224
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752606AbeFZJEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNZJbrDZi/gfCKdvlwfxHuqIxdM/kKHHk8LnDG52+R4=;
 b=g3p/SQNVLwkVoc8jtQa02TYQubvQmyzK/0llhW6Ava6NWFP9cdz022mpWOzj4z1WU3+aApe9T/Lztlj9E2uIJreprTqVMAYIX6/MBCtIjv9dWMpcNLuTbndFHh1suUCiDeQ+g1XXfR27aWzmYDKsOrybwe7BEm15+7yE5y5uetE=
Received: from BYAPR07MB4886.namprd07.prod.outlook.com (52.135.205.149) by
 BYAPR07MB5048.namprd07.prod.outlook.com (52.135.239.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Tue, 26 Jun 2018 09:04:31 +0000
Received: from BYAPR07MB4886.namprd07.prod.outlook.com
 ([fe80::dd8d:8d7f:c2e:6f27]) by BYAPR07MB4886.namprd07.prod.outlook.com
 ([fe80::dd8d:8d7f:c2e:6f27%4]) with mapi id 15.20.0884.024; Tue, 26 Jun 2018
 09:04:31 +0000
From:   Krzysztof Witos <kwitos@cadence.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:CADENCE MIPI-CSI2 BRIDGES" <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] added support for csirx dphy
Thread-Topic: [PATCH 2/2] added support for csirx dphy
Thread-Index: AQHT/xQqHXyX8LiAg0eC6gatjz/toaRfaswAgBLthjA=
Date:   Tue, 26 Jun 2018 09:04:31 +0000
Message-ID: <BYAPR07MB48868E383E03E438ED63BD76C3490@BYAPR07MB4886.namprd07.prod.outlook.com>
References: <20180608103304.16054-1-kwitos@cadence.com>
 <20180608103304.16054-3-kwitos@cadence.com>
 <20180614075118.ukxhr5b73ofjnz6c@flea>
In-Reply-To: <20180614075118.ukxhr5b73ofjnz6c@flea>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3dpdG9zXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjdmZTJjNDctNzkxZi0xMWU4LTg1OWYtMDAyMWNjZGE1ZDAzXGFtZS10ZXN0XGY3ZmUyYzQ4LTc5MWYtMTFlOC04NTlmLTAwMjFjY2RhNWQwM2JvZHkudHh0IiBzej0iOTEzNSIgdD0iMTMxNzQ0Nzc0ODU3MDAxMDM2IiBoPSJYUFlvbG45SUkzS3M5NitmV21DNWNHTWgxa0E9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kwitos@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5048;7:zDD5EshVmnwRmMZXwaHthpritz86qdfza7S0qdyMXAdKfp/Qtx/mZeGEATAChGCf2vkyiWQokFDExDZwuNmujJbFNZE37fKMogwk6lqw/7XXu2abDwLyGXZ//t6/QdZ7xZJMQFo8N8rA2O/UrUlKOIBH3UneApic1TloA3uO8ae/eNKtFn0flGSX6tbLF/OlaTs4D3DxcTTsi3xkYiWnPjBcPL2SULGTS88BOSkwD5IN1/TZS7D00p081Zyl/BaD;20:RHgfaKNY1ZUcTHYSii7eXsjGeFbIcD5Z20I5qWK2IXtahJzVYIopBGYuRStMaw/0IetOQXLkhN/HBQ6O5+0Gg5zntkUH4GD90o4wTMNn3VqPD+AVfJ6f+bEwvpZBI3+TJgysl2rpoFn58bE562fjbvswtvcQWXzxu2g7inNy+aBi7zDwurarA/wQZAHPX0+wijH6o46pcc9CRH0i8GCSUN62zhJYZCkzAEeP68O+hNHgU/MBc2JUNBhM/D9IXC4K
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 348bd27e-b92f-4ac3-310c-08d5db43d465
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5048;
x-ms-traffictypediagnostic: BYAPR07MB5048:
x-microsoft-antispam-prvs: <BYAPR07MB50485CA3F26EFD4F812E9559C3490@BYAPR07MB5048.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB5048;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5048;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(36092001)(575784001)(76176011)(2900100001)(7696005)(53936002)(966005)(8936002)(8676002)(5250100002)(6506007)(2906002)(186003)(486006)(5660300001)(476003)(5024004)(14444005)(54906003)(81156014)(316002)(81166006)(102836004)(26005)(11346002)(74316002)(14454004)(305945005)(7736002)(446003)(6116002)(3846002)(55016002)(6306002)(6916009)(229853002)(6246003)(4326008)(66066001)(25786009)(99286004)(105586002)(9686003)(6436002)(33656002)(97736004)(68736007)(106356001)(86362001)(478600001)(256004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5048;H:BYAPR07MB4886.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g9j7TjezVnR9kUqhPBuetk9vTG+ATmFRFjqq1pIj9mhLl98pPV4bEoDHi6jYU8vyX69ZYVoXMq4J2zY81OuqWDhRjrec5xApXjeFrlNiUjxcC/4kzQCmCj1g/u44UNBT2y6dfGJuiYTn8FOue7x6/t+ZsYW19X20BENIPOQvt81c6XOCxFB+otaPfaOHmxq845eE+14yix5GoWA7/vw+gpUxzOLOXvKHBy+F5FFk9LfxZV5YFFeKKkvlbFfImHHAaMh/KOLhJpZxTEivF7iQ5DrIb9M0y7ZUTxGT44c6GtEuV32a3JIlXiNGBaiApckE+4YHpY7uWB/OvE0W+FzWpTgeoIgpZLPvurBwwGCv6Uo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348bd27e-b92f-4ac3-310c-08d5db43d465
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 09:04:31.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thank you very much for the review. Yes, I understand your point.=20
This needs to be changed.

> Hi,
>=20
> On Fri, Jun 08, 2018 at 11:33:04AM +0100, Krzysztof Witos wrote:
> > Signed-off-by: Krzysztof Witos <kwitos@cadence.com>
>=20
> A commit log explaining what you're doing here would be nice.
>=20
> > ---
> >  drivers/media/platform/cadence/cdns-csi2rx.c | 342
> > ++++++++++++++++++++++++---
> >  1 file changed, 313 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c
> > b/drivers/media/platform/cadence/cdns-csi2rx.c
> > index a0f02916006b..9251ea6015f0 100644
> > --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> > +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> > @@ -2,14 +2,16 @@
> >  /*
> >   * Driver for Cadence MIPI-CSI2 RX Controller v1.3
> >   *
> > - * Copyright (C) 2017 Cadence Design Systems Inc.
> > + * Copyright (C) 2017,2018 Cadence Design Systems Inc.
> >   */
> >
> >  #include <linux/clk.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_graph.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> > @@ -44,6 +46,33 @@
> >  #define CSI2RX_LANES_MAX	4
> >  #define CSI2RX_STREAMS_MAX	4
> >
> > +/* DPHY registers */
> > +#define DPHY_PMA_CMN(reg)       (reg)
> > +#define DPHY_PMA_LCLK(reg)      (0x100 + (reg))
> > +#define DPHY_PMA_LDATA(lane, reg)   (0x200 + ((lane) * 0x100) + (reg))
> > +#define DPHY_PMA_RCLK(reg)      (0x600 + (reg))
> > +#define DPHY_PMA_RDATA(lane, reg)   (0x700 + ((lane) * 0x100) + (reg))
> > +#define DPHY_PCS(reg)           (0xb00 + (reg))
> > +
> > +#define DPHY_CMN_SSM            DPHY_PMA_CMN(0x20)
> > +#define DPHY_CMN_SSM_EN         BIT(0)
> > +#define DPHY_CMN_RX_MODE_EN     BIT(10)
> > +
> > +#define DPHY_CMN_PWM            DPHY_PMA_CMN(0x40)
> > +#define DPHY_CMN_PWM_DIV(x)     ((x) << 20)
> > +#define DPHY_CMN_PWM_LOW(x)     ((x) << 10)
> > +#define DPHY_CMN_PWM_HIGH(x)        (x)
> > +
> > +#define DPHY_CMN_PLL_CFG	DPHY_PMA_CMN(0xE8)
> > +#define PLL_LOCKED		BIT(2)
> > +
> > +#define DPHY_PSM_CFG            DPHY_PCS(0x4)
> > +#define DPHY_PSM_CFG_FROM_REG       BIT(0)
> > +#define DPHY_PSM_CLK_DIV(x)     ((x) << 1)
> > +
> > +#define DPHY_BAND_CTRL          DPHY_PCS(0x0)
> > +#define DPHY_BAND_LEFT_VAL(x)	(x)
> > +
> >  enum csi2rx_pads {
> >  	CSI2RX_PAD_SINK,
> >  	CSI2RX_PAD_SOURCE_STREAM0,
> > @@ -67,7 +96,7 @@ struct csi2rx_priv {
> >  	struct clk			*sys_clk;
> >  	struct clk			*p_clk;
> >  	struct clk			*pixel_clk[CSI2RX_STREAMS_MAX];
> > -	struct phy			*dphy;
> > +	struct clk			*hs_clk;
> >
> >  	u8				lanes[CSI2RX_LANES_MAX];
> >  	u8				num_lanes;
> > @@ -83,8 +112,175 @@ struct csi2rx_priv {
> >  	struct v4l2_async_subdev	asd;
> >  	struct v4l2_subdev		*source_subdev;
> >  	int				source_pad;
> > +	struct cdns_dphy		*dphy;
> > +};
> > +
> > +struct cdns_dphy_cfg {
> > +	unsigned int nlanes;
> > +};
> > +
> > +struct cdns_dphy;
> > +
> > +enum cdns_dphy_clk_lane_cfg {
> > +	DPHY_CLK_CFG_LEFT_DRIVES_ALL =3D 0,
> > +	DPHY_CLK_CFG_LEFT_DRIVES_RIGHT =3D 1,
> > +	DPHY_CLK_CFG_LEFT_DRIVES_LEFT =3D 2,
> > +	DPHY_CLK_CFG_RIGHT_DRIVES_ALL =3D 3
> > +};
> > +
> > +struct cdns_dphy_ops {
> > +	int (*probe)(struct cdns_dphy *dphy);
> > +	void (*remove)(struct cdns_dphy *dphy);
> > +	void (*set_psm_div)(struct cdns_dphy *dphy, u8 div);
> > +	void (*set_pll_cfg)(struct cdns_dphy *dphy);
> > +	void (*set_clk_lane_cfg)(struct cdns_dphy *dphy,
> > +		enum cdns_dphy_clk_lane_cfg cfg);
> > +	void (*is_pll_locked)(struct cdns_dphy *dphy);
> > +	void (*set_band_ctrl)(struct cdns_dphy *dphy, u8 value); };
> > +
> > +struct cdns_dphy {
> > +	struct cdns_dphy_cfg cfg;
> > +	void __iomem *regs;
> > +	struct clk *psm_clk;
> > +	const struct cdns_dphy_ops *ops;
> >  };
> >
> > +static int cdns_dphy_set_band_ctrl(struct cdns_dphy *dphy,
> > +	struct csi2rx_priv *csirx)
> > +{
> > +	u8 band_value;
> > +	u32 hs_freq_mhz =3D clk_get_rate(csirx->hs_clk);
> > +
> > +	if (hs_freq_mhz >=3D 80 && hs_freq_mhz < 100)
> > +		band_value =3D 0;
> > +	else if (hs_freq_mhz >=3D 100 && hs_freq_mhz < 120)
> > +		band_value =3D 1;
> > +	else if (hs_freq_mhz >=3D 120 && hs_freq_mhz < 160)
> > +		band_value =3D 2;
> > +	else if (hs_freq_mhz >=3D 160 && hs_freq_mhz < 200)
> > +		band_value =3D 3;
> > +	else if (hs_freq_mhz >=3D 200 && hs_freq_mhz < 240)
> > +		band_value =3D 4;
> > +	else if (hs_freq_mhz >=3D 240 && hs_freq_mhz < 280)
> > +		band_value =3D 5;
> > +	else if (hs_freq_mhz >=3D 280 && hs_freq_mhz < 320)
> > +		band_value =3D 6;
> > +	else if (hs_freq_mhz >=3D 320 && hs_freq_mhz < 360)
> > +		band_value =3D 7;
> > +	else if (hs_freq_mhz >=3D 360 && hs_freq_mhz < 400)
> > +		band_value =3D 8;
> > +	else if (hs_freq_mhz >=3D 400 && hs_freq_mhz < 480)
> > +		band_value =3D 9;
> > +	else if (hs_freq_mhz >=3D 480 && hs_freq_mhz < 560)
> > +		band_value =3D 10;
> > +	else if (hs_freq_mhz >=3D 560 && hs_freq_mhz < 640)
> > +		band_value =3D 11;
> > +	else if (hs_freq_mhz >=3D 640 && hs_freq_mhz < 720)
> > +		band_value =3D 12;
> > +	else if (hs_freq_mhz >=3D 720 && hs_freq_mhz < 800)
> > +		band_value =3D 13;
> > +	else if (hs_freq_mhz >=3D 800 && hs_freq_mhz < 880)
> > +		band_value =3D 14;
> > +	else if (hs_freq_mhz >=3D 880 && hs_freq_mhz < 1040)
> > +		band_value =3D 15;
> > +	else if (hs_freq_mhz >=3D 1040 && hs_freq_mhz < 1200)
> > +		band_value =3D 16;
> > +	else if (hs_freq_mhz >=3D 1200 && hs_freq_mhz < 1350)
> > +		band_value =3D 17;
> > +	else if (hs_freq_mhz >=3D 1350 && hs_freq_mhz < 1500)
> > +		band_value =3D 18;
> > +	else if (hs_freq_mhz >=3D 1500 && hs_freq_mhz < 1750)
> > +		band_value =3D 19;
> > +	else if (hs_freq_mhz >=3D 1750 && hs_freq_mhz < 2000)
> > +		band_value =3D 20;
> > +	else if (hs_freq_mhz >=3D 2000 && hs_freq_mhz < 2250)
> > +		band_value =3D 21;
> > +	else if (hs_freq_mhz >=3D 2250 && hs_freq_mhz <=3D 2500)
> > +		band_value =3D 22;
> > +	else
> > +		return -EINVAL;
> > +
> > +	if (dphy->ops->set_band_ctrl)
> > +		dphy->ops->set_band_ctrl(dphy, band_value);
> > +
> > +	return 0;
> > +}
> > +
> > +static int cdns_dphy_setup_psm(struct cdns_dphy *dphy) {
> > +	unsigned long psm_clk_hz =3D clk_get_rate(dphy->psm_clk);
> > +	unsigned long psm_div;
> > +
> > +	if (!psm_clk_hz || psm_clk_hz > 100000000)
> > +		return -EINVAL;
> > +
> > +	psm_div =3D DIV_ROUND_CLOSEST(psm_clk_hz, 1000000);
> > +	if (dphy->ops->set_psm_div)
> > +		dphy->ops->set_psm_div(dphy, psm_div);
> > +
> > +	return 0;
> > +}
> > +
> > +static void cdns_dphy_set_clk_lane_cfg(struct cdns_dphy *dphy,
> > +	enum cdns_dphy_clk_lane_cfg cfg)
> > +{
> > +	if (dphy->ops->set_clk_lane_cfg)
> > +		dphy->ops->set_clk_lane_cfg(dphy, cfg); }
> > +
> > +static void cdns_dphy_set_pll_cfg(struct cdns_dphy *dphy) {
> > +	if (dphy->ops->set_pll_cfg)
> > +		dphy->ops->set_pll_cfg(dphy);
> > +}
> > +
> > +static void cdns_dphy_is_pll_locked(struct cdns_dphy *dphy) {
> > +	if (dphy->ops->is_pll_locked)
> > +		dphy->ops->is_pll_locked(dphy);
> > +}
> > +
> > +static void cdns_csirx_dphy_init(struct csi2rx_priv *csi2rx,
> > +	const struct cdns_dphy_cfg *dphy_cfg) {
> > +
> > +	/*
> > +	 * Configure the band control settings.
> > +	 */
> > +	cdns_dphy_set_band_ctrl(csi2rx->dphy, csi2rx);
> > +
> > +	/*
> > +	 * Configure the internal PSM clk divider so that the DPHY has a
> > +	 * 1MHz clk (or something close).
> > +	 */
> > +	WARN_ON_ONCE(cdns_dphy_setup_psm(csi2rx->dphy));
> > +
> > +	/*
> > +	 * Configure attach clk lanes to data lanes: the DPHY has 2 clk lanes
> > +	 * and 8 data lanes, each clk lane can be attache different set of
> > +	 * data lanes. The 2 groups are named 'left' and 'right', so here we
> > +	 * just say that we want the 'left' clk lane to drive the 'left' data
> > +	 * lanes.
> > +	 */
> > +	cdns_dphy_set_clk_lane_cfg(csi2rx->dphy,
> > +		DPHY_CLK_CFG_LEFT_DRIVES_LEFT);
> > +
> > +	/*
> > +	 * Configure the DPHY PLL that will be used to generate the TX byte
> > +	 * clk.
> > +	 */
> > +	cdns_dphy_set_pll_cfg(csi2rx->dphy);
> > +
> > +	/*  Start RX state machine. */
> > +	writel(DPHY_CMN_SSM_EN | DPHY_CMN_RX_MODE_EN,
> > +		csi2rx->dphy->regs + DPHY_CMN_SSM);
> > +
> > +	/* Checking if PLL is locked */
> > +	cdns_dphy_is_pll_locked(csi2rx->dphy);
> > +
> > +}
> > +
>=20
> That part looks like it's pretty much the same thing than the PHY support=
 in
> the DSI bridge found there:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers
> /gpu/drm/bridge/cdns-dsi.c#n493
>=20
> This code shouldn't be duplicated, but shared, ideally through the phy
> framework. That would require some changes to that framework though.
>=20
> Maxime
>=20
> --
> Maxime Ripard, Bootlin (formerly Free Electrons) Embedded Linux and Kerne=
l
> engineering https://bootlin.com


Best Regards,
Krzysztof
