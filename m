Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbeDWH0a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:26:30 -0400
Received: from mail-db5eur01on0126.outbound.protection.outlook.com ([104.47.2.126]:27376
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754067AbeDWHXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:23:32 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Russell King <linux@armlinux.org.uk>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/8] drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
Date: Mon, 23 Apr 2018 09:22:56 +0200
Message-Id: <20180423072301.11962-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180423072301.11962-1-peda@axentia.se>
References: <20180423072301.11962-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0128.eurprd05.prod.outlook.com
 (2603:10a6:7:28::15) To DB6PR0202MB2774.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:Qrg2Ji1WoEgV9ZGqpe8b39rT90CTGm4l7jRDnFdSVU+/MLjZs76S7xTJWn5VPRYEb46rjfGRhxsR5rEP9b7tzNu/9bAsVH90TBDM1OqVb9FtLcgaIdRwenJfH9+kjKqjYN3y3emUkNm0FT/J5FHBtSKq9Yq8mYiPdNQeZtpCH0PJ0jwlSs7DO3RcvKPPfe86tDkF1q6Or7Q5sHM9ulLdm9Jrd9GHkPFdNaMxxC2UFYxrszB1rT0IoBGOsQpk92j9;25:qWIjgIQ6+mqccZmLicmdRDGeceHxdwXqBeIcnoqmyNwfoa79DT+RdfIbDjEK5b3j9yKZ9hY0SV72Tr3eORdGyNDic3bxdoMwvXoFNyivPp+JIHFy1pvhJWA5abF75ULNrnMO0ylEpjJViAS1+N4Lm0517wcWH6Rucs/JuaUQWWJs+gqE+lhVXHyknMmnGF8jIf8dyuBnXvAOJwJ82BuNZTPT0djF8aVqqsGS5OgoHfgVmOLdTQjiALFTk6QzK6wtSrq1rUaYKqNSAOpjXj/xtYKID81r3vIijjAV+iYRa2LMfXte+xj2yI2Puj19GBQxlzRHljpm66hGLNyp/YcFrw==;31:aJ7WEbxzwHq9vwR+D0ekY5yJOT2o7uyRDA+n907K0brCbBo6ssIigNrrg71D2dohH4kB5QhCmJaGzkmmR0+gdSaLv8912yN2TWStVfbVaNVaDcX9b83eApm8Gxl9+0qxNCY8lwiJM5PzuMZGKETjFoU0c7yMLg0z2cieQPvhxnc+AbqvXqodq3xv34IDNF29L0AbSlXA6mDrDDKpEZ/e+k+2DMjIKaKtsCrmBT5NQCE=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27743610255137327B77D10FBC890@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:/ehD6p+nKfCHpa0gsH1hRwZNzMdDh58En9Y2xdDS6FzbkEr+5PEgy23AlGkoS50fkQICQW1LraqhhbhK+K18DPX7+XAfJXjWJefD65WyubFTprbEGJASrH91mT2kCoVDszwLgKxiHRCYpf0JGolrlymJ/z7BEBxtJmz0MFIN8PjV1VqV8y/FjXUHcZR997yWhR3wPAkV0IeVTTNP9MCMpXaph6t/1oYZD3+3fYLZemy1oxEOWqcR99nF3h+k7t+7olOsM062FLMhmrqMggDLdQ==
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(6506007)(386003)(2351001)(25786009)(2361001)(1076002)(26005)(476003)(3846002)(6116002)(956004)(2616005)(11346002)(76176011)(478600001)(52116002)(66066001)(86362001)(575784001)(2906002)(446003)(16526019)(81166006)(48376002)(5660300001)(305945005)(8936002)(6486002)(6916009)(74482002)(36756003)(7736002)(53936002)(6666003)(316002)(54906003)(7416002)(4326008)(5890100001)(16586007)(50466002)(186003)(50226002)(47776003)(8676002)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2774;23:NSLpcNOmYu4R7m95mWdufRRkAG1fo0P9PQ2Wfd+?=
 =?us-ascii?Q?0d35p6Lt0lK4HutgoyGxIZv6xZwcrV4oJCqmsj4OMwkoq9ZQnsUwpSppkDEv?=
 =?us-ascii?Q?kZVZwSmdJo0cCqtoKQmJvTH95A3li4Mc4BeQlGXc/RW2OpS1rsAkV+jo1mSY?=
 =?us-ascii?Q?KWqzR9Ll4uhSlvuD0UIbrF4MfMoGAEi/4mAJVYnd5H4wAYOTKv4LCxto+KPi?=
 =?us-ascii?Q?7IIiebqEme4DtaHmjX6oflZ0x29crRTOdlZsXvPsP5WmVKF2rn7S64uZEuxz?=
 =?us-ascii?Q?jv2Ioq8S0piA5+dDm9H56S5fCQwvz+ewzX7yBloVLBwGy1IMPU9c1A2fh4o0?=
 =?us-ascii?Q?CQGzXv9/IEa05Cxhbc5TVlHHfXJZCtsRS1evLF1/QnwPv3/Sru2HIe0kVnDw?=
 =?us-ascii?Q?5LCvozvSN9hHqJBURVeXUr2+3u+tLhaJfkjbRd8zCbPlz3JdCeW7m3VziUdR?=
 =?us-ascii?Q?Zd0y8W/E7LtSUpagH0OYGU4j55MkTUArGCrjKsW5aiPq8DiH6mcJ16gXVOmQ?=
 =?us-ascii?Q?yoRoSpnvKHFxT8W4qCsqEJZbZTAIUsCqHBzv7mspEJfBiHRCveDsvBkjQXBn?=
 =?us-ascii?Q?ePVN/XTQOihoREMkscURopekZGO3vGHb3/ZwpluAl26PpBxHKopZzWn/dvBn?=
 =?us-ascii?Q?QrzRYSw8KGK/LEQaC4VvFy2MGIHe5zzZVTV3uaZw0thJiIexFeJtsu9mvMF5?=
 =?us-ascii?Q?wxbL7PEEct+kruer5rOH2vywdl91GD9OKIpbSHZ7iBuReZuvgWXluYatKR4i?=
 =?us-ascii?Q?UmESSuifTQEFxU2lBpp2hhAxzIWqgxB4y4YICu7lrskMVj/kUnD+v7TXouHv?=
 =?us-ascii?Q?Sdo3G9sVdP36tysat/4clrcCfa4YW78K3fts8qbzU/92whcDxaIzzKVaRQ8i?=
 =?us-ascii?Q?0Xqvplrc0M1AnhAZHZKT2KqwrG6a/oL74oQHcfVb0GrG4LmfCji3fOwNDBOA?=
 =?us-ascii?Q?p/6GI+f7GD1ct4x5QTZL0Xz1NgBQTudjCx+qrLYrLJ/dAS8UkFHLuV++TveG?=
 =?us-ascii?Q?VYamPowIBP+y0DbxUg1JVC0bAtH2kxFc5Ulzoo1LBKs+E/juj4APsRFEEVOF?=
 =?us-ascii?Q?h7JlBSMsFCKlaSjgGXF/uD8lQUvoO28t7Qq+S5yD0y542Ijwo8+a7HPpS0+o?=
 =?us-ascii?Q?wVQr5l6BY8dr7wLvgMCUOQI9MBiMVKp3zXW32qba6XG5RbeuTfItwLg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: WfokVtrHO9MqrGLmDmNFJjUMTkEI7YT9M7Pp46j+HMBWSYT9VIbySuLjmt22VRiYF0+gZ9M7owJV349+EjwuqJF8/01cuNK1qEse/VAXEPonKf/O+2zRp/hC7C1OFOrF6Xkj0kJn53dOkIrw7TVtW2UJ/PGQcbBrSHsSolJiKqmtHAHMIfs/jwVxYyTetJPl
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:+cKor3fsyKvLZLSldnX86Uao4DXVbelztdEQFA5j1AKQHxZKZIjCzmtwHUb2m4wPqz8kSh6UYtbr8hG/Mau+kFS2r+rEX33IDlt5voCMkwStysukfSPPRfoTKlEmOYaaeBNPxCcnyY8SxVvgSXM03CQQVid6dRvElZt/NQxYaYyjHeH99BMzVFNDYkjsq1vq5xovLe2DAFdXfASoPJGDnCDUn9jMC5V7zGv33/GIOIsxxXpjgnkUSwvr1remDAcd9eHt0tnyx/L9QSlms8pcyBe4MOnsmXWzkMuy76kMMw3mqjxr5mEHa1q7cRZmb2WUYriVSBJahlKsQ/6S1Gf8MmCHc33e4CZgwlxr7NcBuc0oPmkH02MINp+Xc39bboEh56b3hRzRFoUjpS6F6N/lxNBPf3Plmh66l877EhZggBtu9FC1xyWOwpM2WxKcoPbvOM2TOaXeZBhaGoMRRVNQxg==;5:6hmyuKt+BeYXb7+RavdlTbDDqm7T2/POoRBcIj0/2thda3NswzCFA/MT5QCdTZ6PsDy5EjcvCfMnrRNpGm0PeQSvzvUuWEcD/LX4hGW53Jkb9X85S9qJtOuLKTTUq9Qd4sfvlex2jG7K5Cf3OBfo6OAzI92Pww9PboWTaS7FuNE=;24:m3Fs6GurYpPUd/hzepI6xYB12rq3kWTveq6iDDqe3INbnazcBtQ/UEu3qS4SNvxyPCR++duu61ZXVjJbfItRUUQFBshKnuIeEukjlqrkbzU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:PwMcNAcX4q/K+/CyA5eDEQLSu44ogigYWAr3s7LgYkJ9C8oGjc2aoUW3nTF56swypBogVMBrfsdjYcaWmKJA8PuptbZyeSrZoW4B9QLLFoYvlVmnv1b7b5Jp3BgIvkRnbOCahSsCnLK32rDAfTM7a1HNKVwePDQ/FppD87DajnONwhBm+jcdeRSEhPnqDsFDZstQgoR49Wnw475tVWEtlBA7r+0tZA6IfYNflkfg9xqW1A9ALWZsJQR8mccc3OH3
X-MS-Office365-Filtering-Correlation-Id: 49ae79d5-ed04-481a-708c-08d5a8eb1d3e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 07:23:29.2174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ae79d5-ed04-481a-708c-08d5a8eb1d3e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
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
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 70 +++++++++++++++++-------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 67 ++++++++++++++++++++---
 3 files changed, 111 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d73281095fac..c38a479ada98 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -226,6 +226,55 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
 #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
 
