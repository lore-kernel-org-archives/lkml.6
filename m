Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9198CC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480A72089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mGQNBQQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480A72089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeJOX5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:57:52 -0400
Received: from mail-eopbgr50040.outbound.protection.outlook.com ([40.107.5.40]:20704
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbeJOX5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/kBCOFPrxtu5ivkke3JFrFDQTCMnzHcOmPCZ02kcAQ=;
 b=mGQNBQQNKm6yTlKiLJZhbmTGb8dzzxPFnz2c1hEw3v4gzgNcKAVGO5XMoGvJ5lUraoV0wN//+Z4eKbduiQr71s8IfgtYqWUL9D/mqAqLyikS8M9bIqoFY/xANbU8Q+STshjet1+YXkCcgHeFpPhGx8cxuPc9IyT3XYsQS/VkbJs=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5043.eurprd04.prod.outlook.com (20.177.40.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 16:11:54 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::25a0:3167:d718:91c1]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::25a0:3167:d718:91c1%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 16:11:54 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/4] Port mxs-dcp to imx6ull and imx6sll
Thread-Topic: [PATCH v2 0/4] Port mxs-dcp to imx6ull and imx6sll
Thread-Index: AQHUZIrVW85xcbkx8EaJGu2CO/Ct4qUgefmA
Date:   Mon, 15 Oct 2018 16:11:54 +0000
Message-ID: <AM0PR04MB42113CBC474C64ADE3B3D01780FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <cover.1539609921.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1539609921.git.leonard.crestez@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [116.237.60.178]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5043;6:SH58FJoe2ZgEk5AR0Hs2nrCy69o9P1Vn2LJkkHoKVHa2eZB2SrdwW8rNBCqud1PNjK46fj0qfOfqpH0G5Vmk6x9GkKJNW81ZqxvpJO6h58p9X5Nma8dYLZKsFSna76r2q4E13wVFGH6I6Zd7u9Xz083DDd0UvPguh8zboHSbEVTGeBfHA4foxudpalF3IMPqtPd149eOcJ56gYFUIDIkz/aA8Uoh7NWUcgq1Fhj3jm/Bk6aTIK3ubtWhq7NZMMGlCZ09h4VkzjX6hqgRsrQ+Mvf4YHoD4c8Jqs0UhwTe/MXpB6W/YsTP6qN049QnAA/QZu9f7yAGZB/DR4cId3mk9E2sZ3vaT6YtPYXp/GfssEyMVfYN+voyboF+yX2PvK+/9z/pRrkXbYP2xPDyG/v4wb8jeFWtumBRBgFiGVn/n3y7/svPd2IyeOz1pmz1W/3MV23uVOxwCYz7mwUD+574UQ==;5:5EsgIRLrx7Lv6T9b8utduo7WMw3xu14XKO/SDzhn/yKQV0gB0da5WlcmaR9vWUwXw/oB9zIlBLbIVSYRE3Oc7ctrmnALFb67reNw5psLLI/L5JW2TjUR4wrYs8TIP5CaeXHh3FB8YShlfVfIe0Zg4RoeElrjcFkIaGAtb0HDfD0=;7:tavp27WOmlNWI+O1toOcP6d2P59hevKlmU4UMxrVTK9x+80O8bMKu2LldnokqUiUZjASQj2EyvTjt57miYhKOGQ4RCvJH7xkc9ih8TgEe7AUYjbK46yWEYic+67ldF+QAn/YnbXNI7bFg8jcqWrUg9wCma4nM9kNvCsOUcmvIYg5UJqqCNmcVVjqvEMsxARn2P6Yt+4CR2i1Oe3pPVrMkaGsCrwSQlUtbKcOikUmg7cOV6gOGK4CJkCIGG3lJKzG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8ac2c5b7-2a68-403f-e50f-08d632b8ec92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5043;
x-ms-traffictypediagnostic: AM0PR04MB5043:
x-microsoft-antispam-prvs: <AM0PR04MB504398D530675215EE0A1FA580FD0@AM0PR04MB5043.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR04MB5043;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5043;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(51914003)(13464003)(486006)(106356001)(105586002)(9686003)(966005)(6306002)(33656002)(476003)(55016002)(14454004)(6436002)(6246003)(478600001)(8676002)(2906002)(53936002)(71200400001)(74316002)(8936002)(11346002)(81156014)(305945005)(71190400001)(39060400002)(76176011)(110136005)(7696005)(229853002)(53546011)(6506007)(81166006)(3846002)(99286004)(7416002)(54906003)(6116002)(5250100002)(446003)(26005)(97736004)(2900100001)(102836004)(68736007)(186003)(7736002)(316002)(66066001)(4326008)(5660300001)(86362001)(6636002)(25786009)(14444005)(256004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5043;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hNMUPrGHEb6WYtWAvLc175Qr6uU4X/NYyONTVXIjMB/RK+AHn5xYMlic6J2ZjRDvwInGyHV+YmEMjTSGPs6g6K0vgMmDeMIu9m5XsCmtgf2HOY5q4qWsq2B8wAWoNkCY3q2jUYtj/aU9Gq/pF9NZYIK4M/xoS1KracDKnWYWFj/BYU5jK2ep0rv1//lZr7xCCa1dG8d5uQnIa/sPZrqpeqcqZbTF3ay6WN5zOy52GWiV0QRf1k33KmGhk1PzRuYFM/JVGjBA0UrRSu28ZNscqGt4Nj+fK6HDlXkKoQh0B4WbyteIiuxdpEWMhffJqYaDJxRZfS4Tm6pGpoNyrAlBzNgV/g2lhR5klBqXG5YS4as=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac2c5b7-2a68-403f-e50f-08d632b8ec92
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 16:11:54.3314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

> -----Original Message-----
> From: Leonard Crestez
> Sent: Monday, October 15, 2018 9:28 PM


[...]

> Subject: [PATCH v2 0/4] Port mxs-dcp to imx6ull and imx6sll
>=20
> The DCP block is present on 6sll and 6ull but not enabled. The hardware i=
s
> mostly compatible with 6sl, the only important difference is that explici=
t clock
> enabling is required.
>=20
> There were several issues with the functionality of this driver (it didn'=
t even
> probe properly) but they are fixed in cryptodev/master by this series:
>     https://lore.kernel.org/patchwork/cover/994874/
>=20

Thanks for the work.
I will be glad to help the test if you provide some test guides. :-)

Regards
Dong Aisheng

> ---
> Changes since v1:
>  * Add devicetree maintainers for dt-bindings
>  * Add a patch enabling in imx_v6_v7_defconfig. Since tcrypt now passes t=
his
> shouldn't cause any issues
>  * Link to v1: https://lore.kernel.org/patchwork/cover/994893/
>=20
> Leonard Crestez (4):
>   dt-bindings: crypto: Mention clocks for mxs-dcp
>   crypto: mxs-dcp - Add support for dcp clk
>   ARM: dts: imx6ull: Add dcp node
>   ARM: imx_v6_v7_defconfig: Enable CRYPTO_DEV_MXS_DCP
>=20
>  .../devicetree/bindings/crypto/fsl-dcp.txt     |  2 ++
>  arch/arm/boot/dts/imx6ull.dtsi                 | 10 ++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig           |  1 +
>  drivers/crypto/mxs-dcp.c                       | 18
> ++++++++++++++++++
>  4 files changed, 31 insertions(+)
>=20
> --
> 2.17.1

