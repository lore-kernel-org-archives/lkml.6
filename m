Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754947AbeCSCdy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 22:33:54 -0400
Received: from mail-cys01nam02on0078.outbound.protection.outlook.com ([104.47.37.78]:63173
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754218AbeCSCdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 22:33:51 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <shengjiu.wang@nxp.com>
CC: <Linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH V2 1/2] clk: imx6sx: add missing lvds2 clock to the clock tree
Date: Mon, 19 Mar 2018 10:30:44 +0800
Message-ID: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131659004290820749;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(39380400002)(346002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(72206003)(8676002)(5660300001)(26826003)(2201001)(104016004)(336012)(51416003)(498600001)(86362001)(575784001)(81166006)(81156014)(50226002)(105606002)(97736004)(36756003)(305945005)(316002)(356003)(4326008)(48376002)(85426001)(53936002)(50466002)(110136005)(16586007)(68736007)(8936002)(450100002)(77096007)(2906002)(26005)(47776003)(6636002)(106466001)(54906003)(32563001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB349;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD018;1:SUHMUj6fTVUxhay+pbjdZ98TwlSRbYBVom6n1pYn093aBt7xmyDK86jNMsQQxODoEV5WGYQh+iy3tWDmgFaFmoKIL7++jHxa/qRQdw/FttLo7ppf553fbPAyD4Fl14kP
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50368f8b-eb82-4377-092c-08d58d41d8b1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:DM2PR03MB349;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB349;3:gs4cosUez8nGIQKc7048Uad0QGBztjkE4s+4ySwTnkheFrcPPq2GSdNhUVFSP3HxjBLkbJbpz99D58VqynxkrTWttdhJYBbySJ+Mm7JRe1hfNPh5N7y6UB+G+HAyzZlS0T8UfkKjZGD/BtgVhVU38xrTg6uStcq3MzTGqisz9s52pxuExCcDp5H0CDd80lanIqmAKbcCe5xTo5+i7EgVnGCnu5HAE9lmT/Cj9GeDim70W6gjRA8ahaIjxQSwTRQoD1IGltmZrnvsttSA9av3cSJ3nKAAVX0yvNqCuYrIDmBepcF8rb9ezrQ39v3eAYZnomnkJD0k39P058pU+biWLPQAmedv2/SEvV1kmJ+iPkg=;25:gRrfa2YFPvRWxIzMVcjlbKarAVFtJQ0+GDmR+MxWzfHATT68duHwtIIqi4De8+ZwBbdxtmib9pqP0tiN2RcTimtdF1r0kpOKBG1xBdLvWIYboIjiHQpsXPCWI23p4D5tQgu6Ob3ClA9do4YZDTKzrRSeG7zpbV63gjhW7IOAbXVRNxhin1DDnmXZ40Yfs0nh4VrOoZMM87PERvQL6t0kGykmYaUeviEMUQjgOCSvpvEIEzk7ObKhlKheHU38x2di+jlSxwTJd1m57cnYE3uR4ypArfZvNgoCl3sZq1sZpzGKx65k4dSc1g26A4+MNJAYOOLdwvP0UuAm3h+L6CQwYg==
X-MS-TrafficTypeDiagnostic: DM2PR03MB349:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB349;31:wcWnZ1IK+HYelbPkUR74e3uAO7OCGqzmtuP1ucbmDSZn3be5e/5EQSKKlauiqflfP9qPS+0xZ6PmGxChTHFXzormjgRXIuZiu2Gx5TCDBvUldFwdsCwnLrZc7n7YlNihsnWYl+r0qWDckig2Yx5JM5bccRqK6gGPq4fbMDlrlhNKY2nckX5qBDtqNw5BeE0wtdPtWT++HHHjrPGVMvD3DCPkpLQIetiurWKr5+Djt0g=;4:DYCMKNUInwMsyjHWd1bXWTgiDYL4GpXD69JYSSi8yZ35mvXf91jsyvuDJPveRH94l9OqZze8RiQTCcQIFp4mpzfK3bHKaxV+5jj9pyOcl94cvQGNWM+Tx0S7KhSS6Un6FO+tcNOtPOdUTdiL2o14+49X3byEXNQ7Dj0iODwy7Ku0L68RH7CGyticx7Xir758K41hzGgKz4iSR0GQbtnXDPVe5uFUH2AV9Dw5jPb/1vgni8QjMw4TZDFxpziHa1hoP5QZ4mlksGpka9yL1f30VJ6fFdOoe5ehCUh9ILgmjCFS+f94AUI8tWCFgqTszfE6
X-Microsoft-Antispam-PRVS: <DM2PR03MB3496C03B32FD1969197DF3CF5D40@DM2PR03MB349.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6096035)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123563025)(20161123559100)(20161123556025)(201708071742011);SRVR:DM2PR03MB349;BCL:0;PCL:0;RULEID:(400006);SRVR:DM2PR03MB349;
X-Forefront-PRVS: 06167FAD59
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB349;23:4SIOfaAX5shqg8YuIfMI2DWchtNBl7G4lJbKGBl2vB?=
 =?us-ascii?Q?tE9TyuN2VtNGzYVqoUcy+Z2NJExU7bTKjafOp97zgXwNrRcVmi9Av+tqIz23?=
 =?us-ascii?Q?E8z0HHGkgLhRMVRryv3muCytygreIb1B3Ni4/SBs8kF/DLfhlxPV+AxX52Eg?=
 =?us-ascii?Q?NFEBDHykhSmwNCT4TxEsjkzbL7621P+DNdtNTlekrdWuaTmVS65I3+lFQ1M+?=
 =?us-ascii?Q?g9XFoc+I070fp7OOMenZMYsymhu2OehccwZ/0esGmoT5kSoK4CE/GfsmzRBW?=
 =?us-ascii?Q?M1v9YOJ/4bPIJNbEmp1KaOiL6R+Ns8RdTs6mApkWsJI24QdsBgiu5bcaZnG9?=
 =?us-ascii?Q?bSO0z9rtxCIRZXdjBN2vHlb16FJ2itqkgdwvoSp2GY//mI0tqvM8CZ9+ZAna?=
 =?us-ascii?Q?IZQ+CvkK7Z3wIeieQMXkUcKARyyA8P3JgV8WR6kPQwi92idnz5UabelURNk1?=
 =?us-ascii?Q?OQFqBaytlXIVjUXMdDnif5vUAs0A3nmqXCFAmAgbtVaUU1JfRhzxwONXnf0N?=
 =?us-ascii?Q?OfSKbBa/I9rLBq0cLMOU5e9S7ZqSbOba+ie412+Uuffs02dbsgSEp8/xxeWa?=
 =?us-ascii?Q?YLjt8qvR0Jp1Eb1KyyfU/0xYfli454gTqaqNG94PP58uGh+7SPopEJ4RgJx1?=
 =?us-ascii?Q?b26nhVaKexOUaGwyZdmaTnTOd5jJbU20KLAsVLh541PQLQBsqFDWWGhHsO+B?=
 =?us-ascii?Q?GftS0tZbT5q6/TR4KisLmnbwnxb4kTB5lMDZ+46pRml3wztDOubh9xAkeggB?=
 =?us-ascii?Q?udWS8eqVG/1Zj2hHw2lBzW3QOzTsBsup1O3VUxypxoA2cv3hh4odlTlTA5Qz?=
 =?us-ascii?Q?z/himyokr6bwIaZY7OKFB1dOlJZYw4iMUumbjjjtP/yYzxm/Z7zi2T7igrI/?=
 =?us-ascii?Q?FGdU6KTvCL2b2maKP6z6dW/wggAvFJ89dLm21BnDYJ31k4CAaZUCHt1u9hs1?=
 =?us-ascii?Q?tjn1If8EVEOg6Zc0vHcel8DDf6wvQxreqVD2djxg/SnM+1SgQQm4rqn+p59X?=
 =?us-ascii?Q?UztjruSApFG6OcLw0KeBC2aSTRgdMt187YB6SY25KR50eeMnGb03EvbynDK+?=
 =?us-ascii?Q?s9pAzOsAa+40DgpmPRUTY4T/JI8/Eu3fscQw598olodhf/4TIvkL+ob6bYkV?=
 =?us-ascii?Q?AOuI0KnIxfTMHbD8/8LwFoQJvnBY8yB/cASn7Im1vSUtMU0kng8g=3D=3D?=
