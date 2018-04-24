Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932803AbeDXCJ1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:09:27 -0400
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:34880
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932786AbeDXCJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:09:19 -0400
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/5] ARM: dts: imx6sx-sabreauto: add max7322 IO expander support
Date: Tue, 24 Apr 2018 10:04:58 +0800
Message-Id: <1524535501-8567-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524535501-8567-1-git-send-email-Anson.Huang@nxp.com>
References: <1524535501-8567-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:6tlxsyBf4RoCcgeczJEEX05FebQbVpekPu3iWh2sLE+Lf0G/P7Y0742DXYgDtbcZrM7/B1kwl/DIrqrdoGG7/54ACie28uZLd0MJFiaEtGqOG8nrJc85fkc/5hCVpL8cLQ95Vt92SMDqgU32BP8pwayw8cCjhnqO3am2nwu2mEv6XjcUluEkUYAns1vV3VO2err/ktlXuTMlKa9UeaRHs94cPf6Y/Opp/AcrkYM3bJGZB4X60/L+zvZHBeUBtW3W;25:WOhWabKAlxCxxpMha+zJTxWpqML8vtJCo8mY53tauWgUzePjiTTV3r2IebYsONxndmlPeXlaCtoXnq2P/k1zv56dJwdNXml1IrnTq9oC0uuFabUMEjU3/rlx029ux29QV6nLADEClFJPr2UfWjaXzaCZ8q2L+hrHYjtFWAqTvsHku0MwUVyaoQpx5zvJto5bi/NJCroykK7+MrsLsBSXQkte3V/tXXZW6rTcKSWBffWDWk6hAHHy1u9S2WCYQ8MvtgT7joHA8VrbGt076Xno7FbwMpbre83iMu1oi6xASGiLe7kagKEXMYDD3w6dhfcFk7qxx4KkRyQ8iae+KVdLUg==;31:dwTHccummGNRdEhWkmF/jGMN+g981vLNkYOTIvwjL8L+gJOYi5hbHANLM7c+kGKRLY5c/BOoLIMjoz2ixvdOembViDMziCTFrC+Ee69X+IrQgsEKJAIFDP/bspFcqdYZJeXDA4gqpG0wTVYfJtPu6e9YvE+7hEYg5Jh22cNQMi/I3/8o1zLHFiUWdIg29MPxTInREK/0K4V5m5OqsaxE8EfLurg3Y2PeObjN0FoSxkE=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:FXOtTnoGLRu5GpzvuYPD/H9bYytjOJfjDZVrDGcW4xYDDCj+SxbVfY2o7UOgsgE0uFdLbQn4OLwUceEkB34HRfXnB2lNwzq9FjwkWIIrrcGIXqVW/BPseM1PF0FamEx5s1ggNnr2KZ69mwu7K9qXEBImQtLWy/U2atGqqwZ6e/aQ8dbqNZgpBVRNA7Kqpd/b71cEj38rZE9WtcFommozMT7gC9hYM70LtTWsaeBB71oQB05EN+AetMMtv7O61DUVjJZRqxDViwTGTi+BG3APVOWCZ2e0frEkIcofI5A0mLNs6umybl91YOfxQ5oF0T/7sBRd+VV2Lxb4jBxZwN+IiXt8bvT7NDOsKMY8aS0U0uX+jRGSkw/sf1nl/E63VTyUx/GjBQ0xwFnFC8AWu3BQHxx685cxodn4S5Rfy6ENg9urvuzPI5ytIUJNzNSNxE6y3uaRiLYs2TnvjiFhtqZLIeqsdynkUbXDJmd4BaHo27cz+57maqqDF0eVlbAvpl1H;4:roxrIEMqtLCCFCJb7hmoeHsuEgQZmmn29UcDyFBFnfIhEsqUDwiCW+lF9LNFj5bS16M1X4+S0THO/ifR6rN11OVS9KugspJRNrWXVaVhFqWsuqRwjh0as67bF+8O9YFnJFwG+LvQ/8gGAr4AD5vJ17nYrui3Mw/ojo7zu/JPpsVA8lFOxFOix4xzA1cdocbAIJn2ntSeT1wn61NKHrmCRnlSP96UgxEVpxCJ0OGRTAaA/Iu2fv+O9YrkVUJ8ttvmSvdgBw0x8hWnth13z2ofWDRQam9m0JLmfY5I9xZEBvXaZ8LXbYzRi1vFwaWVX4qv
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315812AB4EDA1395C6A7BEAF5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39380400002)(39860400002)(376002)(6486002)(956004)(305945005)(7736002)(4326008)(50226002)(86362001)(6666003)(8936002)(25786009)(47776003)(66066001)(8676002)(81166006)(50466002)(478600001)(5660300001)(2906002)(36756003)(3846002)(316002)(53936002)(6512007)(16586007)(48376002)(6116002)(386003)(6506007)(52116002)(26005)(76176011)(446003)(11346002)(2616005)(476003)(186003)(16526019)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:2HOcfW61nAxFSHdgrbS5zNyALmh+/m4eYuoCsi7Si?=
 =?us-ascii?Q?Sd0loI4dteoxSenUag/4aAfSq4rt66IdE5VE32hemHSBDByNl8p0/UnXEjIU?=
 =?us-ascii?Q?G7RtwW8IvloR38dyDqFnEiWrkaaCUBS08X0VVpI/Yv+dHFcJXaq1nOYe56sZ?=
 =?us-ascii?Q?v3sCci+I7F4dlqszKoaIigdi6KMoo41GHydK9Tosctn9F7GcNzPVTDTw0KDd?=
 =?us-ascii?Q?v9wEtfw8PwYdA6jlBGKtdQmr2TnUvvjtiTLJTOdHXD4qu1LKWJ/qycVrmfyX?=
 =?us-ascii?Q?YOVRamvf47HQYO8TCT4XhivqF1uPMBq+XZwgjk/pYf6IIQp/n8i5SpmEARDY?=
 =?us-ascii?Q?M8liTeXam2e1EWeVjAEKxFhJYmnLunxsdv5NiPsA5WdSe7cdk6Jq1Xs5pqJj?=
 =?us-ascii?Q?MVrp1xXuvXNTLMwgXiHD3+rv1YG+jRA9elJHEtGVQi4NWwpYF+5wsJHRG0u4?=
 =?us-ascii?Q?zPrw8nsWikVIsjQ27Z/PbSlfS8spy165Hs12aJAYpGlyJ7EzwpcYOxc2OAXt?=
 =?us-ascii?Q?u0fOGfKJQ2BuSBQ1mij5CROIz8y3AeF52HPU59QjXMX+ecV9D0WLhdbKb+U9?=
 =?us-ascii?Q?Kos1L5cDDa7z/yFV7ul/11+iHli2+z0f+Qgx/PgQEZOdp8TguE6ZDab+CItE?=
 =?us-ascii?Q?+/bCBaVSYGqr7uvcHDiLN4NXbuAUmY6fwMPCuoINa8XkHoT4mBpxucgrlQnJ?=
 =?us-ascii?Q?tFAMmosBT809sDEhShQK9CbDWj6ZSxutSAdlT3w4cJ7yIwFAWtvKhGgihyS0?=
 =?us-ascii?Q?0CmIdgjMJZYn64nahUAdCv7o6aIjK8BC+tZaWp0PWEQ0a9MUKH+ChlxERaHP?=
 =?us-ascii?Q?gINAe7Vqh/m4ShOWdhcMWd67B+gMCv2bISQnOKQ2Iyzqvhs1/WBaWopkvhTj?=
 =?us-ascii?Q?veGdSRCnP7RR2YBl3yWpmepWu7uBt0t76+YGXbK3rgRQ254QIVAZQRE3qU21?=
 =?us-ascii?Q?+N0q1vUxMpNrtD7p7ig8xSEt7Rgy+6kFnPqZHc+VmkaTTqbEfvbihR7A6X2S?=
 =?us-ascii?Q?Mp6/TToTfH3VQtyppuY0jIp?=
