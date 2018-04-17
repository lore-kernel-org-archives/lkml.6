Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753679AbeDQNMc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:12:32 -0400
Received: from mail-he1eur01on0098.outbound.protection.outlook.com ([104.47.0.98]:60480
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753213AbeDQNLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:11:38 -0400
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
Subject: [PATCH v2 4/6] drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
Date: Tue, 17 Apr 2018 15:10:50 +0200
Message-Id: <20180417131052.16336-5-peda@axentia.se>
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
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:HY0dx1IrEqmlbhNT+kvFUZidmV1cpPm+dekGyq4aGFdlv5QtDyZ6JAjwhW9faLtIocpv2nz5NFBxEIBSh4bYRfF05gUJYd12it6K0Cl5bUu0nSFs3sQdS/KsTw0ebjsyw9dVbYRD9L2lopH3eSN4bbI3pP1wZh51WUMqxEuhN+R4oIQ4UYNqvy/OENfwFCC8cwnXZLdkMicKEB1eocd7lQbyGwQGcBpj2uYYbf81oXlaJV0LB2bLCICB+Pl/3AnZ;25:71gOGeeuHhqsDTqwOamWHjJEcTIPwhRHOSLHtDLnFfj03sB2md9kyUkG68Er8et25x1OmotNtwWI51OYmtsnZsQ7ExzCjudO4MeUs4Ai+3S7n8b+ZkRvcPBONua8zVaSlJC2T4NWiNVjwgJMi1arNcmj0c5lkyj0EhOAI7tNpAs8k2V0dcO7RifDXbY+tZwoEJOYnwFNVPrT0CLt2O6YQ5o/pq/6+jEb+VKtdnlA4GXodAl6313ck4PPUajpsTsBXwVkZ0FvI+fWB46GvqXUPXg7JDlXyLj5QV/+kZnHe0RvWiMMq3ZX5JVLvEKWTpHZY05+4gs89ILN2UIZpMBVtw==;31:BXRxarvopYK55fOAL/t2u8qHMu9NbKkM7MZb3MDAHbFvZN2bZ1lKB/XKa1MWlhFs4mYPnyuCk6oqYN89lzuCMA9uRVgTXIvS1Qnys7AmjA88KLIk09Yhqi9SFKlQyquR0laTHyn15YDa6/fROru2JLfHexe3pmVaXNjqMKUMOyy2/ZRgPRpXH5W2pLYesj0I+fYi3oBOVF6ga0Ri5ziUDiTeIkW9Z9yAc6YoZr3Sk7k=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2778965D56D96A4B97908854BCB70@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:BUpK9klCqev/U8/cvWrx6bLWvHqdt9NavgwHKED58otTkcdDvwZM3PrGP59wr/Rv6zZXqeN5Z14lFMfV9VV4xTWbRSJCLYOpIli3fyD9rCzFsAJvAR9rp+RgPR+EgXJAykTe1F85FSFacLEt36w/oVk3mGUue79j3jRAipj/MFFi7isSj4nuUthg9DKsh6q873aeoKQHZaqunv+unFGb85h5CaWawbpsuUGasTZVyYBsLFeJH/qvejWkM2QSvOlkM6DEQzoWIEWsF1Emv/KsCQ==
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39830400003)(39380400002)(366004)(189003)(199004)(47776003)(81156014)(36756003)(66066001)(74482002)(2361001)(2351001)(50466002)(105586002)(316002)(48376002)(81166006)(478600001)(25786009)(54906003)(50226002)(16526019)(186003)(68736007)(7736002)(16586007)(8936002)(5660300001)(6512007)(3846002)(4326008)(53936002)(956004)(476003)(486006)(2616005)(446003)(11346002)(106356001)(97736004)(76176011)(386003)(6116002)(51416003)(6506007)(8676002)(52116002)(26005)(86362001)(1076002)(2906002)(6666003)(305945005)(6486002)(6916009)(7416002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2778;23:4bbKymL6G/bZLlx+gWPHpu5npiS7sSOwA61IC55?=
 =?us-ascii?Q?IwgmhpBSbXheDHN0gXa5h/euML/sTHUoeq5BMAY79dVaQEh+ZVO6gF0HNqLl?=
 =?us-ascii?Q?Jr2QrL/4evNQxJyJGTf0+FO+Pff2iJbsSZArwFuevgz+Z7awdjTeb2sony60?=
 =?us-ascii?Q?Bt7pcs/JR4jb926JYxnNjbRy7H1Y0N3CePrzgprroPNUS80b1yrN/x+z9Axr?=
 =?us-ascii?Q?RRZQq0afywBsR4jCpt5gPlsreBIqPaUaJzOXKG4e3v5Nw8emO5xvqArCY/1E?=
 =?us-ascii?Q?enC1B3UIYkLGwzG8Ce9I5Z2TEYFAkZToZO+/l8+UogHApKPGYqEZ9+irqJgv?=
 =?us-ascii?Q?mss0zWZ5KS2MdixlZLbbD+4UscYvQmzOgAgqhAWNA59pNCcgsTei2zX3rFKs?=
 =?us-ascii?Q?gmK8cro1VWwh5lUIs/gD1O6q0o7fVEoPLAu3GlmV+AC0XtorW82aTCJ1NZnr?=
 =?us-ascii?Q?NVLwD51uhz7Ua+mpedylIlmW/br2oD/RGfqRooT0jBceXL11q+yHXyTBC1Uf?=
 =?us-ascii?Q?Du+atSIhbqc/4Vllsldwiz8nftyi/mJhLq7ojuZ8IDFdY9QguUkgLpbZZTeQ?=
 =?us-ascii?Q?lA7F10qZA/Nl1sge7tsTHngtzGlsjMlou0Ks2CsG1XGTsyHskhvdAULffEiS?=
 =?us-ascii?Q?DsOPeLXNPhK6OxTdAS3LgUhSVfeZ1Xk0oXGkR+RxWbIc0sIRCEg/CtJflN3t?=
 =?us-ascii?Q?g+5Pa+B9sbDOuJIC/RerA/g6zhwfOcx6N2Kp22McWzG+bajGHFbfwbGZ70Zr?=
 =?us-ascii?Q?+W4/ugvo3ODbHtAnE7/ZRPZ/v29cArxlqpZI2FhK2ivnPaIZrt+B4VDabVLg?=
 =?us-ascii?Q?9iJRWXIDEekXziC8Owj2n39UwdNixM/blGSq7uwKNp0z7ttmZQCMbaQbZISF?=
 =?us-ascii?Q?sRKysWygQ3Dxho5L87WC9A2cW60PSoU7Rldemaj1nXum9ZNCAzc34PbEJveZ?=
 =?us-ascii?Q?TCyVaRhI/35ph7N0a7ehrSeOXAOMtwv2HNnp2aTMIqjI65/g6L1qGoXXc+LA?=
 =?us-ascii?Q?R/S4XxfVeQAPAr47I8FDhy+fim8N/evqRZ4Ipfa5A05SXjp24Jr4typJmt3+?=
 =?us-ascii?Q?767iAcwcW5fDEKn353p8++inSZgD1bBLbqIvZhGFiiRnyvRqEiM6txvHOOts?=
 =?us-ascii?Q?0JX8MldKpFoY7WQCKoyRlDMmSkazLJWX26aww6aTnJuU1it/cZz6Q1vpS36U?=
 =?us-ascii?Q?h8XKiqitRp/4KXxke3/nM8QvG/JNQ/gicPz8fBtwQiXH/Z5Hh+0RFd5amu7o?=
 =?us-ascii?Q?LqnxA7PM+Psza5979ynWEa+hXm2bfiWELNu3pOvEobFbttQThUJj3kxxd0oT?=
 =?us-ascii?Q?+PGGXWx1zCeG6YXWv37T7ti0=3D?=
X-Microsoft-Antispam-Message-Info: kj7QMld6L1kPFszc1U9hglhINYEcvvdYcoLCweJZE/k0Gxp87XHKUoJ9de8BVh5LelTFxqR3zTqxanbSvqC1eYe66d6JdIo1L4fHXOfXZGi3qA2Y5Q6r99aIeEdR9wN6dECEuDwlcBvwQck5+n+uUvBtKHXu4YAGKahu8VdlzMOtKgD/xDH5zhuNYj3fs07L
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:BzmFhvKEJXfqmi3lvvmbAHjZ3i+Nt1OfZqrZCwcAL2Rslp/+kbjImKz8oEgoSn+QsmYpv3DC4QOBaJA7zt5d+UfKGvCyvMx897YL00XO7cAsIE7RHbe9oiAU7XqJRG2SLQECFP1Xl0uyrocC+uBcAL9xfBU2Lx/Vn85LfLopEueFoDykusCrc/mZZawbJ4CWsOZsVmX1Iv/q55UvcPkfyPkaNpSwXxQDNXMvzHkTgASCCzNryNWi8NNfP/6JyCRJwFz7V2WslSex8XnBnWc/elnbm/68fCNvFzfsGMRrl5F39RvWUPcJ9yGVTzHrBhfACLcDJ2zZXoYTCWhPaTXOcSwS195AJ89jitgEV9RV2JeKCQCajQLhXVWzd+d1M4jfyXOhTkbLntEyZGHLBFWMTIcfwaNmyGxSD1QAGGBjlBR4YKUqm4Tjsx1Ay6n5sNmVlk1ZC9jXyRxJOtcI1eAVgA==;5:SZ5sySAiReDjp4BaBg8NlH8FMoY/kV531oxU9Z5fsmwIXkc5Mhh/AJ3uU5mltaLc39DDg1LjxbgY3Lyr5g3UNrgwvWYzQ31r3Ntz6bVNv6kJiyPaa1wIN5picH+rIGq4hx6CUtJkf5hUkDeyl2gn07Z6N5xolKovRO2siU77va8=;24:gTOdGRe2cKv+/Aw7a/3mvmuy0PYuywe8rWJTvs6t4Uepc7jQVd6SuGGChY/yIgFBmJ1Vttz0IEc3VQXnJRC2eZZGMrvEv+3w3xIzfgMN4V8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:wqRA/smvWbUbQon7g1xmugEwKrtUco6ZMlsjAfrRBOnp+yGpeOjSKmVWe5tcfi0sZ2RCM4S5Bp1bY8IZyAoWMdbqdU0iUy7TTE6tdmuk+6Ma5wPpKxmvPK7J5ZvQGPKQ4BCGpXjI5TDhd98yKi466FKLYGSGqyadRWa0doB/xiGw+nUjfQtD+eC9uXb4WTbgDzvduU5Y2Sq5OQpzWNcEngHaH3rbnSIPl3XncyBJ32zXsYIe8qag7Hh/B6S/jJrY
X-MS-Office365-Filtering-Correlation-Id: ee8a5762-3bda-4737-6035-08d5a464bf21
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 13:11:34.9051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8a5762-3bda-4737-6035-08d5a464bf21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This beats the heuristic that the connector is involved in what format
should be output for cases where this fails.

E.g. if there is a bridge that changes format between the encoder and the
connector, or if some of the RGB pins between the lcd controller and the
encoder are not routed on the PCB.

This is critical for the devices that have the "conflicting output
formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
RGB bits move around depending on the selected output mode. For
devices that do not have the "conflicting output formats" issue
(SAMA5D2, SAMA5D4), this is completely irrelevant.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 85 ++++++++++++++++++++------
 1 file changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d73281095fac..2e718959981e 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -19,12 +19,14 @@
  */
 
 #include <linux/clk.h>
+#include <linux/of_graph.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/consumer.h>
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_of.h>
 #include <drm/drmP.h>
 
 #include <video/videomode.h>
@@ -226,6 +228,68 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
 #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
 
+static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
+{
+	struct drm_connector *connector = state->connector;
+	struct drm_display_info *info = &connector->display_info;
+	unsigned int supported_fmts = 0;
+	struct device_node *ep;
+	int j;
+
+	/*
+	 * Use the connector index as an approximation of the
+	 * endpoint node index. We know it's true for our case
+	 * depending on the driver implementation.
+	 */
+	ep = of_graph_get_endpoint_by_regs(connector->dev->dev->of_node, 0,
+					   connector->index);
+
+	if (ep) {
+		int bus_fmt = drm_of_media_bus_fmt(ep);
+
+		of_node_put(ep);
+
+		if (bus_fmt < 0)
+			return bus_fmt;
+
+		switch (bus_fmt) {
+		case 0:
+			break;
+		case MEDIA_BUS_FMT_RGB444_1X12:
+			return ATMEL_HLCDC_RGB444_OUTPUT;
+		case MEDIA_BUS_FMT_RGB565_1X16:
+			return ATMEL_HLCDC_RGB565_OUTPUT;
+		case MEDIA_BUS_FMT_RGB666_1X18:
+			return ATMEL_HLCDC_RGB666_OUTPUT;
+		case MEDIA_BUS_FMT_RGB888_1X24:
+			return ATMEL_HLCDC_RGB888_OUTPUT;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	for (j = 0; j < info->num_bus_formats; j++) {
+		switch (info->bus_formats[j]) {
+		case MEDIA_BUS_FMT_RGB444_1X12:
+			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB565_1X16:
+			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB666_1X18:
+			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB888_1X24:
+			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return supported_fmts;
+}
+
 static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 {
 	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
@@ -238,31 +302,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
 
 	for_each_new_connector_in_state(state->state, connector, cstate, i) {
-		struct drm_display_info *info = &connector->display_info;
 		unsigned int supported_fmts = 0;
-		int j;
 
 		if (!cstate->crtc)
 			continue;
 
-		for (j = 0; j < info->num_bus_formats; j++) {
-			switch (info->bus_formats[j]) {
-			case MEDIA_BUS_FMT_RGB444_1X12:
-				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
-				break;
-			case MEDIA_BUS_FMT_RGB565_1X16:
-				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
-				break;
-			case MEDIA_BUS_FMT_RGB666_1X18:
-				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
-				break;
-			case MEDIA_BUS_FMT_RGB888_1X24:
-				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
-				break;
-			default:
-				break;
-			}
-		}
+		supported_fmts = atmel_hlcdc_connector_output_mode(cstate);
 
 		if (crtc->dc->desc->conflicting_output_formats)
 			output_fmts &= supported_fmts;
-- 
2.11.0
