Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDEBECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29A321521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OVfu7iNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29A321521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbeITI3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:41 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:53376
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388127AbeITI3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iG9jQw9ZKbDVXD6r4fPS27qo+RBUuQPP5rF6DPn8V7Q=;
 b=OVfu7iNGXjIktcLHHAu52UDKYNs6P7AOHYk49QZSOdei6Tn1UAfWdh/l0r9Tt30+pV1FNKkUd/f7re7VXe7lJI0wt1LT3sdhRkvt9jI74Rj01e9kOsycgJjc87BuVx3R5bHOHNxW/C6+LY1XRyhAdJ+Wl2vyVvh7n90ZjVK+T1k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 45/56] Revert "ARM: dts: imx7d: Invert legacy PCI
 irq mapping"
Thread-Topic: [PATCH AUTOSEL 4.18 45/56] Revert "ARM: dts: imx7d: Invert
 legacy PCI irq mapping"
Thread-Index: AQHUUIxXqtoHGX20q0qe1Z9kX6/lVA==
Date:   Thu, 20 Sep 2018 02:47:59 +0000
Message-ID: <20180920024716.58490-45-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:nKBY6hYd9TtLAaK4AW8pS5+pUy3v34+8oha3Oz/nOEbWU4eeaVeZKiZxOunI43CcSjFeu/7+Bk7pAKe+vJYqKI3qd+hov8BWQf/1ovPqRIUDuoLcdEH32r+5F5z0eRY6uG4kgYeQ8BlLCPkkoinzU4IlrraY4as/Q0B+MsQlrlWl6N2BXO4m568m9p66p5PQuQOcC32qv0s0KdUsgqZ2TTlCCeo2wjtoYd2eVjUn0OQx1Qzt2R9/mAwaFO3kfDY8lTcu1HSWOvgqlyGnzzAjStdOKxDk8wzfhqAk+Ft37CcvYfLn1XNzFSVZ3CPJuO0hoyNMQGG1Q0dts/rLcuZlshGT6BNpCUYXFk9Bl4Kmi0t20MyxgSLghwuRiL+STwd232JJ2d5ITILPt82Tn+c6VI5SG4mlJlqmliRk+V7myLwY157bcNmn+lx52h4hpfwE832GoDVjXwjnU3piKfl50Q==;5:us+VKEZ03mahxhS2g5jHM6S8oe+yv6Hb6AtIW6NFylrBgjnXTYkPsfztNTERE/G1a3qcf7sQa74FxaIcFt9c4O4JCvQWq1I6fXoyC91Xi4d65QwJO+AgO6tvhdiTvIIGUY6+QYaJgL0pcHN45pWpR0BFY41FIU4OkctBa9TR2Gg=;7:aFYrVbg7mbrxXeTlgGUhCbF3lhaEKlmI1zZgVN9PVxY+8rgYKhrpNGVA+XNYliQzhFdOlpVuAURh9geVk4X+jsNWDi9jtjfAdBAUI1B1QzYLZLHILMuoWY6RB/FUqVaND217zOLfwpm5y8MuJ0IXVyB1LC9OUAsJ/0yFe2Dm3GJzbTwpQBI9Zg2/FWupyAAaYx7vlMh2ySguTuRTvlxJNPFB0JOo/qTQYcvRn+siQr3eofiQqSRROhF/9zSHJEXC
x-ms-office365-filtering-correlation-id: de13d5ac-5670-464f-9492-08d61ea38a78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165497ECA502D051BC0CD0DFB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(575784001)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: cQ77KNl5ryLTps3ww1CU+8tMljEYgZy6G0Aeuqfp6tST70ioVp2sE3VQUYD5aAktBRa5jkOj3DNLWFp0l3NaJ1CJtmJWDCKff7fDsJ1JwWhRdW+I6Nfd0ldH/2F0/ULMR4lRPw4417B9Mbt9ZHIXO3fX14L4WA10puJdgjUcftmQ+0o4eBo2tFhnofe0GG87suvBP/gpTCkpKUi6gXKe4GtVaDntpUgN9m5V+MyeSevrwlkS2lDe1KtiscyeQahCUmNWG36N3sHMTc1utWCN/+01cNc/DWTRpdjLv8h2YhVp620ZJ7jlZVyxJF5rXky9fwiDt2El0Bq2qMsGM+xw6Vh4a0B/zUXMFCFukJFDO9o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de13d5ac-5670-464f-9492-08d61ea38a78
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:59.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

[ Upstream commit 538d6e9d597584e80514698e24321645debde78f ]

This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.

That commit followed the reference manual but unfortunately the imx7d
manual is incorrect.

Tested with ath9k pcie card and confirmed internally.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
Fixes: 1c86c9dd82f8 ("ARM: dts: imx7d: Invert legacy PCI irq mapping")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 8d3d123d0a5c..37f0a5afe348 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -125,10 +125,14 @@
 		interrupt-names =3D "msi";
 		#interrupt-cells =3D <1>;
 		interrupt-map-mask =3D <0 0 0 0x7>;
-		interrupt-map =3D <0 0 0 1 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 2 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 3 &intc GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 4 &intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+		/*
+		 * Reference manual lists pci irqs incorrectly
+		 * Real hardware ordering is same as imx6: D+MSI, C, B, A
+		 */
+		interrupt-map =3D <0 0 0 1 &intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &intc GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 		clocks =3D <&clks IMX7D_PCIE_CTRL_ROOT_CLK>,
 			 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>,
 			 <&clks IMX7D_PCIE_PHY_ROOT_CLK>;
--=20
2.17.1
