Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA66C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C2D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sIr5MJj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfBTGhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:37:11 -0500
Received: from mail-eopbgr20088.outbound.protection.outlook.com ([40.107.2.88]:58857
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726629AbfBTGhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tONR45tNJhx9H8beOwM2lxRSNLX78lZ8C7Y6AXx2fto=;
 b=sIr5MJj9nuA45ERgP/bKcQjh11CJ6TBdF9RaBRH1YRKSr3wtP5II524pIQripJHGEU3dYDjjV/Kj3yIgCQoY6/wB1jG3PAN6tgyaAhjBvHok8IYq2OfWhvQTubMrsGUpuOraCLLJ6HGVkcHy3B0pqFO0kWLC4bp/ojOXrn7P8DY=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB6040.eurprd04.prod.outlook.com (20.179.6.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 06:36:27 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 06:36:27 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Rob Herring <robh@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH V3 1/4] dt-binding: irq: imx-irqsteer: use irq number
 instead of group number
Thread-Topic: [PATCH V3 1/4] dt-binding: irq: imx-irqsteer: use irq number
 instead of group number
Thread-Index: AQHUuTt5Spk4kSNY5kK4EHnWuE5BYKXazGsAgAOXlwCACfaDgA==
Date:   Wed, 20 Feb 2019 06:36:27 +0000
Message-ID: <AM6PR04MB4215574A539086C4B0386A01807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
 <1548921464-28917-2-git-send-email-aisheng.dong@nxp.com>
 <8db40cd7-7695-0267-c626-26ebe086b2b8@arm.com> <20190213222700.GA31052@bogus>
In-Reply-To: <20190213222700.GA31052@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b818746-6c0f-476a-31c2-08d696fdbd99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6040;
x-ms-traffictypediagnostic: AM6PR04MB6040:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR04MB6040;23:av/pXP6huq25LMzS+49vJnFFnEME2P1rF22cTS0TH?=
 =?us-ascii?Q?csDqSTKcrQxhRWkfFm4qkEN2NJWL/VCF9l7uKQl8jRUSPaobuwy/9SbMPrWa?=
 =?us-ascii?Q?UJSDhnnwL8Ybpd+M9PppPnR524jWZdF7/iuOw0THrbe/xyEhD5HUhV+TpESF?=
 =?us-ascii?Q?2dv4ZsbIQObRs/SPEIaz2KJVPVtn8gz0cSQpWkof8cce1rfPOrM7verznukJ?=
 =?us-ascii?Q?/PtmwUX3dMh0PFPzJaG1C7HWvw+UW0WilN2bj3x5cPB0b6kHg+4XZigz3sXv?=
 =?us-ascii?Q?0GCmIf5bf0V0ZH0ZkQ1qW/BwLRrHO/wxxwKguQ3i+1Dl3tCkwjt8kIGbqmUe?=
 =?us-ascii?Q?k1ksdI5/vrcCF+cjHpY1UZbLz4kbwroCmNMsuZ/0FSYRmJHmcDUqioXdVOHQ?=
 =?us-ascii?Q?hnMK5HvG2Q/Gtn+DNOgMHkxXnqiecjrKQy20O/1/pSl5kE5wFyv3P61yabtQ?=
 =?us-ascii?Q?GE5KiC0CieNNxqaP0UrlCBwbeuIbUj87JHMHKsLnyLB67GJbszlcyWMMw0ED?=
 =?us-ascii?Q?ei7nfx+08PS5jjeOuL7FgF6PTbwPwi1HhzrwfwpW3PuSwTQXu1G2izBOSwwY?=
 =?us-ascii?Q?wKFGP/o4l2UgR+CLF39VWgHeFmHSIUxn5cx6PJUgA7fyHmAZ+h8Q6ysUrgZ0?=
 =?us-ascii?Q?6yC7SHkU1bTceE59bnvYwak68pvBBRtgMF9OMPcQQlAFwdRIc1R02PqfTPoC?=
 =?us-ascii?Q?X4kW0n35RGjQyZKaPlO6VAkpSSDJyTXq0hcXOOSo5uZbahj7PGJBTQoYZuBl?=
 =?us-ascii?Q?p1bhVKjMk8nHXI8bwhkjO0F28CMXLl8/owV2hNShoOUa5yptu8P1CpIwoqnz?=
 =?us-ascii?Q?8JXFr8Uy4k/NSDC40hGjpTl+YvemLVMNAgJ9AxngfDb4mh+Rrckw58KtiBmC?=
 =?us-ascii?Q?3bT7saDc9ER6qXjuEqxHDgGB+kHWTm2dY5ir8cmDJJWZYkzlsmWfsQCCOaLP?=
 =?us-ascii?Q?IJiNPcd6S+MUAbitMFgJJQozJAgnhG3l6sjQG6kTaKuf45VZy5o4rN+tFgcj?=
 =?us-ascii?Q?85/AAtlozPm+TLoBQnk7Z8rwGj5OZaU1pUMOIjvz+1w1GbqODjJykBTLqgCv?=
 =?us-ascii?Q?exA+urKSq9l3OII5WEqac01nI246GHuX8E4kmFEarvuMIzUqKw3tBGRXYJNN?=
 =?us-ascii?Q?Zpanoli4eLMD0goLRIB98P4ZCYUwG4KdOzuz3CgmreDZy3hLqljPP5zSKeVG?=
 =?us-ascii?Q?OwEYYbn7gasRtXowUb8eZV92NdRC5e75l9L97QiIAQ80Wwces2oNF5hlFsa6?=
 =?us-ascii?Q?JcaUDNEer1pi8cy83HMbuymd5ASUSFjsKSle58QjJCrRxb5wj13MFSCtxY0I?=
 =?us-ascii?Q?a99tDoGMItVbjx0xlneYvU=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB6040BF11A95D5F6FA17D0BB1807D0@AM6PR04MB6040.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(51914003)(54534003)(54906003)(4326008)(53936002)(53546011)(6246003)(186003)(9686003)(25786009)(316002)(102836004)(5660300002)(86362001)(6506007)(478600001)(26005)(55016002)(66066001)(71200400001)(71190400001)(7696005)(81156014)(486006)(81166006)(93886005)(256004)(8936002)(229853002)(2906002)(7736002)(305945005)(11346002)(446003)(476003)(76176011)(3846002)(6116002)(74316002)(99286004)(97736004)(106356001)(8676002)(68736007)(105586002)(14454004)(110136005)(6436002)(33656002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6040;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Omy4lASQRNgLk77cVndQepp9TaVocM+1qQSvhz95f5CoahjG5Hvb5omzrGVuTGJ968EY19CZi9nShoh/VvzbfVlUgYPuConySqw+ty94J40fZHi3UTUy9M7AHGMylCUUqTpzKeRoOEKYVTr3F4VbHPHAzN9DILpVQHPWhTdXUDrKJ05PQNdSfLLDHKhaf5laKOL6NSpBOulbxqkOJ2px/L/6/v+oLy1zAudqP+xZGSgOrxDHY33aUe754SaCtLVzpCv1DyLrK8x0Zg9//RN8LUJSic/CTEs0OLnaGyqKHgwNP7RIEN0r8ux7u0CN/sPstyHBDFTHRlZXu0jtMJ/vu/P89S1GQAz9nxUV2GLw7naXaYe3qnwiN1eoRvX/G75YwX7PabHAkoejDaE0xnM99tWXLJoFkRnyzLsgqJrR6LE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b818746-6c0f-476a-31c2-08d696fdbd99
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 06:36:27.0529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Thursday, February 14, 2019 6:27 AM>=20
> On Mon, Feb 11, 2019 at 03:35:40PM +0000, Marc Zyngier wrote:
> > On 31/01/2019 08:03, Aisheng Dong wrote:
> > > Not all 64 interrupts may be used in one group. e.g. most irqsteer
> > > in imx8qxp and imx8qm subsystems supports only 32 interrupts.
> > >
> > > As the IP integration parameters are Channel number and interrupts
> > > number, let's use fsl,irqs-num to represents how many interrupts
> > > supported by this irqsteer channel.
> > >
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: devicetree@vger.kernel.org
> > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > ---
> > > ChangeLog:
> > >  v1->v2:
> > >   * change property name fsl,irqs-per-chan to fsl,num-irqs.
> > > ---
> > >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt       =
| 6
> +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqstee
> > > r.txt
> > > b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqstee
> > > r.txt
> > > index 45790ce..6d0a41b 100644
> > > ---
> > > a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqstee
> > > r.txt
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irq
> > > +++ steer.txt
> > > @@ -16,8 +16,8 @@ Required properties:
> > >  - #interrupt-cells: Specifies the number of cells needed to encode a=
n
> > >    interrupt source. The value must be 1.
> > >  - fsl,channel: The output channel that all input IRQs should be stee=
red
> into.
> > > -- fsl,irq-groups: Number of IRQ groups managed by this controller
> instance.
> > > -  Each group manages 64 input interrupts.
> > > +- fsl,num-irqs: Number of input interrupts of this channel.
> > > +  Should be multiple of 32 input interrupts and up to 512 interrupts=
.
> > >
> > >  Example:
> > >
> > > @@ -28,7 +28,7 @@ Example:
> > >  		clocks =3D <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> > >  		clock-names =3D "ipg";
> > >  		fsl,channel =3D <0>;
> > > -		fsl,irq-groups =3D <1>;
> > > +		fsl,num-irqs =3D <64>;
> > >  		interrupt-controller;
> > >  		#interrupt-cells =3D <1>;
> > >  	};
> > >
> >
> > This is a change to an existing binding, so I'd need the Ack from a DT
> > maintainer before I can queue this.
>=20
> The DT maintainer doesn't care as long as there's an explanation that say=
s it's
> breaking compatibility and why it is okay to do so. This one doesn't do t=
hat.
>=20

Got it.
I will add them and resend, thanks for the suggestion.

Regards
Dong Aisheng

> Rob
