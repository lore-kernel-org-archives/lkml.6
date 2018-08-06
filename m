Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177D6C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AF5219A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sIz41YOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AF5219A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeHFE6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:58:38 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:52128
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbeHFE6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP64sNzukr0ebzEwTn8pseZbZ9ShkdbrCsrgLKQ2WvM=;
 b=sIz41YOY7Lq3TuN+FAnwPEdYWVg/Avbmvg7vCeNcfYMm33kW+xe5olSH7Nf7uNDiuDpqWXMlFOAagjjr0SP9jIebM7IBpkN0KMrZVLHZnaTKrtiZVsHC+eVXRFnDdHgtsqWkIeBBYxwcdXfWugK4IAos+AbxlKcwwnA3md9nAiQ=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3191.eurprd04.prod.outlook.com (10.170.214.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 02:51:38 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::5a5:2607:a2c7:681c]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::5a5:2607:a2c7:681c%2]) with mapi id 15.20.1017.019; Mon, 6 Aug 2018
 02:51:38 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
Thread-Topic: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
Thread-Index: AQHUJMI3bwczuvIkzEyBW8aO9arKeKSizQEwgAlblYCABexxwA==
Date:   Mon, 6 Aug 2018 02:51:38 +0000
Message-ID: <DB6PR04MB3223921579ED18FDD802A73F89200@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-6-o.rempel@pengutronix.de>
 <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <403db02e-9c91-5080-ee9c-7a44716e64b2@pengutronix.de>
In-Reply-To: <403db02e-9c91-5080-ee9c-7a44716e64b2@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3191;6:cIylBRtK7qXQXSAjWdtP2KjprWloYQKZGFjUqlGfN2s1jnlyzXQfw71ldIPlpzQNIeKBiWfM2CYGF22nlYFUFjzHlWIzmJ+Fg1LuAYu88OcMyjryzDx9zye5HJaImvtOQ1lW6/K7/hhk1n1mjUpx2w7W95/45IfCbqIMPJZmqc6iBNB6tFCmb9l0K7E7heWk51u+j19C8i4ke+v90IhO4pzKy5xDfEsq04JTczV61SdlHN6y1QMDfLhvvhY2vlTzPDbUqkxoJ6UbgbJvhFFx+QUVhaqId/TB4oEnNAzVroGsuknkUUyhaUufgtS5He3TElCEJIuufGF0q6XqX9Ebg2JB1PCA3NNPUx+Dt6T8R8HPkwV80R/SyJeDI3A9A8PvOcRjqY7inwqibv5dUGK8wAG6kLmZo+bE6Zbqzy2mnSWQko0TbrX4/9PtYodj8LugwY+lSEGXGTU7aLW88qO7og==;5:xqOcN/dgwRAAza1cJJQJ+ytneV18EM9+vgXnGwrdsLYpASWpmm2WgXnYmUqfoN8PCgBSl7DmIFv7OjYZb5q4pSy1YMtXM+UC/bzVmuqEyaCgX8KGCYuBOzAAOgj57vmz+oMgcY2yIv0EnjXL/78sWyyCmq7RonyZv64qLButdfI=;7:I8I4bXP+FJ8sdaBpaS6piqlp4c+vbZ8BZFS7TB42G5WGAS6S8ZgsFDyg+tamfNOSMFqWx253rpV//FG2IATTMlzna2TCqYuZthY3VvG703njNy5MRHwoLznr+ZJmMFgMNWvxbliXaxm5XdfI/SrokcRi5I3GfIHS1FgnMDQwMaZgg1uJmdoizeDZjh5yUifVK2wHAxvFPrL80xYV89nyxpl0UMlrhmWj45VT38sYtgBQT607g2eBH55uviM8RuQV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b578d412-ee3f-4e6b-6712-08d5fb4787f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3191;
x-ms-traffictypediagnostic: DB6PR04MB3191:
x-microsoft-antispam-prvs: <DB6PR04MB319133A34C64119A50E5498C89200@DB6PR04MB3191.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3191;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3191;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(39860400002)(136003)(199004)(189003)(54906003)(110136005)(11346002)(486006)(476003)(99286004)(186003)(7696005)(316002)(76176011)(97736004)(256004)(446003)(55016002)(102836004)(229853002)(26005)(6506007)(25786009)(53936002)(86362001)(4326008)(39060400002)(9686003)(3846002)(6246003)(5250100002)(93886005)(6116002)(68736007)(5660300001)(81166006)(2906002)(81156014)(8936002)(14454004)(33656002)(7416002)(6436002)(106356001)(7736002)(2900100001)(66066001)(105586002)(8676002)(478600001)(305945005)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3191;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0Zji8m5/Cwh/Py75YwXe57pJLozczBUBIbFlp8+9G5iVkuiQb6C3lEF1XR9d5hfk+Tpk9fhxiPPlcj2ECgu3pbdxnpLEHdBsV5KEDnJJkAFqyLndmBJydRa1xo15UAGkUedL4avbAX1mn/n6Eyf+fmQpgAyLxCUijRKQ1X54poPB8xB30bUKEtQSKIToOCsiPnOApm4zCAo0VTAjP8ydUDZRCLy3D8wL63UM5i8Chhh9gTIYe/A3uT7KWcQcN3Bh0ZLQkrqp3/977TCqG2vaDuy6rozr6PBKT29x0VWnpKR2ZLxfzTDEUzmU2VOiR+gDuespp61gKAU3msttrQDW/x0rHuzhnRwu4F/7xIufjJA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b578d412-ee3f-4e6b-6712-08d5fb4787f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 02:51:38.4268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +static struct pfuze_chip *syspm_pfuze_chip;
> >> +
> >> +static void pfuze_power_off_prepare(void)
> >> +	dev_info(syspm_pfuze_chip->dev, "Configure standy mode for power
> >> +off");
> > Add 'if (syspm_pfuze_chip ->chip_id =3D=3D PFUZE100))' here is easy for
> > extend Support on pfuze200/3000.. in the feature.
> There is already:
> static int pfuze_power_off_prepare_init(struct pfuze_chip *pfuze_chip) {
>         if (pfuze_chip->chip_id !=3D PFUZE100) {
>                 dev_warn(pfuze_chip->dev, "Requested
> pm_power_off_prepare handler for not supported chip\n");
>                 return -ENODEV;
>         }
>=20
>=20
> No need to add it in pfuze_power_off_prepare()
I saw you add chip check in pfuze_power_off_prepare_init(), but I'm saying
In the future case pfuze200/3000 may should still support this feature, but=
 registers
are different between different chips, thus, move checking chip into pfuze_=
power_off_prepare()
could make the later patch for pfuze200/3000 more clear, less and easier.
