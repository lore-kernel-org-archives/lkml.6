Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC6FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B3F20821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vpzGrEeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfBLMlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:41:50 -0500
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:59840
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727763AbfBLMlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVc/JtbbRTELlWx231defLYAofKFwIwng/JQG+dvt5A=;
 b=vpzGrEeLrnHpHNMJGyrlxiSQ/RxitQGcxgZhmwI/n8oaVH2kVGx9wQ6/uTtrvL1cESqLMwoakQDU8llmXAbVEARMwlrqP9x4OpilTAMldRaPwstjK2mxqYIN/mFtmAbAh2i23SI+7oaud5nCIhvtQbMgMwPdPXMYyv8zaF7xJzY=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5379.eurprd04.prod.outlook.com (20.178.115.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 12:41:45 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 12:41:45 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Anson Huang <anson.huang@nxp.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add cpu opp table
Thread-Topic: [PATCH] arm64: dts: imx8mq: Add cpu opp table
Thread-Index: AQHUwswF0jCrGFVmyEmVHUYdS4x2MaXcE4iAgAAHfgA=
Date:   Tue, 12 Feb 2019 12:41:45 +0000
Message-ID: <20190212124144.gxxecxqu5xk2ts2m@fsr-ub1664-175>
References: <1549973439-26706-1-git-send-email-abel.vesa@nxp.com>
 <CAOMZO5BgWYKv_sJ=pmknEs+CdOasdK47H32xbwtHub6s0yi=rQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BgWYKv_sJ=pmknEs+CdOasdK47H32xbwtHub6s0yi=rQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5379;6:hz6gU7OtRihyDMhLrLciz0t1DuK7uVd53Nah9mST5LRKcZTfRau358009aUy1YMSW3wv6lyssrsp2BK17Dv+NKSfCOgKYdZgJxFQL6aFp/Z7Gyx+jSlf/Y2V3GhhG4ZY3o2sPfKvS36GZIRPGQCtJO68y6al1iecXzsn9oX2xj+UezJe8U7qnRq57UOGe/vZC5vfpfNMu5PMmEDwPz6+/CPKAMK9m21ueyHZ/EnYZ3E8jRS842VWYB4baR7yRCST5jP+ghXWycoLhkfJmTytAZcbSxrz52zhtsfmzNrEV9f5EdD9MK27getj1NTUUSWOijPUoT800YmN+M2t0iuox3m7X1ZWgSBTO4oKz0jabB+nfRgzE+7zneZdy3GfbYdbFzf48cN4BHhIbW5OFfgxPIYCFew8mgthAxfKeWeBafyZISoEIfmDq8x8zS6rvMzteFKWgGOk2C0dsaAnRArwSA==;5:OL2CHKIG2k+yp8GrNLv1XZvKnijhwLF7VU7I7uoHTFfhjsSqXUNS0/hg51R8AsdxiIWWdZ+2e1dqm+EYQ0oA9grz6TJCpupct5aw200mqhojeWYKuorHA9slurxMkZZpBVWgqUHFaZSHsbUEttSmTkcGPy8fFPCq8eHZ3BN3e5eT9ZcfG1e7oI2JylmXgnyCM3CEu0jPRma/w1S9ECcJRA==;7:wWdg5C56YWgGwCOJJDjUX44iLwTxNEZrZTsV1JdQjGQIHRx9Z9e+6+a6ZFQnZP3P0gpX0IGeT/7KEjDmOf6FRUUdKMB7uQn5fp0BIQDjjYLw1HaJIbvkUM7mbx0xMpJBnr0RO72vuUYVUJMNN9vKSg==
x-ms-office365-filtering-correlation-id: e32133be-e497-4c15-42f5-08d690e772da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5379;
x-ms-traffictypediagnostic: AM0PR04MB5379:
x-microsoft-antispam-prvs: <AM0PR04MB5379C0155B88C2CF65BF6413F6650@AM0PR04MB5379.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(6246003)(1411001)(3846002)(33716001)(305945005)(86362001)(53936002)(33896004)(6116002)(8936002)(478600001)(14454004)(81156014)(81166006)(26005)(8676002)(6506007)(186003)(76176011)(53546011)(7736002)(68736007)(102836004)(97736004)(105586002)(54906003)(2906002)(25786009)(6486002)(1076003)(6916009)(6512007)(44832011)(316002)(11346002)(71200400001)(6436002)(71190400001)(476003)(106356001)(9686003)(486006)(66066001)(4744005)(229853002)(446003)(256004)(4326008)(99286004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5379;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bpD4HeYSQdd30Whe4BFjXKCzX1bYhBUGmQCqn3lIvo4qEXV2cT6pMuXBtgxTeDbddJxu7qfXbxRj4I9ZoJ2EECIkeJzXbok109RraAjSB3WNaX+GvGAgNLZpomD0NfgjW4ESfvG0Q7uuzJDLNuJ2oEOt+dtdMih7C8DnMNn4AP2R3tv1egDWSbBJD+RMrMz8F9lJUJ5jd5WktlPfhiyxfw+H92qmoT5s0AqfXd0UREdueQQaUboFg44wTZJtsWxoRganllJfa8YPNDJxEdStRNCoUPoQnNmcLk7aL1Nz8UhjUTl8RCMbkeEIgV9zwDWUw3Ay7O/5KnkOYDV8jdNrYFmCpBsXYgRD23s8pqfRJ0+lZtVpwmLWktxI3OPEWbr4cKPseHqtkpedZ2D5lxQUGuM8Aks981c9Hs7DNUzLw+g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7AA8AB28B3E6654E827C7A2C090881EF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32133be-e497-4c15-42f5-08d690e772da
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 12:41:45.7194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5379
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-12 10:14:55, Fabio Estevam wrote:
> Hi Abel,
>=20
> On Tue, Feb 12, 2019 at 10:13 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
> > From: Anson Huang <Anson.Huang@nxp.com>
> >
> > Add i.MX8MQ cpu OPP table info for cpu-freq driver.
>=20
> Has the imx8m cpufreq driver already been submitted?

I just sent the cpufreq driver along with the device registering.=
