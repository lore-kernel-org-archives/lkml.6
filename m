Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321D8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5E12192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j9Gw3aw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392225AbfBOOlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:41:52 -0500
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:60048
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387515AbfBOOlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U7gU+TLwJ9yh/IZqBptRDOJ4Njji7BTTzXJKb8fOIg=;
 b=j9Gw3aw0oU4wgp7e2sQGuzaT6adMO8hl+L8XbsKBxp/K7lvetbNSo0KwTsY1t+mIs2d/gkWpAp7LuZfvyGSQ2RyqkrisgE6NgHPOZc1MckDP4aHLp5siScbaTtoQuSqOKI0FUfNQjeRKQ4fzoZ91TYNENWYJ6U+DfXBzM/evCUg=
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com (20.177.49.153) by
 VI1PR04MB4174.eurprd04.prod.outlook.com (52.134.30.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.17; Fri, 15 Feb 2019 14:41:47 +0000
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::3d48:4560:6982:4c32]) by VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::3d48:4560:6982:4c32%3]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 14:41:47 +0000
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 3/3] enetc: Add ENETC PF level external MDIO
 support
Thread-Topic: [PATCH net-next v2 3/3] enetc: Add ENETC PF level external MDIO
 support
Thread-Index: AQHUxRa2xfAoHsNatECZeGrGwDGmUaXg3FCAgAAPfPA=
Date:   Fri, 15 Feb 2019 14:41:47 +0000
Message-ID: <VI1PR04MB488080895C871B6B3ABA571D96600@VI1PR04MB4880.eurprd04.prod.outlook.com>
References: <1550225414-12125-1-git-send-email-claudiu.manoil@nxp.com>
 <1550225414-12125-4-git-send-email-claudiu.manoil@nxp.com>
 <20190215133459.GH5699@lunn.ch>
In-Reply-To: <20190215133459.GH5699@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=claudiu.manoil@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e18b633c-c1c1-4738-bd77-08d69353b6c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4174;
x-ms-traffictypediagnostic: VI1PR04MB4174:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB4174;23:HGabyH9cr78tsrJyumilkISD8DSaQK4Na/2MmrADl?=
 =?us-ascii?Q?i+oPEyC10HpGkYkFgoDuCehNSTvP5I5c+0kolXwFNiRXzfXE5NCoeDR9LYab?=
 =?us-ascii?Q?KWTe8yS6sPLvUFWaZsk0jSQloSiS9zrgxFYrmZTQsM0uSM5wedZvWT1WvfuE?=
 =?us-ascii?Q?SvLZEXHx/o/LXpvVrv84dV/0EEI2ohnC6WT4CZs7H0KmSncuj4jN3aS7WJHN?=
 =?us-ascii?Q?cduYPQjCji4WMb9iapDAuM1G7HhQdd6073I1VcNGpwvpdRWqnMgpTnY4wqCp?=
 =?us-ascii?Q?dYY1K7lIVNWLN9nKtDpwBA/yx0lwjQuX8ob5tolRupyB16Uo/OYsrhtyow09?=
 =?us-ascii?Q?9/x/CiRqDjqXdLWHUuUCT3EJjAm9jkellEageKdpfe0FZRSZ0AW2YXhiH13t?=
 =?us-ascii?Q?8o9J2qPVSLtX9cjmgaInGAGVTtxZv9cuq8E7m5RJqJaNSoGRYIsTlQR4d4/J?=
 =?us-ascii?Q?wmx9MnbMcMAxCT6a2IEUuGdrBVF2tqwkJPL7DTOR6IyqnvBL0lUDQxE207dR?=
 =?us-ascii?Q?zAPGVcOwQW3xJi20Ro/MyAEB4YCZ+4D2ULZZlfI+RWBvo1R2dfvxwaSjwU4N?=
 =?us-ascii?Q?PNTbENl+foiq+wbQefAKi66DZLVO3Xn39i3VimAFMpS+4eWejyx4qRt0r4MI?=
 =?us-ascii?Q?FQnB/R+E7EcGhyhaYmTYZ/0nNhjzeGj/IFd+0PPuxYbYp0m3TSN4AtAB+lZo?=
 =?us-ascii?Q?dVM1dQVI8nU76ytz5q7t/jtQ1FnQV9lQRmr0/UzAIFm34BO86fN4UktsUQdB?=
 =?us-ascii?Q?+NXuChburA1QlEZ9FX1O3EClIMrJVG4ivKb+MtHS/DncN1ue2Fc2l9sKwgzR?=
 =?us-ascii?Q?vcQe9v5Kha1H1vl1dR1I9G17O/UsjiwtI4no6KOYgrr6ekbearp5HeUpa19E?=
 =?us-ascii?Q?v4hHeaTGQ3Wt05Pa5K3PCojR7FBlJpZzI9bUaSGCXM2YLhik08jz914vHlyD?=
 =?us-ascii?Q?ohwccGYv2fnqh4mh//pTcr6Keva3LRXIRK8kuNMP6ytZGuAmIfTCg3Nt2Osa?=
 =?us-ascii?Q?3GhOge9PyDDA7KmCR6frm8EqJG5QpB51BZrA8fJeIyIP8KFUKUQDI5WfttTL?=
 =?us-ascii?Q?vCJK1aoYdIhcQ+f/AS1CvLn5HNc+IJoEssxM5tcKxY4uUKcrFb9oLNqk68of?=
 =?us-ascii?Q?Y3xioPr0iUgX91pK51/xKpFnLCQd3xCWlfU7h5N5cePBq4zIxI3AHe8iu/K3?=
 =?us-ascii?Q?/Z8VAR8VEcKt8CbQGrxLXwz5ecMsY6DAEqq?=
