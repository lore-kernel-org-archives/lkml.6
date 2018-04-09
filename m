Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbeDIK7x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:59:53 -0400
Received: from mail-db5eur01on0139.outbound.protection.outlook.com ([104.47.2.139]:45136
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752487AbeDIK7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:59:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] drm/atmel-hlcdc: allow overriding the output mode
Date: Mon,  9 Apr 2018 12:59:16 +0200
Message-Id: <20180409105918.20792-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180409105918.20792-1-peda@axentia.se>
References: <20180409105918.20792-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::37) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a052f0f4-90c6-4107-9a02-08d59e09012e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:t4RTA8r4AOKn4L6S39s80syFPS2YQuITZWeCKazFdA0jyqrwKCu917Xv5+cknjE07l8S4pwAUcvJp9YnelU8YcM2Day33FIVuDxTh6MBQSkdmbRDBczKtz7H7NwDDK1h7D1aG0QlNAkc+8pV0R23ObLQC38t3Ozkhd2iAqjKTL2wpIBbQnIj0mWDDNQ8XVFh1FCjwFR/7f+fvAOeG9lTNvGFuyiY2nOdHYKG9mVz5Qu+xYGIuPEavE8LOXi/ZsaK;25:M9iXF4niJCjk/10ghdpEpwKKGH0MoP0Ji1IKW29ECiK0s7yj+fXkMB4o048If1KJY5fqwjVHwMQKEh2bZzWoJ0ngG1LQ2uFhiwdumiu7DwFUSox3i4cXptv3k5jwLCek/OHQvEbLOKKyHKJsPfTikVXNRdSvllKJtS/aHEgqeSlRwVxDX0tbfSlO61r7iy1Vdg1y6cTl5iYL/dKv9PILCMGM2REZz1W0nwlnbqMJeBOf4gKawOdc+11ihZnkCvQVHdyb8xgQ4AMf1cDpMBi6qFOp55BDa8b34BTd2KHfqjavTqXp90AMcUETmJhQ3ngOOo8WP0UeYmmHS/eS8nWacQ==;31:Mwc9b2MR3orx/XBfe1LdLzIUIZKHxi+0j4ly2nWgjMY4w4GO6j7KHhhRuloL9kDrJqBZ4XFB0+bUl/M6QaPuGHWsSEwl0REn50Qaue1We3w56EGFbytAnJXjnBm0wbYtnQwlFi15rlXKUJ63pKw5rr+VPbEplSCsnm2xG8pCwd6XMuTtpR2vsFOZYEbzDxvy7aw8o6gvUG1DG4B7fGHRhKvJmePFv8cubx4vRjfzTlE=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2775DC9F47053487DEA0CD08BCBF0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:kR3pOW+WE1sth/9+fawwngehlsCpYKsNxwQ9mF12rfzxlv+Uuhjf0rCZjidjvjCjZtxsyc0MvhSvKvwlx3hkQdHb7M5U7jynYnaRtSeUBt55dn8QWVRJo4UF+BeOaEk8Kk70Q56XZpmmvCKw/Yr4JiCaffoVMMX2aP3nxBRCh5EBi5w+RMnIWJHLDJ/a0aISkDROsyif2hQB4q0C3HeDqm3dqq0Awmm7c2+IjhxDzZF62LEV2uAmbkVjWmH9CJgUd0+MxokO6C9hn7dc3lMGXw==
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(39830400003)(396003)(366004)(199004)(189003)(575784001)(5890100001)(86362001)(68736007)(26005)(106356001)(478600001)(186003)(2351001)(16526019)(2361001)(74482002)(446003)(48376002)(16586007)(50466002)(76176011)(54906003)(386003)(6506007)(316002)(52116002)(51416003)(6666003)(6916009)(2906002)(6116002)(1076002)(105586002)(66066001)(47776003)(97736004)(7736002)(6512007)(7416002)(305945005)(11346002)(53936002)(5660300001)(8676002)(3846002)(81156014)(81166006)(36756003)(8936002)(476003)(2616005)(486006)(50226002)(4326008)(6486002)(25786009)(956004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2775;23:iA0vctC6UImcFy/DsFBMpiCfNH1P6nIz3V7QxEU?=
 =?us-ascii?Q?37LQBaQp3EBDwGPg9gRFwO4GyF8GNminPpnayqaFYHr8fQ0ECShIBLN4adQp?=
 =?us-ascii?Q?9xGe7MBfOYM++C8Gbrksy3be26U03dh2HzWbRT9aB1SH48OeP8DoUMSweoRi?=
 =?us-ascii?Q?Hy7GEfAMHSw5b79OMObIqF1G+tZn2bGGVz99hQ9Cga0g3GBNL32AfhPc6nSn?=
 =?us-ascii?Q?mYhioty+UvCA6V0zdcrWxKL9wTEE7MVAUFLqYI4jlsOq4Zp8LkYUJ9AWyRbv?=
 =?us-ascii?Q?SJXhbp+gJicBVt091WQhN9CbRp1urhqBPjOyFCsRrsUfA4JsPmTe0wJkxGbY?=
 =?us-ascii?Q?h8qTWfRsPmTlAoPEw/CB5zJq6Gwd/pnMemzt7NsbLEHq1pdUOTnycJpshdM/?=
 =?us-ascii?Q?ctA5VhRBuJ/YgWKxTyh0ZW+r3gquRaQHRkhKruCd3LGpLX1azvBu7GmPg49G?=
 =?us-ascii?Q?d3caaxaZn5OErYjLWAjLzdo5oRJyth7b69KywvfIWAYaRr2FTeQmUYD3Iieu?=
 =?us-ascii?Q?MGRUPJ3m4eeqZ+rByeZ/psHX1GfCx9Bv2FcH7h5v0VO2GGZ43/+M29BeHYxZ?=
 =?us-ascii?Q?7ZEf2aAX5oDm+98iwcSofljkTw4uuMc0tMgbTwIS8HLpeqGBM7LviqrkZybi?=
 =?us-ascii?Q?b4niN2XHVYQLwYTn730OBxsOuHdermxoWHOHy7L8RNGN0m9eb1YfRUfuXv1b?=
 =?us-ascii?Q?OopvRYI+ZO7aDfxGruVSZFxf6Pw3ogZ17A5CyGUFIt8pxuffO1bVhlCBfEc3?=
 =?us-ascii?Q?rmYCCr8QNk/yzTJE3H68P47RS96TyuqUptb1KklMrrG4zKj3GCyQ6mh9IDN3?=
 =?us-ascii?Q?dHajesXmVcS9X/Nam1lCkeAah9T2mvMHSUjnLzXnFmKG3riDo5qXqsZ7TbmJ?=
 =?us-ascii?Q?8nE0W3KgYgPOfj56EJR5Lgc5/Vx4i0ZBnJR9VCtU4/JYyaxCdBbYyavMXc2a?=
 =?us-ascii?Q?IBTB6QKhBKvyoIP/n2xggTXl6vhz84wWBHKWQId/UQG77AIvJzKrNPK4GP/L?=
 =?us-ascii?Q?5TEoKGM4VQa/sKODSGN8G5TQ/ARzhmmjPj7W1rHgwFkFYgkgrR2q4RpDO3oV?=
 =?us-ascii?Q?FE5yzjd6nxUlp7R3aQVCSuA0sNRJgLdPXeceRbiQFOcDJEn5LMPxV/8SgKpR?=
 =?us-ascii?Q?QR1uNCWzS7lqN6uWU+entqBOWyD3FwtQtjzphaJa79iqQrbTp1YtgMACez5w?=
 =?us-ascii?Q?0d8AOBon041OB5M47b2Dpxj7u+WZ7exVIVqy81CnpdendcOP2GMfs6D3uRXr?=
 =?us-ascii?Q?2Elz7NG0K/Ntiai6WPrm1uLslS1+kkZ6Lh28OisFejHxLuszZjj+NcWV94Nt?=
 =?us-ascii?Q?MhIqXisZimsF9kTO/0Kj5UDZNXNilPcy/SicDSycDAJMmsu/FLp5U9Cay1U9?=
 =?us-ascii?Q?VOD4dYTFMhAXnKYBellS9M2j7NhA=3D?=
X-Microsoft-Antispam-Message-Info: Um6sxCwMLYz5Rt26P5Jg4PR0tb5z4BtdTmi/IBe0L/3gZ8D4aHGE41twv1cWODL71oT91VE3SCAI40h4yWw66Xn35pJZ1lsPDbtJBf1nbFaXMLN99cNVB1SpNEAe42aQJFNpzk5N2CF/IiZ1lDfhNeyivszInZDbZKF5H0Ku6P/UOE9pDziDmh6At9o1Eqvi
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:oDFyFO3TqPM+PgGInGse/vvNw0JfYTH/17qry48IwqObXCNZGLMvsR5SNm14uRPfkrs9ROYQS2I8j9LtOckuu2ES5vKKsVtI6oyZ3sCvuWyIcImrNIQ5xLamI/+upuAnp2HtJqeI/VjDz2JsScIAeI3DCTg6WPVjLkHsjD3AGaGHOr4NAakZSOabLnYn2fYIwBaxxkbLsGyrWAFWHwGYpAQOs8+BY8fya42WL+I9OfkoTVG87wcSQxbvqt/oZn9n9+hhnkv/XVR2nWFDeUKMUOaeNfKTwJemiUDsQ5Gw8ajiNd2NS9sOYVJcNN6cFUk6a1Eowr1n375EeBVPADyhDpgCTeUT0X8wxf4VZiSRltvPlzK98ZQLMQcxcbGzHMrv/jshWXXuLwDs0GGUMK0DYYkHuuGy4HnRaFW9+Th7/bgT1Po3i42P6djbip6l6zT6Z5/WMHIL+BPypjtfVJ/lpQ==;5:i3Dii4ZWZK4mTqUkzNb4RlRN/XcYEsDLaQtX1iaGrYwnxfTcWUXTJvIcupFKmQ47ctB6Eginri1OY9e4ZSmq0z58SWca5ACRZeiL+F9MUUGnT+q5FIS6NJDzrUqSlzG2xfOqqVK7wSlZwOzjsX3JiHRJcUvdBKozapsc76B1iGU=;24:KYgeYyvZGtCyiBGEhw7T7+a5bmA2QcEVy3JlqhcGZRK4GpVKsU2dYpEfMgner9mZpI8UOl7HYwAs+BIdvWLFt4aVz5S0XBD1niv1/DHDr54=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:Swe1Vv8saR82QeVzqhXCTzNY0Yw8ewCTrYX2VaxhWnaRlkmAZUhxzQ8upH7FrTvoHxxrIyfgjv3ploJSOY53aAzgizYGKmpmmW/n42MMx5hlqZOBxAV+SpZ/s6YZvYpuqbUTrTgrNYiiVw8Xob9L8rzoWuUs3XEskqR9Lp73mH84wWxWGmi4pKaETZ96WAkJ1Hvk+JP5N1wZL7TAdfVyCQVZ2eeW0Uv+3368buFBfX7BbM4Sj6KmQx2vGb+928+f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 10:59:44.8073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a052f0f4-90c6-4107-9a02-08d59e09012e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This beats the heuristic that the connector is involved in what format
should be output for cases where this fails.

E.g. if there is a bridge that changes format between the encoder and the
connector, or if the encoder and connector provided by the tda998x driver
is in use in which case the connector does not advertize and format at
all.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 12 ++++++------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c   | 19 +++++++++++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h   |  8 ++++++++
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d73281095fac..9bfff228f893 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -220,12 +220,6 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 	drm_crtc_vblank_on(c);
 }
 
