Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA440C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFFD206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ehCjG0PZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbeLNPaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:30:20 -0500
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:22720
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727229AbeLNPaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRZzsR2FlGrHfMBDL1Me5gsZfeY0YmePbPX0AOTbfdk=;
 b=ehCjG0PZYGXbGA6jQyyrv3G1xWKfzcuJGKaL4v8Mntk97P4WzFlWoImygdlLXh/0DLq2qyUp05RFh28teMQmJ1XZXLHAmrusHTvnE+6zlNifjfqmJbmkGOKNK2++ePVaIaj6bxFsXuRHL4Y/vwixyZ1DPJLMOpqJpWWFkDW0K6o=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 15:30:09 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Fri, 14 Dec 2018
 15:30:09 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 1/3] clk: imx: Make parent_names const pointer in composite-8m
Thread-Topic: [PATCH 1/3] clk: imx: Make parent_names const pointer in
 composite-8m
Thread-Index: AQHUk8HlMVhoSDEw90uEQbKPCADBdQ==
Date:   Fri, 14 Dec 2018 15:30:09 +0000
Message-ID: <1544801400-18951-2-git-send-email-abel.vesa@nxp.com>
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::33) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3754;6:IMEWIkfepxFZYQLJgr+BUnklrzkL9x3SgkWtC37DFIOVazzOpQrRqlgxLYLOLrXK5zgbSm5NSdxghPRh9f4CRY4N/Ru+1dyz5DvWWS1NLpFHkA5lalYxnDH3mlkzBnvhEWw9ySww0f41/pe9HKMgA84ilsaWMdmVE4KeRZpmzqr20F/Wfvyn8cAOnZS7J/q+CsA/1v4WY7LbpY3btgklA4XTgWTtJk55CnimzOxbQqtf0CaFUATvisgz2CWiSGAiJZaejx1AdGiqyUzWvu95vXmq36AoBHMB2yZWCqejxSKYIQ3qftEmLS1oheucfbH5FVbSyP/q122nkqa2aoTFboJ4yknVSn2U7CZAukQmBZgkic9WVhAqyZ616DiIlt/niWyOO6qSaysBCODknMKZkhT5AYgpIuuRzckzGpat9CD+HpJ+StOyRAICTWuLWtcA77CmpCVXo41bKI+dmGMWFA==;5:4sYNSKKgOHGxW6FmrBS3NSq+ugYJC/e4jEanMG5B5mZPxFvYXFKEFbouYNdVxORCq+K5yhVOsMLdH6J6vmVBZPHlECTu8Oj18lvyHkWLyBbxZlH98T9fJB/WxLdbqEv7cNbES6XHdG7cLq1DmFJPh7d3EQisxUEfuYrJ5j85Bl8=;7:Uu9bsKYpW2SvH1I0wzVOuMyxNBhUfMm3yNGaKp6LkOQEr/OOLpU+vyun7gpKu1u0vlZsUyICK3vKnpqW7d7YCOs6kG7NJw/fZg3+UMEz0JVaMobtRFu+ncG52K2vdX+XLVpEZXC2pOI+GZR5WnpyEw==
x-ms-office365-filtering-correlation-id: 0463b735-9aa0-494f-ae86-08d661d90810
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB3754C2421786162D2373E6FAF6A10@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3754;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3754;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(2616005)(53936002)(6636002)(8936002)(186003)(66066001)(97736004)(52116002)(68736007)(4326008)(305945005)(36756003)(25786009)(14454004)(2906002)(6512007)(478600001)(5660300001)(386003)(316002)(26005)(99286004)(6486002)(6506007)(71200400001)(105586002)(54906003)(110136005)(76176011)(81166006)(81156014)(8676002)(486006)(7736002)(3846002)(44832011)(6116002)(6436002)(86362001)(106356001)(71190400001)(102836004)(446003)(11346002)(476003)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3658.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xdz31EZzp5EsIiGeB1Af2cH2U8RGJAzlA37qpd8mc86XsXp3no1XCm91eq75c6zursY8QS9VHrN0KOIVpoZflwF8h/Ycdm9NFYd7Krc7mFr9BhUDekDnm5GrzvMBjCgoFsqD77UsWD6mFtoWJbIV8DU4HjZZ3igianveBfoUKeg08JPUOd0ENlboPC/PWx3Wh3qnfjwe+D9Q5bilmhpTe5bbRYSYhma9tUubnHg9PD5vfozBlH5Z9DQ6Ag4BAxQp9zvd4VgYp/RI912f92J57B53ajI+F93bz/AVUt+qlSFZWyHpQ8qhbvo9fBPleg46
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0463b735-9aa0-494f-ae86-08d661d90810
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 15:30:09.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parent_names needs to be pointer to const pointer to const char.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 2 +-
 drivers/clk/imx/clk.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-compo=
site-8m.c
index 527ade1..574fac1 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -123,7 +123,7 @@ static const struct clk_ops imx8m_clk_composite_divider=
_ops =3D {
 };
=20
 struct clk *imx8m_clk_composite_flags(const char *name,
-					const char **parent_names,
+					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
 					unsigned long flags)
 {
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 028312d..1363dbe 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -354,7 +354,7 @@ struct clk *imx_clk_cpu(const char *name, const char *p=
arent_name,
 		struct clk *step);
=20
 struct clk *imx8m_clk_composite_flags(const char *name,
-					const char **parent_names,
+					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
 					unsigned long flags);
=20
--=20
2.7.4