x-microsoft-antispam-prvs: <VI1PR04MB4174D6E2E2AA227D7FE4E97196600@VI1PR04MB4174.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(366004)(199004)(189003)(13464003)(8936002)(6436002)(81166006)(8676002)(86362001)(68736007)(305945005)(81156014)(6916009)(478600001)(54906003)(6116002)(3846002)(74316002)(316002)(102836004)(6506007)(26005)(186003)(99286004)(7696005)(76176011)(14454004)(25786009)(256004)(11346002)(486006)(4326008)(476003)(446003)(105586002)(33656002)(55016002)(9686003)(106356001)(53936002)(6246003)(97736004)(71200400001)(71190400001)(7736002)(44832011)(66066001)(229853002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4174;H:VI1PR04MB4880.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QdsvHuRuRi1DF9v7DGLl2qYGnYPjNpj2IRzdHCGqZyzjIFwjLU3XGR9A9U84+8SrWqAV43qfYg+irNReW+AtIRNKJaQfGXu88jkwBbnVbI4RX1jo3V3I1G1Fs/E2fzUjokv32KQFlk1RV11B9MZGO0c1hi72+ATJQzeWxf9gIKJUUjdy7QpzNWWD3Ncj00LgPUs0f82xN9aSG7OaGRQX0EGWkB71YAyGEyBDhm0KytDsMCTN359+ZZaF9aNRXgmoiFGxt1Q1MF0E1GztVxJ/zEDLOdhBp2/TalSo4Bbr3vM4kDlRnIO31HGyVrYO9aIgmF9/ZKYk8XZjRZe3T6UtsM8u9rjUFj2i96jzxpTSuRIhUrWcB923GRa1MAMuO5YRXJ1Gc2cxWyaIRTlHG51wMdS7oOA7z9vU3QlOmHe9q8c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18b633c-c1c1-4738-bd77-08d69353b6c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 14:41:47.6066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Andrew Lunn <andrew@lunn.ch>
>Sent: Friday, February 15, 2019 3:35 PM
>To: Claudiu Manoil <claudiu.manoil@nxp.com>
>Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; David S =
.
>Miller <davem@davemloft.net>; Alexandru Marginean
><alexandru.marginean@nxp.com>; linux-arm-kernel@lists.infradead.org;
>devicetree@vger.kernel.org; netdev@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH net-next v2 3/3] enetc: Add ENETC PF level external MD=
IO
>support
>
>On Fri, Feb 15, 2019 at 12:10:14PM +0200, Claudiu Manoil wrote:
>> Each ENETC PF has its own MDIO interface, the corresponding
>> MDIO registers are mapped in the ENETC's Port register block.
>> The current patch adds a driver for these PF level MDIO buses,
>> so that each PF can manage directly its own external link.
>>
>> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
>> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
>> ---
>> v2 - used readx_poll_timeout()
>>    - added mdio node child to the port node
>
>Hi Claudiu
>
>Please document this in the device tree binding.
>

Hi,
I don't really see what bindings would need to be documented, as the node
names and properties used so far are common.  Like, the "mdio" node name
is common, the enetc ports are "pci" nodes, nothing special for these.
What's missing?

Regards,
Claudiu
