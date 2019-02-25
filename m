Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25532087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dCR3J02Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfBYJbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:31:15 -0500
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:51264
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbfBYJbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyU/YMSkZ6cKNpYrcvxajOFVGy76xbDViBzDKYg8/jc=;
 b=dCR3J02QJPAcHNrYZzKzqxuHTgX/Og3efkKCrq5ac3fu3rY00d0WMK89gOEFDLRJiNtRHB7xWe7d7fm/fp7OnnipM7mYc9JmeEmC8sIVZ6eM5TjgEE3g3Hij0lvPiU2F8Mr7ANYnjmuRJTT4iFcU0bm5HL4kSDhhLd4u6Zyl3u4=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6034.eurprd04.prod.outlook.com (20.179.35.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 09:31:11 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 09:31:11 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Chris Spencer <spencercw@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Abel Vesa <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: imx: Add generic i.MX8 SoC driver
Thread-Topic: [PATCH] soc: imx: Add generic i.MX8 SoC driver
Thread-Index: AQHUu7aVxVb7WzSFe0KD+xVLEa1s3KXwSAwAgAAaNQA=
Date:   Mon, 25 Feb 2019 09:31:11 +0000
Message-ID: <20190225093110.xl2va6jfov3wxbyk@fsr-ub1664-175>
References: <1549194583-7684-1-git-send-email-abel.vesa@nxp.com>
 <CAGUNXRTY0yKnLH1hnxiv5ydnWG2VKNzpY_4rZ2yRhj8_Jq9rYQ@mail.gmail.com>
In-Reply-To: <CAGUNXRTY0yKnLH1hnxiv5ydnWG2VKNzpY_4rZ2yRhj8_Jq9rYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a87c2515-7cbb-448f-367a-08d69b03faf2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6034;
x-ms-traffictypediagnostic: AM0PR04MB6034:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB6034;23:9MrNZdTC9un6s/8IOKssohKBBAV2ZBKdQ6ujO1Ok0?=
 =?us-ascii?Q?JeztyGedPnREi1y1HM5UjmfNFJ3KwNHzpaLZ3c5tk01DTtkcxIBHuLhdUI3F?=
 =?us-ascii?Q?ypay5JR9kaqvVleHNgFs36dSHACaoMG+JkbeCeh1mltSzUonUYkIkB4769ym?=
 =?us-ascii?Q?rocdkLjjrIR+VfP3brw6ccQGyt6HTKAsnleu0b60la8X0nwp7142LcB3u8BF?=
 =?us-ascii?Q?GYngqabQuRQO4G3eti8+wj2kUnCh2afKEcJmFDnkhzJdhVmoyKdnvLOVTz1a?=
 =?us-ascii?Q?/GPvnAQC6JQ0Mep+G6YregAfxyanDpBIJlfb2zvqx65bKtif+UeuMSz9s2ha?=
 =?us-ascii?Q?yXMSMNgof7Ip/VayDNawhp9q3fxZ16Xkxs20zYo49D/OiFDoU+9eYvvZSFS0?=
 =?us-ascii?Q?HE5KqE+cuyv+w0INxqS1GuhzpWyWGaw9YR/EZ2+FeIFcTbFAqTTxUnl59kMe?=
 =?us-ascii?Q?fCxDAp6Ks4IQDVMhOLTIKvQ9g9hAEcfEq7hVWGtUHpd3tLBK7fPpaxBO3Wg4?=
 =?us-ascii?Q?sU9PJUZ0bWw1x2CCfePBB8SBWUeeX6UG8TO1nkEbFvY1oW6EFt/u0M9npwDa?=
 =?us-ascii?Q?iIEu2BETtBsbvvlOjzQ8EiuuBMyp+gFW4/zp+vK1QXdXV677n70g7W2JRkjP?=
 =?us-ascii?Q?NwC7JL7asqM5cHfRChxzKC9MIHbRLm1uhpGU70IejRQgKv2V66LHLhK+Mugb?=
 =?us-ascii?Q?Z0SZ3XjN8GyUnWRAShlCaMofw4OuDqwM9xWQXY7DiLygrGCk3l05K0288iR0?=
 =?us-ascii?Q?aJ++Lh0FoUSLRDF4B6LuP5+ZNZJ7BhwczZTVfnlbnkhLEG7XdLnTuGec79Hl?=
 =?us-ascii?Q?tJz9PSimkQJumTej6cOXawyPE/g2eNr7Sv5lBkndv15hHq8iyi1Hn2+9n0IQ?=
 =?us-ascii?Q?NE1qMpbXiavlVI3nu4HOlagf+K2N2P+SGxiw7yaT5h1JrOGCzjJ0oH64ZgpA?=
 =?us-ascii?Q?AiAmkKWodT0Mdj0dDcYbNHuFNknTw+sQ2JVR3K1F99b0PSOAHgHCsnNdkjAq?=
 =?us-ascii?Q?yCExH8VcIJ/zXrN86sEBCMVJojoaEPLXRAK7Mwu09kclQxOMhf6//GN7WDMf?=
 =?us-ascii?Q?gxDWZvXqvyOP+TfRLaLPUXvXeN3Uxwp6n/4JPyUHcKB2NroeORDVVNxKTUJa?=
 =?us-ascii?Q?vIWJWMLzrHZ55KfcggmdUOiONzu58Njc9D3/c/D4R7P2sCFn+ybiG0WmQUgJ?=
 =?us-ascii?Q?W6NsotTvGs/ykvEdam1TFRSgAm+lKYwbuxwb5OQ6Gygzm/mPII1gRDx56gg6?=
 =?us-ascii?Q?ahJ28k1vo9dl0yIjnh2n9fJUVYesxfDZkrU+RYPM6xZ3BCusTqydzH/RuKpD?=
 =?us-ascii?Q?9AMfdMrl/morT7CnOhdALo=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB6034F5AD56FCCED553082D6AF67A0@AM0PR04MB6034.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(39860400002)(396003)(366004)(346002)(376002)(189003)(199004)(6506007)(53546011)(76176011)(102836004)(4326008)(66066001)(316002)(26005)(186003)(99286004)(33716001)(6436002)(6916009)(44832011)(54906003)(6486002)(305945005)(7736002)(256004)(105586002)(106356001)(81166006)(81156014)(486006)(2906002)(446003)(476003)(6246003)(5660300002)(229853002)(8676002)(25786009)(3846002)(6116002)(14454004)(86362001)(478600001)(8936002)(9686003)(6512007)(1076003)(68736007)(1411001)(53936002)(4744005)(11346002)(71190400001)(71200400001)(97736004)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6034;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IU2rrTyNniCU/6UD95KXyd19nuMS0fzbdC+I7vA7M6DUhA4eKILTTylunLkLD9O937sX2urj0g5rubo+/yDjJHwUK53m+sAvPvxX9244p3K50uGFpCG76xNJLB5HKDc8qhKuMZJEq4nUuONH9YRfjD62sk2X21Duc/C8APoI0OWqOf0WNhawNdxk5DL6GPz4axpnB0vamzVaGAc3mSHk8JCnAmKR8kbVWUdz8NuXQCISi2YGaKWICUcvnq2bBSRtnE+oDh8WFVRO2mQEZdszlMDbbajCf5uVF7RRTdJg1dbnh/ZaaHeolre954cNQdKnClbw0xO1JXTxcuOC8qZC+U//kDkn2WEoy74VLDTNYKR/wNuexO+yBhW4GK5R2F/LDTYYhH7oxZI7vQGi0tC6xmo7iY7G700VEFjzUjOSBfI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BB855CC1325D041A765D60313B91608@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87c2515-7cbb-448f-367a-08d69b03faf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 09:31:11.6348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-25 07:57:22, Chris Spencer wrote:
> On Sun, 3 Feb 2019 at 11:50, Abel Vesa <abel.vesa@nxp.com> wrote:
> > Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
>=20
> Tested-by: Chris Spencer <christopher.spencer@sea.co.uk>
>=20

I don't get it, in the RFC you said you didn't have the boards to test.
How did you test it then ?=20

> My patch series which adds support for the i.MX8MQ to the CAAM driver
> [1] needs the SoC driver, so it would be good to get this one in.
>=20

The SoC driver needs a little bit of rework because of the way the
revisions are detected. I'll resend this in the next couple of days.

> Thanks,
> Chris
> =
