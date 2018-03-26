Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeCZVZk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:25:40 -0400
Received: from mail-eopbgr10110.outbound.protection.outlook.com ([40.107.1.110]:43744
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752259AbeCZVZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:25:34 -0400
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
Subject: [PATCH v2 3/5] drm: of: add display bus-format parser
Date: Mon, 26 Mar 2018 23:24:45 +0200
Message-Id: <20180326212447.7380-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180326212447.7380-1-peda@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::27)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06a87ddc-6808-4af2-31d6-08d593601b1f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:mqYa0O8ypyAtXFEyM3I8I0EG6gVHvfKHOZGNeKJNewJazMbWOgcKFqDQLH1tpG67XqWOHZvGhTblmWNpPvkULfK0zgAeFBijpOtbett5mAf09YsUqXgz19q7LKyveQb6HgZ01kToBTwfcWGky0oD8ruX9qM7T8HlHOdSa4mH4cG2JCyDpb+aDu5dzgEqACXJ5Tsy5eKyjQfzgDBd7opP0AacB/3k7BAFjN98LXQPq3CEFPYBL4svEkpdR3sqRNDN;25:ch+/lCFwh18i4qaVHqbqeGo7PCIqbXq8Eizf78tn76R5ln3ue1zR0JAFTH2mIDbqBwgu702OMcBm9Z2Nk6dIZbllleYBJtsW65NiRDnJfEEDgoUffIR9khoKKKrPGMKftLwz+or83YGWUapIJtfs+aSm5UQDRWBDxelHcL/0CnPm0Vk/VuM6aHKDykWBSCZwaxrZRhZiXeWWLexydEWl+VFivRVX13fjk2pf3rb7VxWybLTdNWdXsnb6wIdHZb0h8OTefNDMO3MwHVWFMf5yp9JavuOg6MY2yCXKMt46mkR66gBQCatNT9lCyobfWG49vlc/CLz+YcGP6A3K7PgtAQ==;31:LTulc+uDbzFQI0ABirUvUqvGn4UUiZHz0knOo9LmvcQVl+Qm5Tdyr3ks5ZHc5yFikWjzuAr2TPnLbqijZ+pvuEtqCKp2ZLyWkNj8KBiBmncjiXkUpoyvV53y6++x/izf0lGYpf2fISRaimlUcYMZ/F2g9aPfcC8vvJGi/DQj7F1eY0Q+oZgy+J2fNO08wmgxeKUER9dIfBy7ORFSa9BvBlidcC7TAgTMNBF3SllI5Vo=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769A9FAFB9D9E93FC9927AEBCAD0@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:dpZbh/t58qWtxC9RLR51lgITRAvyWRx0rToBltwY0UrrJ+7z0b5C0p4qs4KdUCgDCt96fEnQuJadgOZ9EMnvKr6ULWXjc3DpwRR9Fec8kYDcVd12aF8PTCgpQZN596XMb4LXYMV3ukryaO2keqCUyyYgHnWrwXN7Mdt+gh/A9/yNttza5f5oWIvYKWGnILR0AGK6mmGp3qIWQa4uNjP4fj80muCRkxH5j3EPRKhwRYWxeSevNsZ6ZB+0vw0gmpvi4OyUUQXy+frVPOcYcqvF8A==
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39830400003)(366004)(39380400002)(396003)(199004)(189003)(446003)(2351001)(316002)(16526019)(186003)(54906003)(16586007)(11346002)(2361001)(97736004)(105586002)(6486002)(53936002)(956004)(6512007)(2906002)(2616005)(1076002)(68736007)(66066001)(51416003)(76176011)(48376002)(486005)(486005)(52116002)(6666003)(5660300001)(106356001)(86362001)(6916009)(50466002)(47776003)(478600001)(386003)(305945005)(8676002)(25786009)(26005)(74482002)(6506007)(7736002)(6116002)(36756003)(7416002)(4326008)(3846002)(81166006)(59450400001)(81156014)(8936002)(476003)(50226002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:LpCLQCQz8QxirxCAGfTUlYvv+m3nQnju0ZupejK?=
 =?us-ascii?Q?ii5DlVo8WU5WjrAqOF4iv1VGRjY7toqRUN5a1SNUhoOql0AgbDdmxKqoGVxT?=
 =?us-ascii?Q?wgl7o2kKxKstaQeCP2QKuwsJ+IXUI3XJjvY4IkUeicr8FDmA22VMkjQj8Nk+?=
 =?us-ascii?Q?/icrZJNflKtHAV9bB+K7lqYK7mIFoZzRGRfMH/hLvO3sEkGxzAHU6B82pfSA?=
 =?us-ascii?Q?QeZFLVJ7vKgkNpD0FU8ggJ42A6Yf7i92PBUMMiuPT43JZkWgnEIYjIjvq5is?=
 =?us-ascii?Q?yWEhgn7d4J07C+HZW8dYsRL06WHOHWLCYdSNOk4h3pYOMhO65aMwk+Jnmjzn?=
 =?us-ascii?Q?C4lpfpWn1go2d5mVkAPtWutgOlHh863NgpIQ9dr/Kg69lKLDdpiV21vwd1WP?=
 =?us-ascii?Q?DKXEdSMJjslLgX2EHuYzFu/rjc6OMhTQhtmWN1oebI6A+AP3lZ6UcieFyEyc?=
 =?us-ascii?Q?lnAIVEtGi31I/HTaa95mEbFgIkMuxivBu9Lh9puUMhRG/NxNm7Hq0RogCqjN?=
 =?us-ascii?Q?7quJQjiTTIMesm4LIRr1o4givHUNCz675MdBy2BPkudduzVDSf/qB2S4gFz0?=
 =?us-ascii?Q?0U0dp8zg1rTfWfakVBQBgUc+owXHd9RMai+o+gIAWh5p/U1hi+LzaRyQgszq?=
 =?us-ascii?Q?AbJNphb3n/Y1bSXGTN9nwQVKWu9NWZIeG9T5Z9SKlW/SbkjD2Fv/s1bycUWq?=
 =?us-ascii?Q?/TeaF8Jxzs6BfdLIyKIcxfgiLzlaix/KSTphEcTQ+pfwRr9r+fGEkAatBSYx?=
 =?us-ascii?Q?vVbPBVyw28RGtGIwFuq09aQysQ96YrtktcZQEd6/uBk33DSY2K97/ui1187l?=
 =?us-ascii?Q?SnCGgLyTDpQvAJM9cdRx1xN1X+Jxo+0LuGnYJ36QuczyzNfqzToYEI6WzLdR?=
 =?us-ascii?Q?12C1X8ZjB+O7KJ78edjgNlneZIiCKO5VED88VNEaHuxL+03Xe42wPC0uicUl?=
 =?us-ascii?Q?1FyEjXgYYcdYFT+GddYHogG9lmRYSpuTVd5I1y5ufhQnfCPer6Oh6a/epfy8?=
 =?us-ascii?Q?Ksg9u7BcEshYEXlCrJg2xU20amXzCk5PoJMhjdQDpdDrVxSpFaMlngvYIX1c?=
 =?us-ascii?Q?GHnzGWmRjGqqkamJmDZ4hKub2KM31qQ1qb31mVOs/EFJjkpRzIL0/OaBEMM2?=
 =?us-ascii?Q?PdK4UoeMnRggmM7BF24WC0FwQJ1PNtYI3MlUbXGrzxjR5TKDQHLAczFeMEkx?=
 =?us-ascii?Q?1/c5grbHixRoQylHVd9Ws1MwIzAPTOPLelwZpQ2rPUTCbCIOO2HmjqjIiqyY?=
 =?us-ascii?Q?R89Yj5VlkO827xi/3LGxihNoS1KzIKUtMie+iFY9xAfDyAxCY4E/GYJz4HE5?=
 =?us-ascii?Q?X1YyszafJKyAcKkbvvih4/wHXg7Cyk2r+1mQxLYqNGFHYlMBPEp1Ay1Rnowa?=
 =?us-ascii?Q?rZII7sw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 1L7V3NvmnnpOFUNkRyHlOb4bVrGvgL+aW/hUyj1CIODcGgdb8uxn9mQMBtGBQonVL5rs4aGOk+fbbIERspmOSR+cC6rbAECMfejtJVHsyhzK3VPaUI/rmHhH63xX10LoEmT9kikbT88KG1oTCWNKJolmXU8mDq2uMkIHI7039/B27UMwbodgBNcJKWg+Qzf9
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:6R+F4ox5wpJC08cXL/rcWuX4JzLeAD9sBPul7akzhRtYYZghRkrg988pclTfPsuKKYYLTu5a9xxKI0j1SiblU6zK6gCw8oOGAxKWflUNUCVEfDS+bOJ9aswinkdM2zRuwO/Q/rnanrIfj9/1Frg2YPywInTLLHYt37QqzAnXsYlv1NDlfi51Bav6zCntaFmAXyI7G0uzWwPcuJ69Wlxgh4y8yCul3+/H7nHKQK9CZRssaFizU6/ChvwQu/zRngs6dK29bGwm8s/BwHJkDDEhI34YcuYO447LoKV1A2apX4tZ74DLV42R7HfWNJb5qgscnreVNpn1VHbH2NzRfoA7Cps3aQ/La3RmQmZHla3lFWPOMqlZ9JpyqvKg0pXwTrI/laegoQwgAD29wBBM6CXmJOVkmHkcKvCqhRWt8Su3DBl+mmlN3Du42Pl2UDAxjq2iPe80wi0RfXYU57E+eJjOIA==;5:WaIDcdPIGOSrU4sv5v6hV7MDAhA66qQRr0XnZhZ3JY55Pm2VUFd0EP7SZxe1ut3lUe1NMUVpT5tIoEcTjSqXgcz9JKMgFSaLS+3bHY/HVaOP78fBSH4OK+jHjVGZFmZOMaJ5NV6aZ701MoU5nzKnipb9ea18vVTi2auKn3WFJn8=;24:6jfGEPPxSB+HA/AXU9BOsqplDtxz3373WJPzXm4aAsBauC4+WoB6MgJklHQYJDxkfk43fsMRSeILbKUcYcj04gxkSDt2iEdnCZxuAVuvo+E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:Y9JZdr9Bdt2CpQW/Rqstf5CZr0bmXDzHdfm3VbxFo6uWJhEyeAH86v7q59/FNoo5ERcRk/8q0CLdhUUofq4/7pokcMffHh6FlDmKnnZCk9YbZGFRrp+GeG31DV8rsHIjCOkFym7LYqf6uMQ55cq03Pm8PILp1bxShERUV1ec6oJO4IhM+z8bji3a86vuSUkqPHg7DehBT0hrpOGwI6Johhe5NAgXP2wXZ05ZD9ipaVvTthd31lDG7cjyYe17rBBw
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 21:25:31.3287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a87ddc-6808-4af2-31d6-08d593601b1f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a common API to parse display bus format strings into fourcc codes.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/display/bus-format.txt     | 35 +++++++++++++
 drivers/gpu/drm/drm_of.c                           | 59 ++++++++++++++++++++++
 include/drm/drm_of.h                               |  9 ++++
 3 files changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bus-format.txt

diff --git a/Documentation/devicetree/bindings/display/bus-format.txt b/Documentation/devicetree/bindings/display/bus-format.txt
new file mode 100644
index 000000000000..590e6c73f3dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bus-format.txt
@@ -0,0 +1,35 @@
+Bus formats in the display pipe
+===============================
+
+Various encoders in display controllers output the pixels in different
+formats. Circuits handling display connectors and hardwired panels also
+expect pixel input in various formats. We call these formats bus formats.
+
+Some bus formats are:
+
+Parallel
+--------
+
+rgb888
+	8 parallel lines for red, green and blue respectively. There are
+	also lines for the pixel-clock, horizontal-sync, vertical-sync
+	and data-enable.
+
+rgb666
+	Same as rgb888, but with 6 lines per color.
+
+rgb565
+	Same as rgb888, but with 6 green lines and 5 red and blue lines.
+
+rgb444
+	Same as rgb888, but with 4 lines per color.
+
+
+LVDS
+----
+
+jeida-18
+jeida-24
+vesa-24
+	These are LVDS bus formats, see the data-mapping property in
+	panel/panel-lvds.txt for a description of these bus formats.
diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 4c191c050e7d..5f65471225bb 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -262,3 +262,62 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);
+
+/*
+ * drm_of_bus_formats - parse list of bus format strings into drm fourcc
+ * @np: device tree node containing bus format property
+ * @propname: name of bus format property
+ * @bus_formats: array of parsed fourcc codes
+ *
+ * On success, @bus_formats points to a location where the actual drm
+ * fourcc codes are.
+ * WARNING: The caller is responsible for freeing this memory with kfree.
+ *
+ * Returns the number of parsed bus format entries, or one of the standard
+ * error codes on failure.
+ */
+int drm_of_bus_formats(const struct device_node *np, const char *propname,
+		       u32 **bus_formats)
+{
+	int num_bus_formats = of_property_count_strings(np, propname);
+	const char *fmt;
+	int ret;
+	int i;
+
+	if (num_bus_formats <= 0)
+		return num_bus_formats;
+
+	*bus_formats = kmalloc(num_bus_formats * sizeof(**bus_formats),
+			       GFP_KERNEL);
+	if (!*bus_formats)
+		return -ENOMEM;
+
+	for (i = 0; i < num_bus_formats; ++i) {
+		ret = of_property_read_string_index(np, propname, i, &fmt);
+		if (ret < 0)
+			return ret;
+
+		if (!strcmp(fmt, "rgb444")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB444_1X12;
+		} else if (!strcmp(fmt, "rgb565")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB565_1X16;
+		} else if (!strcmp(fmt, "rgb666")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB666_1X18;
+		} else if (!strcmp(fmt, "rgb888")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB888_1X24;
+		} else if (!strcmp(fmt, "jeida-18")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG;
+		} else if (!strcmp(fmt, "jeida-24")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA;
+		} else if (!strcmp(fmt, "vesa-24")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
+		} else {
+			kfree(*bus_formats);
+			*bus_formats = NULL;
+			return -EINVAL;
+		}
+	}
+
+	return num_bus_formats;
+}
+EXPORT_SYMBOL_GPL(drm_of_bus_formats);
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index b93c239afb60..ccacddc03a2e 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -33,6 +33,8 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 				int port, int endpoint,
 				struct drm_panel **panel,
 				struct drm_bridge **bridge);
+int drm_of_bus_formats(const struct device_node *np, const char *propname,
+		       u32 **bus_formats);
 #else
 static inline uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 						  struct device_node *port)
@@ -69,6 +71,13 @@ static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
 {
 	return -EINVAL;
 }
+
+static inline int drm_of_bus_formats(const struct device_node *np,
+				     const char *propname,
+				     u32 **bus_formats)
+{
+	return -EINVAL;
+}
 #endif
 
 /*
-- 
2.11.0
