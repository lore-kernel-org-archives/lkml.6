Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2974CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E857621019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pk+Gqj7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfAVJTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:19:47 -0500
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:18535
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbfAVJTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiXDEs58VOu2qtPTiLuymU+8l2mM8Dfrurz2jvV6HrE=;
 b=Pk+Gqj7udMShUlNf5H70rxzrodH4yDJ8C91ligrWsHbVkcB/ZRUR+LmNdqXvXoBFKDGxgnY3bN3BzgXY0M/zRixfE9qxp39UiOP+ZccihAy/eMPyjiHtS8trDxIErvRjm8EmdJOsqJAUUSFtna1jWO2PgMXbtM3tvc1PuQX0l4c=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4957.eurprd04.prod.outlook.com (20.177.49.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Tue, 22 Jan 2019 09:19:42 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%5]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:19:42 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8 2/5] dt-bindings: spi: add binding file for NXP FlexSPI
 controller
Thread-Topic: [PATCH v8 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Thread-Index: AQHUrMnj2HaRDCPgY0i5ihL9RBjnkaW7Bz/QgAAFoACAAABwoA==
Date:   Tue, 22 Jan 2019 09:19:41 +0000
Message-ID: <VI1PR04MB57266B148D07519F26574FFA99980@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1547553487-9936-3-git-send-email-yogeshnarayan.gaur@nxp.com>
        <VI1PR04MB57266D861937B99899F3C1C699980@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20190122101658.6bb89d54@bbrezillon>
In-Reply-To: <20190122101658.6bb89d54@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [92.120.0.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4957;6:rRHcTb8EXu2CJtlh7sQLh5A5xvqhLVC63r9M6nYb6yhoIYr0pTzUlhgTQ0vUR534ZWq2Wu+owE4pItVJjHJ0uGQa3TSEMBYKyUxNh/+wyJ2gbDJQ36RZIgfBpw4L7/jh7HatSgOiy6r4qnDXJilSx/s0WDlob8owuD+clj7oJOC6vTHtaDzTbwKLLJUxp6e9aMfPtKK6rPANtWy5sBGpib1pkC5IyGUOlQLZTYarMVH3m+Alg/p6tG0lhjgD10qEye9qi2Ba6Wgpv0/cBlk7oSJVnE4KAK9JBWISAXMZZbvkNgS7IiKOUAmz5T+2fhWFAfE+xk/ObnZQFA81GKJ39nEL94idxkYWcmdQJuHYOCiZhbpKjUriY3ZjHcvKb2v5Z0jR0zOwEK3eDFDyrC3DPes4q+KPZKWO2kitvKwvS4aH8fchnibmHqUySdhZTiXk5C6FxtqRuBe4RWkZRXJlBg==;5:nfCnfwNdhCQPzO7V7a445GP6NDbmeghWmjjvBuoD/wuazObiND/RYVqmJ3uh1j5nSeWatJl0RqzOnOhKRq+RuF/n8AiY6/7+v4C+UNrZyqkE2DJP64DIQ0/+hH4icI3gZYEqU1/UKk1tsXoHNu1lVz4wsCTug7EHD24AHeGdTGdYiB7n4U/TFiaM7OSx6vub253KXwk1RYINRTuDGVR5Qw==;7:W9TD2tk5lXcKPpQMMLjik42/MmYckSIQaryO2wX6AejvHODXifroJttF26zXDEUp3Go7dioB88PKgIYJ92x2uGkU1zxnuFi3VH/3uFmDW5kliFB/D8mgRHLJ4UPkXe+kVk74+SW5Y81zNvxhXT45mA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: db6712fd-1ed3-453f-fa2e-08d6804abdd4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4957;
x-ms-traffictypediagnostic: VI1PR04MB4957:
x-microsoft-antispam-prvs: <VI1PR04MB49574F55BAD1B75FBE6D424499980@VI1PR04MB4957.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(189003)(199004)(13464003)(7416002)(55016002)(9686003)(8936002)(229853002)(8676002)(76176011)(97736004)(53936002)(81166006)(81156014)(6506007)(25786009)(53546011)(7736002)(2906002)(6436002)(39060400002)(256004)(74316002)(14454004)(68736007)(305945005)(54906003)(186003)(86362001)(33656002)(102836004)(6916009)(11346002)(66066001)(446003)(486006)(99286004)(4326008)(316002)(71200400001)(71190400001)(106356001)(476003)(93886005)(6246003)(7696005)(4744005)(478600001)(3846002)(6116002)(26005)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4957;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hKYlhc/UVCM5ITinNh+Y2W5a5jtMJyO5Sckk84s7QggvA1SC9dUOMqQJx2FqbSSvWhq1cL1yVItKUVBa9LYuEMfBb9v9L/tkYZvhtUbCbFQGb5FjJ2hoKmdKVOblSXGU6zDPxZcvyvYAQMgDv3vnp/Blw8FzqPWqLNzDcZV4VEr3klRxldvgwof2iWOeTFTsww1FnNCtim9M8KbgVTHP78RtJ8J6VVo/8rXoVH20Xi67R07ix4lBKx88NAjdTlAjXz8ajZI8/WyhtDIxIN7UnKRjw3Z550d95tEZ6ZosxRAO0oecJbgNBthHA0lKYE6raLvhiNoXQvTg4ooOIedKLaAUjgJzEx1LNyn3nJZt/ShJwEVGUAxSOL9Fw/jrUMhe8CyroMtq3K/AmWx4n5eKNOvJvb135X/x74fiCw+/dkE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6712fd-1ed3-453f-fa2e-08d6804abdd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:19:41.8609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:bbrezillon@kernel.org]
> Sent: Tuesday, January 22, 2019 2:47 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: robh@kernel.org; shawnguo@kernel.org; mark.rutland@arm.com;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> frieder.schrempf@kontron.de; linux-spi@vger.kernel.org;
> marek.vasut@gmail.com; broonie@kernel.org; linux-mtd@lists.infradead.org;
> computersforpeace@gmail.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v8 2/5] dt-bindings: spi: add binding file for NXP Fl=
exSPI
> controller
>=20
> On Tue, 22 Jan 2019 09:00:14 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi Rob / Shawn,
> >
> > Can you please apply patches [1] [2].
>=20
> No, DT bindings should go through Mark's tree. Just wait a bit please.

Ok, thanks.

--
Regards
Yogesh Gaur
