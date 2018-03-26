Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeCZVZu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:25:50 -0400
Received: from mail-he1eur01on0091.outbound.protection.outlook.com ([104.47.0.91]:51428
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752259AbeCZVZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:25:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, Jacopo Mondi <jacopo@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/5] drm: bridge: lvds-encoder: allow specifying the input bus format
Date: Mon, 26 Mar 2018 23:24:46 +0200
Message-Id: <20180326212447.7380-5-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180326212447.7380-1-peda@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::27)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a099ea-742e-45f5-ae5d-08d59360218a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:IJBMGN/d5o+egSTP77+WMOGlh8bD2mi1yzmyYgQU679pfH0M21Gi9To/o2wBDlvYikuVUm9Fr7UtfTZHD65OD//Qv01+5JoMiyRvGCi461wJjxx0OVKr9D1en+ee6j1SH+ldIMJQL8L0YlJ3B1ckIY1KufIAM6dc4TZvMCgY/pdfK9zNl/pSsgF9RFB4H3vOFtQgOpa3BoG++txg/uEIn1j2ZJ6E6D6oHNUAaxNLrqU34tRzVcLoM64PKpuVkKJj;25:7VQAwrN37ufwN0/haKN8zkrTKu0mUc5O7gFUb0ylBbLZYHrz5z4oYdGZd1yZoVo+SBCGKh1N2x0ZNT3pjNfuLaXq+zzTBTVFMpghTCNr55SqANVHbvpa3jC82LK8heYc3lU9lJ9b0EN/is8Psh+OHLmASbHW84UXi/OknHOBylPjna8t6EIbSjN0xLexscn1OGUUB1FIRI371GYnANipVZuCx1WDQI5vvD8y62gxkE90dLfCUQivCy3ONyBar9ir5Mzo+jrIPN9oAasCAfk1ZkakYANeUu+unpS9zGtwgbgjVv8lR7BE6YHcF3ZIuWbZawAWuLYC3wkXgKph95WpzQ==;31:AnXnqft+7EARZfCTjf1VpyHjoEYc2hHxsenVPbEkUoLBjqr6k/xSlRlwqfdziuTxt/XTnFm6rry4PKPUj47FPitAVK5mL352phZLo0cIGcAs6p16U2dwek7HEseEqpZo1dX98wjsc1OEO2A2MYxNHgSenPgzklx8WgHGb2jm8egwzyGeD2mC0WDQHk4+NNJYM3minEo9E2qj6Gu7NijbksgenZvfNCRG4bqCt+5RmYc=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769A3D46425492FE7A7530FBCAD0@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:XAE7y6uAqsYyLKV0ZRLmEZL0VWeqj/VdrfAGV0z0cXm3/MIWt1qz1vKP2S9GOUR42B1nedAhf3bb1HYHJVTWdP0UfzaHiNpxgCPGQXC5ypzVfVERSTfr2FgOZZ1S9AdvAoM65dLyivPuMGLDQBVJqDoqay2/upbWC1yI9U0McyAtEHpd9XlXp8xkjYgGVR1kSom9TNcaSkfhO/2FGsXPSG/sUjB4bAA+XngUDu5uQbL9udJFmEFGO+9LKYSDa20ZX6FTNc1J4XECZrSfmsl9WA==
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39380400002)(396003)(39840400004)(199004)(189003)(446003)(2351001)(316002)(16526019)(186003)(54906003)(16586007)(11346002)(2361001)(97736004)(105586002)(6486002)(53936002)(956004)(6512007)(2906002)(2616005)(1076002)(68736007)(66066001)(51416003)(76176011)(48376002)(486005)(486005)(52116002)(5660300001)(106356001)(86362001)(6916009)(575784001)(50466002)(47776003)(478600001)(386003)(305945005)(8676002)(25786009)(26005)(74482002)(6506007)(7736002)(6116002)(36756003)(7416002)(4326008)(3846002)(5890100001)(81166006)(81156014)(8936002)(476003)(50226002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:nffUheGPQ+1XqV+cm5CelJsSNWJwLOl9KntH0IE?=
 =?us-ascii?Q?vomDraIGnaR/FkRvR3wsQPVglYAhfb1kNRvALA81x9sTMuSoNaUlZXH+idF1?=
 =?us-ascii?Q?Ybp55R9h8ylIDsPayhE1VS8Fy3w+sQVbia5zygrQ/rddX8ZfCivsDAcQSfc1?=
 =?us-ascii?Q?mUIjx5uD/cg3ThQbTeB9tVqagtiBHsW6MBmvvvAwr1NXn7zCA5JRw0+GFEB0?=
 =?us-ascii?Q?326ItWY8LWNhvDwEpBy4GvFmeUBU6DqgFQ3T2ybBQcR3iLItOkbtZ9L0M4RR?=
 =?us-ascii?Q?2rym+QZpS4iunf46r7OHzCMwGze4cotfAQ4tpDUrxo9MnLpCi8MT+INNXTyH?=
 =?us-ascii?Q?ocUhjWkj8rtm11RTKUyMXREwqsOZ9fXieG+etiup/HSyYlDqx8ZywJ54s9JU?=
 =?us-ascii?Q?wdpXB3tVP7hGPFbluGABY9A0682xThRpUenTkDVoX2/47ZeqZ2TW7GbuXfkE?=
 =?us-ascii?Q?RjePN0ro0ak60nQxcWPGaTlsYA4tlYiyhZeDgjrsqHXSWCNZRMpshdTqLtXI?=
 =?us-ascii?Q?4NffeBn73O4yFLjnCc3pNXlTIEqsVn9r2QrNaYYK8tXKMCfE727NVT01h9ME?=
 =?us-ascii?Q?kbmDbuGubIW3OCAWaNRIwNwlRZAIhoQ/MHxpLsmj2IRVcHmHHd2KmQP3+Ske?=
 =?us-ascii?Q?NJwCjrjmVtPSFqrSKfgFMemfOWiwj/isKNf+mSAVkf7sIndoVxHHU8By7Pbn?=
 =?us-ascii?Q?7igO2e2piTtSy9o7YG4xFXd9v7fvlZdDYabwas/4NZUwKYTT/lSKa4d9lwm0?=
 =?us-ascii?Q?0WTI99JvR0L/fCL0Y5zOYs59+BH3qDdAFtVNZGVBbC0wInFky/syjQsJP0kn?=
 =?us-ascii?Q?58iNxO4g2gGgz8f/U7e5Qg+BakZuo3tmhgbCXXAec/8tKkkHIeYQ//go2rV3?=
 =?us-ascii?Q?ac2ZmzPhxkdGWPq5wY2aPH4L/zE9o/0Xk23cZev/VwKevdDa9QxFPotvr49N?=
 =?us-ascii?Q?zg8IFb9oDyGsx7DnlEWeZzur2gTmJjR7dF5pbuviAjABMY8cAwMp+Jp7SWPI?=
 =?us-ascii?Q?t0mo4fzlbOQkTXm90hO0isWl0qboQm98RCslpvXNNQwgVVG9SFOFFCYxh/oJ?=
 =?us-ascii?Q?TQfbrVvVnME27cbLxPZzFgGmhL9gZBWDQQixzk/Ws3HIEvMrIvDrTKD7N96s?=
 =?us-ascii?Q?qyXVDaMlhGTuVUN/yUKUlpxTBon+j7fFlgb+BreO/eFL1PitBN0ML6u7EaJS?=
 =?us-ascii?Q?zKvhqHH1TEH61myJWVMlNbRG0ShY7LVgdfOJYd4wUIOR7TYnsaxa3it8CIKO?=
 =?us-ascii?Q?mtOC5glzXNgLrgq1Nuh8OA1Mx9n3wAATOwS03ALmQfHC+nd/fiNs6RNv0tQ6?=
 =?us-ascii?Q?bYq46f230bSdGDXJGcrITilAj1PK4Mb/E1vwp/8k1UH4lPQERPdgf7IoGXrT?=
 =?us-ascii?Q?0OeolkA=3D=3D?=
X-Microsoft-Antispam-Message-Info: a7ojIwwrAeShxIuYoKKEBrmwXKEs1kO83US8Em04O9GKx9AGsrsMeTtpSBvyT2TD4gocTOZZgmo9MSvNK2B5myeGM13U15gPCLCKJGxq/hJuO1hkQyyuG5Aj+Rvrn44o4oeO3QsMFVU7uHKqrNbkm4qq//fKzqySSSqAvadlbxJNdPMapb2cB7gAL0HyllKO
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:s5NiJ8TAd1V4P8ppdW0gOzHNmYEqm5e6Vb0trJqBKTf/sZ/29U0wVOzEwFvV2wBtI/lSC6PIY6OWkJTDFMsEEUJaUVlh/kzaDS3y8/WRvWbsrd1Xrfe0lDWlCTtEJFPksTmWN4D8kw/ZH42cu8tPhN/bKAj1YpgLf4ymB5/k4i3h1HlHV6x2Ip/1gWF2Oqqq7r0zmnItWpvQnHH2CnMYT+0bPDf6rzsD8d52lMBH31kMPI8nKN7w7dYTtmUDlRhR2l4QbFa/VsrMZKtXoOC7RAynZ8LJ5d3h+yvQIdcrjFCBowO+h+F5ogFa+hXwIEm3obSw+nkvNcEsXLdxuRsvdp6P3so5bYUZf9exgGHh6uaOnlQr9FxKOyhvI3hAVT410t3EgYVUN6TNHyJ3KudBLov0skNy7qyFK9kWIaSEbo/HqUSPUdIV+MC6udzBbp+KA1u6zuIjM5+LJ5fBpqHpUA==;5:BiDle2Ad0+gUyGBdFYaC7Hmbckwr4KYX1JqeyLu9LPxub28fvvIfqmvb/BVx4E4jbBE4lsyCKulvyUdiABsddAkvY/mUAtiwu4JiwH7UOsIPz917TQByHReT6jdxSiCkMS/9HN6gcQwHq/Suo0QhO7vPP9xxAOoGmGzZwuOxm68=;24:UrCE7SRvfodBKxjoslA9P1ngtOYWzJopqlix1hevO6kkTXugswfWt63CyJxIeUD2Cw1IAME2TsZq00Tl3ttAE7FGvvQtLbm/3Lsa8h2kd24=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:1+oTJdFz/Ezf7n7/8DYxnAY7aTi+M8R+zD9gZpQhgJJnQnM835/6czTyvUwl12EOCYTbXpa9xPie1RnI2N0XGuJTROSFrJG5+mdm5OOnrDbU2g6NIUkYQ7/ag3B31eTcfXzEHY9uGlff/cfdhDOCLkokpepZijBbFhoXV42B8tyrTWa1gFpMAL8X0vKDop7fOEXwxMopYnaChcaQOqmX+O0KBgo4fscSk+QeDkTFC16JhbZEjfA9uMw+fjEajH7R
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 21:25:42.0994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a099ea-742e-45f5-ae5d-08d59360218a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the bridge changes the bus format, allow this to be described in
the bridge, instead of providing false information about the bus
format of the connector or panel.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/display/bridge/lvds-transmitter.txt   |  6 ++++++
 drivers/gpu/drm/bridge/lvds-encoder.c              | 25 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
index 50220190c203..8d40a2069252 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -30,6 +30,12 @@ Required properties:
   device-specific version corresponding to the device first
   followed by the generic version.
 
+Optional properties:
+
+- interface-pix-fmt:
+  List of valid input bus formats of the encoder. Recognized bus formats
+  are listed in ../bus-format.txt
+
 Required nodes:
 
 This device has two video ports. Their connections are modeled using the OF
diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
index 75b0d3f6e4de..b78619b5560a 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -9,6 +9,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <linux/of_graph.h>
@@ -16,6 +17,8 @@
 struct lvds_encoder {
 	struct drm_bridge bridge;
 	struct drm_bridge *panel_bridge;
+	int num_bus_formats;
+	u32 *bus_formats;
 };
 
 static int lvds_encoder_attach(struct drm_bridge *bridge)
@@ -28,8 +31,22 @@ static int lvds_encoder_attach(struct drm_bridge *bridge)
 				 bridge);
 }
 