-#define ATMEL_HLCDC_RGB444_OUTPUT	BIT(0)
-#define ATMEL_HLCDC_RGB565_OUTPUT	BIT(1)
-#define ATMEL_HLCDC_RGB666_OUTPUT	BIT(2)
-#define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
-#define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
-
 static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 {
 	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
@@ -237,6 +231,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 
 	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
 
+	if (crtc->dc->force_output_mode) {
+		hstate = drm_crtc_state_to_atmel_hlcdc_crtc_state(state);
+		hstate->output_mode = fls(crtc->dc->force_output_mode) - 1;
+		return 0;
+	}
+
 	for_each_new_connector_in_state(state->state, connector, cstate, i) {
 		struct drm_display_info *info = &connector->display_info;
 		unsigned int supported_fmts = 0;
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index c1ea5c36b006..dccd0be548a9 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -600,6 +600,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 	struct platform_device *pdev = to_platform_device(dev->dev);
 	const struct of_device_id *match;
 	struct atmel_hlcdc_dc *dc;
+	const char *output_mode;
 	int ret;
 
 	match = of_match_node(atmel_hlcdc_of_match, dev->dev->parent->of_node);
@@ -634,6 +635,24 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 
 	pm_runtime_enable(dev->dev);
 
+	ret = of_property_read_string(dev->dev->of_node,
+				      "output-mode", &output_mode);
+	if (!ret) {
+		if (!strcmp(output_mode, "rgb444")) {
+			dc->force_output_mode = ATMEL_HLCDC_RGB444_OUTPUT;
+		} else if (!strcmp(output_mode, "rgb565")) {
+			dc->force_output_mode = ATMEL_HLCDC_RGB565_OUTPUT;
+		} else if (!strcmp(output_mode, "rgb666")) {
+			dc->force_output_mode = ATMEL_HLCDC_RGB666_OUTPUT;
+		} else if (!strcmp(output_mode, "rgb888")) {
+			dc->force_output_mode = ATMEL_HLCDC_RGB888_OUTPUT;
+		} else {
+			dev_err(dev->dev, "unknown output-mode\n");
+			ret = -EINVAL;
+			goto err_destroy_wq;
+		}
+	}
+
 	ret = drm_vblank_init(dev, 1);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to initialize vblank\n");
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index ab32d5b268d2..a810171b9353 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -153,6 +153,12 @@
 
 #define ATMEL_HLCDC_MAX_LAYERS			6
 
+#define ATMEL_HLCDC_RGB444_OUTPUT		BIT(0)
+#define ATMEL_HLCDC_RGB565_OUTPUT		BIT(1)
+#define ATMEL_HLCDC_RGB666_OUTPUT		BIT(2)
+#define ATMEL_HLCDC_RGB888_OUTPUT		BIT(3)
+#define ATMEL_HLCDC_OUTPUT_MODE_MASK		GENMASK(3, 0)
+
 /**
  * Atmel HLCDC Layer registers layout structure
  *
@@ -365,6 +371,7 @@ struct atmel_hlcdc_plane_properties {
  * @hlcdc: pointer to the atmel_hlcdc structure provided by the MFD device
  * @fbdev: framebuffer device attached to the Display Controller
  * @crtc: CRTC provided by the display controller
+ * @force_output_mode: if set, this output mode beats the selection heuristic
  * @planes: instantiated planes
  * @layers: active HLCDC layers
  * @wq: display controller workqueue
@@ -376,6 +383,7 @@ struct atmel_hlcdc_dc {
 	struct dma_pool *dscrpool;
 	struct atmel_hlcdc *hlcdc;
 	struct drm_crtc *crtc;
+	unsigned int force_output_mode;
 	struct atmel_hlcdc_layer *layers[ATMEL_HLCDC_MAX_LAYERS];
 	struct workqueue_struct *wq;
 	struct {
-- 
2.11.0
