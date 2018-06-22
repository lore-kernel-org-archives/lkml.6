Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501F5C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38FC240FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X4DMPLWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38FC240FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeFVLLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:11:53 -0400
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:29216
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751085AbeFVLLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2QxpB61mHpkZSD7QweEbBjejXMiUukg+Av1tKyooD8=;
 b=X4DMPLWHUM500x2+07ub5UhhzDUeaiZzPA48duMoeZe49G+pOXHdby3hMZq2TVmvPyoPq2aGBERvuctSy/oWZdMoTf6OJElvZ5ABO/pa0m4BTrZtkxhWwTTRD4pMzt/21v7OCg0CzuasKCGrL23n5anl2EqOE7QNdpqT0eexdHE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4788.eurprd04.prod.outlook.com (20.176.215.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Fri, 22 Jun 2018 11:11:46 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce%2]) with mapi id 15.20.0884.010; Fri, 22 Jun 2018
 11:11:46 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>
Subject: RE: [PATCH v4 1/2] dt-bindings: add binding for i.MX8MQ IOMUXC
Thread-Topic: [PATCH v4 1/2] dt-bindings: add binding for i.MX8MQ IOMUXC
Thread-Index: AQHUCJGbXd1PklWkH0WWOlAIX9nFvaRsHwjQ
Date:   Fri, 22 Jun 2018 11:11:46 +0000
Message-ID: <AM0PR04MB4211C586B7824172B9B2232280750@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1529497429-8576-1-git-send-email-abel.vesa@nxp.com>
 <1529497429-8576-2-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1529497429-8576-2-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4788;7:ZOZD87rB/d/Dc091wJSobqUuDxJbNzOPO7TpoPSgtKEMgNtjBDkD7H0eh92ElIp6oOFlfadV4O3DUPpBXEsrd25qxMOnH0u6nMzi4qr6TnS6qhZpXxaef6oHQ3WHwe8K3aNwlAB/WqC55d81vqQ4zqeMVhRaRcBktvAqjlwpwppUtPig9oI0iUO7qHzw9lRYYEoEa6U5SqZHi0H6I6gvNv4abrmAwXRxSR2wCkGEWJSugp7MYndvcI3MN71OrA/i
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a74775f-2a38-465e-afc0-08d5d830f16d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4788;
x-ms-traffictypediagnostic: AM0PR04MB4788:
x-microsoft-antispam-prvs: <AM0PR04MB47883AB2090CBD337AD1848A80750@AM0PR04MB4788.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4788;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4788;
x-forefront-prvs: 071156160B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(366004)(346002)(396003)(189003)(199004)(13464003)(33656002)(105586002)(106356001)(305945005)(6116002)(229853002)(25786009)(7736002)(81156014)(2906002)(5660300001)(8936002)(26005)(3846002)(6436002)(81166006)(486006)(66066001)(9686003)(55016002)(74316002)(76176011)(8676002)(446003)(6246003)(53936002)(3660700001)(7696005)(2900100001)(6506007)(54906003)(14454004)(478600001)(53546011)(68736007)(86362001)(4326008)(110136005)(99286004)(102836004)(476003)(316002)(3280700002)(5250100002)(97736004)(7416002)(11346002)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4788;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xW071Xn1iucF9QuhTvnkPb0BAQrvjo4O6QQV1TnwxcqfLODO6uNOCJIRWIT/06H35iS8PwChd9tVn7KggtxWpl47j7HjRFNrESG2P2ondP1UMn0ex6zm9Bfji/glbROgmtS4onsNUIXsCqUNgyDVKAiM0w6rY1gpTVWAdzEocb1dQfl8fZ0Uw+u14RtXBHA1P/bDjj5Fep6Hs58pMmc2ntvxbvRA2D60t7CFldb9oI0ixXCJ9OtfHEKmGixAvL4sispamL/Kdq8toXjF+mE0CFh/JzLVa9/swBzBMUfuIqW+RX1AruVcRnJhhimEkmOw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a74775f-2a38-465e-afc0-08d5d830f16d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2018 11:11:46.2539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Abel Vesa
> Sent: Wednesday, June 20, 2018 8:24 PM
> To: Lucas Stach <l.stach@pengutronix.de>; A.s. Dong
> <aisheng.dong@nxp.com>
> Cc: linux-gpio@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Shawn
> Guo <shawnguo@kernel.org>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Linus Walleij <linus.walleij@linaro.org>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Abel Vesa
> <abelvesa@linux.com>; Abel Vesa <abel.vesa@nxp.com>
> Subject: [PATCH v4 1/2] dt-bindings: add binding for i.MX8MQ IOMUXC
>=20
> This adds the binding for the i.MX8MQ pin controller, in the same fashion=
 as
> earlier i.MX SoCs.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../bindings/pinctrl/fsl,imx8mq-pinctrl.txt        | 29
> ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl=
.txt
> b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
> new file mode 100644
> index 0000000..f11a3f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
> @@ -0,0 +1,29 @@
> +* Freescale IMX8MQ IOMUX Controller
> +
> +Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this
> +directory for common binding part and usage.
> +
> +Required properties:
> +- compatible: "fsl,imx8mq-iomuxc"
> +- fsl,pins: each entry consists of 6 integers and represents the mux
> +and config
> +  setting for one pin.  The first 5 integers <mux_reg conf_reg
> +input_reg mux_val
> +  input_val> are specified using a PIN_FUNC_ID macro, which can be
> +found in
> +  imx8mq-pinfunc.h under device tree source folder.  The last integer
> +CONFIG is
> +  the pad setting value like pull-up on this pin.  Please refer to
> +i.MX8M Quad
> +  Reference Manual for detailed CONFIG settings.
> +
> +Examples:
> +
> +&uart1 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_uart1>;
> +};
> +
> +&iomuxc {
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins =3D <
> +			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX
> 0x49
> +			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX
> 0x49
> +		>;
> +	};
> +};

How about giving more detailed information in the example as it only shows
show the pinctrl group part.

e.g.
iomuxc: iomuxc@30330000 {
        compatible =3D "fsl,imx8mq-iomuxc";
        reg =3D <0x0 0x30330000 0x0 0x10000>;

        pinctrl_uart1: uart1grp {
                fsl,pins =3D <
                        MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX             0x4=
9
                        MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX             0x4=
9
                >;
        };
};

Other than that:
Acked-by: Dong Aisheng <Aisheng.dong@nxp.com>

Regards
Dong Aisheng

> --
> 2.7.4