+static int lvds_encoder_input_formats(struct drm_bridge *bridge,
+				      const u32 **bus_formats)
+{
+	struct lvds_encoder *lvds_encoder = container_of(bridge,
+							 struct lvds_encoder,
+							 bridge);
+
+	if (lvds_encoder->num_bus_formats)
+		*bus_formats = lvds_encoder->bus_formats;
+
+	return lvds_encoder->num_bus_formats;
+}
+
 static struct drm_bridge_funcs funcs = {
 	.attach = lvds_encoder_attach,
+	.input_formats = lvds_encoder_input_formats,
 };
 
 static int lvds_encoder_probe(struct platform_device *pdev)
@@ -39,6 +56,7 @@ static int lvds_encoder_probe(struct platform_device *pdev)
 	struct device_node *panel_node;
 	struct drm_panel *panel;
 	struct lvds_encoder *lvds_encoder;
+	int ret;
 
 	lvds_encoder = devm_kzalloc(&pdev->dev, sizeof(*lvds_encoder),
 				    GFP_KERNEL);
@@ -79,6 +97,12 @@ static int lvds_encoder_probe(struct platform_device *pdev)
 	if (IS_ERR(lvds_encoder->panel_bridge))
 		return PTR_ERR(lvds_encoder->panel_bridge);
 
+	ret = drm_of_bus_formats(pdev->dev.of_node, "interface-pix-fmt",
+				 &lvds_encoder->bus_formats);
+	if (ret < 0)
+		return ret;
+	lvds_encoder->num_bus_formats = ret;
+
 	/* The panel_bridge bridge is attached to the panel's of_node,
 	 * but we need a bridge attached to our of_node for our user
 	 * to look up.
@@ -96,6 +120,7 @@ static int lvds_encoder_remove(struct platform_device *pdev)
 {
 	struct lvds_encoder *lvds_encoder = platform_get_drvdata(pdev);
 
+	kfree(lvds_encoder->bus_formats);
 	drm_bridge_remove(&lvds_encoder->bridge);
 
 	return 0;
-- 
2.11.0
