Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754045AbeDSQ2h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:28:37 -0400
Received: from mail-he1eur01on0131.outbound.protection.outlook.com ([104.47.0.131]:58400
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754019AbeDSQ2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:28:32 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
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
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/7] drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
Date: Thu, 19 Apr 2018 18:27:48 +0200
Message-Id: <20180419162751.25223-5-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419162751.25223-1-peda@axentia.se>
References: <20180419162751.25223-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::49) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:t2uOpc/WXsQt0nwp6h4VJfR4RB2zVJYCVjJuSgTN3EP25n3SMmrsPd19OmRZByMc4isAD3OS4Gp5wn2ICX6j2M8Yr6Vs0gMgsosF5BtBqamfuzIdD1wUOjhyQNALXcGdOtJfON+gMSiWWHH7s9FYlEWSAsjn93IeSi79ESTireMy9Ssd/B+sR5FjAocPcc4dX2gp+D3Luk4RDSGsN+kgpptBMpkMW407IPY7gICeauntxgsmata2J0nUvnQmIOIb;25:LhKZGowtlsni31BqqThE8uCpUemk0XbHHqFB4n/SU+teFnl80ys5dO8KYOVPD2bI6mfvJ2jwQtueEF3kMOXsD/niJm3HkHBnTUjaTLTbxlGtotGlycOyTTBnrawXy4L+OaRCeAdzUPdqsuWDKpjKz03E9AYkGFUKD3OOQ+dErskRJJPbkxIPk3m6QbBxHWJAL/wQYI39grXBkCcRfqd3dHaJkj/rcuy12sQ/Vl74EBcCVIEOwy6KaTRcG2xln+CHSgbVHB2h4Ydou6UjnpHljfVuO2aPzUqVpA1TMqraYvJz9uwaO/XCi0NCadb331+HE9IVinP7H9UzCs215oKzuw==;31:YSnAb6t6W+4MlJgwpVgM95R2MfgIzxEYOm4lUPhhQBg/0rmCY+bxz5ckflrk7zD10V9ck0uOcB3+EXrJ+k8WwxqBPvm/9FrUw/OJqnUxgl/j/XBQ8fvWBEeJ/GILcXuFy3P+ntfZxIjKEE5+IBDFhH2SKJBAExc1fVkxPMRUEt9/8HsEiXBupqq//m9/cC7rhmgMaE8skSap3xhvoddWxKRIB7qjdSS4FWn5b1lvSXk=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784AD707CB063A5A785487DBCB50@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:MYPHrG7beK9FErjGv+fNwjk07Gk0PWaloTUT50FUKkBccrUPkmO/Lj9lPgT/gzz9hbbNtX+iKxZdO0sBZlLpOCDqEvYxVP9Ws1zYIDoPA7tbsXJXIz8PxOzthpGJPWhT/ppGFhrquyVj5JddyatzP1x/5hp9kkAHyx6oTQ3ZjvBBXjGOvQrFVCF3EmXFEMH8XT1T5ZdsybISSaKQDeU7SfkENUEFmxDCm8/Cz5n1GoKl1Y2scgChJatCA/pwm8mvCnzAuF1KVwjUkCeoK2QJbA==
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39840400004)(26005)(86362001)(50466002)(50226002)(8936002)(6506007)(386003)(76176011)(47776003)(1076002)(2351001)(66066001)(5890100001)(6116002)(3846002)(2361001)(16526019)(305945005)(186003)(74482002)(11346002)(956004)(2906002)(446003)(6512007)(52116002)(53936002)(6916009)(6486002)(476003)(478600001)(316002)(8676002)(4326008)(2616005)(36756003)(7416002)(7736002)(6666003)(48376002)(16586007)(5660300001)(54906003)(25786009)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:sy8anVz3XWBkqkymy7kCySpqLCqHfrVl6m40VJL?=
 =?us-ascii?Q?QVJ4GvspSmvLsSAkj7h6Z6+GeSXKBPKDwp9tQl6HHUS0iPhiyU5KTQS8C7aY?=
 =?us-ascii?Q?q3J1AieHCIva8n57M+6Nc6EzXg2t6L/2QXEB/OKxil14yfPnj1xyts3lv1wz?=
 =?us-ascii?Q?yhG0pz/XJK4etzUYrcqBZQuTxLoUQ7Lh4K8CXCFFqE4m5A6U18OLH85FkQDA?=
 =?us-ascii?Q?rneY8q/aVOj9V+pjqBSKZmlHvPkQHVkEz+9Ok2MvMFvPnUGQi6tHA8h6DPGX?=
 =?us-ascii?Q?zESxU8ruSBbBjhhmV/ie+S0xbOF6GcR0gCMYnZcbOfQ1SVQMrWd98LsBQBA4?=
 =?us-ascii?Q?/5LP7g8AUh+6q4yZ5Y4fxIIflhlkwgG4sA2qNv0L8Yh9GKNtwV4bklgxyujG?=
 =?us-ascii?Q?Iy5QSUdArvhQaTVXkmFlOskaToXCpMEbpdVRx5ebzlSjhGvB7gbsjhWzV+Si?=
 =?us-ascii?Q?Aup9L+NXeU8q1PPKlDl7yhvAJqrUC8/nxklx+RAAZ63mCF9UDI/ucVaQMVLi?=
 =?us-ascii?Q?l1GYgFNhPF+oy5KN8HMJbbpMRFuqgTg1k+IPlZyoZW2far52H/hw3v4oBkRf?=
 =?us-ascii?Q?t8VYi1no6SVpFjyH0FtspqtrG50335Hu5NDEo2X2BL3/iwNhgJIAzuC8mOiG?=
 =?us-ascii?Q?u02ZKgafNGdH4VWRan8pPhgNqU74IKigFbdVhvi4lgD+IrFjrsNk+Z5c0/X8?=
 =?us-ascii?Q?ND/6G90Ew+GHUEn/9rNHBF5b6dJzafqURHdV4zDiJ85Sa37w1QP1NQzAbt4S?=
 =?us-ascii?Q?URR9kIgad6Usk6ziqns6U6QPTgzY89bezc9yKV51oZ28TvO2TFsHk5wNc40i?=
 =?us-ascii?Q?s1d8RUFee+8fMRcr+mqqFe+Eqg2U2garJltujjRhVIL82mu+Q2YNGKdXwUKm?=
 =?us-ascii?Q?mGWQ3pZp05x/iaYQFjxOoXO6ToegUUL/ux41TGMqoXZ7QxLrKiInPuyBDvsc?=
 =?us-ascii?Q?I+ZZwD/N8IRBrPonhEdjQSw4FrGZBCYYw9JFRPGP/BudkKYgoSYPe0J1saz+?=
 =?us-ascii?Q?GVtB1LHsDLfCufOHSfWrNH8rG7bJHBKBvXRDYuDX8GaOkT3BP5Ha9cNYUvgU?=
 =?us-ascii?Q?mI0XUi/g9PBHDU3iZKga76GV+g0BRUKukyLRoeBxNav1/Xu/IzaclbfWGLOo?=
 =?us-ascii?Q?PCJfMGoYPJdoigf1Qj7eJef8oDQ7kwIDY182NxiKuTl8+GFAgjm865g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: QGJ4flbXr68TiHng8r94vUs1EnzIKxuy10KKqw6Kz2CX7n63H31x18owycp8L02DYqxJJY6KLr9qG+aBgVJvAiNN2xNBZznP/yDLdmTC8CIV25kcgKZMudUwG2LMaZ+mMKd2wcrQYTe1lBqKKMju1ELBlxH05+J+rLTUSaXpeNFtUpQhq01Nd1QTgF6GsbbW
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:pXu8jysSE7FI/RRM7UC7uZnPFeKKuwat+7IRwSQWDkHUtfclJP/aFry8aXPXUFw7enKyLPYo2IETW5MI3HQxtVsWG0ADWRMqlFy3uRaUaI+8WQSA1kxlc31f1nZRpgcwWdiOEN7BezNcbRb/tPGII82XUKrGDZQlfG4XVmsCIYgqwEJSEjjRZHARPUx8/eeRms4oUGAyR8IXbCe3P/Jb1l68zQxL3SIYj60qY6Z1FZ1kgS9F67uBZkaB5Oho8YPfFWeCeUGy2r89RxZJd1KklVZ/MfjuxZoitBLZOZtuniSDtSt5DRuMLVLYIKDxW+yBaOodOQNoaBh5y+pPHlgHQo8SlaGuSYTySDY5o/ZYbs5f1rCGlYh9AXKkREuQnD71ErOGKqEZ8s6/OiucokMpzr0CdRXDsSqxvGImkjyhgcmqHJzXqA8sFOd6AuZhUc4SwNM2kR82VXJtz22BRRkTig==;5:fMj8JK/C0bHkq49MNMUhAAviFJ2sMU/k5VzoKO5fyqNF5S2QuJMZFYGFKK29B+Rd61T8kzqomgo02cR+qzwz25zIN7rC5IM6fkxadTe7WY9C3swjYXUu/ggpZLdzgbNpuIA4UVayRV8RYDVEyrCBg07i18ilRroock+U9jigdO8=;24:/7gypFue93YWbZbkDpZwosMoK5qqXXKW0OVS3ED90x80UHxyOtdMNhPUIDe7ToXcW2pcpLcYJkJks7XlQxpDC0KB7JoUJ1xfkZpywWYI04Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:FVMJC1nMDYnKMI9Q9OC8nDUA1fP4tM3bDjxBIO9hiV4MsaQS/969Yh3CMMC59CqnWtxacVfad2ZPrX6bRMlGXTCJuNfuu04ZKzk6kMy5fWGRUmwd/yBlx5CEIgZ8XEPA4EuXuBNNyJT51Pg4ijzHixgsKr6gUYWja2Mdf9veGSi/bD6kW3ilWeLt2RjlDWBt3gwhD7qb+wIZ4IpZo6DYbeu0yxpBa6o71djPTJDyDu90YCtxo8R4PbkxiO/UpAg4
X-MS-Office365-Filtering-Correlation-Id: 0800700e-8620-4f64-f101-08d5a61295e9
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 16:28:28.5833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0800700e-8620-4f64-f101-08d5a61295e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
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
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 71 +++++++++++++++++-------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  2 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 40 ++++++++++++-
 3 files changed, 92 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d73281095fac..b4e7f5b6f497 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -226,6 +226,56 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
 #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
 