+static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
+{
+	struct drm_connector *connector = state->connector;
+	struct drm_display_info *info = &connector->display_info;
+	struct drm_encoder *encoder;
+	unsigned int supported_fmts = 0;
+	int j;
+
+	encoder = state->best_encoder;
+	if (!encoder)
+		encoder = connector->encoder;
+
+	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
+	case 0:
+		break;
+	case MEDIA_BUS_FMT_RGB444_1X12:
+		return ATMEL_HLCDC_RGB444_OUTPUT;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		return ATMEL_HLCDC_RGB565_OUTPUT;
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		return ATMEL_HLCDC_RGB666_OUTPUT;
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		return ATMEL_HLCDC_RGB888_OUTPUT;
+	default:
+		return -EINVAL;
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
@@ -238,31 +287,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
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
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index ab32d5b268d2..77bd2d0ae508 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -454,5 +454,6 @@ void atmel_hlcdc_crtc_irq(struct drm_crtc *c);
 int atmel_hlcdc_crtc_create(struct drm_device *dev);
 
 int atmel_hlcdc_create_outputs(struct drm_device *dev);
+int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder);
 
 #endif /* DRM_ATMEL_HLCDC_H */
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 8db51fb131db..db4d6aaaef93 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -27,33 +27,86 @@
 
 #include "atmel_hlcdc_dc.h"
 
