Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E998C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2C12146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XHDV7mp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfBTGhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:37:53 -0500
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:44686
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726629AbfBTGhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYcSBU73h3bsetvxWc9hflX+f9X5+Ay2aJtW9dGL1/w=;
 b=XHDV7mp35ngD3V+uF34Zjvpi4aL2RqgDmeJljSxae98lDl25d/PviRYq/TKstS52q5BpWXmnaFPjf7BoDGjYs0DCDCKvE9SunZRqg3rFhtIp2vt7YeP/PO3CrOh8uBITusb+C39FY+DyOfsmy1FDo6NtaRI2aWiBMaynPnBKwDQ=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB6040.eurprd04.prod.outlook.com (20.179.6.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 06:37:47 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 06:37:47 +0000
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
Subject: RE: [PATCH V3 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Thread-Topic: [PATCH V3 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Thread-Index: AQHUuTt8PgNPpOmrA0+KGlk6eJo216XazA+AgAOYwACACfX6gA==
Date:   Wed, 20 Feb 2019 06:37:47 +0000
Message-ID: <AM6PR04MB421536C38BF72B8739485304807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
 <1548921464-28917-3-git-send-email-aisheng.dong@nxp.com>
 <23f5f2f0-79b8-b9f7-9f46-972966563596@arm.com> <20190213222952.GA4814@bogus>
In-Reply-To: <20190213222952.GA4814@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 576d6a34-5bbf-4208-235c-08d696fded98
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6040;
x-ms-traffictypediagnostic: AM6PR04MB6040:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR04MB6040;23:Cda21D/+tm8EGyazBi23SyslW/LtaHzpHsSBK4S7r?=
 =?us-ascii?Q?KvgEodoETzRQ0+1Ol2TawZ91Z+s9+oP+yKMI2tsn46HS01oH4bcU99td7HG5?=
 =?us-ascii?Q?8Yu3SCdDFD8jwUFC+Ml9NMbFSTgZfS2Hbk1AlTu8ClMZ182+5pUfwUWALWda?=
 =?us-ascii?Q?B87sp0rVX+6i/A+3NgyaU0C+3/C9lvl+BPW/DOvIOZCHEG/iGIPlrqZ9n1Kl?=
 =?us-ascii?Q?+K6BpkpzHPo9NZ9h93xLbw8QyuDzyyjalt+bcl4tAmPqhpXklX++pq7hz+Uu?=
 =?us-ascii?Q?6YfnbPZwTcTkQxVMSycbxZnHvrt5xQG74MriH45qSQNScQUiP3SvdV9Kz9ZV?=
 =?us-ascii?Q?5ox1Yb+1vBlRq7uBE6BloGW3L/H82H+qHAXX28RwzZe9CNwZwe6+2rxxQ8S/?=
 =?us-ascii?Q?tNtgYkRaQAPBnrIaA0TiGDLSEOWFxsgu2srBkaD0D/9yPHyyCfw9IQAb9sD4?=
 =?us-ascii?Q?pqVFMbwkmUt8sWMGRYH10IiKwzkkAo+UcSHc3FpDUeoqb8sq/FuUl49EI8XB?=
 =?us-ascii?Q?75g+zBeQYo3BnsPjPc+Gqg5/rE1hyFJsZ2jaIj7jRU9yvkfc8o8kuX1z/g3s?=
 =?us-ascii?Q?/zcJCpnP1Rk3en2qNtxzPQtn2yxWMqOGxEcy/yA3u7DvtlqtMPGCUTxFzrJ4?=
 =?us-ascii?Q?9Tb7sq2RHg81A7LfTBYyR5a31cZ+HBmN8XeSd4jbiv85gcvaWA5r2We6mEdw?=
 =?us-ascii?Q?2avrXK37aE8tayO9FdNntqNhXD+DJUw04RLjqi0qjytMAc6zqmjRbn9meYCk?=
 =?us-ascii?Q?4toPJaDffu4EI4HnqBIg+NMWSbzKti8ZtbjSSrBfhq5Y0fkzbiJB3LfpBChi?=
 =?us-ascii?Q?XPHmuO4ObFt6O2+T/HyTAHK1C14717/qTffip6e/v06siUjG7A02jqLZF3F8?=
 =?us-ascii?Q?FXbmZu4dFniSqhXp72lgAbEhUzOYgYZF2n0yQuWyLC0TvG0PNkuO1orhCXHb?=
 =?us-ascii?Q?HduvxwYrgxyI09e8/cfdqaIfcOo1N8LpORL/uxo1qqxeE1e3SffeUh1mvcco?=
 =?us-ascii?Q?Dp3TmQflG3wGeBl+msCMbXtstz4YmN6lHhbWae37A0XNSBcJxZqXq4VD9JrN?=
 =?us-ascii?Q?V/wxt166woJCtezM3LUDq8hX7ysBJLUI2bgy4r6iT2o9WYTsD5Dn0m2ueuwA?=
 =?us-ascii?Q?KbQh7K40U34bi/wz0xgvhMxDdsG8QeDJEtJaAJjZsVyAbtUfO67hhxHDWQxJ?=
 =?us-ascii?Q?RWmgPDUzzOn33xWvL+q5A6mfesUKLwf7zIJ6Xs0+OTYsFCjVJzRMcsaq+DOl?=
 =?us-ascii?Q?qIVhOV4gj3SoVH7v9j5Ej4EPexDXTnWbPYxRAinqRvFs6Swo2Ysnch3CND9F?=
 =?us-ascii?B?UT09?=
x-microsoft-antispam-prvs: <AM6PR04MB60408DC1675E66E557B56FEB807D0@AM6PR04MB6040.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(54534003)(54906003)(4326008)(53936002)(53546011)(6246003)(186003)(9686003)(25786009)(316002)(102836004)(5660300002)(86362001)(6506007)(478600001)(26005)(55016002)(66066001)(71200400001)(71190400001)(7696005)(81156014)(486006)(81166006)(93886005)(256004)(8936002)(229853002)(2906002)(7736002)(305945005)(11346002)(446003)(476003)(76176011)(3846002)(6116002)(74316002)(99286004)(97736004)(106356001)(8676002)(68736007)(105586002)(14454004)(110136005)(6436002)(33656002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6040;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D3VINvihY/9jpNCsq6xztD7drrTjqxvOd26M40z3ipxBEPmnDz1/FFDgjTwnCYmud8BVfd8/hpZebB1AAPThpWAwVDg+eTD380XCzBtoGIpwC1lATGpd5+UrveL2PQtnw++8J+vMtsTaR/xl64KeG8GSdXNhEgh05sobhm8rqhII2Mhb2QhNUIF9QlZt1hJdbRK/Scj/q/OlskxzAQE2B6k7lwsDvP+hGhmQakjXf5Kn0EGM5gsk3UhzFNYTl9anZtFDrNA7HjgMvJOmDEW6fEgyN7EnzFSr87UzKFMYBjnLc8TWI+QMpucuFp1N4o8S672iNiCDdhyAPpiv8BuCgJ6AsZyvWSoZ3pqM7P+i9xxctpLuFFvLtdaxDKrLFXpRwJW5dOoJVxDvooFg/wmY1UqPLnZ5qxjINHLRK7lnwME=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576d6a34-5bbf-4208-235c-08d696fded98
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 06:37:47.5596
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
> Sent: Thursday, February 14, 2019 6:30 AM
> On Mon, Feb 11, 2019 at 03:34:23PM +0000, Marc Zyngier wrote:
> > On 31/01/2019 08:03, Aisheng Dong wrote:
> > > One irqsteer channel can support up to 8 output interrupts.
> > >
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > ---
> > > ChangeLog:
> > > v2->v3:
> > >  * fix a typo
> > > v1->v2:
> > >  * remove one unnecessary note.
> > > ---
> > >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt       =
 | 5
> +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqstee
> > > r.txt
> > > b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqstee
> > > r.txt
> > > index 6d0a41b..582991c 100644
> > > ---
> > > a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqstee
> > > r.txt
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irq
> > > +++ steer.txt
> > > @@ -6,8 +6,9 @@ Required properties:
> > >  	- "fsl,imx8m-irqsteer"
> > >  	- "fsl,imx-irqsteer"
> > >  - reg: Physical base address and size of registers.
> > > -- interrupts: Should contain the parent interrupt line used to
> > > multiplex the
> > > -  input interrupts.
> > > +- interrupts: Should contain the up to 8 parent interrupt lines
> > > +used to
> > > +  multiplex the input interrupts. They should be specified
> > > +sequentially
> > > +  from output 0 to 7.
> > >  - clocks: Should contain one clock for entry in clock-names
> > >    see Documentation/devicetree/bindings/clock/clock-bindings.txt
> > >  - clock-names:
> > >
> >
> > I'd like an Ack from a DT person, as this is a change to an existing
> > binding.
>=20
> It's fine as long as old kernels ignore extra entries and new kernels sti=
ll support
> a single entry. Otherwise, it needs a explanation.

Yes, it's like that. No compatibility break.

Regards
Dong Aisheng
>=20
> Rob
