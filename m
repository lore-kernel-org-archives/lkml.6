Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A86C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F7A21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sQR6oHpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390897AbeLUDeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 22:34:21 -0500
Received: from mail-eopbgr30067.outbound.protection.outlook.com ([40.107.3.67]:38240
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388804AbeLUDeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 22:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6kobo7gOgGzH+oBlzNRfZ6Ur+CR7wb0E3CMtwyUEog=;
 b=sQR6oHpLC6cH0YoI34jcBTNYV26jTW+Kb8FH5YhFlXtGwUdwnS+7Oec98Xa9pbLNwOLof/JCZWkPjwu533B6efB+LzUT84UrdbLkAmFq/NjwkgwfeNgNspARn+laWzbxF7CBbK0+PieOMzjngXB7AZLaL+gJWEKgpCsUQDVdVxw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4372.eurprd04.prod.outlook.com (52.135.148.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 03:34:16 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 03:34:16 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] Documentation: can: flexcan: add PE clock source
 property to device tree
Thread-Topic: [PATCH 1/2] Documentation: can: flexcan: add PE clock source
 property to device tree
Thread-Index: AQHUkrKTWGGc6AwLT0O/CaAwEdOfgaWIHiWAgAByP6A=
Date:   Fri, 21 Dec 2018 03:34:16 +0000
Message-ID: <AM0PR04MB42113435FFFF1C01330A35D180B80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
 <20181213070537.25095-2-qiangqing.zhang@nxp.com>
 <20181220202247.GA26362@bogus>
In-Reply-To: <20181220202247.GA26362@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4372;6:l3lZPRqVS+dh95MNguG1Bn7Sac4cxPOdAZnopEX1kGp6h3VSfRY+MA2/w9mWx+jP5hF2NCYvfvM0U+pxObx5jackYyK2QefgfigvMjDYRMUw6LxEjS1lQEMDPAZuGrJDuIK8YW0pAAJx0W7+ZbhwzJ405x2BB69o4vvaqJttmoWd/8Zc81x3m73/4NT+xofCWET/F3U+8LRWB/0yeR3q4Nm67xo+WrHrzCQNOhQRxCLbZmwsTxBOzq756jMbFEiUk5XSI2PFIalf5fbalnlHD2817ac+4LlCZTdf+EPADpJZDy6yqipsbHsHIF+sY4CSC+hVc5dBZCedaJp5iH2N7SOtHpL3EArHmNuqQuO3b/jd61fTmCB7xfWptXYRMg+KhGuti3Vc3JS2kZthhz6PhW8luPZ+/01Id8MhDHWxtMWmAfzEPBOCFf3HHRk7CPRV0aJVLLIwbcNbnd8MjqRU8w==;5:O+kibUJafgqTLmr0PhEMCXoL4gzg193O/XyGn1yiIjoaI+qU6IynZvWp5pb5G0L4atZ/evlXs/AW1HVfONcVwZ2yy59jxtNUDHN1lqCdDwrx3xUQXgl+38+1GCRbXAl5GpfjWW6bNFoTxdxe3A/XsJXsuYtkfwD/8qCjTPGqQWs=;7:3/JK88IJX2ZkwlYzTqTSvi1ls7t8Bu1gjaKkIMLF51hWkWpM8RS2BRarfhRpyQOkMDXTrphgp79CtP9vMlTfUztCME5YfUvM7aGyzZ4aqwGQmer/PZ0LHBYrYB0LMI9bbu+iHjqhoqWPKTVIRzsjQw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9b1345f7-5d18-4148-8bf8-08d666f52f32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4372;
x-ms-traffictypediagnostic: AM0PR04MB4372:
x-microsoft-antispam-prvs: <AM0PR04MB4372BB6FFE2B2BC935818A0C80B80@AM0PR04MB4372.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4372;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4372;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(189003)(13464003)(8676002)(2906002)(5660300001)(9686003)(53936002)(8936002)(97736004)(74316002)(6246003)(7736002)(81156014)(55016002)(105586002)(186003)(106356001)(4326008)(86362001)(229853002)(7696005)(110136005)(305945005)(54906003)(6436002)(68736007)(478600001)(476003)(316002)(76176011)(6116002)(6506007)(81166006)(71200400001)(71190400001)(25786009)(99286004)(486006)(44832011)(26005)(66066001)(3846002)(14454004)(446003)(256004)(102836004)(14444005)(11346002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4372;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yTJDmBRgUzIyESC+crM5Mk+Dpj6HjVrPb0OYnKbKAy9mSXHFnMb3lM0Rcs1HAsqTY3BV3uU/JB7fClmUE/FUA0XifJdXxxbs4D0WXcIbVs2fpZCbAyJvsCXO1sZIr+WI//R3ijhqVYdu8+CjF6B/4xKKfreZKpImyTF61Jp6HK8Gx0UTaLl+rI84kzFbLX9A8lVumLtiRDbieVfI6dTtElGk0zILzyDfxJcmNJeMuUmUT6O6VuGI2HS+QR0jF8YjIvh/LByR/hedkrB52KpcZ/z7aYy0H4JrW1oZS3JfXppVeJhhYVKBv4n98MZfCzwM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1345f7-5d18-4148-8bf8-08d666f52f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 03:34:16.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Friday, December 21, 2018 4:23 AM
>=20
> On Thu, Dec 13, 2018 at 07:07:57AM +0000, Joakim Zhang wrote:
> > From: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > The FlexCAN controller can parse clock source property from DTS file
> > to select PE clock source.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8
> > ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > index bc77477c6878..a04168605998 100644
> > --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > @@ -32,6 +32,13 @@ Optional properties:
> >  		 ack_gpr is the gpr register offset of CAN stop acknowledge.
> >  		 ack_bit is the bit offset of CAN stop acknowledge.
> >
> > +- fsl,clk-source: Select the clock source to the CAN Protocol Engine (=
PE).
> > +		  It's SoC Implementation dependent. Refer to RM for detailed
>=20
> If SoC dependent, then it should be implied by the SoC specific compatibl=
e.
> Also, seems like you should add clock binding support here if you need mo=
re
> clock control.

The clock source selection is done by a register bit inside the IP block:
BIT13 CLKSRC CAN Engine Clock Source
0b - The CAN engine clock source is the oscillator clock.=20
1b - The CAN engine clock source is the peripheral clock.

Currently it's written 1 by default during driver initialization.
drivers/net/can/flexcan.c
/* select "bus clock", chip must be disabled */
reg =3D priv->read(&regs->ctrl);
reg |=3D FLEXCAN_CTRL_CLK_SRC;
priv->write(reg, &regs->ctrl);

I'm not sure if it's a typical case to abstract CLKSRC bit into a common cl=
ock mux.
(Is there any similar case in kernel?)
But I think we can also use SoC specific compatible to write 0 for those sp=
ecial
Ones (currently only imx8qxp). Then this patch may not be needed.

Marc,
Please let us know if you have a different idea.

Regards
Dong Aisheng

>=20
> > +		  definition. If this property is not set in device tree node
> > +		  then driver selects clock source 1 by default.
> > +		  0: clock source 0 (oscillator clock)
> > +		  1: clock source 1 (peripheral clock)
> > +
> >  Example:
> >
> >  	can@1c000 {
> > @@ -40,4 +47,5 @@ Example:
> >  		interrupts =3D <48 0x2>;
> >  		interrupt-parent =3D <&mpic>;
> >  		clock-frequency =3D <200000000>; // filled in by bootloader
> > +		fsl,clk-source =3D <0>; // select clock source 0 for PE
> >  	};
> > --
> > 2.17.1
> >
