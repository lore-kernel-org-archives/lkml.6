Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49880C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021B92173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T/0vsru4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfBZKLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:11:39 -0500
Received: from mail-eopbgr130055.outbound.protection.outlook.com ([40.107.13.55]:17613
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726602AbfBZKLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Tw12xB1ajkqPXg0EQ6CyGxy6i6KHRsX+WOfIzWGsZE=;
 b=T/0vsru4TuJ0uWWJhryIaca9vZguy0AxdAJ8BZqXBM8wbIeNEM9eU3O0e/LJlMKWe9duyYf+8wl8P3X3W04PIT9a/gWtt3HCLX9e1yWN2ro1JxP49PNg/C3v7ytDzH6WO8+hwp8bnq6u9WtYVSQEzqXaE4CUMjDwlcdiplQLzUg=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 10:10:56 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 10:10:56 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "oss@buserror.net" <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: [PATCH v1 2/4] soc/fsl/guts: Add definition for LX2160A
Thread-Topic: [PATCH v1 2/4] soc/fsl/guts: Add definition for LX2160A
Thread-Index: AQHUzbuQYKYv2wO0zU+Vxs419sFTww==
Date:   Tue, 26 Feb 2019 10:10:56 +0000
Message-ID: <1551132245-6089-3-git-send-email-vabhav.sharma@nxp.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::21) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2728a28-0000-4a79-1307-08d69bd2b2c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5726;
x-ms-traffictypediagnostic: VI1PR04MB5726:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR04MB5726;23:w3S/Z9AqqRvVXF6AfkaXTXGnJ2CrwjRRRgUOBz8?=
 =?iso-8859-1?Q?d/FllXeElf6zldjqWSxsHM8KoSweyVo/O0O1XnKuTnSR/2+F27KXzp0EbY?=
 =?iso-8859-1?Q?I9ehdB1h8h/skAANfUD+LdjKtJKzab1eb4sdJnQ2AhJpJ/Cv6US0GzoWHZ?=
 =?iso-8859-1?Q?cDOBPPCEUoNEUOdAHdLppZMe0ss4dNd4q1pqwzxwzq+6J0knmd12zqr7Da?=
 =?iso-8859-1?Q?alNjMMpK1np1xLsUPt/ukTis7xsQsiUvBpQM7iqIO16l1guZdXl9qHQ0g9?=
 =?iso-8859-1?Q?SyCRnlSi51Xaw16PYp1OTgWcny9tNHGaRypvIsvM53HKeKpBD9uP7kZ9mA?=
 =?iso-8859-1?Q?TUuJz17wMePr30fh+qvV0N03cIKf4OZ3QJtGCU/vVgMBNE1987KXPiy4ww?=
 =?iso-8859-1?Q?hrK0v+lEjhcT9Jyp8s+3AEgzi4muvnR8LoYWoQg/ox3RDY0sSFjFldJbJA?=
 =?iso-8859-1?Q?2moFAXSaBPT7j9mUSJJnX5bjSQlMO6z9K0LGdbiY3NuMVTccl4TP+mSe9x?=
 =?iso-8859-1?Q?VtGgP6hUM7KQ+/2pGkzcsw0uKWEnS7qFJLdKbcHKbnEBG7/NCF5mfuP85b?=
 =?iso-8859-1?Q?RCL9/7+JMBdh9Vg3dwqepc1USTnPRtK0GCdlcE6IcNFrmwGR65it840InR?=
 =?iso-8859-1?Q?nZ8hSSZZRP6BCc9fXwCoWNGxYhWRuHv34S7WRkwkospnaJ3wU5t7FZZwrG?=
 =?iso-8859-1?Q?0LiJ4SCHIM4wo4fGaeB5SC4G7P/HG1jhPQLklB4XjBktTSpb1eaY2wNcrI?=
 =?iso-8859-1?Q?uzLyBmZCt0g8yQ7PYySPoghUjz786wQHYCPoxl5htcH3alrVyz37PRYrc9?=
 =?iso-8859-1?Q?Y50tod8/UTV3USQr+NcSrYyarRbRkASyGNtGTStLckzT48zaBm4IZKnarP?=
 =?iso-8859-1?Q?4kfuf1+RjB07XRLXxK0Jzhevkzeya0eEPp5o93sfAbcNBJaiHe+HvzqulJ?=
 =?iso-8859-1?Q?q3lZRb5mZvEp9emeQbmPmp0MxT8oQtrU3W/x5LIxaxbcEwY8WAHGE0ml6s?=
 =?iso-8859-1?Q?kJPrPoTwu1b5Ag9gnmk13w+feYlSUDLvdJtTz1NAd4BmJK0m1mW0YhGdxo?=
 =?iso-8859-1?Q?nWGLj5I17hOm43MYU4i6xNBV8nfyFQxgSARcOiX+ABwrqzSDehbz/6MD4j?=
 =?iso-8859-1?Q?mvgsdbUhp8C7O+mAsrOVlZuKRwoMwIZjdAODvdwWcwmdDXGtdCm1CliAGt?=
 =?iso-8859-1?Q?55BxmxWZHO53RKhLB+iETSYsMVTjhEJamh6pxvtv1kgh+bL6iR+G0tfHpo?=
 =?iso-8859-1?Q?Z8zI0iQStYVot4+kNlhoN4Dmi/IVCe5fOI+I+JHEUVhZXa+kfhXEt+2Z4V?=
 =?iso-8859-1?Q?ST9NCHCS67q1YVJWmq1XFgHvCwkRrHFmYm3+zt5dEALoT4Totpp6pzGqir?=
 =?iso-8859-1?Q?qNtFueTBB3VSkztZXpCkiE8LoksJu?=
