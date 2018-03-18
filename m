Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeCRDRV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 23:17:21 -0400
Received: from mail-dm3nam03on0069.outbound.protection.outlook.com ([104.47.41.69]:18553
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752379AbeCRDRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 23:17:17 -0400
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
Subject: [PATCH 1/2] clk: imx6sx: add missing lvds2 clock to the clock tree
Date: Sun, 18 Mar 2018 11:14:12 +0800
Message-ID: <1521342853-2941-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131658166351494600;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(39380400002)(376002)(396003)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(81166006)(16586007)(81156014)(4326008)(450100002)(8676002)(53936002)(106466001)(8936002)(2906002)(6636002)(6666003)(104016004)(51416003)(47776003)(50226002)(72206003)(36756003)(305945005)(356003)(105606002)(86362001)(26826003)(498600001)(336012)(2201001)(68736007)(85426001)(110136005)(54906003)(316002)(48376002)(97736004)(77096007)(5660300001)(50466002)(26005)(32563001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2156;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD024;1:O8AA4NJd8Ry+2+rjYky16a1MyHHblniIW03KrTOiOhvBwHHq0JmR5abVQ9jyfAWMKNRp0NfPHzlkAilWdkryNriuZL+BRuvLMkQxTvCV1kjfBaEMYVhk1q59Sv98eYne
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 262da714-68bc-4e48-7844-08d58c7ebf96
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:CY1PR03MB2156;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2156;3:7cku/g5Tj0K+qUUFukvgl0ria+AR6epkzGu1aumWGRyEr2qDrwYkXS4Z1eEp/5AL9wxWmi8mZzXo8EizJ+Q54tLYuedmD0na8dVayoBXfJHsaZCQxd6tlHE5MIbeDib7Y1nS/q8+4aNpeTpRf9/qRZC91Tsk35De77gZekgUkQ0FHhjBTvjtwAFxybf3lwBbhPjPB/V+BahAxtAby+a7r0Vh3aNyb2XiK6K7EVOhHlxjakCt6GfsvzNfnz7SYO9AdKPpbs9tZOuPEmlI0fbMMZswz2wMnvVLIFa9AUZ54V0D1n2sc1tCb5na8WtjXSXqC4qNcoUshoA/yXQoKZ6fEOM5lw6gi/upk3DrqUjqEM8=;25:TU+XSSFyk31PUMXnOmoE3UVXRFex6B1Mh0xbfLELHMczV94iz4c/asoOWLN1xcmXXcjuRx+TvOsZLVPPfVuvM+inE6UBcetG0S6fi03BqLyP9Fvoqb1N5HsOqzUJBuWg+m9wWhi9j8y4Fj/oGokxpSqTPnGRn/ZfiEliA4wEbo8xLixRLH4zzZkVW6wgA8oY1f6gGqgJO2LG5Fk91NkIuL6coZdcmp8wpT0HZkeL2DiF0adHBdxTkVwHcfvAkIf7iJS86i3MIzjyRs2NL5Q+Z1hE4ejoXz3FXKPiKUNmEeD51+NbvmSz2yRM6FtR1RJ0ycD2CGb8Cf6/tsw54vQHmA==
X-MS-TrafficTypeDiagnostic: CY1PR03MB2156:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2156;31:XeCsXQ3XTY2irKeF0WsoG/GaKE/nvB0whw8E58uPkjo1Rcv5HAoTvY6j9R/ip7aorpBYxmhSih/QNfHrL4OmaqAn/Lu0Ri13s2WPVN78LapHaO37rH2XszIrYf/X+s0KV6fTaAz97YNPP+O7RvycJ2A+FD2U7DdfidG8oUTvPSUYq0AUUzBW/p4mt6LR7SA9vmvOSQrvGDujPzmh7h/7ioc6LD9BQ0NjODsH/eUpjbA=;4:hembFBlTB0GLt7W6edO5ESPgFleacSd9wYz4XV9C0b37EEKpvRvz6QeTU2+GVscNWhgEi/o9pPrbRn3JtdJoe830wHs+cPG5GWlW70x/flpBMe1RUy21TVw+MaCnxaGQkwK+4comqLcd6i0wgmzrr5VcIQMdyPJHyPz7a0+yt+diWF3qtOI0XkckBusSgxZ9bTsz+im7PFb9fkwF5azuQk+i+aXqoB+pe0Qwb9mTRREHlW3NkyL5rxrvCQJVnJNoI5u1uhiWHCDczX8q0gooDo6gm0T1rPfXxBhxCPl0G4nQ9vdqsgAxzuO1fZVCsbVm
X-Microsoft-Antispam-PRVS: <CY1PR03MB21564C636134D3BAFC51E821F5D50@CY1PR03MB2156.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6055026)(6096035)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123563025)(20161123559100)(20161123556025)(201708071742011);SRVR:CY1PR03MB2156;BCL:0;PCL:0;RULEID:(400006);SRVR:CY1PR03MB2156;
X-Forefront-PRVS: 06157D541C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR03MB2156;23:HrOPS5jJ3UKF6gbmV3lUCH7x65E4kd4iMew7NuUVQ?=
 =?us-ascii?Q?f1n5V7p2bi/8OOeH+hKNE7BOEVeKSrfQ/GGXHMw+uLmUNZGpl2X1a9kGOul8?=
 =?us-ascii?Q?YDkSHWspy4nw5YcVZX2NNN2pwZPT92idf2FD+WkagRcGpcmrDv64tQm0bHdd?=
 =?us-ascii?Q?UDEf5tHSzIDPvzXE44ViL6CgzyoQBgwy/tEshGMHnJfrnbBiXxz8WgXYASe2?=
 =?us-ascii?Q?RqS3Guso40bgOOSsFr0E6+vtPvXXjuQ3mKY5GJaZeolsy0sY0rKysLFfgBSo?=
 =?us-ascii?Q?rNbCgRRBFGAIijtLQGFinpDz5HrHZD41xBA6c52/OKsptc0lcPMo90TK6YYR?=
 =?us-ascii?Q?5Kmc/oA5BKHWHloI6hi4Z7Ro5X3pSHSupMw8ccjgYiBEVbgoPPCCez6WR5Sz?=
 =?us-ascii?Q?ssCdPU3/iQRPHcJ8tLhWHW0aHBEt3x+gFpW7dt1F20izaL1Z7LaZMGAct1+f?=
 =?us-ascii?Q?2pXNKOK0SbTBQnAaijjS5hrpxMcFj5pBFsbD+JXenE0+XA+8NbsIX2x1/pt5?=
 =?us-ascii?Q?4x4wVeoKUFWhUJdvN8sdnDpNOc8Qj0J5MaAOfM8tC6HaZg4DYWFPQsmfL7Ro?=
 =?us-ascii?Q?UtSiqUnn7AdpQyko9o6UBE29g5KMCbgacMqwAfCSHrk5N4/XEeyXHua1WSNn?=
 =?us-ascii?Q?EzCv8PKnqOiQMTaWhQKmYtVbICVPWXfxW78ODEIg3b8USDXyEu4CNmT48iST?=
 =?us-ascii?Q?sS/7Svo+msrQN6l7T+n+uSc5U8HDetYv5t2LeEG4PSqmTno1Xzdeh0s6D2ph?=
 =?us-ascii?Q?uCdhqJbhW8pv4lElcJEsd0MQUkXEKQUGoapjfvwk2sAtZ4QKU+2eEWQlYURD?=
 =?us-ascii?Q?zX4ZCBRYzfWggprDzv8nQ6EC0ixpOMSD6053GZAAHpd4aNu1uiweiSi7eakX?=
 =?us-ascii?Q?kDbSNTr1Vzbh6qJ5HqhfrroG3+EUH0IdTCERkF8g60DhWLRhmAFbxSDzF8dg?=
 =?us-ascii?Q?J5XRk/ljJCY+DJMG4DeKgVDiOFIF4ASAdsk23wWevL7e0EIoGFOj8PwDxeqy?=
 =?us-ascii?Q?RYGzR5oMCGNnxTj3x2KtGQURDwzbOIZSSDfjMgWUTC8oJK2DrG2KU0Q4cb53?=
 =?us-ascii?Q?4BctXKnpPuRTFQklbU7DgCpg41BttV+8uHMT8v1u4iJUzrnpbXrVBNi2mOob?=
 =?us-ascii?Q?jhXkw/SyJ/mmBiGwxlCE4RWzrspA6snYITQJuvISSWzTbejclwwRQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: vy83erTLoh3oYwG0pfdi73v2W8KDO1+xWhkqQnaSHlZb78bwtIuM5P0QoS8Nwja6Z80LU5UM8y5/tr7RL5tLiS8mc4qdQ2t8vbGG/CR4wMHR8g+F8Wmfd7bKM+HTsW+RR85RY3Z3aVs7PDhuVZIkR4SNwz4ZulIvztQ+HWIwQklRseYJvsJ4Mz38/RCa7kQP
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB2156;6:sHnoVBUbmFKzFG6Dfasld33vz3k8FBx1m7iI/tMcOsrgLjzejklcZ0lOCV1kxtl3B31OljjWelhmjn9AnJd2Tje02dFxQRnLk//Jb2i+mNlsCJg2SiSpoGtU+ydyEBYa+jm4EAK6Sb6ZDH0lox+7dGI65FsnhC1160wFJLWfTJWecqjnmchXoGnHur7lKvVgdg+XKFWMP3cqc68CusF9kzSQ+1fqShOEOIGfJuXHDwLfW7Ahcyf9spUwQEUne6hoFJbgs/wC6erFM1qF5oE9WmAk6sWRu0B/hdmBseFMlY+wzCYFTSECnc4qm/nf3TNGsYxY64v3FVVlU0gMAJywVtUKbEOzzhC4rfFbymz++3Q=;5:/BHKfphH6nvhUfaNaGlnBN+7fRIs09VZ3P95p07zumRVc9BiR8/L8Y/w/iyvrFANUZTRSWwB0xE1nWobalbI9ukpr5ITgwcqS6sLc/YvzfToieeaZ1jz67EB+y17+sb3WjaEmygN5BqoskSsCLrCd9E9YN+IiPC7BJnUJZwZMMw=;24:cWLco8tAXnMv+kCAbyHmlf/X4VJjCcZgBViCddL7Lkye6hRMIRN9ZSDDaMEJnRRgNmoHG25b4UfD341DRlSbbCWu4fDSWt3bjI3yKFI0Gps=;7:If/Yqym5eFtd4cbaqpXTjLnmIwGaGbhdCIH/eZEX0/ggCxXlnBHRC0ht+u8g0VO0G+H8HcTWCtHYTUA3RvfqRLN6dXNtwr4iU0TVzdqmWMWxWov/ZRuzJpBGXqAmdlklqYPnl6tDNRYnAi6/cBI8MxThwgRgOeXFhZf97oCcLOcBx/76iMz4Qn/kPR39PIZe2j8nwHDpnlViA1wEEzEcyhmGHfSeQIEaqImQJfsx+SwffWcEPIJu8NvpRv+aXC48
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2018 03:17:14.9310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 262da714-68bc-4e48-7844-08d58c7ebf96
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2156
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
 drivers/clk/imx/clk-imx6sx.c             | 6 +++++-
 include/dt-bindings/clock/imx6sx-clock.h | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index e6d389e..d180797 100644
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
@@ -160,6 +160,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 
 	/* Clock source from external clock via CLK1 PAD */
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