+static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
+{
+	struct drm_connector *connector = state->connector;
+	struct atmel_hlcdc_dc *dc = connector->dev->dev_private;
+	struct drm_encoder *encoder;
+	struct drm_display_info *info = &connector->display_info;
+	unsigned int supported_fmts = 0;
+	int j;
+
+	encoder = state->best_encoder;
+	if (!encoder)
+		encoder = connector->encoder;
+
+	switch (dc->bus_fmt[encoder->index]) {
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
@@ -238,31 +288,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
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
index ab32d5b268d2..be2d180dd169 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -365,6 +365,7 @@ struct atmel_hlcdc_plane_properties {
  * @hlcdc: pointer to the atmel_hlcdc structure provided by the MFD device
  * @fbdev: framebuffer device attached to the Display Controller
  * @crtc: CRTC provided by the display controller
+ * @bus_fmt: Array of bus format overrides, per connector.
  * @planes: instantiated planes
  * @layers: active HLCDC layers
  * @wq: display controller workqueue
@@ -376,6 +377,7 @@ struct atmel_hlcdc_dc {
 	struct dma_pool *dscrpool;
 	struct atmel_hlcdc *hlcdc;
 	struct drm_crtc *crtc;
+	int *bus_fmt;
 	struct atmel_hlcdc_layer *layers[ATMEL_HLCDC_MAX_LAYERS];
 	struct workqueue_struct *wq;
 	struct {
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 8db51fb131db..8787e2890c93 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -77,10 +77,48 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 
 int atmel_hlcdc_create_outputs(struct drm_device *dev)
 {
+	struct atmel_hlcdc_dc *dc = dev->dev_private;
+	struct device_node *ep;
+	int count = of_graph_get_endpoint_count(dev->dev->of_node);
 	int endpoint, ret = 0;
 
-	for (endpoint = 0; !ret; endpoint++)
+	/*
+	 * Assume that each endpoint will create a single encoder
+	 * so that the encoder index can be used as index into
+	 * this bus_fmt array.
+	 */
+	dc->bus_fmt = devm_kzalloc(dev->dev, count * sizeof(*dc->bus_fmt),
+				   GFP_KERNEL);
+	if (!dc->bus_fmt)
+		return -ENOMEM;
+
+	for (endpoint = 0; !ret; endpoint++) {
+		ep = of_graph_get_endpoint_by_regs(dev->dev->of_node, 0,
+						   endpoint);
+		if (!ep) {
+			ret = -ENODEV;
+			break;
+		}
+
+		dc->bus_fmt[endpoint] = drm_of_media_bus_fmt(ep);
+
+		switch (dc->bus_fmt[endpoint]) {
+		case 0:
+		case MEDIA_BUS_FMT_RGB444_1X12:
+		case MEDIA_BUS_FMT_RGB565_1X16:
+		case MEDIA_BUS_FMT_RGB666_1X18:
+		case MEDIA_BUS_FMT_RGB888_1X24:
+			break;
+		default:
+			ret = dc->bus_fmt[endpoint];
+			if (ret > 0)
+				ret = -EINVAL;
+		}
+		if (ret < 0)
+			break;
+
 		ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
+	}
 
 	/* At least one device was successfully attached.*/
 	if (ret == -ENODEV && endpoint)
-- 
2.11.0