X-Microsoft-Antispam-Message-Info: zp9z6OrlWECizoGGjBZruqcbuqXCZRq/WsbthlVefjg1DfHYQas81Yv98DypIlS1Jd0inqf0fCX7jBDYfqV12S2SLo7PVoWMWtx5WrzlqF/oAUn0gGxKFMAgIabj+aPbJPTW0GNKOYrJbXBulO67rpiyepOKMuYLKaSlNu6EztTy6kB/a7+ZzjBNwjGqZRFW
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB349;6:Fa/fDC2FBbKddqBOJ3NFQD1y2uqfOtPpeqUlI9VG/ee/0GPhRAgAb/PGb1YSPsLup2AvSXG0JSOsPPfT+lywC4bU8H7zH89hJY1Guml8PfcVKuzBdv9lCz6cf6BA4qPesNg0/5G9QlJ9tIFRqHHb7fudfprroS9EpykQZ8uhpUmDYwpgi7a+leOiZ0z6lkmcZj9AtmBR3TgpX7DMScxVVzDX02WdTD7oiEAb4FUmZYIRGaJKT6cvDV56pMWnAuJgj3du9gKwCA39kykunCFjPmPLtw8kGrfFBY8GlLMQ7XYuxLVPxcsnX7FEjGSK2w+9AvYCHwcHbWkV4JOmWoILyseJ3mdtl952j+hXTjnHhlg=;5:CBnog98i8NlbGkNP/DOiPM+XxNECv+FFKJKomZ80rCVdfghiy+RGCBjDmB1q/KgimmN1jnWhAueBu23DqQUq8Gzuwi+KW8MIO6+SMLVa7k8yOZvxUGDHC0wdN/mWDyylY1ZML0zhfG2q8lJ2DA79zz9Pe/INBCv7j4BssmkXMwc=;24:7NJNIbFGGzYQeE9laGQuKzihb2rUmn2SEa2MSLjhWUukBwueIUijfhZBNX1lWMSskRFwxl8lVC82Jf7dYqXx5U1/z4ibn5J7FHc/vaQg6Io=;7:wVwTRveF/urrR/sCuoRVzX7IepKdylLiz62swczdrV0CbJEypnw605oIrWGTfI4bqYA44rfT+a+WjKGrmVK1MddT4jYAFgptZqCU7NJ72e/MkwdH2GKRtw5Ac163tC9A/AVbZ+mFAyyGZXJgqjNmopsj+Gv4hO6jQxEr0rRzRZe/oFBwiGHcRfQ7/QlKZ83uqCvgjM6RmDjlFqg+D0I9lLsKErBcYxkjmg/bFFbgwhAzObpa3yxCMgLI/U+M+CKB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 02:33:48.9104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50368f8b-eb82-4377-092c-08d58d41d8b1
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB349
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX has lvds2 (analog clock2), an I/O clock like lvds1.
And this lvds2, along with lvds1, can be used to provide
external clock source to the internal pll, such as pll4_audio
and pll5_video.

