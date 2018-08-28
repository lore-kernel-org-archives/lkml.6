Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EAFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C526D20645
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IIOqVRlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C526D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeH1FrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:47:08 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:52346
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbeH1FrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5/PyrZ49WcgNgwqq0Xpw8IgrPKPnAQAQXSCiIdASvo=;
 b=IIOqVRlqh6t5eHEaqmBMYlVFpaxXtabL9gUSRH3lWOM87E8cXL0nKlHXgKD4ZWZBuRGDknRdYZIPX0hkXutAa4SO2MVC61+NpyHEKUQwpcTVcmhpBLsvVHOP1qpkGyae2ZeGv4mRUHzKeaF7pux71QcCbP80eoIBbqWPT53oXUk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5169.eurprd04.prod.outlook.com (20.177.42.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 01:57:46 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5d61:a56c:c249:290]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5d61:a56c:c249:290%3]) with mapi id 15.20.1080.015; Tue, 28 Aug 2018
 01:57:46 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: RE: [PATCH] pinctrl: Convert to using %pOFn instead of
 device_node.name
Thread-Topic: [PATCH] pinctrl: Convert to using %pOFn instead of
 device_node.name
Thread-Index: AQHUPnIn7djfR4qhw0qB8jpfI9cBpKTUZ6Hw
Date:   Tue, 28 Aug 2018 01:57:46 +0000
Message-ID: <AM0PR04MB4211652B5C4C4CD91EA17297800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-40-robh@kernel.org>
In-Reply-To: <20180828015252.28511-40-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5169;6:iqkHGnMj5Fm/+nTw1raUtD2isEtvgxmB4WikrtuzsWXLlX73ltGYpbQB2c4KhNxue/yi9msBZp8jpKVxOEWm+lnGQ6LzJNFfUlvoC9VWoopo9Jzux8JPm6+8S2IkZXfeBJtahezpqZPO4f6TM11B1qZc8goZpcnGooqJBy2DqZ4tt/ZunNIKY5NBYwGqrvR/F3brp1C55TSykxoLbmL/4ZPGJSX9fJtVKOVAXGCUNGy1HRGCrF+SgXCXCsbSKFsdswXXlSgnSzdjiK+XF8ECeA40bJWpw1ddh8LwVkFeXbXhs499qDrwQUvtEihLxLz02I4HQ6WYvwjS7iB/icEMbEVGKldRXIT9kM5VUMfuKhj+prs38o2DzFNgSWPNOI3Y1dfC7BDyiL2jSHMVuhdZPlUsogr8lDIW+PDO8+r5OH6b4hhJo535qtyLi28zxO+sJrDVL35I6eDPWETFrqGgGQ==;5:PYrEyvKXtwO3abBs+m4akj0s/ZSnbcNl3G6E/0ayf58nLsF/BiAtH0kQK/sbw37tEtPSec+9j1XWO75KGAng/9zLmQ17TdSjVkMR9bdVhWEgQ4XZwn/etW31CIvwZaYOzGmUS4i64pGts/klKM7HWfA9WdQgAJKIo9zcZmgE6bg=;7:Qz1Hb9T5KJkkGvHn0EQ7bPL8duXKpn4iRVoFMLD9kcWhuwszhVTa4j1TdvA7iD6tNc7gypwM4mm4B+WIoGFyPB9xqNt+CHMU1goUUAYU8bJuGjF4idnvRjPOlg7WvzvrL57vGgQzDnkiO6qcY6l7qQ7eFHAZyAr5xsxNmYqXsERDpBaprm8wmwy9O9EotEJA5AArXwHRLEFB0UFJqgtuIFLHqUKOlca4xK1PzU+nJwSk/D5qQX/S7VDJnX6A/gdc
x-ms-office365-filtering-correlation-id: 3f7ba5d9-7b4c-4d63-1f4c-08d60c89a6db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5169;
x-ms-traffictypediagnostic: AM0PR04MB5169:
x-microsoft-antispam-prvs: <AM0PR04MB5169C9374B6DF1BAAC2FFA11800A0@AM0PR04MB5169.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:AM0PR04MB5169;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5169;
x-forefront-prvs: 077884B8B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(13464003)(4326008)(54906003)(55016002)(26005)(86362001)(8936002)(6246003)(33656002)(53546011)(110136005)(11346002)(476003)(14454004)(81166006)(8676002)(81156014)(68736007)(9686003)(74316002)(256004)(229853002)(3846002)(5660300001)(2906002)(2900100001)(2501003)(316002)(105586002)(97736004)(486006)(7406005)(446003)(6116002)(99286004)(7736002)(5250100002)(305945005)(7416002)(53936002)(6506007)(106356001)(186003)(7696005)(76176011)(39060400002)(102836004)(25786009)(66066001)(6436002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5169;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LOIbdE77WI/cSkqwJwZGVLJ83ewXbqoK3Ud0M7M75aPsfL+73+RWLNiWe1OeSpCn4k968201RTHcdR0f8TiKRrEMTCdbHeheXYnx7RV0SId4h9DKYkUF2iBiM0y9CyuONbFartwKhNAvsAkDJCBF6wOhMwnoVICHpKXMcl2chcTjqpX1zjQAxcq7HGuL60m5CD7Z68Gj8zGgDeHaw/g7ntbvvVAupN+l3AL8uQdhInvowUJTaJzNna0ZIMlzQdUwzA5aNsLNFdJWJmtuJDGgh/6iGdlpfmnX6PL48Vwofnh6vB3NkwRsUpS7e2Mwh/OC4h5ee3k+YHZbTCaJEyZWlFFSvNztJcseSwlwNzLSQsQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7ba5d9-7b4c-4d63-1f4c-08d60c89a6db
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 01:57:46.8153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, August 28, 2018 9:53 AM
> To: linux-kernel@vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>; A.s. Dong
> <aisheng.dong@nxp.com>; Fabio Estevam <festevam@gmail.com>; Shawn
> Guo <shawnguo@kernel.org>; Stefan Agner <stefan@agner.ch>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Sean Wang
> <sean.wang@mediatek.com>; Matthias Brugger <matthias.bgg@gmail.com>;
> Carlo Caione <carlo@caione.org>; Kevin Hilman <khilman@baylibre.com>;
> Jason Cooper <jason@lakedaemon.net>; Andrew Lunn <andrew@lunn.ch>;
> Gregory Clement <gregory.clement@bootlin.com>; Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com>; Jean-Christophe Plagniol-Villard
> <plagnioj@jcrosoft.com>; Nicolas Ferre <nicolas.ferre@microchip.com>;
> Alexandre Belloni <alexandre.belloni@bootlin.com>; Heiko Stuebner
> <heiko@sntech.de>; Tony Lindgren <tony@atomide.com>; Haojian Zhuang
> <haojian.zhuang@linaro.org>; Patrice Chotard <patrice.chotard@st.com>;
> Barry Song <baohua@kernel.org>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@st.com>; Maxime Ripard <maxime.ripard@bootlin.com>;
> Chen-Yu Tsai <wens@csie.org>; linux-gpio@vger.kernel.org;
> linux-mediatek@lists.infradead.org; linux-arm-kernel@lists.infradead.org;
> linux-amlogic@lists.infradead.org; linux-rockchip@lists.infradead.org;
> linux-omap@vger.kernel.org
> Subject: [PATCH] pinctrl: Convert to using %pOFn instead of device_node.n=
ame
>=20
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>=20
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pinctrl/berlin/berlin.c               |  6 ++--
>  drivers/pinctrl/freescale/pinctrl-imx.c       |  7 ++--
>  drivers/pinctrl/freescale/pinctrl-imx1-core.c | 12 +++----

For i.MX,
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