X-Microsoft-Antispam-Message-Info: EfKk/ES0pFPKQaQG0nA0u8NYQpHJiPrZERoGQdK+IUU4YisDlh74gbc5tOMDl5sASTn9VQoO/Uitl3oyzv+1Ma/eKigws9mmW+3W4w3Oqa6rXsRwQ0RWhx15jIyTdtafF7x7EqODdlZLz/xVuCMf87N/IbvXkJDEWG/aAqiNHbZF1agaD1ZS8r7YkhgdD/fx
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:EvUvTMip/VI266AXRaExsJEKG+AIPiwxewkEFx8KtgSX0qy36CwB9RPmxD7qMiSBZKdoZBp/b7JzBe1ayz9SftNN4hEuWG0EsWxLKMAw851QN/VIJJOJlniAcYAGWHs+KAYcL1KcmDJp97dkhpxwexfH5dnJja7cTE0s2e4j+Cc4cPvBRf2ufbMB91TwpbDbsucdNnTqEpKKIrqMwq6V25UcqJS77wZjLR5dAXTuKnZIZDT6/rPwLMG5PGL4ubJkA0OKmn65d5NXHrp2uwLapjFPYiJSNbHb3yWOYHk/qt2Xq8uP2wcN/Rbkkp5pY20tdOwHGVjpdgyOCeBYJDq/9AihN5zq7jDDHZh2p4rzHF8XJgkDs70aRA6R4kNp+gR4lhTXV7ZNJl/WAACFonCO2rinSLey/3dW6OGGrWeu+iBmq4eB7CIYrQnO4tnmNkGx9iHuluzG2BphWUFdlO9YWg==;5:DT5J47f4Fpvfl8Ivq5pGNEni4nxdoxU9CjO2HzkNCz8sWwo9R4oxvk8Ws3JBFZdVRkrW67A4KYyWb+E/EPRTNhatVTuxkgE3vL0zZgU3LqdOi4UxqhwGx8k5sphNxmOvJpgK4vzMUL2YlyQGdim8jfXtGJO/XK+8t0/XkjxDN68=;24:jD6nfTexsmdmxSuI5qr2DxKx+djF+a93OzvrJouFET7nLF9M9MC6R0hgr1haLSY897V23uvvLj1DZ107/Adj/RnRto7YCfJekggseP30mA8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:lcGfM6UfgKzn45OFA3YxtZgL259gjsEJJc2cSiTpj5qgS3yLl1R9QMGYdKCCGidEmk1rbYR3ZbZw4DHFetXVVJnF6Y5Vr7kBtYfxIb0lkRqMqTg1lE58k4XbutC/H1MwlSUbvcffSbLnonD6r5WgJINh6Pi8Nduf0bEUVlfr/ZyDAl/9cKFDN+Tk+CnyVEbICoa5aTQkul2fqsVaCV2Xkpwb1hc4CXZN4p0z9F8eLlXk0oMxxYvfTPe2graNxjF9
X-MS-Office365-Filtering-Correlation-Id: b3379462-5a73-4167-558b-08d5a9886200
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 02:09:13.6052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3379462-5a73-4167-558b-08d5a9886200
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAX7322 IO expander support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V1.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 2caca934..d59084f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -163,6 +163,13 @@
 	pinctrl-0 = <&pinctrl_i2c2_1>;
 	status = "okay";
 
+	max7322: gpio@68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	pmic: pfuze100@08 {
 		compatible = "fsl,pfuze100";
 		reg = <0x08>;
-- 
2.7.4
