Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE046C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E8E222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GtYm8Ocb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392724AbfBNPsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:48:50 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:39832
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729127AbfBNPsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWo2BZPgKzdoy8iK8BCTcvCFR2LKt6xnOreozBjkilE=;
 b=GtYm8OcbDW807MiRS7xFt9bZivADSQDQCfakI+Zc2a6GZ7/njRxtO9fi1tPEoYkBPkbu8bftfDgaEARH/BAAzVtBBAaV98p7WS79E9mblCi6N9RSx4rpaiIVa7LBTWpJyJ+qS2htMhuEu6ho3M1antCAX7IxbTO26sMEPV1ylJo=
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com (20.177.49.153) by
 VI1PR04MB1600.eurprd04.prod.outlook.com (10.164.84.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 14 Feb 2019 15:48:45 +0000
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::3d48:4560:6982:4c32]) by VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::3d48:4560:6982:4c32%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 15:48:45 +0000
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 3/3] enetc: Add ENETC PF level external MDIO
 support
Thread-Topic: [PATCH net-next 3/3] enetc: Add ENETC PF level external MDIO
 support
Thread-Index: AQHUw4ulFN6tcoF1pUCxgbH5xFJWpaXeCIWAgAFlQ9A=
Date:   Thu, 14 Feb 2019 15:48:44 +0000
Message-ID: <VI1PR04MB4880C8E3E302C7D3856DB68396670@VI1PR04MB4880.eurprd04.prod.outlook.com>
References: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
 <1550055743-15542-4-git-send-email-claudiu.manoil@nxp.com>
 <20190213181323.GA708@lunn.ch>