This patch mainly adds the lvds2 to the clock tree and fix its
relationship with pll accordingly.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c             | 8 ++++++--
 include/dt-bindings/clock/imx6sx-clock.h | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index e6d389e..478ad0d 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -80,7 +80,7 @@ static const char *lvds_sels[]	= {
 	"arm", "pll1_sys", "dummy", "dummy", "dummy", "dummy", "dummy", "pll5_video_div",
 	"dummy", "dummy", "pcie_ref_125m", "dummy", "usbphy1", "usbphy2",
 };
-static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", };
+static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", "lvds2_in", "dummy", };
 static const char *pll1_bypass_sels[] = { "pll1", "pll1_bypass_src", };
 static const char *pll2_bypass_sels[] = { "pll2", "pll2_bypass_src", };
 static const char *pll3_bypass_sels[] = { "pll3", "pll3_bypass_src", };
@@ -158,8 +158,9 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_IPP_DI0] = of_clk_get_by_name(ccm_node, "ipp_di0");
 	clks[IMX6SX_CLK_IPP_DI1] = of_clk_get_by_name(ccm_node, "ipp_di1");
 
-	/* Clock source from external clock via CLK1 PAD */
+	/* Clock source from external clock via CLK1/2 PAD */
 	clks[IMX6SX_CLK_ANACLK1] = imx_obtain_fixed_clock("anaclk1", 0);
