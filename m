Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5586DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFB12184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hekjxa6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfBLJ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:57:37 -0500
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:8224
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfBLJ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGYoMosSug0clgOuvCqJruQWpJGQ+jDHIEQWXlMHTSg=;
 b=hekjxa6GvCXR/9vKaCc+/7hrEpSssLvbHN0hdJOo6XBFRsRtNExWMTya8Hn+5dHnILQJsFTd4QIEWU9nwERArmIiIZTh5B4yaKJqgGiM8WUCVxlcZ/COlR6mx2z7pobE1hoHOnohLoYLAOMQy3SAkCdkMQaCRCQ9ZsVWORBwHDw=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6116.eurprd04.prod.outlook.com (20.179.33.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 12 Feb 2019 09:57:32 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 09:57:32 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Carlo Caione <ccaione@baylibre.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: imx-ocotp: Add i.MX8MQ compatible
Thread-Topic: [PATCH 1/3] dt-bindings: imx-ocotp: Add i.MX8MQ compatible
Thread-Index: AQHUwinfXUV9s79yzE6xqkNTp1E4f6Xb7mmA
Date:   Tue, 12 Feb 2019 09:57:31 +0000
Message-ID: <20190212095731.ffyd33vndaldrp7i@fsr-ub1664-175>
References: <20190211165011.5114-1-l.stach@pengutronix.de>
In-Reply-To: <20190211165011.5114-1-l.stach@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6116;6:w9w2DV9jkwCgQ2ZCiNqY2dElT/r8rk6G8SgdN9vF6jTDjeOft3B8YAIYZE+rJAsMafGTndR8gehVdPG2R6eoTb1UBwjIzyGrlXY2aX0m8YKrfn5Q8My4SBkb8y+yKdTYTWP8YtrpGNKByFtJtAdWHYmXsQAdgLZnGcQjHfUPFBUg9GszPTKKkyIAhs4sn41F7FJjCfkCkTjEZEyoiuYOyUzeFBN+mAu8ntBfqBe99iyZR7g+qhGzUlgalmSUPPZsgg7cVAu8aZxyI0x4bVW4eZzZtwgLUdvu86no/53hOwbN2Hzv39f8hXx07cJ/rjOcqvy55VBFmOaXbB5pkYQ/N0TVagc8HwRNwJYd4zjG78PlUGmD2fG5sO5ut5++CEP8j8b0ZwP5zxLpD2748eYWDJZClNE109PYg8Aj+h5wpM+n4tZFPyjGY1BGh3ftGABazA1QbX7V4z7EcSI6iK0OJQ==;5:gam54GkTET+6+jVhIA0XIMkaVULBBe0yHCH821YY3IxjyOIYOXm8aVzWcGac9/Zc5r9Uzqj6CyKQW20b5ZPaDiJTD8P9vOWzhEcAqrfS/K9MZZjfnOW5+7raS8bNVbDqy0M4f+9ENZWtujnNrypIsKBWaBWyObgjJNjq1iJUo7Rl1msUj3bfHq67EyBEEODzfAD5Jm+gH0UbBuTxvy/hdw==;7:x8kjee2wQxAPDWBFNc91e7AdqqXSN5TqXSPyeRbjRMnIEqU0VdDwoBPn/KL6+9YtWxOvfuGyZoiW4GZBAlb4vfAGFiYBNSOFA16SleW06hCRhGgKFuTIqdwgE++i3K4j/0J19ynmXR1kN73qD7Ohtw==
x-ms-office365-filtering-correlation-id: 2e29a5d7-4d95-45e2-f93c-08d690d08192
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6116;
x-ms-traffictypediagnostic: AM0PR04MB6116:
x-microsoft-antispam-prvs: <AM0PR04MB611611E42153D75AA1E4B7B3F6650@AM0PR04MB6116.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(7916004)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(478600001)(486006)(66066001)(14454004)(97736004)(1076003)(71190400001)(71200400001)(186003)(26005)(105586002)(106356001)(446003)(11346002)(476003)(53936002)(256004)(14444005)(25786009)(3846002)(6116002)(6246003)(4326008)(102836004)(7736002)(53546011)(6506007)(86362001)(9686003)(6512007)(8676002)(2906002)(8936002)(305945005)(81166006)(81156014)(6436002)(6916009)(33716001)(76176011)(33896004)(229853002)(99286004)(68736007)(6486002)(44832011)(316002)(54906003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6116;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lZWuuQ7zgMY/a6cHiLkVe1vn1IMQRkVzU+qCOLfSq8dEcKHP0Z/iFzovLXDAuceqGA4iNd8Uu9yHyOlwGiZ+sEXWDYLAl0kOvQdlldgrE1zYbcnaooN7l3hg69GmLqw2eMBIZQoevgQbxPXrRot+x3K+KjtFokWUoR6aBL/NJKc8tNpj4u4WzdBnUjrICFrZmLx2o25/oVNilB373kIgEQO1WRZMnQgcy1yPgyIQ5byIAmPHz+uVnF42mR0w8D8G88UdNmKMonuKDUwqUJHyaLHcaYh7BC9Y/EGuZd3caO7sll1LdHF9SGz04zoVHwC9Ojrwr3V6QNNM/XgzYQkzDpy3CaZdaLDSVQ0VmdyQC/fk6O2ZxpRgv26Ng9v6AzAnh/oPVP7i4mXMU3QMHw/fZ1Y0grkBuZVkVrCabuZo4Ns=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21AA47679148184C87CDC2646C2CB6FE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e29a5d7-4d95-45e2-f93c-08d690d08192
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 09:57:32.0103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-11 17:50:09, Lucas Stach wrote:
> Add compatible for i.MX8MQ and add both i.MX7D/S and i.M8MQ
> to the description.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Docu=
mentation/devicetree/bindings/nvmem/imx-ocotp.txt
> index 792bc5fafeb9..bb8fb8fc6217 100644
> --- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> @@ -1,7 +1,8 @@
>  Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
> =20
>  This binding represents the on-chip eFuse OTP controller found on
> -i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL and i.MX6SLL SoCs.
> +i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6SLL, i.MX7D/S
> +and i.MX8MQ SoCs.
> =20
>  Required properties:
>  - compatible: should be one of
> @@ -11,6 +12,7 @@ Required properties:
>  	"fsl,imx6ul-ocotp" (i.MX6UL),
>  	"fsl,imx7d-ocotp" (i.MX7D/S),
>  	"fsl,imx6sll-ocotp" (i.MX6SLL),
> +	"fsl,imx8mq-ocotp" (i.MX8MQ),
>  	followed by "syscon".
>  - #address-cells : Should be 1
>  - #size-cells : Should be 1
> --=20
> 2.20.1
>=20

The entire series looks good to me.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>=