In-Reply-To: <20190213181323.GA708@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=claudiu.manoil@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ecb3dac-6db1-476e-4a8a-08d69293e6de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1600;
x-ms-traffictypediagnostic: VI1PR04MB1600:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB1600;23:hdVtDHrzFUbnvThW5AbKZgbOqD7wTvPbSktrHFoKv?=
 =?us-ascii?Q?j2X2Z//q3gloyq2VRkZusX1G98ay5ZY1+543G+K1d8tUmaAqbcMdxQRHk7Aw?=
 =?us-ascii?Q?fWAwrduSqN9OxkIZeeEPNEpLBPDgaeVn/stPkkDAwChcy74oDZc5ZLc3Schd?=
 =?us-ascii?Q?W18ye+6yZDHPN3fDrHFjbYi0E2o4hlBnkBc7dmfX97jOVleP7ds+qGnoyURj?=
 =?us-ascii?Q?Bb6V14rIyPhavd+BSg3WPDD+qx3lo/W8G1dmlepbF0mgo/daKJeYOTs34eUv?=
 =?us-ascii?Q?jqP81Blqt2but7xycW66d+uc7w7w01SpbqDWSIJLPWoCND1d9Wxwi4YaokZ/?=
 =?us-ascii?Q?A3Ur09KT8zdfeyMPQ0ahUZzTd8IhsOB95KofVR4uKGVgNsUwMurmoiz4DuEf?=
 =?us-ascii?Q?wNaBA2FhVOkxeawdkh8rYpJoo2e/O1AG0UcCmNVBnYz6VoH4CuiaP9F+CDvx?=
 =?us-ascii?Q?DMdh9eMSSDW1OEbG508drRhKNH6JyOH2ahRGL91mIS7uSlU4aDQWwsiiGuBf?=
 =?us-ascii?Q?lyGnJvJvccyIiDXLhEs9HWZZ1YZUJ9zpGdWUDPCW+HseugL7gfpAAlj1lrcx?=
 =?us-ascii?Q?Bg4ECLNlS/l6bg8DT8FFNSaLZRq+LxE8k6QpwIfZyvLt8kMLA4fHAmuyj/wW?=
 =?us-ascii?Q?wWqSUyFaYAAmbUD5TFvwPcZ0GtwSXAiM8KUPGSJ2T9MDgn6mjbN9Fp9SS4NK?=
 =?us-ascii?Q?ivX1WIWY3uRpbHrv1S9JIREn0ZvyPvP/MbDjXe0eTq+oHplFlIFCk0qQNCJt?=
 =?us-ascii?Q?eYh/u5O682V9SrpXidWOJlqeXV6BbjtwXk8+j6MnHpAUJ7Jd5NjDWTO+5HY/?=
 =?us-ascii?Q?O5Jyh1rQC8ohu4zjUNCazby3oVp1iLXMMcnWie1MfoordcLDNGRwqQBU4qvN?=
 =?us-ascii?Q?ylVK6vDnOtyy6aaChKem/9enMfSLAtcvjK1xW5+U9g+wNYmc4hHelDQZMtN+?=
 =?us-ascii?Q?letgBtiMI++j6KG6wmUxPLycYHuKDubm+31xfj6yyUuLD0mjwznkX+IrGv1I?=
 =?us-ascii?Q?qxScUGxKBq+c5OUPNXP+SAwPiWv8VDP2CgsUu1niI55LjqwEsODK4Tv1kdch?=
 =?us-ascii?Q?8tz/zS3SeOSUbsvHv2Og1cjnEWvUmyi/acqiZC2CT4NS77QXycDPuf+uavZt?=
 =?us-ascii?Q?zbMulFcHhk7QwDauTi6HwtyNAovGqzGAxDN87SnbLTrj4DW4OeyGVnzBtcLa?=
 =?us-ascii?Q?57y+IAWT2HTKMbqyRpDYZ8b1+YhqVCjo8Bb9aE/qWj/FGwA6BfJaOLFtQ=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB16006586086E3186DFA5148B96670@VI1PR04MB1600.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(366004)(51914003)(199004)(189003)(13464003)(305945005)(478600001)(6436002)(7696005)(99286004)(105586002)(54906003)(74316002)(55016002)(2906002)(14454004)(9686003)(11346002)(446003)(8936002)(476003)(33656002)(316002)(7736002)(486006)(6916009)(8676002)(81156014)(81166006)(44832011)(97736004)(229853002)(186003)(25786009)(86362001)(66066001)(256004)(4326008)(26005)(71190400001)(71200400001)(6116002)(76176011)(106356001)(53936002)(6506007)(102836004)(68736007)(6246003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1600;H:VI1PR04MB4880.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JHFlQFl/hXZ40vdd077DNnzLoDflXsnT2zB3zAWH6Jf8/9Ts9BrrT5QjhPoz5Zs9jZ0BAYjQfBPJgsGHkLJJ5t3OdXYSdQDIozriF/gxzmHZdC1O4XOTlmDa+yFlNdcA08OYfyPNsLRnrjvGQ211N95/QrW0A0jHD9l1HJsb+ATPO0TlCeyw9z9pH1VHG8KiQovlpw3sAu+TzfyDX0R3odT7UXhhnyxgkoT6OAzXokU0yX+MrlkKZPhh4EjAtomLHEAcuKGDn/03W5kz8wnJYGEEnOxbo1TQLsSdZ75P2H6qzoJXaj2qj/6ffNbC9CAxowibNjtEf695+SSHvPXHJlx5MjFDAcUlWhjV7na/RD+ub3LMcJwPHh/QOnItxOLZo4WAMaExqDmxOK7k2egt/EEe7pQK1Fh9p8ftGBZMsOE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecb3dac-6db1-476e-4a8a-08d69293e6de
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:48:44.9558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Andrew Lunn <andrew@lunn.ch>
>Sent: Wednesday, February 13, 2019 8:13 PM
>To: Claudiu Manoil <claudiu.manoil@nxp.com>
>Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; David S =
.
>Miller <davem@davemloft.net>; devicetree@vger.kernel.org; Alexandru
>Marginean <alexandru.marginean@nxp.com>; linux-kernel@vger.kernel.org;
>linux-arm-kernel@lists.infradead.org; netdev@vger.kernel.org
>Subject: Re: [PATCH net-next 3/3] enetc: Add ENETC PF level external MDIO
>support
>
[...]
>> +static int enetc_mdio_write(struct mii_bus *bus, int phy_id, int regnum=
,
>> +			    u16 value)
>> +{
>> +	struct enetc_mdio_regs __iomem *regs =3D bus_to_enetc_regs(bus);
>> +	u32 mdio_ctl, mdio_cfg;
>> +	u16 dev_addr;
>> +	int ret;
>> +
>> +	mdio_cfg =3D MDIO_CFG_CLKDIV(ENETC_MDC_DIV) | MDIO_CFG_NEG;
>
>What does MDIO_CFG_NEG mean?
>

I'll add a comment in the code to clarify this define.
It means the MDIO is driven by master on MDC negative edge, which is how=20
the external mdio busses work on this hardware. For internal MDIO CFG_NEG i=
s 0.

 [...]
>
>Maybe MDIO_CFG_ENC could be called MDIO_CFG_C45? Assuming that is what
>it actually means?
>
You're right, in the hardware manual this bit is actually called "ENC45", s=
o
I'll change the define name to that.  Should be more clear like this.

[...]
>
>It is a good idea to have an mdio node which contains the list of
>PHYs. You can get into odd situations if you don't do that.
>

Hopefully this doesn't complicate things since these are not platform devic=
es.
It's not as easy as adding new platform device driver for mdio...

Ok for the rest of the comments too.
Thanks for the review.

Claudiu
