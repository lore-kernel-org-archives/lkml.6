Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2D6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5991E217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wql+GIRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfBZMBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:01:06 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:4689
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfBZMBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR9V4l68q7d2BJiTqHD3rIy5cDx0gCuQmaU2et+pIO4=;
 b=wql+GIRjvAHf7qkQLguVBVRYE+/dPOU7heJYCvHXBFUz+UlAl5ashKy5mWd69CnsM5mcyifaze5x0g5BfgVi6nKNTiYCzLzixcHecMNFWJwlF+uD9eHsMSXr7TZ1V/hA1uRc6PfXHFQ7zdazbs0wzuw50fANqbHq/0Gu0eWOcvs=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4542.eurprd04.prod.outlook.com (20.177.55.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 12:00:58 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 12:00:58 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V8 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V8 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUybAPUmnoI6Ce/UqIMDTlZO/oOqXt7LgAgABXLoCAA716YA==
Date:   Tue, 26 Feb 2019 12:00:57 +0000
Message-ID: <VI1PR04MB422261F6A295A58FF06E90DE807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
 <20190223213759.GA1472@localhost.localdomain>
 <DB3PR0402MB39164677D09DA6CB3A6951B3F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39164677D09DA6CB3A6951B3F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98d9448f-a98a-4e3c-38d6-08d69be211b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4542;
x-ms-traffictypediagnostic: VI1PR04MB4542:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB4542;23:juyxq9PPP4A2p8wuIt8sSsbP+p0vLb5m3TjCTDCjG?=
 =?us-ascii?Q?NyqgldGMxL+Z/77aHYbvwq3V0Tftxg7OD41D2Iwiph6bZRnMqKfHTbFDr7US?=
 =?us-ascii?Q?5gyW/m+dOs4bpXmvRCvFxAumZpIDr2NUOdWKQS9aqEeOYihIlh/MIShmPFuU?=
 =?us-ascii?Q?09SYlkO8aq0Bx9tqjWpUAjR8Ar+/w5bFBOqYFbevW6gColEz0O22qifVDYdB?=
 =?us-ascii?Q?1RQVB03HrL3vvbC/1AhPeQ93u+1Fq/VM534ZWR73BoY23/By2+ri+phh3kIB?=
 =?us-ascii?Q?XqAi7gUGD2uUsAT9vg5Eb7vcKNKbmisiMjH2/ZT++ei1C3FiHUs/3x8VDoA9?=
 =?us-ascii?Q?8JMNYYEEikX5jBcoHctcT8ve2LJAQlqqpzmMO67i6Aq8QG1y09ko1OjRDfqJ?=
 =?us-ascii?Q?9rhUfQxa0q2J6mYwikjHdNda7TEbxZqR+fURx0Di+UZKry3t6k0BBEeNASyc?=
 =?us-ascii?Q?bXAuRyoqy6QqchfLK9tO+nSD6qqpINrWPts84QVrg27JIFfCPTQ8PV6bmfcU?=
 =?us-ascii?Q?nLz3WI5NEzrNYnEdpUezsC+OHvekPB2V8ZOYfjZkd49490+o4hsXhFe3aTzx?=
 =?us-ascii?Q?QG8eMqnuZ9qzRBXBHigBJNDxpQG+DycxusZ9TMKvCmrq/gcB1Z6H9vfEsR6K?=
 =?us-ascii?Q?2k4ysoVo3m8iv5MzpProL6yZ1/Ln5JSOULXWS5ST95Dr4qQLzghj8gpj9+6b?=
 =?us-ascii?Q?xGngI6eEFSXYkBuby9NUkGsC2gGYVgUBw51HEBiSce3M5fRI2C9gsMqD+BEv?=
 =?us-ascii?Q?0MR8sfpZ+a0YBXJ2DKxm11QxmMe+qMfptFNuVy1ygW1sxNaVisyhSp/S+s9B?=
 =?us-ascii?Q?lA3QWTvh6QBiv7HffMIMl1Ej7NyfTw2IB5uSquTwjQD+7bmNRDNe2ORWxY3y?=
 =?us-ascii?Q?bWT2pbTqPDJSo51qbI5ihWsgwhqawxx4GpLLmE0IO9OMes7d4n24NDB2bACI?=
 =?us-ascii?Q?l6feaBw3nJ+yLZb9dejxVIssfOwpFbZELbPba6MdwKYkpfnkcy2JoH77WWxU?=
 =?us-ascii?Q?jiat0PBzngVZgfkvNpY7qk5JjhS2tv+W/eW6GkuY9vmuySH0t/EIQN2Ls4Yw?=
 =?us-ascii?Q?CuX1hJQmlDUA9QsE3IO4pEQPAeRjjWa75dmMbDo7zuoAmk02VHZ0ccfPvxiL?=
 =?us-ascii?Q?fumrNwpHR5m6U/TlUu/qUtTSwETFNaT3V4TWcIm+sG80Jp5ZLhobibaUYDwg?=
 =?us-ascii?Q?Qpw8XdVq+N7Jn1uUfF5YW4X5GsyFlwqJUSPODNsHRigTwKeU+rlFZXilWtlm?=
 =?us-ascii?Q?ZM1GLqXJbphESkGUs5+ehcYGybkCmhsDyHtP5KT?=
x-microsoft-antispam-prvs: <VI1PR04MB4542AE132C76F9B25B3BC341807B0@VI1PR04MB4542.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(7696005)(105586002)(6506007)(3846002)(102836004)(68736007)(6246003)(6116002)(186003)(76176011)(4326008)(316002)(44832011)(52536013)(33656002)(476003)(54906003)(486006)(110136005)(55016002)(53936002)(25786009)(9686003)(99286004)(71190400001)(71200400001)(6436002)(14454004)(26005)(106356001)(11346002)(446003)(5660300002)(74316002)(478600001)(2906002)(14444005)(256004)(8936002)(229853002)(8676002)(81156014)(81166006)(97736004)(66066001)(7736002)(305945005)(86362001)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4542;H:VI1PR04MB4222.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7fNvp6jsFgmZN1mGya3MbaYjzIJykGiIykeq+q7AisiEbJu6/NJOGZkeICL6dpf2QucLL0RQWTtV/uLcdXrz5QXRYvO0n438UW0qen98EWWVWQQppAiK3Da+Uyzi6hjFGZrfHxxKcYP347Md1yLqLa/HE2C9sDSN50w9yQg/1co2Ieg0HANLmnpgOE029T1HEHXuH0lTfRZG1Q5GNludlAgq913GFgHgsDyFshYOv+owk/I6ZNg8mnco/p1ZJ2fdBr8+ri+5NWh6OpnuVJbwBkINzquf2rgdtkEYtSFDtioy6iJuHgHw2FrZQzRN+sqPMdlAM+dmqRy27lCmDikmcOG54k+FOR/JIK9dlc05g6/dK0gYEGqdo6H+MtJ2e3Elv41i1JQWukNMZxMVbpT3JYqY2zpvt7M6I7hBvvlqUZw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d9448f-a98a-4e3c-38d6-08d69be211b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 12:00:57.9502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4542
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> > On Thu, Feb 21, 2019 at 06:38:30AM +0000, Anson Huang wrote:
> > > NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as system
> > > controller, the system controller is in charge of system power,
> > > clock and thermal sensors etc. management, Linux kernel has to
> > > communicate with system controller via MU (message unit) IPC to get
> > > temperature from thermal sensors, this patch adds binding doc for
> > > i.MX system controller thermal driver.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>

You need drop the former Reviewed-by once there's significant changes.

> > > +Thermal bindings based on SCU Message Protocol
> > > +------------------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible:			Should be :
> > > +				  "fsl,imx8qxp-sc-thermal"
> > > +				followed by "fsl,imx-sc-thermal";
> > > +
> > > +- #thermal-sensor-cells:	See
> > Documentation/devicetree/bindings/thermal/thermal.txt
> > > +				for a description.
> > > +
> > > +- imx,sensor-resource-id: 	Property array to specify each thermal
> zone's
> > sensor resource ID.
> >
> > If this is an array...
> >
> > > +
> > >  Example (imx8qxp):
> > >  -------------
> > >  lsio_mu1: mailbox@5d1c0000 {
> > > @@ -168,6 +181,12 @@ firmware {
> > >  		rtc: rtc {
> > >  			compatible =3D "fsl,imx8qxp-sc-rtc";
> > >  		};
> > > +
> > > +		tsens: thermal-sensor {
> > > +			compatible =3D "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-
> > thermal";
> > > +			#thermal-sensor-cells =3D <0>;
> > > +			imx,sensor-resource-id =3D <IMX_SC_R_SYSTEM>;
> >
> > then this example should have an array, to be better express how this
> > is supposed to work. Can you please resend this with an array instead?
>=20
> On i.MX8QXP, there is ONLY 1 thermal zone available currently, but the th=
ermal
> driver is supposed to support multi thermal zones as well for i.MX8QM, in=
 V9
> patch set I just sent, I use the " imx,sensor-resource-id " element count=
 to
> determine how many thermal sensors will be supported, so that we can also
> get rid of searching the thermal-zones' child node, I improved the descri=
ption
> as below, is it OK?
>=20

Device tree is used to describe HW.
#thermal-sensor-cells is less to be an optional parameter to me.
If HW supports, then it should be 1 and update the example accordingly.

Regards
Dong Aisheng

>  41 +- imx,sensor-resource-id:      A single integer for single thermal z=
one's
> resource ID or
>  42 +                               an array of integers to specify each
> thermal zone's sensor
>  43 +                               resource ID.

