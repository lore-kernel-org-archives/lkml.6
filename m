Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A47C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308D0208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="uG+PAfyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308D0208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeH1NkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:40:17 -0400
Received: from mail-eopbgr70139.outbound.protection.outlook.com ([40.107.7.139]:45339
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727341AbeH1NkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cowwMsqlUoW57pXAINMmFOwktRkNpo4kp8A21j/XvmI=;
 b=uG+PAfyjR/2FF92w8dVL/tTd5XTyigvJb+qeht5etCn7HgyVtyd4gWFjoEnY5EVUtmWOEyLWT4x3D+9ohP5ZfQ/J2iugGSQ0ffIpoODHaeXPur36HNoIvXEFD+5ezJ3/L7ezHsHo+UBBVHz23p+pZPSsJ3+Fn34kyIm/WqKNa5M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2449.eurprd02.prod.outlook.com (2603:10a6:203:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Tue, 28 Aug
 2018 09:49:19 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 2/5] ARM: dts: at91: nattis: make the SD-card slot work
Date:   Tue, 28 Aug 2018 11:48:41 +0200
Message-Id: <20180828094844.10018-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180828094844.10018-1-peda@axentia.se>
References: <20180828094844.10018-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f1057ef-1b10-467b-84c0-08d60ccb86f3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:Wcz6KlH5P1iRCyC3LUzTWUiLxsGZK0dJgQAhhRldcm9EtQpGbtMttsAsQ+9+AW3EN432zfjt6XzruRqisZP+EfX+vEVULEvEV2vB2eNcI2FbXLtB3fXjeADbKuGZDonCItbUiH3DnIL+SIg96UuLiS/yy7a+w24DkbYyilVX1pmbkG6x2uBfnIdqUI9zEjcoiiy99O+TgDz+btAWoWZxW00a++/AW16ZCAI6PIw2OBf55uOTmzHYQSbL+0cKuyGG;25:5W1eyruLak5XexlSZ5algkX9FOtTd7Er2Z0kw4U900PSvjplGzGWzxZyKFSm2ZZGd31eUIDLQIe9NoF0FXMbtCVc4VJBqkXcejG6wsBkTZj6Yv/IY0rIhlk+p93KjVhTb2/BN/34XNJmJa+Shu28J7OAbsSYhv6RaK1Qd4JrTzbDCEnBJUN1mEw93Rz4y22NajZrebOcrcxhFMRpxovuLSw+KKYlbRSSEZF2wk3Gnk9RZuN9ulGFoPSpq/PnV5IXbnkMid6yU2qj77Waat078+l+f7nbQOaOOwm8Z9QgakQwcDmbX0zbzIiifI4acSgdR2sIgqcu0dEYjKAD2gp+bw==;31:m6p1ouqdKs9/CNfgcUuiGDidvgS7B7okIPrm7WW1U4EmfNwAS7aUUp5ej5LW3lOKLQkpScbKVjXwEig2R1M1oUbfrg9A8Fh9a/l3lSZeS7asDZZhgd2fXIKcfcZSM/hiia/45yJ2Ye2gEUiB3EHddvZBr9C6v40+R104ciQRPk4pAsdif3Qq/Mwz5uMceGFWMNKxRw8S9o4bfFokSu5RORDbi1UL6o78i+curcOqbSU=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2449CA6A2A4FA424A9D07B85BC0A0@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:EjjiTc/zmGgRhAyRXyzJLHcqKBWFUjfy8pCHS1W2Pw6feJtdjOhBzY/K0jlIjJgocIoHElIo9/RkOxoXdhF4To53ylXWJ7B9ak5r2p5AKUDD47ieuyNQ6DSoCzbLYRbnxFRqi7knn0ARE77Q1keIpC8SaxZqTYkXOJzezpkYR4rTxzteh3wEKQQ8F232pUVMZrm6E7e6LslKXymx6xcMFUUYXEftnVlD5Pcoy01MiBAPbK5oN2U4b292QDSgIwRyWFoljeGo0p0gcZawVX960w==
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39830400003)(199004)(189003)(74482002)(16586007)(54906003)(26005)(4326008)(2351001)(6506007)(478600001)(316002)(386003)(16526019)(186003)(2361001)(36756003)(2616005)(476003)(50226002)(11346002)(956004)(446003)(6116002)(97736004)(8936002)(3846002)(1076002)(52116002)(25786009)(86362001)(51416003)(76176011)(6916009)(5660300001)(6666003)(486006)(50466002)(48376002)(81166006)(53936002)(6486002)(6512007)(105586002)(81156014)(66066001)(106356001)(305945005)(8676002)(7736002)(47776003)(68736007)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2449;23:YqirvDMrER6bSq2U1/x7K6ueA1SJXofZWNwJPt5?=
 =?us-ascii?Q?wsiMGg4zPpde16TUr/u8xetv2nbfjwj8lGWrDLt/Vk7pSWv1WuGP8n5jOBsK?=
 =?us-ascii?Q?4fUoUGlxeMQDwn/mUoKnYVO9UUKH+iGWIx+/6Bg0GsoPvJkv5mdv41iiirrJ?=
 =?us-ascii?Q?VciP1r0pUGDSLgNkxg4LTKdn1DjOuFVq35YnpYVFCps3DTaZ3zyNfLzWProg?=
 =?us-ascii?Q?3YnDXMBbYG5HE1IKxY4ZSvSt8uYFO2YgXl7SlRGJstiQ7kmqR2p2vJZf5QIQ?=
 =?us-ascii?Q?jVxrcYC2dvSl8NZEJS+nLaGn9V8aUcgOsl6ZR0allXPdpxus8xzm30cIrFME?=
 =?us-ascii?Q?ZFsAo8HBS+P8UslCpF9iT+JEwH3Yl0S9CG70P9OzTlD7WhEBX6HdFPEo7k6q?=
 =?us-ascii?Q?TeOU6TVrA63is5gnmzWi8eCx2eLFHhia2PS4/lvg5I64qBLk/IB9OI96lsNQ?=
 =?us-ascii?Q?Np4HT3nxfwfcxdruFn1oAbMJkFp+6uoIXV4CVRd3lq/YIxepYrF/b4YNg+hd?=
 =?us-ascii?Q?VbKZQED+fGbMPTmjb70JeuZzWhCek5JUMMWx+eO7xoTgCJIPzhmI0weBda1t?=
 =?us-ascii?Q?V+A1B8AbeiTivPAjypX55S28+SqO3vJuyXXyO/0Fq8VYcSXkqSXaLXfViRuv?=
 =?us-ascii?Q?btSGjYtCkGctcgCtLfaDWUe2mP2YxyxSQdVL844ZX17qSuWDFDLp8sNwuCWA?=
 =?us-ascii?Q?ekL1geyNiTw2jSaUBNJJgsrB2dV+hVBRyR0Eu12CYJ0s4tXl396Kf2ub60QR?=
 =?us-ascii?Q?9LZEgpPIEJKollyC+19TpDfjfzs1AvlgvN8VEg/cddBrdO/y+ZF+XA9t30H8?=
 =?us-ascii?Q?K7YGgdmioFeL+1Ab1bZSWzEdX8CXLoldW/rVBGAMNvUKM83+vA1ZL2pz0MDl?=
 =?us-ascii?Q?L5RVGZB+jQJ5jhUvITjKpaEcBhHFZhwj1NyPsreAdIjsMDg2fptZ3t0RvlRG?=
 =?us-ascii?Q?fiLrh4J9/Ze91xJ18mD+r73/bGRYx+pwhpQ9C92iFngmQoqUs2kwkNnlhKeq?=
 =?us-ascii?Q?O3LYwQJZRECNTYFsJ39moubwLyYpNjIWcahghgvW5DqJfFMP9xW+IuNnwUYA?=
 =?us-ascii?Q?67cjuCguVnlJF0/D3C+yUQMoJGRSaaHb+CleOV1HAHozeD025FVijEmFzOp9?=
 =?us-ascii?Q?geQ3I5O3GWSDf01HWadhBW9DVNTNv6mrh8KLTKzLx+8b4mMsA0UQPPJbPg39?=
 =?us-ascii?Q?Bo0IVTcuYY1SpG0kLR9kJenn2HcRnKvJ/cqwW0aItn9dDUyrNJJqcAvnMnHr?=
 =?us-ascii?Q?/ieS1tVtaEKINE6P2OLR/0ZUrF+HlBX82gHAZttF41/pxZI8hg2oAHjMERQr?=
 =?us-ascii?Q?aTg=3D=3D?=
