Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91A1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72752148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netmodule.onmicrosoft.com header.i=@netmodule.onmicrosoft.com header.b="KTDaavfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfBUHxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:53:45 -0500
Received: from mail-eopbgr10105.outbound.protection.outlook.com ([40.107.1.105]:17680
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726779AbfBUHxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector1-netmodule-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPeYQZJBeY6B6zBM1ssl8Sf1UsG+FTlK83vlGcVXNrc=;
 b=KTDaavfLr/iX/qbY5kuY9U2o1NKc+DGZFEqLxh3ZjwuMMuiT8ccGiAY4Lqgi+N3qdgBFl22SpX/XbsPq86P5b4JX1WfS6OF0uXWcSY1LFaGBYvI3exG//mkjfIFsQpV7QXdJewzI5nBnPcJUhoBunoo6xzwAo2TcddNml85ZRhw=
Received: from VI1PR06MB5902.eurprd06.prod.outlook.com (20.178.123.205) by
 VI1PR06MB4525.eurprd06.prod.outlook.com (20.178.11.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 07:53:36 +0000
Received: from VI1PR06MB5902.eurprd06.prod.outlook.com
 ([fe80::2d9c:550:bc51:d69a]) by VI1PR06MB5902.eurprd06.prod.outlook.com
 ([fe80::2d9c:550:bc51:d69a%5]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 07:53:36 +0000
From:   Marcel Reichmuth <Marcel.Reichmuth@netmodule.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] net: dsa: add missing phy address offset
Thread-Topic: [PATCH] net: dsa: add missing phy address offset
Thread-Index: AQHUyUgzULgH1qu5306pO+2T82cCJ6XpEgIAgAABJgCAAM9dgA==
Date:   Thu, 21 Feb 2019 07:53:36 +0000
Message-ID: <20190221075333.t7vikxznp3l6ello@debian>
References: <20190220181426.2970-1-marcel.reichmuth@netmodule.com>
 <d4e6e37b-01c2-3141-8e30-b7e8c252c0ef@gmail.com>
 <20190220193122.GA5302@lunn.ch>
In-Reply-To: <20190220193122.GA5302@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20170113 (1.7.2)
x-originating-ip: [185.130.140.44]
x-clientproxiedby: VI1PR0102CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::43) To VI1PR06MB5902.eurprd06.prod.outlook.com
 (2603:10a6:803:d7::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceeb1a8d-0cc8-46a5-b464-08d697d1af00
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600110)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR06MB4525;
x-ms-traffictypediagnostic: VI1PR06MB4525:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR06MB4525;23:0LA69pJy3f0di7+tgSIpSKHxuRvb6yYeLBYhYby9Z?=
 =?us-ascii?Q?+YEJGcbOs/wzKfvvMoidxKzwpetJoTvqeIp73VA+gpm1z0f7ujddrCpeFnL3?=
 =?us-ascii?Q?G9On8eS0Keggc0A3DLwpvOKrqM/6TES7rnI8p9HuIJZSuzgg5zLGvwFsCpFL?=
 =?us-ascii?Q?KQF3RiKimq3Xx+PClNhwgMJDMswdbCVuvzp08T3xd+Z26gLP6M5vrL9XmYMH?=
 =?us-ascii?Q?eVyN2XJP525LQh9ORHiee0/73+w4YFc64grcSOEHoWagUKBaxHci6RFRpIbF?=
 =?us-ascii?Q?4m/7FaeO/RmHclmRmo2tfn1vezKW2I3v2xzSoIipA5X03soBpEqnauKHb33g?=
 =?us-ascii?Q?h1v6PwT/6jDcllNed7FtR+WRZTM+yZfeAaFhhl4ZmxZ9JxOeBFwQMn7+B5fw?=
 =?us-ascii?Q?DTgauPDVyCkAhax8cM1qAiGtsUoGBnHu2iaCbeXi2ycbQOu6bYtk+pIcxPUn?=
 =?us-ascii?Q?tv7H1JtKH9ghSO7Mh51W7C85awSuvn14pHaRT/VJmOkm5KbDWSLAA0gOdpBw?=
 =?us-ascii?Q?rEzUqW1lU2Be3tSWf7hZEPL5O4rkE+FcQ/IyCobrWKiSIJIWYJIy5hT3KZQT?=
 =?us-ascii?Q?qICJgkeFle4L4Yp4LBZqijI3abgQrobCZGkh8ncPdo6rgqt19k/F2Sfq/dHW?=
 =?us-ascii?Q?8FFCSyvVW2As3ImH7tFt6e+nsIMEC1DhuxCiB7CSDQfhJH/h2QfgkvKVY2Bq?=
 =?us-ascii?Q?aq5Dgks+cFLbDQjklrncQqu1P7MRW4W3SGGTc/wgntMJk/Ts6PhjTTDX/pQ2?=
 =?us-ascii?Q?fqpaQrzTYS6397YExpU9H04XfH6ucUryXU6WXsg9v4yVvU0RlKIor6SGkwbX?=
 =?us-ascii?Q?5Es4jjK03MMvg+SzLBhmWJdLJ4xTC0lRBhEUU2VnzdZM+k0Goq98zKmqtugO?=
 =?us-ascii?Q?S4hQLcyJG1CWIuDm8LjkL/+pUXRcuWmDa5t8hvFOhbmdGSC7DI9lpyqFJ57F?=
 =?us-ascii?Q?Tln8HGx3Eui4EW9zfYAWWV5bzgramHOB5ZuRj226uqEC9QDOf7QFgPaKFg13?=
 =?us-ascii?Q?d9AMyi1ZMO87+WLGSe/wkgOTUi3Veo5ZEo/gY05gNsKsdWehTmxEtvmGjcWr?=
 =?us-ascii?Q?qb6sDQCWTffTv6AcsvqirznQsKIBptmTT0eSuQhcKgeNnIUT8tLa9HPO1wcS?=
 =?us-ascii?Q?qGX4YnFgYd6XI6dmdfBrPQBh+z9wSmocgdl2cL6k3oHcOWfJ0u3FHkUy+o9l?=
 =?us-ascii?Q?pLd0ZbswJyT2APmqhku8xyjQ3DDQ5h8H2oz/8ESxTCzq+xyoI6DgX7rNCYlk?=
 =?us-ascii?Q?nOk4aNAD21/TegESGAKzLASR/mf8uszVTlK5AP45Vrgy3CimvRmRmD131HBF?=
 =?us-ascii?Q?N10Gsv+LT53mAisv1xcQTzzKUGvK/4nWfy4l141Ix/sACcyJ8L7aS2RN+EUi?=
 =?us-ascii?Q?Z8RdQHrdZETu+SpPgaUh36ptKk=3D?=
x-microsoft-antispam-prvs: <VI1PR06MB4525493E69AE4BE4EFE03AA19B7E0@VI1PR06MB4525.eurprd06.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(39840400004)(376002)(346002)(136003)(199004)(189003)(486006)(6246003)(4744005)(86362001)(8676002)(81156014)(81166006)(68736007)(476003)(7736002)(53936002)(106356001)(44832011)(14454004)(386003)(105586002)(305945005)(2906002)(6116002)(256004)(446003)(5660300002)(33896004)(76176011)(3846002)(11346002)(1076003)(71190400001)(71200400001)(66066001)(8936002)(97736004)(52116002)(508600001)(99286004)(186003)(4326008)(72206003)(6486002)(316002)(6916009)(25786009)(53546011)(54906003)(102836004)(58126008)(6346003)(6506007)(33716001)(26005)(6512007)(9686003)(229853002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR06MB4525;H:VI1PR06MB5902.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netmodule.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Marcel.Reichmuth@netmodule.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HSc5NOZN9etsfTGPCcYr19VH169bvM/EejB6sUa/+TYNksciL/hoPyr0KaanW7ZPEcj8Lr6tLHnMvY1nKJgPgOvR0RZdMZ9mxxL/DHFnNcmHBFDEiAn7xMdSBO5MAUl9+hKRv61PvygJtUFcXgQpqPMWuWITm6CRAizEq0tbirBIrrWnaNoTOSRu6qD1SDGsafNVdM8mgdn+d9H+Da6zuXKsZ6lt695PLFmochYRnSSt03MiiaGm6ceCUtKAZcwUdb9CQfE5Q2KubfKowBNB/nvO3PfhooZVfk96cK1EcIVZLqXJIqOLADE7hWiIrwO/hwjcXDzU//LuQypN69D1gMaFwBho3v8GizBB96DKP5BgULZiQxOOqBsWpf7OTdyqUyohvmotiuEnXq0ahGcvq/hIksWi3Yup/X5dhXerBKc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <72778CC4B0539149A435FA5D0F496D98@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceeb1a8d-0cc8-46a5-b464-08d697d1af00
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 07:53:35.7070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4525
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 08:31:22PM +0100, Andrew Lunn wrote:
> On Wed, Feb 20, 2019 at 11:27:16AM -0800, Florian Fainelli wrote:
> > On 2/20/19 10:15 AM, Marcel Reichmuth wrote:
> >=20
> > You are supposed to describe the port to PHY mapping using the binding,
> > so for instance:
> >=20
> > ports {
> > 	port@0 {
> > 		reg =3D <0>;
> > 		phy-handle =3D <&phy1>;
> > 	};
> >=20
> > };
> >=20
> > mdio {
> > 	phy1: phy@1 {
> > 		reg =3D <1>;
> > 	};
> > };
> >=20
> > etc. is not that working for you?
>=20
>=20
> The Espressobin does exactly this:
>=20
> arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts=20
>=20
> It also uses the 6341.
>
Thank you very much for your hints. Yes that works indeed too. I
just assumed it was intended to work automatically with the=20
built-in phys as it does with the other switches I am using.

