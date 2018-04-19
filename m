Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeDSQ3x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:29:53 -0400
Received: from mail-he1eur01on0093.outbound.protection.outlook.com ([104.47.0.93]:41173
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753861AbeDSQ22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:28:28 -0400
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
Subject: [PATCH v3 3/7] drm: of: introduce drm_of_media_bus_fmt
Date: Thu, 19 Apr 2018 18:27:47 +0200
Message-Id: <20180419162751.25223-4-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:+2Bg+0piHtjg8gfmB6VtlLEuWd56LSQwQ0hG/LtEh8z3ODjw2reYFDS0+XISyOTqlDFLQSW26yWsIVTkfR5rkYflt503tvfNJc4/Q2mtddpkbrd2rOtUML4bDAC+ZzDf72ulfMk3Lbepkwb0GXDshNKX3faAUN5M1QmAXcYXN+DoPncNnSVyilrq3HNgSB/5tVD72Yme1zOFcjo7cDnQXCzgm0jv759bppENwH+yoM5sP5WKd5hi6rDA3RIEAoTa;25:QYHKORxYDb3xylIWG54cuIulGd4aESIaofd0dMpTBZ9lqKGzAi65L2X6+GRSmmZ6bAwn66e6g7cIUICmH8JpLKMvLK+HzGlV46tWE9rxfJPSIejmq5Ly6MdceggRB6F6OefDj5KFZ0SZu4aMckB9rNJOKP05ByL8W82I1VJkl4RsBaEGTX/EDRsy0HqtsLiBQjvoQXGdbswDy7Qq+iZmsN35hJ0Lu511Lrx3WJVt3UPJeakBBOM+4SNT8VClP534NayVJLfyp2il3eVSfKKPuXRl5rDHZ3iR5zdaYRDWEsg/P1c9adHqGOA0Pxe5bADnLUNPqT1jLzkgf0QmtyaYKQ==;31:FH5Sz2GJFu3V4luiqhbIQFQOfUmIk4qAKiD/+gx0gh+8iTmQ8Mb3T7zx8HQLJZpI1IRjUKlb8dcUB7Iq/yCCt+/ai7e4A2937vZKjTFOqp2xOMm0abpIaKWbFYwW8k7oGi1lg+eeMxzQjBVqtPyAwhhfggQdO/USV8Q/dqZPM81KE+yTbSG9XyqSVLhsRTdEB8ZwczTUS60zKOZgFRtv4hEHx05Pn1/Y9BAHDVwJ8G4=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27840B7BF6C540D846EBAB36BCB50@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:RSjtOKMBtuhpFBY/1gJbzOQHCYIj4gFWjXOe7LMvb4qMaJDp9+3q4VgQUoDFyGrnoH3Exp71DqTS5jwmc6wM/E2VrJUHSs+4ItEBSi2BpXqjsTbLNgxUZHYvRaSbTvAtafNsdAjKP6Qj2LtVPvriguuNvYs3cmxaspnzXn9YFfN5pEzEZLUGKRGVAKeJol8HWi+B8iMvoe2bDsi/BNGYPi2br0o7kgYt3/iXm7FOGFC8wqBDk3DAgFAD9pIWp6UYl9C8FMfD5XCpuDdrcJE57g==
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(26005)(86362001)(50466002)(50226002)(8936002)(6506007)(386003)(76176011)(47776003)(1076002)(2351001)(66066001)(6116002)(3846002)(2361001)(16526019)(305945005)(186003)(74482002)(11346002)(956004)(2906002)(446003)(6512007)(52116002)(53936002)(6916009)(6486002)(476003)(478600001)(316002)(8676002)(4326008)(2616005)(36756003)(7416002)(7736002)(6666003)(48376002)(16586007)(5660300001)(54906003)(25786009)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:uvCOf/M3BFXop8MFyjQqmpAT7EvuGo/vkjmD+z8?=
 =?us-ascii?Q?1Knu4V5zp/WhPV2MD5c5AiYKLtAnqmpjrOaqHoFpcjTXueH2sR0CFeTxTypI?=
 =?us-ascii?Q?Wid1Xk2PFB3shg6FHF0eXTY1E4gmgiCEABBxI1/rmOkBsSa89kroSPYfECK0?=
 =?us-ascii?Q?xP0WGiSlQIUqU+vuhPmQn82YBhOHKKuZweHs0cMZjpVQe0VwLaJg7nXF4B0t?=
 =?us-ascii?Q?sv3KeK34Z7G8FK3yP//s0LoxhHgMUKmD4ScC5ZEoC4GxRlRwEmJP7NlylpVI?=
 =?us-ascii?Q?AY/5boYgAbTkLfpx+hBvAnzHqIk/I1g40aX+jPXAU9vpWDgYvRSY3UDjlHiH?=
 =?us-ascii?Q?6FcmaB9Y7inPFa0x1yH2AXwkqILuLoZR4UxOs7yl7DWSusnxTAESbsPRl+bn?=
 =?us-ascii?Q?D83k8UEJsHjadrY8I1kYFuXBi7YY/+LH//Q9jzsFFbyoAjruvFEsUoiinKja?=
 =?us-ascii?Q?NftYdCUPHzbAkgjjd3dCtmf2CXX8rkYurS+sNEW+LygOoztDNsEz0lax4XiF?=
 =?us-ascii?Q?iRzjzVeGqwUPQdSgx296WtwGSVkojJmq3Y9CSE6SxgetQuZHDclEAc7Uq4gB?=
 =?us-ascii?Q?hOpn8oZ9hx8KdHB19IXbicrnRhpxWUgABHFWrFcM3V4+0ISR8wsMhl8NaYJH?=
 =?us-ascii?Q?b2ytCygD+RHkDx9OEqrewnerU6sEVrJwQNmh+S8Mby0FCgG37YplWQuZsoZJ?=
 =?us-ascii?Q?JvvckFXVLqTK92Avz3acEmjBolYIMvOqTG9BkGxrNWa8cZNAe3eftAGuv3bA?=
 =?us-ascii?Q?EN83nn+BnljQJ1vKhchEI9mIkS99XeXo4+AyW56OYmuUh+J50hJb6RwvRz8R?=
 =?us-ascii?Q?vkV43/pV/nBPL2ss6DV7WOqiUealZojWRfXo0tZjmW5S/Na3fP62HRPRMbnq?=
 =?us-ascii?Q?iLGxH71qWIiAGcBcVuqJxLsApMiSr1D2emylQYe8UwMnZNpv8pz8QAvtkBKC?=
 =?us-ascii?Q?8aXTCvGDbM1nOcvwdO3ES6pP6UhRuKfUuyvUkNzpyHAqGlP/TbwrOabjl6mk?=
 =?us-ascii?Q?TLe998lD4C51QCs4D6nK+dpzFJNutsF0LIhgVm+1MeK9ERXV7rrTZzJTOyLK?=
 =?us-ascii?Q?VcTOTTP5/h5Q7d5ZjeT8PKieVa+QtDzGrYf1w8PctYzSxCnNugY0NiRWECtX?=
 =?us-ascii?Q?uWsrA3hzTOdI=3D?=
X-Microsoft-Antispam-Message-Info: W7vbLS2tPpVfc1C9Z87s34tACIZ+Ifxele9hEMBmyW/r1Voajbc9d4Uhn91nyyCd+7B/NMgrFoA0rZF6QRk7bNMWTte3h/ZNIhvYUcazI8Nj4fgYLZP3BBRLuyz87ZplgSCvPFBPL1/IdHcziS3rMC1uMsi8ZZNCblRveyrowfid2Wg6eGiXTXhQnHEwolTJ
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:aKx4uW9kVd1jppPUQ5eACFiKcPKZdDyJVFfzjwqQrpYh7bJJ5Hr1wglY5nVbFAysbh1PSwg6FoN4ZvJMYDuFPdroFK9NXtbIwp5ydOuXiwRhXN7ESI2cYglh1yVUJpNGA5GntMzAD4iKBE5pVUZQ0KNTOx8v4lW7BLL/hNsHPhaxwHj2ihxZ9PwVbd9MNuRSoG1BSxKF6wvR9duqRUlY0jwjxLKsMtQmszAhE5Jy1u6Ll6Y1ZlSogFAxsiezKxSbBeTgHRZSQwXby/YaHZBNrZ0p3EnmVRljHnd9IhskOVKQgHxJCBjc6jiIp0YmWmKPg/KmiPTJzc88F8tCsFWx0207lNx2ecLRDhuF8kMqdg1Dqb6vHEhjXlKLD3KDGNBekHolvQaPOmm8zixf3LCjrY6QcqTMA6u7JgUu/4IhykmgNXOI8uxE6qCYe3oGVL4h8qBCDVyPRxDeRYlZuYaCPQ==;5:qoaEP1K/WU8dbLKBNaMWm7wl6CpYbnZDjuMWCqULehCsU+t5Roco7HhbQxpXGYvP94VaRFP52B5sE9XU3+ndKhi6ZNTjvxbm5hd1sTCsJLamgN0odIx5/+GiYyWE7uspcPCr9O6q6YfWYklYY/cBQXJrkp2yRLDUtOPMhDikJ4M=;24:t3czxj/DEb/3AdPI4fqDg/GOgkWI7nvLuNhqs2RvlrMY2QtG5sTt7sPctVcgdHqAoiWbPdo2EsIk71NKNKUc+3i10j2ZYZAPn3lF935RAVk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:OCW5iI1FdRvztzZyD530lVTnMI5RTZ8WbX7VX+fgfE1lbLweglmAAA0P+vrfd/jYDI677gtFml5Mx7BqiJMi7MHmvkkx1SG+dV61tsnauLxdaoXBzgN+0nqqcKQ0JfN0w6llvKC1pvMB6SecYBD7lPHwhhc71+LILzLqsPXBu/v2eWozd/o8N0Z6quiMrH2UyPK9cbxi0E0afgqAEWE1O0TeogZDrPFicotmjUKjX9q/oUMQM7MuUk3/VJOEAhyU
X-MS-Office365-Filtering-Correlation-Id: 28d08edc-4103-40ba-4b89-08d5a612931c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 16:28:23.8801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d08edc-4103-40ba-4b89-08d5a612931c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
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