X-Microsoft-Antispam-Message-Info: C7VRmLLxQaAPGoz8vGY4NExLnK1hVuS9/X/KFo79HDBW5mGgSTUuZp7H0apO53/Kc/OBDbBDViOPb7nJyMQilEldyW6Ml6mzVDLPjqIMENGA88ol3XUsmQJi9fZmzcmPNdbYvjnGJ42kh70sQnyzcR4BSoLYH8hsGOiRbE/RgVQe9uegXqmkQuQVnTV8QxXtn/pwM+jRjk+jZHI5vS+2oVeJO9kpJwufkUpGCe2prJN2TnlMD/6djOAglYGzIXrgaV/UCbciqQ+9MVqYyyWH5Dp5v5UQFeo4MQ5pbdRpMks6XjFITpCkGSHy6BPmrHnZl8HO9hiOAwQUo6NxWMs1Ji6TyRV9G98/Djt6KlPfnwM=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:7CGsizPzUkffBMZqmepZLN3ECyjZY7i9d5cS92zb+h4BTG2p7/DQF+dNwFln0GhJHuDyFrP52T6gW5cQGyZl/Bpp2xAKAQAqMG2tL5RWMVhcbjPfTv3xFeBvnNJ+kuwemn4fem8WpZPZZYikBvbEEizMlQlrWa4zp4cTdpERrzS0HM3geWsN671/7Xya0eZYALXcFGSuPOfejmiaIi2QWGTIl084XpnEFuPq7fOveTteg1HCasDNGpx9i0NTwTSGMuwnIvrZnHpbzvbpWRlka3P8ylLs1gqC9I2wck72GjvZUsudQk4QjkvaLmEG4mtoYxow1FSjl6rJabImhR/fIgZk5d+SeE9Njjv9DBllEn+iNp0gG7rzZ5Sc1yctcQazEs2yJZqW5Qoktg+S5RoOTmWHD+1wcoTiee8t85zrK2gmZQYbB9JxDl0bafjt8TCj3Aj6X8DAzUUFvE5dIPeixA==;5:uereb1wK5eTwaykQ/3+jYk1BEp/5CY2vLg9xeZtTh9U+M+ej+0DI0S4mjSrfp/r+rWDHItY+V8BFRN1URy5K15nEaStzFqjp3lzYEnMNAQ/y2R78FPN7klywv66soN+pIT9Z1ivIWHQBOHRToMEUOhbI/CWkZaKsTS/lP/pKNpc=;7:Cx3vNxe/qM7juz/aPK/OZQ2O+VETAaZCuc0SwKcjSU6nmgsbbPZ1TM6X6DjUx8SnnYXbYFnzGN4mr3JOJAaQlXzLfaRVB3E1wcEYJwZ6H6nMhEyt9d4kOS09XIPRP/eItdyYAmCgRNxRmql50fCoNHpj/H+bNb5y3w1k5+XYe9gncS/ALjsPRYUxJHeFjGhO/rl0VfRAZKvnyoMB+noy3RAJdRA47baFyTDFwbzjuzzKHo8/vXvLlIupsfRxvJu/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 09:49:19.5779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1057ef-1b10-467b-84c0-08d60ccb86f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cd-gpios signal is assumed active-low by the driver, and the
cd-inverted property is needed if it is, in fact, active-high. Fix
this oversight.

Fixes: 0e4323899973 ("ARM: dts: at91: add devicetree for the Axentia Nattis with Natte power")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index bfa5815a0721..4308a07b792e 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -221,6 +221,7 @@
 		reg = <0>;
 		bus-width = <4>;
 		cd-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+		cd-inverted;
 	};
 };
 
-- 
2.11.0

