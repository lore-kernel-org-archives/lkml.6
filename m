Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC61CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A25218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g/oif2Vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfBRDEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:04:23 -0500
Received: from mail-eopbgr150047.outbound.protection.outlook.com ([40.107.15.47]:26368
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727602AbfBRDEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 22:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmBf37P15ggFEl/skkx0CW1NLh0nLQM7ZwjfiZFth0s=;
 b=g/oif2Vz8rWWyUqZt+1fOx7SBOQV2pjugKNYvcZTRmOjBKTvYL9Pg8ujP/A3A/kixVGZcL9Rn32imU9AL01YRSnnCnQCMgKrrhImB3wHR3rnaQIyY+qKBknMfwyPBVJ8NK9groWupgHhrnxyhyu+HJKxmnBbz8MtMAXCEt2vdy4=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB1648.eurprd04.prod.outlook.com (10.164.84.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 03:04:18 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2%3]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 03:04:18 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: RE: [PATCH v3] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
Thread-Topic: [PATCH v3] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
Thread-Index: AQHUxUqvA6eOAzVWPUW+Xl7987JiyqXk4fzA
Date:   Mon, 18 Feb 2019 03:04:17 +0000
Message-ID: <VI1PR04MB53274C03CD18C3D3ADB767408B630@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190215162225.19284-1-paul.kocialkowski@bootlin.com>
In-Reply-To: <20190215162225.19284-1-paul.kocialkowski@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d39ff746-698d-473d-165c-08d6954dc5b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1648;
x-ms-traffictypediagnostic: VI1PR04MB1648:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB1648;23:9wXXj8oSznBKGzLI6SASVPpvS24yBvUlN2aGojD9W?=
 =?us-ascii?Q?RL9PjIDA44aVFRbMpfkUWib2DRkkty2x2xUcoKKvG+Eb2VOeDYdID3EsGo/4?=
 =?us-ascii?Q?3LdeesSbI58hX/HlQ/CmWPMqtQAcnPu7TROM9HbSGQfqWKwWOXE4dFFRvsXz?=
 =?us-ascii?Q?Z+Olpsl7T2a5ffdBIly8CUH6axEU7TZpCFBUlSyak8wGtw8xfZAjH0deKa7x?=
 =?us-ascii?Q?LCeWuTN5urGJuDV9QiNaQD4jxXKv0ussOugWwnLL8B6zqC7OtJnN02TnF8vg?=
 =?us-ascii?Q?tJLzGrs8OAQ/WfOzbufLvsKBjPjPD1ucFlDnnhLQ8GcwD+WAbYMsUvcrAYTO?=
 =?us-ascii?Q?XwdOXed+LhDcbp2MA6B5oXLycBogfniwksX+ZLKduDo9J/Zel+pVcV3GV2VW?=
 =?us-ascii?Q?u4c9HUsxx8dLKuVy1vQb0g5n+zTJnJ5LrDd23fdvSpJmcR1PDH03zOx38ABM?=
 =?us-ascii?Q?RcHjqgXwqpW+VNFoCCFRcgvAZToWFjdlYm00/AAFvlHUlUXAm1Cfa1bstlFr?=
 =?us-ascii?Q?Y/jl46xxuM+wN3W9JwWyHFtWEplnNawgovj1tdj5gUO9yo5OzJeIM4au/7r0?=
 =?us-ascii?Q?SpqzDbnIXqaeaY2Xt89+Wquo24MQWV/xKANUuN+pBs0G5L7qYXteOl8QyJUc?=
 =?us-ascii?Q?t50y6diiUOx0ngI3Zv8GifeTCEu7kIEBnh/aR8Mg16aV7d6p52ZmTiL17FEm?=
 =?us-ascii?Q?ktAQH4eL4ejsV4zyLcRNqf/XK0FhsWvtUwIPJ/wlvd8gObR8gmIECU8bMJ+Q?=
 =?us-ascii?Q?hO8QmYhwE1Z0H8W/E9mRWiSJh4IclivEG3hEmH+mHsBq3OxEtmXyke1N26/z?=
 =?us-ascii?Q?n9kBQChBoLxSQd8EBZZKHajnPLmPUHpLXnLqYbGLTylruyYCBOmHyCBYGhhd?=
 =?us-ascii?Q?5y29DWZJLC8YhCM4Z0CZ8GiW7eIZ4K3WxvH+/xp558ZuJ+FaGii+ZjMeXynn?=
 =?us-ascii?Q?Rs04bOCc2dRjA+meESn9KjkEFIWWITMg8gqd82dH3G1qRcAY6x2uZe38zwSk?=
 =?us-ascii?Q?QkvXdZTU3jBI9EYhSupt5iDtcaaM5nnh4CaGMnggDuUy1Wa+k329jYUDuGm9?=
 =?us-ascii?Q?3KYR/T7HIPQwHW68LUnkKRHm/UiY1PO69c2DmnB0nf/PSHR3+zkM3bsXhtfp?=
 =?us-ascii?Q?ZXUv44Lh7dw1SA3dL34QkQ3Z1s8qmOYsgnKPWUe5FYpDbmO6XBMKm9MikNxt?=
 =?us-ascii?Q?CBYb1gHTx6rob1+CBkAVpkyZHi8CsANgzOO2eQIjLP+fvYytxWJd48nLEfRb?=
 =?us-ascii?Q?YmLo4U5DcZEtNm0tLGCYiR1DX+QTYanAKq1OOIzUhlP61Tp3XjyceXszgLSf?=
 =?us-ascii?B?QT09?=
x-microsoft-antispam-prvs: <VI1PR04MB164815FDA6626574B49EB2F18B630@VI1PR04MB1648.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(9686003)(102836004)(229853002)(486006)(53936002)(186003)(7696005)(6506007)(2501003)(6246003)(26005)(11346002)(99286004)(476003)(446003)(44832011)(106356001)(217873002)(110136005)(76176011)(256004)(86362001)(66066001)(25786009)(97736004)(54906003)(14444005)(105586002)(2906002)(6116002)(33656002)(3846002)(5660300002)(74316002)(7736002)(316002)(68736007)(305945005)(81166006)(81156014)(478600001)(8936002)(4326008)(71200400001)(2201001)(55016002)(71190400001)(6436002)(8676002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1648;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 83WoP78oDyrv3hdx/8OFtDc7Gjn7rNNaLmtBrCe08vgmMafZ2XznnKc33XCukrb+P56fUJ6CqLdpn1mCvEOvNl5EhHoeYRFNuhezlSSgC5uqreH0keR7/UAFgeUk12LSlkH7H5aQGsekmDFBOTPi3udpzuwzCxN+Ylzs6/SgJ4oYFEk1P+XIyJWEa3vKa23IWGj4hsWcLiv6BeNfPlPSKa+swIi1mUdv9k/fkFQ4VBQm7O5exID5Fwkz5xtfv/0As7CNyjO+XZHx0Le3Sg44nWtI2MHUr5xLtRGfIo03ye4CmBHaxpEWqTGc+t9MAQ1reQ079kGFQ9IybkZHA4isqdEk6gs/tCF/+BxTsI4MI/RlIoWNbrYbQ/AM/pOloKYeuA5Eb/yuNgJYeGlqqYbvMU8w3qMPpbPAqGAQI6IwAdo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39ff746-698d-473d-165c-08d6954dc5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 03:04:18.0331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> According to the chipidea driver bindings, the USB PHY is specified via t=
he "phys"
> phandle node. However, this only takes effect for USB PHYs that use the c=
ommon
> PHY framework. For legacy USB PHYs, a simple lookup based on the USB PHY
> type is done instead.
>=20
> This does not play out well when more than one USB PHY is registered, sin=
ce the
> first registered PHY matching the type will always be returned regardless=
 of what
> the driver was bound to.
>=20
> Fix this by looking up the PHY based on the "phys" phandle node.
> Although generic PHYs are rather matched by their "phys-name" and not the=
 "phys"
> phandle directly, there is no helper for similar lookup on legacy PHYs an=
d it's
> probably not worth the effort to add it.
>=20
> When no legacy USB PHY is found by phandle, fallback to grabbing any regi=
stered
> USB2 PHY. This ensures backward compatibility if some users were actually=
 relying
> on this mechanism.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
> Changes since v2:
> * Fixed typos in commit message.
>=20
> Changes since v1:
> * Only consider legacy USB PHY error for fallback as suggested;
> * Checked against EPROBE_DEFER before entering fallback.
>=20
>  drivers/usb/chipidea/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c in=
dex
> 7bfcbb23c2a4..016e4004fe9d 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -954,8 +954,15 @@ static int ci_hdrc_probe(struct platform_device *pde=
v)
>  	} else if (ci->platdata->usb_phy) {
>  		ci->usb_phy =3D ci->platdata->usb_phy;
>  	} else {
> +		ci->usb_phy =3D devm_usb_get_phy_by_phandle(dev->parent, "phys",
> +							  0);
>  		ci->phy =3D devm_phy_get(dev->parent, "usb-phy");
> -		ci->usb_phy =3D devm_usb_get_phy(dev->parent,
> USB_PHY_TYPE_USB2);
> +
> +		/* Fallback to grabbing any registered USB2 PHY */
> +		if (IS_ERR(ci->usb_phy) &&
> +		    PTR_ERR(ci->usb_phy) !=3D -EPROBE_DEFER)
> +			ci->usb_phy =3D devm_usb_get_phy(dev->parent,
> +						       USB_PHY_TYPE_USB2);
>=20

I think you may need to do above if ci->phy is error, and not the error is =
-EPROBE_DEFER.

Peter

>  		/* if both generic PHY and USB PHY layers aren't enabled */
>  		if (PTR_ERR(ci->phy) =3D=3D -ENOSYS &&
> --
> 2.20.1

