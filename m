Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbeDQNLk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:11:40 -0400
Received: from mail-he1eur01on0135.outbound.protection.outlook.com ([104.47.0.135]:32189
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753164AbeDQNLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:11:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/6] drm: of: introduce drm_of_media_bus_fmt
Date: Tue, 17 Apr 2018 15:10:49 +0200
Message-Id: <20180417131052.16336-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417131052.16336-1-peda@axentia.se>
References: <20180417131052.16336-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0270.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::22) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(7094020)(4603075)(4627221)(201702281549075)(7048125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:Wz052obBFGAMBolG+GJmJTy+EqTmr44SsMKbKrA8Y6bkZrQVsQ7uRuRNowh/Sf23XmBaOB7Mn0t1v7qkBtrTtfLw6bmiMWifBELq6FD8xPFZsVcJFSYpjKIegohNhxo0V/NIJg4qZVMGXmiGeWuKCxqUtlswl93JybpsjGA0gWleDP3/zSktah+PEwR75JtU8s9TupafhKQVGOeEIh35FOW9r2Iy2KFVn4fBNrICYJj7eN1wx8EfoenQbQ9daGG5;25:CQ3SWa3L/doTjeOXFG+57FtGeomIWYBno6VWCLRPtFmJKDagDRB6yKDENich2hY1WH8+7F51yDYc/ZaKWlyLzqRmF2N1HpJN0IhJUeXtowEnGH6iQaZ3Qtr5INY4MdGxtOZf4TEmbF31kfJt+LIbiqmZAhePhCTgyiVCF7wmg78YWO+GzoK8cIWl7tWcE6OYRFGFLFDahvy6H3CIgWLoj67vZg6xGxqyGbuZmkToDK0edzejzL5jkxm3F+eLviGi5ktDeyCC1AMuzklEAp3AHxghCTiSAsJshH5H/08ekZEvzs+zdhdgQNocGRTbBHzRe5ilvaF3TafABlI/kHUsAQ==;31:0F0JqkIVbsW4d/5aR/6hAkEnkodDsTTlKE+QbVyXB4pPnyGoMA2z+VOskiNbBROTeL7ehJVwt/0BAKwQ6BNO4Yzf8QOCeF2BHPX+VEmwVBMxByQUFkxSx6vnDwNoAJK5Ob3+Vo+vwcLvjUVwwdT/tZk73H7x+txNcPKXnS6f62vf1N0GeJMt+hpfgVkF9C8ZkL+8lKacGQCT186RxPtp64i0fo0yd6Cs4/G3pnogVsc=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2778B2CB036C35A9C6531889BCB70@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:WRimLW0i7yjshD6Q+F2Go72WWaHtmpuEWDWzO9nDInet5oo/W4+RYyli/hUD1/y8U8OGrbPHlx1GdGx68hhY5E5ybGReM881c//tBMlj7nXcO1fzauOTeSIVhJKmaunL13EaU1jothHParhv/jPjARRS9zzHPMYE3SD9QN6brJxHHcv5IddjlBtGbjolN79vHaqXaQrkOX6VsWCum4HtqWcYgT3CeaAVoj9SggTwE0FbXkaxUJjdGvVpLT8GJ0RdAgUsNPP8kRxzGntLZWxLpQ==
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(189003)(199004)(386003)(6116002)(6506007)(8676002)(51416003)(106356001)(97736004)(76176011)(26005)(52116002)(4326008)(53936002)(3846002)(6512007)(476003)(486006)(11346002)(446003)(2616005)(956004)(6486002)(305945005)(6666003)(6916009)(7416002)(86362001)(1076002)(2906002)(2361001)(2351001)(105586002)(50466002)(36756003)(66066001)(47776003)(81156014)(74482002)(54906003)(508600001)(16526019)(186003)(68736007)(16586007)(8936002)(5660300001)(7736002)(50226002)(81166006)(48376002)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2778;23:uKCDIkwPjNYgqqx/t39ropFIpZ2EYhGK1UD+gaP?=
 =?us-ascii?Q?Ea6lPGBlZoNruQPurlYz4hFOv4Z+2MjY0Q68GS6NyOKmlgG+/M0VZBiqs8d/?=
 =?us-ascii?Q?U6/gvyWqnm3Fy8SLHU/eUVaxxN84J+ajVksHfDQlotyV1LwTmlDw16EfOBJg?=
 =?us-ascii?Q?yfwpgU6KMe+tZfyHc1Zz7VnVEIlgXBVG7pWisxdAcKZ49JxzPPlfS6iMBObN?=
 =?us-ascii?Q?NaSGjr60UP2mSQ7IaWY9NjOXwqoR9lOT3b67IEuHracGSRMi7lN7AlgAQoB+?=
 =?us-ascii?Q?NuAV12133kOZyYMRSomiuB1yKT2qrXARE+CKFN3VFI0iGGNJ5EU3HJJ21XBr?=
 =?us-ascii?Q?jD2WmiKmKfSlldA8hxubUI+V5wzF3ySqpmsPLnbPG+qFHfRHPUX4xIuxlbYG?=
 =?us-ascii?Q?t2F1OdKSr78hhB0LvRYODQa7QBZLmhQHUgXMZgDB30yI5t+/McvD0Ao8tX5d?=
 =?us-ascii?Q?lVHn3xROR+Y/vA0dyaQJXqyTlF4N2V2wK43vCXC+V/OtVjxQM60KnUq/FaF4?=
 =?us-ascii?Q?Cd0TBQ4MEJ7l3BAxs+kuZc7b6kILgcIQpnJS39BKkagzXfKDBbq0PdT0yOsk?=
 =?us-ascii?Q?m7M20BYdJ66R9w5cGp+gUmqNNMotGZeS+qiMQ/DbylIhhu82d55xwcciEx/f?=
 =?us-ascii?Q?wc62rNccAA3rHUI2mdnm/BukF79wCFxX06uJbwNGh9MOXCkYBTt05Utkq2Mm?=
 =?us-ascii?Q?CkOq4Cx4IUfjs2mS1TEOCV+4aEFjkEQWLG1dgYiPGeOaWAiTfdkWcxK4w440?=
 =?us-ascii?Q?mYXGIPIizS1963om3BRIKzAbd5r/g3U66RftvidCiMlkl1KtB7IkIy/0Qh2R?=
 =?us-ascii?Q?XgvhSSjf1qZeLU4FAHQrR4FfURBEsHKE2hbz8zYAKc/ikO0mP13CVFzgv4Z+?=
 =?us-ascii?Q?WsFPjP7YiZ6Q4I9QUZaGR4pPne/L9PNKw2sz5Ejcs6t34vJAVjvtGC1J0fj8?=
 =?us-ascii?Q?rAsGmyrpDkm64lQ3RpioIbSQzrjZCvkbudD8WY66GvBVAPqDzJiNEIHwT0/A?=
 =?us-ascii?Q?Yjn3f4Ibzk6r+4LTUa7jeSNHVkbxTB1EgrTid67pRc8tJQlOpynHjY3paWJn?=
 =?us-ascii?Q?pm0xxgr+qaaTA5Jbu2X7xn6lZcowEQGmQACG/x28Ke3ODvogjuVLY0P29o7v?=
 =?us-ascii?Q?lZXfTbxT5QaGtwxeZY1aW0ykuhe+oB+/THXIAqfQ/AGIQCKur1xDyNeuWc4F?=
 =?us-ascii?Q?xbBkn83Mb/s/qvef5Fz8OyjtInxbX04GcIpXL?=
X-Microsoft-Antispam-Message-Info: 9rBvT/aoEDQOOyqzNawn5QZaDubtn1rYsB2SQDmhRopEfU7x2wKNR0gVUbhBRRwpvLCV64/DWa/Vuxz8rO4rVR5tKrxvArn/9LaOy+MbsaeTbDWBKUpvPTSpoHceu/442tD43//bd1gbASvDS2EwIkCi+F1TDPvzcm9h6g/mpiOkRrhWVbNIxv4qGmafxPcs
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:JK2u4yf1QA6vFkYX2eL6n5MaTYTcriKLx8pZ7lKPxgm2OwAx8t7ZvWmwJZfyMd292bq8c0+Mb31QURZyDaqEnhnbNcN/S1ytH3322qTAITapgd5DKjMLFplcGpEyTdqGTOZ2cMfEYY1LNbby4RMkwPJ0W5c7d91luGNwx5Bh0s8mT3dVuJyJ7hy+KNkTelG2+DxoFXAC2z4/sWezlb+cVV+ehJ/q25Q0nc7bqwXpMV+tnb6G2PoFVFNgxCWStZTt43xikQ/7McFYhWo71DputjzTyR8tEy5lji41NHRfgfLAusH6u9BSflPCFjqaO8erBwbsCbMYjuxNPnWkCjzZEHDwnR8A4IS+PTV5zl/W+/xPJel/I4395CF8tT2yoQ263K1VP9NIibXekSq3Xq/kwV7tcsTYY2pQynj9eRKAOqFDzTAveii+OWy/mEfaiMuEzph4YqdWI2aSceRA1veSoA==;5:h+HMs89Ab+2ZkQEL2Iam4eTrIVHwrV7SVMitLOZibEItsHDiXu+6WxCTaO0AkEJFrJA72Xc5w6d85aBq3h3bZSw/xvs9nZ3i/MomG55GpsTQTHAoWmBfPNYhLuXo9F1qcv54YeFMy9JFw5KEmYzotk7ibPw5fTyVOHDfqbOZgZM=;24:KcMB/d4VVhA50MY60op4gtVf+U4lAj1lfwGGi9hcojPz/2+/uM1y0fhjlsvyvLz7aX3DWCaTJhQkMViPt7UshsBglL+sDxpd4aML4cG8ah4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:rg8gyNBKT68ryhYB9uW4JRaQYh+jlpAJOKEomXpVExwtDPIZdFeU6/lcgqthGzyxVMImdKSdgZZqMNGUIXnuLRVN7iNS4ChGlRKGFKc1DyEAlFajRlaslkzyA5VT/vFkrI1zoeXpgKIX1FpFpfN8dxJwO16H1ZPEmyDKcWtoJL05avORSFnBA6vBQc++iA0gU7QSs+ysfCyXHAECuMfvajH8fGM9e2mZQMUXNZYYKR1hO8kx43SjS/PgeyerRd3t
X-MS-Office365-Filtering-Correlation-Id: 822bc881-bea0-4ca5-ee5d-08d5a464bb43
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 13:11:28.4206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 822bc881-bea0-4ca5-ee5d-08d5a464bb43
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a central function to parse a node according to the video
interface binding and get a media bus format.

Start with only supporting a very limited set of a few basic media
bus formats.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_of.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/drm/drm_of.h     |  7 +++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 4c191c050e7d..f9473edb60a7 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -212,6 +212,44 @@ int drm_of_encoder_active_endpoint(struct device_node *node,
 EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
 
 /*
+ * drm_of_media_bus_fmt - return the media bus format described in the node
+ * @node: device tree node containing the media bus format
+ *
+ * @node is presumably an of-graph endpoint node.
+ *
+ * Return the media bus format, or zero if none is described. Or one of the
+ * standard error codes.
+ */
+int drm_of_media_bus_fmt(struct device_node *node)
+{
+	s32 bus_type;
+	u32 bus_width = 0;
+
+	if (!node)
+		return -EINVAL;
+
+	if (of_property_read_u32(node, "bus-type", &bus_type))
+		return 0;
+	if (bus_type != 0)
+		return -EINVAL;
+
+	of_property_read_u32(node, "bus-width", &bus_width);
+	switch (bus_width) {
+	case 12:
+		return MEDIA_BUS_FMT_RGB444_1X12;
+	case 16:
+		return MEDIA_BUS_FMT_RGB565_1X16;
+	case 18:
+		return MEDIA_BUS_FMT_RGB666_1X18;
+	case 24:
+		return MEDIA_BUS_FMT_RGB888_1X24;
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(drm_of_media_bus_fmt);
+
+/*
  * drm_of_find_panel_or_bridge - return connected panel or bridge device
  * @np: device tree node containing encoder output ports
  * @panel: pointer to hold returned drm_panel
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index b93c239afb60..f86f0098b21e 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -29,6 +29,7 @@ int drm_of_component_probe(struct device *dev,
 int drm_of_encoder_active_endpoint(struct device_node *node,
 				   struct drm_encoder *encoder,
 				   struct of_endpoint *endpoint);
+int drm_of_media_bus_fmt(struct device_node *node);
 int drm_of_find_panel_or_bridge(const struct device_node *np,
 				int port, int endpoint,
 				struct drm_panel **panel,
@@ -62,6 +63,12 @@ static inline int drm_of_encoder_active_endpoint(struct device_node *node,
 {
 	return -EINVAL;
 }
+
+static inline int drm_of_media_bus_fmt(struct device_node *node)
+{
+	return -EINVAL;
+}
+
 static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
 					      int port, int endpoint,
 					      struct drm_panel **panel,
-- 
2.11.0
