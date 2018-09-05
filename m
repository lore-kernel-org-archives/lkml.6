Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F12C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FB7206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c6xNMJhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FB7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeIEMoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:44:46 -0400
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:17478
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbeIEMoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r1eoiyM0aRKvd9Oe9D0GLQRln15LYE8a5Ay1+kpo7c=;
 b=c6xNMJhiStM83zo16P2wEXRDExo0RnUitbketaF9a1+PEdEkC8RaXhoB+o1PWuNkK+gOw+vQ8ZInYCtwcJTtc0B96zH0CQn+D47qHzGieFhAOahJoj8WdpykcHL92XMLfozYtOg/j0ofUvllCy6i2/lZM1NdO+i1DpaKg+nbZa4=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3913.eurprd04.prod.outlook.com (2603:10a6:8:f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Wed, 5 Sep 2018 08:15:36 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx6qdl-sabreauto: add egalax touch screen support
Date:   Wed,  5 Sep 2018 16:10:29 +0800
Message-Id: <1536135029-22389-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0035.apcprd03.prod.outlook.com
 (2603:1096:203:2f::23) To DB3PR0402MB3913.eurprd04.prod.outlook.com
 (2603:10a6:8:f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67baaf87-4716-42c9-a6a4-08d61307c448
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3913;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3913;3:r+Kn0uYeKhmOnTLnUCWHi4sHxB51n/eXALAAMpY7clF/iDFc+oXUlzhJoPbQm5CUkmUmVi3WW1Ro9vJCG+PQ9lbYofDnGf+uoprUd7d0I4UiI8sUVL6FPI0wz26xC+uaXE8hqFjf8q+IeteRBqaaFUi6A3uTgWN4/91zhy2CLIEAqqAwPm3n+dUULj3G+p5BdW2hgIX/u7cYJpEg4bsAzDIlUV1BJ76FJP0TAQ1WEmMl0BzOlPUpqcey2LXP4n8t;25:WfuGwWBzy4GJhgCEyt7APBI+GOSQKZbtoAgWeFHeHbkla17PLHZrpWheWUivqrZT1R1qJSpE7SHxfxB6rIkZul/X81RI8RYqaY6JJlrl4HahiyZMTUvCiF+EgfKYHVw8NThpS0QRQMctvQQSZTHAqfE1h+wgZXbHbS5xZc5VcWe5dpy/JCoSPbNU2Qd/XOIaymiBsNznKCC1iWf5TCmSadeXisHtf5+CPzexxuC+a+aB6pVur4fdRY3z68iJYxFAnJmIsxV5Ho8chMS6zbmv22gyFAeTA0lynJOuigPf03wAc52YKpSLHP9dDQu5bxxaP3Ef4hq+kiqn1QNnOn5vfQ==;31:QtgB4LElpa1e1huW5Tv9BzHliwtn2g3x1+Zk+jIPTIZfMMvn1fMP3V6Hy9hzshHGUzQ9WEEaOqiPSnp5aA/PxM/icDJKmnNIcE0RQTYqgBw7fVBIqQ7JhfKQwU1q50anWM58rGETD8jYcLs1rf/5WuFuHiwIbYp33Yz4wyx9HNCYbwK7saoL8e0rmLHIeBpFXSLBXjcutom9npPVzcalKJbt0qHoUW1XraBQFOtzrwQ=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3913:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3913;20:8h3D6izzsrB2qwogWKOskXZrbZ8t/vvRBeq5tZVZU5pGikKY09BtuEpCA4hZ1CmgfIX4O6woaWKlz6rfMl27fLl98u6AJWpksONv0C93oh0RdXx2CX1FpTdJAXXVsaf16D/7EeMeHQxLKRMizhSVQ/S6Rcu29IubsaDn1bh8E7Tl/ZDXczmP0Jkiqio4zItMTCs8kPM4xQAgvsINA8EPIRiOy0h4jPYzALLFEO5iWVqG1u6hBbYDCGGJuQGPUxn1nJxjV8IK5D7dx2gqt//VfConDew5gDQh8T2LRHopvtFFhuXlIZiYUCG7F1fMH3e+twAv4Iq5+jK0z4RE8MuntTjdXtxCfWIQBtafsW9FqMsp+SOScohcgmA/RGA1FsQ+ufRn5g4Z3u8Val7IS/2vkBk0g+F47BOGP9DybELwQZO9ycWOpe9VuTAzMPkRbuFyief47JYiJL+vecoiSVSuZkT14KYQRjoTdOc+VYZPYbLxCtKeJhlLu4t7sHOEZyX+;4:NfyFPBT3FGrO9pFDR9y8IsLwcD5+TTe6wqPDZq/KzGz8EbNz4RlVz4wK014+IIdgU5Nvu24mRGCFmtMAfiZU8fw8HQuuJ4cIN+VT0iSJ0fQEs44UH6GepqdQxhKc9otY9JPZH9uchAXto1qrs/qpwLo/fOzEL+lUO1+iMZwhKXG9eimFE6D5RYyvWgJw7grzvhWgdYHE/cynfBZjALlBrpa9k4TJbj2qZ/KwS133BwRak9qqJYELRT3I7yp8jlDkf64L61xPH4OgLZ+GpmKrVl1fNiX3dg5HAh3nuxHE/oBVBXGd1k+KOTSIBss/wnBq
X-Microsoft-Antispam-PRVS: <DB3PR0402MB391392D3C0E77DA257D3CF09F5020@DB3PR0402MB3913.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231344)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:DB3PR0402MB3913;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3913;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(199004)(189003)(5660300001)(6512007)(4326008)(86362001)(66066001)(6486002)(68736007)(50226002)(47776003)(575784001)(52116002)(51416003)(53936002)(48376002)(50466002)(25786009)(3846002)(305945005)(7736002)(2616005)(956004)(36756003)(97736004)(6116002)(186003)(16526019)(1857600001)(8676002)(81166006)(105586002)(106356001)(81156014)(386003)(6506007)(478600001)(486006)(6666003)(8936002)(26005)(6346003)(476003)(2906002)(316002)(16586007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3913;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3913;23:37ey/NX32HC5tZoyAenXtqZiEX0Imi/CsHy+j8m?=
 =?us-ascii?Q?Ra333rvv75AMqmPVi0ldapa1X5R6dj5VQFI7YKMF6heaEvTYvlqXkEuQRoKS?=
 =?us-ascii?Q?vQg2acwsa9cHBzDB57WfxHFa/fkBAvQvGUDCVaUA80+0dkymA4Y2eirtim31?=
 =?us-ascii?Q?6JzyJ0+EBKpXcgB9cbu4Na6Ze7DMBHMyAeUnTdqMi2EVaIyj4FbzSARRM1Zl?=
 =?us-ascii?Q?yR5c3/ssadxQCZCiBlEAAKoQL1DkfpFZs5jDV6ClR1ipoDa72bQ0/XXP+b2k?=
 =?us-ascii?Q?fKXcG+JizdQMb/1eob2kx/PLi5VT00VKd9GsxQjL+qkBA29UwDng1LxuGFBH?=
 =?us-ascii?Q?MstNveXnuAVB2SndEC32QbMxhQuWSfxvO6wRn7n+Qr6rp5ureSAtt20vNRfS?=
 =?us-ascii?Q?SpbdWcjCrzEi8PCWk4T8bk78XZpZmPrxfqyeBs2zqG5lAzkCpWsajIj6zfmI?=
 =?us-ascii?Q?Ak54cDJZRyJT8mfSTu8e9M5fT0iCihUdK6YgArnql+fRhrxM9wq00+nj+DZV?=
 =?us-ascii?Q?wn+A6lZogeDpDcGZLFj7/rKc1Jd39tdLha7sQwDX/hNIziQvF2XCSQUp8agO?=
 =?us-ascii?Q?Onx/SGf4di7FLiq5E93H/vrk1utDiQ9iP717KLOx2iZ38aZsyTBVmUWmO3fH?=
 =?us-ascii?Q?Gtw8vTACOKmf8gpKOQuSYDVPaCjItJsW0mthCLDgycqidTlrsbaBF4S2arzA?=
 =?us-ascii?Q?/eJhDTO0LI6vEUWT6Wc1NKC4C+UVQ4Z6zsE6QVI/hcl3MIwrDx2SNGzpu5zu?=
 =?us-ascii?Q?ITOms6QP0MOuNnyc46Ewj1IImYbnco9oRajyWHa1vrZ0TXTcpyAuQOwumkGA?=
 =?us-ascii?Q?bRzvl9cAbKD9ftl4No6YrOcMw4AAIc46mdi/75bASVa6i95jrSdgQ3TomCV8?=
 =?us-ascii?Q?w89NjYzyUJq2sWIgkhwTf2Lb/MZdsSpCydQGCQRvqx0o26CyOYJtguKaeu21?=
 =?us-ascii?Q?pbFRPRVUb9lh8t7gzibT/rv+SaWtV6XMR19i8u7cThlqh7T6Trl/vBryqdXb?=
 =?us-ascii?Q?3bXjCFdHCB7/wtpFvO3bhGQy3Wv+CvqaurYw5oPjwPQ+0MI+Iu/mqiDwDvE0?=
 =?us-ascii?Q?zzAQ5wqWScBRCZrVz6e7MCoNJjoRdB2seJibS3Utxexvf8cGljE+fhhC+zgo?=
 =?us-ascii?Q?UPKjPV4HLE4H70XAeRwDgtNCBcWkIKKxKEqcNCT34EtnTavfUXiTlc5Iyjw9?=
 =?us-ascii?Q?Bb2DEfEms8t9KA3E=3D?=
X-Microsoft-Antispam-Message-Info: nOLD7JlotVGU+hdV8mxNUPD4noU1blI2T/W1dphF09+bHZtVJ6/O9iaUpT5/g+rPkahQizWWbpR6UzV4qeSPIPb+7XkdDc54arbYVH6j2Lu4x7z9BCuGDn9NRQ5w4EiZVAoyuP1Z2wyYCTstJM9O19clEgNLB2gATP05XaVd9xFKC5J7LaAseqqnC2XmJdIV0eMU896LxkLusLPHi3CAu+hgxXqExABeWWwlHevBQbr5nAN5nhf4oXklEEb8HUbY76itygjI74vhgvEaOpLgx++XxxmKBBT2DqorXOWjs4H1/A+W8bQ9BR+tnLv9A4jdBss9Rk16a01t0Umx1IU/xIeSPS4ssWw6Tx35zyuiqoc=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3913;6:9ME5fEYnGmbOzfEz1+zu8b3hN9eNO/N6nQB9wHZ+jYxkQhbuHtKa1mqN3DGT1BKDknIsrH8Hhu/rWENAzBtWn2jtdhpcK+UrR9AzqSuCcb5u3XOF4P/QJ4TJIv2mcMqnHOwX+SER1wzuJu23ptYsiQ3aeCVK/CrTwRvDgc4CRoUZU3UD0QhGN/4CNyN1wTU7uP0PUfWkLg5F02gKg+GstU3egt99oZucuQK18bEsal2EVmTxe/qXnfsiG9ZED1RkYDDJzznAKB/o99TVgq6BSVvXGa+fo9kkky4EDFnno3exnDNQvNKk53rM3RM9xrhZzzOR7UeWMVEcakP0/rc4JgPR7V4ZBCfSibxpvAg2ldWB/BrP9C70zn30U6YyidCkMmT8TdMSUnhLr3uMnOAGs9Q4QgKNsD4xpbRXwbJXo7Uyt4cQPK949Rm5XSgVIoEGSpbgVZIJ+yNNqH9noHC7HA==;5:X2DDQ7hlgkGD5ISYioAKbauA4wqUN1vrh3+SszTYdmNUsPBSCYbICPmv8Qwp2PqnKO0s30tOLcBVB49lfgMyCVTJoezmPJn8xlb+gkrUPorLlfMawPpeM4Pnrw/FP5IutmIZq4r9gTdcsf6kE5/r6mgRDEQrvWkTOlRpD0oQO6M=;7:VdMF3luOJ3y68aO/tgehkURGQobCDI6Ku8UD683D/juXHAI7uVJbVVNVkaAEwc/p+uGz+6k9RHIIqpgMm1RC5ex8bbtlFgaejkHpgac6gqR68mC6PQCpj+7yg26T30sV/n+psmnS+CFBVr4QWAMR2ky5wFSyXL4HuMruW352HYOv2Xv0afCqLggyOD6P3+OuCZ38Z/sBXDCJEoq0PmG65IBqSliPwit3Bkw7vD6USdQCC3fUQ2wgb71YEngTKejk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 08:15:36.3298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67baaf87-4716-42c9-a6a4-08d61307c448
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add egalax touch screen support on i2c2 bus.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 246af86..a6dc5c4 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -417,6 +417,15 @@
 		VLC-supply = <&reg_audio>;
 	};
 
+	touchscreen@4 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_egalax_int>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &i2c3 {
@@ -452,6 +461,12 @@
 			>;
 		};
 
+		pinctrl_egalax_int: egalax-intgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_EB0__GPIO2_IO28		0xb0b1
+			>;
+		};
+
 		pinctrl_enet: enetgrp {
 			fsl,pins = <
 				MX6QDL_PAD_KEY_COL1__ENET_MDIO		0x1b0b0
-- 
2.7.4

