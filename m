Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeCZVZb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:25:31 -0400
Received: from mail-eopbgr10108.outbound.protection.outlook.com ([40.107.1.108]:20836
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752171AbeCZVZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:25:26 -0400
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
Subject: [PATCH v2 2/5] drm: bridge: add API to query the expected input formats of bridges
Date: Mon, 26 Mar 2018 23:24:44 +0200
Message-Id: <20180326212447.7380-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180326212447.7380-1-peda@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::27)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e7ea886-a999-4418-c223-08d593601602
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:5LzGw73Iea5zgyiaW82itqKbkGfdX4C7tzhqHOZqCz1NdXufBXh7Ex1Ry5p5H+a8ayaCe0Mda7aOf7epcsACIFJ5nB2cBkkjhac+CEu3F2xUQ1Fv0gUUUH6fIDbl1WeiZiou0DQafxwmiltoxQ8pAcb6G5bmQJcj2k+iFGF8tb7XGkY0oX7SittMOESQVQff5dIaDg35X+QJSXcuzXSYPFF9pyztZVmR2VVpOPwd5PAkBnD+F6KWDa5rOxOzTXyK;25:7rd1xAQdkgPpHArMOrw4komC/8MGT78ZtpahWPdoJl8ESH+pizn7gJ2WYGwWFjC37gUmmrg/YEhU0p06oy7XzDPeXDEJaWEw4Xj9i5uqfu6hmdyR/JOs15DkrrvoGICvHBr4Oh04UHcEICOPtdWeQKW+tbUilReQuCfp2WDNQnMXtuXsyfXUGhOjkx2Tv/WhdmHpkFJfuYEh1ryCAQML29FRD59SXz+dv2mc+OZTyqNNBDYe7S9qnNfNHHv8LSO7htsKNKd32ubKKvKDJpaKy3U2mPLx3+ion7EdAoIZMSjkgt8uGEMcc1dAR9PBsNrxpO38p2Rcu3kqf3YeI/4miQ==;31:lFBDwqVWQASrVsHqrieJ5RI6oP4KkvA+1/KanNdcfyGGOg7ls+X8534ZM+/0i6zCvwC0FIjWQfhriXu7bQbuk5aoxagmh5Ty+81S7X8Kl4DEjzSXmXLd1c1o+pOadKwHPf7GIsSPYQSGWSX6OXEsqp2/2lsZXmdAXnoeyBZp5g3UFy6z4BdKYjYvgzeWEN3WqxCRThq3m2J9Q2ibRQkPjpaQXzgAZP6JiWgVPcJpZEQ=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB276928B0AE27BD29CF8ECB7EBCAD0@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:WL8ZLOXHZuVreE7FTp7jEwJQPHkKwrL5jmog5uvpUbZs7EgghVppCF7s7eww0Jtf19eqgZIeiuGYbkZ2ePG1lY3jPUXB8pAur8Fej3lAY0pQpxUjwj0ykOQkfIhhfecbFA0EjfCOPVzRybR1dXfsyrwF0QeD44bFJVR/TmnlYoiXfAGqKRdOk/aa2Ivon1u2yq8ihQt7QFWuRhW0GQqB9HZ25/mLy0ToSyyzoO26aGclYGKb6NGOJBNITsjB+07SBf60ozbIqwb3fheSvA16q0XIw3rPuYmG7uaHy7mLoUnat+O2oPMbsJVk7yuW3ErL
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39830400003)(366004)(39380400002)(396003)(199004)(189003)(446003)(2351001)(316002)(16526019)(186003)(54906003)(16586007)(11346002)(2361001)(97736004)(105586002)(6486002)(53936002)(956004)(6512007)(2906002)(2616005)(1076002)(68736007)(66066001)(51416003)(76176011)(48376002)(486005)(486005)(52116002)(6666003)(5660300001)(106356001)(86362001)(6916009)(575784001)(50466002)(47776003)(478600001)(386003)(305945005)(8676002)(25786009)(26005)(74482002)(6506007)(7736002)(6116002)(36756003)(7416002)(4326008)(3846002)(81166006)(81156014)(8936002)(476003)(50226002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:9IXOTqzgJIK78C6wlzGx4l1yV7J/yu+4E+ph9Da?=
 =?us-ascii?Q?rqdooS8TNeHt24cZPwawUJtc0Xd/veXrjEWEr9qI+1VvnQGOENBx6eOw2sSp?=
 =?us-ascii?Q?OOWH6J4W/+8rqNecOW8bMeFzSwC4fQbMJyiHPykhf8HNPCGqc7jKmwXbTYVQ?=
 =?us-ascii?Q?Nv7B8D1cciL56Efnl1Y+Qku77ZR6cLaB0kHVPfR9tmy+Pv23GyfSmBhkGC5+?=
 =?us-ascii?Q?tRftTouiIcEotlpopmaltIAntaXx4aVKAaBMiN3hb/UxsgAcD0OKEgXoV9vb?=
 =?us-ascii?Q?UnvZj79o46NaRcwSo6wSkqkAterZUcuOOnIcKsq+t4EGqISf6PKyca/Yxn40?=
 =?us-ascii?Q?e53mdfcIOt6xN8tl5hBX2BJkxRKeXtvC2wW3GrU5m0uAJ0huKcrDeWResypL?=
 =?us-ascii?Q?eo7fAoEGjsu46qsqGvVcdZCieYw83bxBdhxm3SFlUIqj1sDdbB2/ZYQWM9NH?=
 =?us-ascii?Q?E1egLjlCdY9yPXNKHYVhfs2iQhYiaJIe0ZAo/mJFEqp0XP7Uy2WoO7phznft?=
 =?us-ascii?Q?cJELLTeD59zTerTLthjFF7tNr1Q4X/6tYA6sza5VOgZ+JoKcCCderXLtqg0o?=
 =?us-ascii?Q?AZNVXJhr8O3CE9zq7TiijrV8nuB45KnyKFZNj3TZ1lMh2KIgO3CDL7tnuXOt?=
 =?us-ascii?Q?tnaiTGzvmYveLijvD3EkO+eAQcpNYgG8x4pzhcZr8dgiDdOzPt+VR6v4s5gT?=
 =?us-ascii?Q?6gJsEGOgy2ux+feyXdpj/PX/Yi1LngnAQtuxelO0sUV6h3wYxfrQWHjN8hh3?=
 =?us-ascii?Q?Yx8mlyAeqHsgpoCpyxe06W+qb37ydeWN9u5Qc3lbOMX1Q8GjgAwouytDC2vM?=
 =?us-ascii?Q?zt88Z2EvdMqQocj7l61bgzL5C8b11delCE67RP/NliTuk0x1VPn8LIjc01pm?=
 =?us-ascii?Q?yoXr7wHccmyQxsC9zYEUlVs4DFaAFlDVNtBqRXcctw3IUQQaxtcAlGWzfHfU?=
 =?us-ascii?Q?LcWyvRRkAAB2zRRiUs4SqjQBBla4WLqCUD/PdwDNSta/u4Wz4atAvT0v0V4x?=
 =?us-ascii?Q?C4SrsdDbvNBVGDE/Ryg7dlxJeuTFPUruzqWka2/rClrxfgc9sDYFkh3K5XkR?=
 =?us-ascii?Q?LDaQmjPCRRgK2GC67G0fnBx2lmkhwDVpi+Oy1UJWRR0TKT/P27v1Wcnce+/5?=
 =?us-ascii?Q?hb8Ls3JUayQP/+239/srjXvdcfQ4ObG5VbRNP07x5xxGhgdOo9VlSlZijQRh?=
 =?us-ascii?Q?n7OEAl2kLkMneGWIM0VHBBjRKUWe6vyqS/7DhWi8zLlHfCYJe9FYfXsAs1Pu?=
 =?us-ascii?Q?AHZAQfPQoQQFyi/AR4Lxl7koOufhJWi5KoHFaksFF6jVkoV3Bot/+fJypQS5?=
 =?us-ascii?Q?jBpuUciJOKVScW55w5qED2DYYJr/TeEf4RYBWl81id35JolMqA4T5cTSZaWl?=
 =?us-ascii?Q?Ght/uKQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: aOBHXoQJDaOilIk1y2xbSwGiG08UJ0Fd5f7gxDM7Hu+vOXHabAlpWFnNlYdNOiSOpeTy9UOc8ZpOWOx9eldV6QXPy/TpgbZJaT+O88j7WKvuWtWccQb9ggWfjIeUDidCdYz5Nk5rQemcLUlneLpo1FMCrwHH16JLxn6af+bbnQbNdhHfFMcQl+TUn24+gzPl
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:yBouxZNaTuXdwz5wAwAcJ8ZBXSrk9K2jof1sH+VpPoEEKPqAs/VW5zxjdwhIW7/42ppqrObPpKYVFXBb4LnsbpPoW8ZN/KI1Swhvw+T0biUoHdMSPYbq1J14qIre9SCfACRoljhfhlgSeyLg5xrPw1kqMYwsBHu2/q7Lo44XoYvJA936f5E6W0rViywdumloWpFjCwluYShMHLLdwRQgHIoPR5nZ52jPihGTQtyT+Y3N8873Yv3bnkXnuL0y4OZYbIZHud/vGpTJjnMk0DvzGeKYhLBlningPAwUxU14t8hQq8XLfvZxkEEnscID0SmnOpj34i3W2kSvri2xwX5FB/YXedLWS/3TPilXxY/Zg9rma6nzh269B/p+URsnlpqkgObT4wdOgiyKotmJnDn2/3LjmSanD4RdbgwSFeEBnn4BKisS2dCI2akyJH7Xtopr6PstRXjscj9yCZz8/dblaQ==;5:KwATvsvvt/R9r9ks+WCHV8ffovTqvwFgxkqq0N3pq4mXqKmKSqAWgBrmg48fHGeT6bJRRuzGTMEh14qgiPLD7tLohEyDmJ8T6s0rcA4VYePA6GJ99KA0TtWofEYT11CPzT/S/rqUCjklKeWYYSzZ4Smc14LFY1WP+aCu1Y6VFR4=;24:JC3QK8LDYnWq2+6r2NOJSjp2ZrGgCbNANskXgm170wxag6fmVreOIEhrpA295um2ywujmI2xgyQyU2A2Zsehk7lFpMsbT7O8mUWYQAhDLuU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:MSWrGeSio0LF5Zpl8yprA2w/+Oje45zE9G37YVNAhrWm8ke4UnikPKE2OpR0ItnGoYJgd4YURFAujZsFw2pttDTCYyiMpSS6uxO2BjEpnyi4EnEpwtSokft9PRJYJD0bxUe3MZ+0M/FHDNv7/ExVCWliyiWOxJnMiMAEoXZ+gGSTV2RDzWXO/y3QRJ/m6LX14Hxeg2NI/Rimhb5Yr3mtIhdwwp0dzEMJbnsHc74f/iyZvk776xD8mM4D08FwRPWF
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 21:25:22.7517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7ea886-a999-4418-c223-08d593601602
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bridges may affect the required bus output format of the encoder, in
which case it may be wrong to use the output format of the panel or
connector as is. Add infrastructure to address this problem.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 32 ++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 18 ++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1638bfe9627c..f85e61b7416e 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -348,6 +348,38 @@ void drm_bridge_enable(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_bridge_enable);
 
+/**
+ * drm_bridge_input_formats - get the expected bus input format of the bridge
+ * @bridge: bridge control structure
+ * @bus_formats: where to store a pointer to the bus input formats
+ *
+ * Calls the &drm_bridge_funcs.input_formats op for the frist bridge in the
+ * chain that has registered this op.
+ *
+ * Note that the bridge passed should normally be the bridge closest to the
+ * encoder, but possibly the bridge closest to an intermediate bridge in
+ * convoluted cases.
+ *
+ * RETURNS:
+ * The number of bus input formats the bridge accepts. Zero means that
+ * the chain of bridges are not converting the bus format and that the
+ * format of the drm_connector should be used.
+ */
+int drm_bridge_input_formats(struct drm_bridge *bridge,
+			     const u32 **bus_formats)
+{
+	int ret = 0;
+
+	if (!bridge)
+		return 0;
+
+	if (bridge->funcs->input_formats)
+		ret = bridge->funcs->input_formats(bridge, bus_formats);
+
+	return ret ?: drm_bridge_input_formats(bridge->next, bus_formats);
+}
+EXPORT_SYMBOL(drm_bridge_input_formats);
+
 #ifdef CONFIG_OF
 /**
  * of_drm_find_bridge - find the bridge corresponding to the device node in
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 682d01ba920c..ae8d3c4af0b8 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -220,6 +220,22 @@ struct drm_bridge_funcs {
 	 * The enable callback is optional.
 	 */
 	void (*enable)(struct drm_bridge *bridge);
+
+	/**
+	 * @input_formats:
+	 *
+	 * The callback reports the expected bus input formats of the bridge.
+	 *
+	 * The @input_formats callback is optional. The bridge is assumed to
+	 * not convert the bus format if the callback is not installed.
+	 *
+	 * RETURNS:
+	 *
+	 * Zero if the bridge does not convert the bus format, otherwise the
+	 * number of bus input formats returned in &bus_formats.
+	 */
+	int (*input_formats)(struct drm_bridge *bridge,
+			     const u32 **bus_formats);
 };
 
 /**
@@ -263,6 +279,8 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
 			struct drm_display_mode *adjusted_mode);
 void drm_bridge_pre_enable(struct drm_bridge *bridge);
 void drm_bridge_enable(struct drm_bridge *bridge);
+int drm_bridge_input_formats(struct drm_bridge *bridge,
+			     const u32 **bus_formats);
 
 #ifdef CONFIG_DRM_PANEL_BRIDGE
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
-- 
2.11.0