+struct atmel_hlcdc_rgb_output {
+	struct drm_encoder encoder;
+	int bus_fmt;
+};
+
 static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
+static struct atmel_hlcdc_rgb_output *
+atmel_hlcdc_encoder_to_rgb_output(struct drm_encoder *encoder)
+{
+	return container_of(encoder, struct atmel_hlcdc_rgb_output, encoder);
+}
+
+int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder)
+{
+	struct atmel_hlcdc_rgb_output *output;
+
+	output = atmel_hlcdc_encoder_to_rgb_output(encoder);
+
+	return output->bus_fmt;
+}
+
+static int atmel_hlcdc_of_bus_fmt(struct device_node *ep)
+{
+	u32 bus_width = 0;
+
+	of_property_read_u32(ep, "bus-width", &bus_width);
+
+	switch (bus_width) {
+	case 0:
+		return 0;
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
+
 static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 {
-	struct drm_encoder *encoder;
+	struct atmel_hlcdc_rgb_output *output;
+	struct device_node *ep;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	int ret;
 
+	ep = of_graph_get_endpoint_by_regs(dev->dev->of_node, 0, endpoint);
+	if (!ep)
+		return -ENODEV;
+
 	ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
 					  &panel, &bridge);
 	if (ret)
 		return ret;
 
-	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
-	if (!encoder)
+	output = devm_kzalloc(dev->dev, sizeof(*output), GFP_KERNEL);
+	if (!output)
 		return -EINVAL;
 
-	ret = drm_encoder_init(dev, encoder,
+	output->bus_fmt = atmel_hlcdc_of_bus_fmt(ep);
+	if (output->bus_fmt < 0) {
+		dev_err(dev->dev, "invalid bus width\n");
+		return -EINVAL;
+	}
+
+	ret = drm_encoder_init(dev, &output->encoder,
 			       &atmel_hlcdc_panel_encoder_funcs,
 			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret)
 		return ret;
 
-	encoder->possible_crtcs = 0x1;
+	output->encoder.possible_crtcs = 0x1;
 
 	if (panel) {
 		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_Unknown);
@@ -62,7 +115,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 	}
 
 	if (bridge) {
-		ret = drm_bridge_attach(encoder, bridge, NULL);
+		ret = drm_bridge_attach(&output->encoder, bridge, NULL);
 		if (!ret)
 			return 0;
 
@@ -70,7 +123,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 			drm_panel_bridge_remove(bridge);
 	}
 
-	drm_encoder_cleanup(encoder);
+	drm_encoder_cleanup(&output->encoder);
 
 	return ret;
 }
-- 
2.11.0