+	clks[IMX6SX_CLK_ANACLK2] = imx_obtain_fixed_clock("anaclk2", 0);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
 	base = of_iomap(np, 0);
@@ -228,7 +229,9 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_PCIE_REF_125M] = imx_clk_gate("pcie_ref_125m", "pcie_ref", base + 0xe0, 19);
 
 	clks[IMX6SX_CLK_LVDS1_OUT] = imx_clk_gate_exclusive("lvds1_out", "lvds1_sel", base + 0x160, 10, BIT(12));
+	clks[IMX6SX_CLK_LVDS2_OUT] = imx_clk_gate_exclusive("lvds2_out", "lvds2_sel", base + 0x160, 11, BIT(13));
 	clks[IMX6SX_CLK_LVDS1_IN]  = imx_clk_gate_exclusive("lvds1_in",  "anaclk1",   base + 0x160, 12, BIT(10));
+	clks[IMX6SX_CLK_LVDS2_IN]  = imx_clk_gate_exclusive("lvds2_in",  "anaclk2",   base + 0x160, 13, BIT(11));
 
 	clks[IMX6SX_CLK_ENET_REF] = clk_register_divider_table(NULL, "enet_ref", "pll6_enet", 0,
 			base + 0xe0, 0, 2, 0, clk_enet_ref_table,
@@ -270,6 +273,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 
 	/*                                                name                reg           shift   width   parent_names       num_parents */
 	clks[IMX6SX_CLK_LVDS1_SEL]          = imx_clk_mux("lvds1_sel",        base + 0x160, 0,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
+	clks[IMX6SX_CLK_LVDS2_SEL]          = imx_clk_mux("lvds2_sel",        base + 0x160, 5,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
 
 	np = ccm_node;
 	base = of_iomap(np, 0);
diff --git a/include/dt-bindings/clock/imx6sx-clock.h b/include/dt-bindings/clock/imx6sx-clock.h
index 36f0324..cd2d6c5 100644
--- a/include/dt-bindings/clock/imx6sx-clock.h
+++ b/include/dt-bindings/clock/imx6sx-clock.h
@@ -275,6 +275,10 @@
 #define IMX6SX_PLL6_BYPASS		262
 #define IMX6SX_PLL7_BYPASS		263
 #define IMX6SX_CLK_SPDIF_GCLK		264
-#define IMX6SX_CLK_CLK_END		265
+#define IMX6SX_CLK_LVDS2_SEL		265
+#define IMX6SX_CLK_LVDS2_OUT		266
+#define IMX6SX_CLK_LVDS2_IN		267
+#define IMX6SX_CLK_ANACLK2		268
+#define IMX6SX_CLK_CLK_END		269
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SX_H */
-- 
2.7.4