x-microsoft-antispam-prvs: <VI1PR04MB57265520BD9E6F1E73D5AF11F37B0@VI1PR04MB5726.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(6116002)(3846002)(50226002)(4326008)(26005)(99286004)(6506007)(386003)(316002)(54906003)(110136005)(8936002)(8676002)(102836004)(305945005)(36756003)(25786009)(53936002)(6486002)(81156014)(81166006)(478600001)(6436002)(44832011)(2906002)(6512007)(71200400001)(2501003)(71190400001)(66066001)(106356001)(105586002)(5660300002)(14454004)(7416002)(97736004)(256004)(446003)(68736007)(7736002)(76176011)(486006)(4744005)(86362001)(2616005)(476003)(11346002)(2201001)(52116002)(186003)(921003)(1121003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5726;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nrJqo2DysAg4Qf6UJHU8DBIjwuIr/ZwrTHAsRbp6IjWRrRaEi8iz3MC2lnocUuuH3f7lKIz9wJmz7FU44ECUlLc2Z8Mmh9gmmMHQ0LtkcsgvXaSRlt7thwCy4HATz655U/+R4Sw1UA1nbRac1K+wQy1lijP5Xa+A6xMTagbaa7t6c7R0AkMVQVNW+UgAgtLA1uQ4rchTUuMk+LlwV7m6pUHrbS0UVU1J+2e1Cdoz0RGLIDMPPkmaRXFLsYY153tix92cCkyN/swhaAsEOQMT4OKwTf1nVSMrwaITswDMjpdK9c/1leZ0McT6UgxfsvphY80EnoKeDFtCGSiZ8SehyMv2gZDCAEiHy2uuGM8EXfLqyzRYuN5Y/yY1P7OZhwr8IqUcIz7ASpm92E+6gFsJiB2PduO009XzanbEieQCcVU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2728a28-0000-4a79-1307-08d69bd2b2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 10:10:51.5906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding compatible string "lx2160a-dcfg" to
initialize guts driver for lx2160 and SoC die
attribute definition for LX2160A

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/soc/fsl/guts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..bcab1ee 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] =3D=
 {
 	  .svr		=3D 0x87000000,
 	  .mask		=3D 0xfff70000,
 	},
+	/* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
+	{ .die          =3D "LX2160A",
+	  .svr          =3D 0x87360000,
+	  .mask         =3D 0xff3f0000,
+	},
 	{ },
 };
=20
@@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] =
=3D {
 	{ .compatible =3D "fsl,ls1088a-dcfg", },
 	{ .compatible =3D "fsl,ls1012a-dcfg", },
 	{ .compatible =3D "fsl,ls1046a-dcfg", },
+	{ .compatible =3D "fsl,lx2160a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
--=20
2.7.4

