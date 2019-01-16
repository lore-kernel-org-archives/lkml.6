Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DE2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFDB20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ggxSFoSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391661AbfAPJ2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:28:18 -0500
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:46048
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389049AbfAPJ2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3APBv3itD8FrE+7HrzqolYWQj2vhncJ62+MO1t7bMQ=;
 b=ggxSFoSLxx2ZNhqr4LZ7y5OcLNM0oU4Rsl0QwvkaYPM6oNco1SFmEmWTwhx4z1khV2T4FR+C8urXNV1izr2NQ5sVCroMUAEf+sobvpMTuh0h7ACFG59UcQLQSxjzv/3w5XDgvSIAv3IWS+/dSiFStoYkgwOT9+FmBmcfdujVvwk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5778.eurprd04.prod.outlook.com (20.178.202.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 16 Jan 2019 09:28:12 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 09:28:12 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx: Fix MU4_INT number
Thread-Topic: [PATCH] arm64: dts: imx: Fix MU4_INT number
Thread-Index: AQHUrPR8+s4T0qQiBEy8rhYNUN5cRKWxoQaQ
Date:   Wed, 16 Jan 2019 09:28:12 +0000
Message-ID: <AM0PR04MB4211A29A977F9B8C84DA40F580820@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190115170501.10952-1-daniel.baluta@nxp.com>
In-Reply-To: <20190115170501.10952-1-daniel.baluta@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5778;6:vhjcsxZjXFQqlbCfPi+MNGxOMgpp0bpRUof0y/4l0tBxAWY/VFccUqCfPQ94oQThHFVaQO9gYZ7nRp0V6Yv9eW7mLG6P2on3Ix+l1m1yfl+CkFzvc9L55KrThbrXCNbtyO+9GrhFZFpsDfJz8krJEacbIyUV/QTedhoyQD6nDK6wUq7eIkoe5Y8rENZpWUWMmSLIUDiJAACRpOmCcvNVUeZoowywb+11Ggp5svmDl9yb74ZCAby0dF7uM7kcpBBNP1/llpZYRGt+ddy2l8TQXqTx5kvn2XQ0f40WJRcQ/hgNI7cGHQin2zvRh/SnDKEBris5iJQuTgYAV4ZqjiA9p2WIiH4QWROM7PSSzH28w7vz7QuZl8RzwZjHnV2kf30K2MCpK+lLnWLvlDvdHmkpTkkEw0PbAfpntbdtwPObncW+/J3A7es3pUv3x6ak3U+NyL+gtZBWhRAN4BMUbuFKSQ==;5:wXXErrxnvSKXbwHVl87hvHv7iHVIY0NArRmpYPFeiU4DAzYuLX//FU2Kc8KLsKcGFFRSlRlyIpxSsnO6rsx2i/K0kxVRZD8j6zHne9fRhSjAOdNaJ4TepDa04SMWCMQuWmw1FsDSLpR1X0nOk8zjxxKdACMxKPzWtP9vu7nMKN2lciY0aBARuVwCu+DmjXx6/3V8BvVlEyd6xdCYyTpHMw==;7:0JtYutoM9fYTxAkWr2zvgTQtyuwNlHACOLHnfuNiy6HF5VPwnEX1jd6yDwxVB6P1lwR7a9yRE0EHt0JRkZT88izR1jqJfgjCwUFzsqKPSKZzpRLUKzOcS37Eyx0gwEeJCmmdILdOVwClOtjzaPOdlA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4d8c8ccc-46f4-456f-598c-08d67b94ef75
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5778;
x-ms-traffictypediagnostic: AM0PR04MB5778:
x-microsoft-antispam-prvs: <AM0PR04MB5778D7AA559051339F46B21980820@AM0PR04MB5778.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(74316002)(53936002)(5660300001)(9686003)(558084003)(4326008)(55016002)(106356001)(33656002)(25786009)(6246003)(97736004)(66066001)(81166006)(14454004)(229853002)(6436002)(8676002)(81156014)(105586002)(8936002)(478600001)(68736007)(2501003)(476003)(99286004)(86362001)(71190400001)(256004)(7696005)(71200400001)(26005)(486006)(305945005)(2906002)(110136005)(44832011)(446003)(3846002)(11346002)(6116002)(7736002)(53546011)(54906003)(6346003)(316002)(102836004)(6506007)(186003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5778;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wGWOqhgcSEVR9G5m8vAqglkOC4VzvTLAydN7HJ3LlxEUlPlATFWwshsalFDBXtDRgGDwUiEKlYFpDoh7/AwCpj2t2SCW/wS0kt2wfFAUB7Qutpt2O0RDhweF5XpRQQyWiz3Zn9Bt5hJKS+qEwrx9L3MmXaMFwdoKMQ0PLHbKfSRsTV5S3IllJ86su8PTv8Mjt6fRSqCwNVhkpb8KMvRkCM9lVBSgSBkC+Dpt8wv2+2mYFFYNuW4p//JqrTzu1f9BafVvYKjgeqry13YQzYrxDTZeyUk/VYatp1jZN1+tMCp6eKK4kh3MhoMillmgH6WfeofBbSOOhjkBLTn9yKoauq2G16CRiVpK/p87o9HoGSZguSWBgbh0i0dBg8habDFW6gM4ZhBk6JFSiwaYWO4jhx7KbYrHOuUkeNXxA4aT9x0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8c8ccc-46f4-456f-598c-08d67b94ef75
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 09:28:12.1114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5778
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Baluta
> Sent: Wednesday, January 16, 2019 1:05 AM
> Subject: [PATCH] arm64: dts: imx: Fix MU4_INT number
>=20
> MU4_INT correct number is 180, while 179 is for MU3_INT.
>=20
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
