Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeEDNxx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:53:53 -0400
Received: from mail-eopbgr20121.outbound.protection.outlook.com ([40.107.2.121]:23401
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751756AbeEDNxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 24/26] drm/bridge: remove the .of_node member
Date: Fri,  4 May 2018 15:52:10 +0200
Message-Id: <20180504135212.26977-25-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504135212.26977-1-peda@axentia.se>
References: <20180504135212.26977-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::25) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:Z+RxfDpnxvYKimkLI6YzNRvisjjGLUcqMUOW0bbMJ5Nh+Ua2BSHO7rgh/tX2HXcLAnMCDBKFjthdxiZvo20e26oIqPt51ZTW6Dgbm+EfgtLeAQ8kqXPyOOOECnjwIAAPgmFIyNWBjGxMoSvxB+T23VQMjpkQE3XkUNw+Sa794/G6h4k4bZhQJOcUiKgU+p6yP9+sCc8cDBnzcqUQF+AQti8dDInR4EdxhYHXL2NrPXGA91LBKby4U0AKlXxEaqqt;25:o4uUwdI8k5pKdTb3LR0+X6J0KkVx2WI2N4Yr/HqGxre+d2ClKKbJ5QB3I0bbduE4Nq49JujjT4TJnB7m477Ni0yhx07s/L7IVfFVf6sEIYsbfsRJaEM30hmCcKVtgMj4B/dKqtUOZOiXBm8MNYUopjyHKuqAYqIEUqN6CbnlT3JP3X4RwGN8aEoDx3jE6j6hJLbasDpmZlD0+uMMMVtZ6NJvrdwM0CfNOKA6lP/0GQGRUNcWhKVEqgAwI0XubjcJmLZKoD8tpe1OlSloJu8PE2ji49TzB9RPtfRYImSd9tjWY9vptagdYbnfKlqZa/a1fKMhYyv/T9eVLIb2mBK/HA==;31:JGhab47+RCn6FvExXxsKIGNsbXLAtf62GYIugmVRYdCcl7dQmda9lVfQK7207aOcwU+NHuejHdB6aCuBg1fRMopFkIEBZo1EIxgpQsGB1AuegIY60pD1ARik+QQ6wycM2duO5XmClF+JXRadwSLxrqnvAaIzRfRAKCa5n4ckGkUARVTEu6WtHyhRXOPqnboqN6WtZ1Wm8/O+pWE/ZDhPdifPE3Y3hOgPdTtLhpUq+p8=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27692D984E78831F08611B75BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:nuYA82ClZDVURvd+GdYOIRjqvkmJQP6Z10xkzCNbcvxVVQTLH6C7frdfgjIuW5T3RuC7paWJh5OmPQMV5yfXQDqVjkNavxAbLy3TuWZXnYEzQpyfqxAGjUvbaUID65UpjFL7jxo3/clgAv3MmZYTKOTWcgbUmAW0tYChTRGsW65zYe290iZXyzVj7SjIkiAxZMIwECx4RZIF3YZKxjxl/xcC6dOAFGXvbYN1VYMMxIGJeKRKdreo65iM1mIubH6Sk+lyZPyUgOIwZl7wtZu5fg==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(39060400002)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(7406005)(956004)(105586002)(2616005)(7416002)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:VxUhQO64A40l3X/9a1mkLbEDNW2JusOgdVxEkug?=
 =?us-ascii?Q?6nT8ZNAtz7cxaTQrEsfHfE7T2AbjQ8h4PuEVp3nwSN1uor+SmyWza4VqdzRw?=
 =?us-ascii?Q?x65CoD+5v6MBNTdfz4QET3IJiGA4pLTzybYSnJb+lxtQl7znRp2tVgg1gJxT?=
 =?us-ascii?Q?rn7UT0M2vIy7dD/JlQFLVkvzn6xP7rk9uaLZ5jKIDrcfY4qx/NdBNW9ZC8op?=
 =?us-ascii?Q?Ic7q4WaRd/w5IRuupxnxASLzrLPGmbh0BydsZDvWrklVqhwAYSLp0FI9u1gE?=
 =?us-ascii?Q?zWh5ZvGfSnVABjkIwwNkrSv5TIEHKOM/hRQlgPb4MX3YbxG87OxfcBJtYh8w?=
 =?us-ascii?Q?Macwyhim3AdLOrjbY9nCXcjIIZMXTHuScYwscUyCDdli8t2EMYmQZ3y6URyp?=
 =?us-ascii?Q?Z5R/mNYYHtJUuAwUGO76Pi2tQnnOyws0FQySFqs4hAy93fNW5k3gPKcMkrjd?=
 =?us-ascii?Q?17XVfRspcoJlqa6+w20M3lAk1VMgAbXs9KLwWMpay7Pkkk/I3SjT2w8SxRNR?=
 =?us-ascii?Q?cu+/51GBYU9OXgQgVMuYaJp6QHCnefXBfnQQwYnHttr0Fp/0zkKnowH76F36?=
 =?us-ascii?Q?YLE86Gn00s8KDQeKOt3Qz8yttQNpWvDrmXXjaVGxJzkq/shKcP+1XvKzEjfd?=
 =?us-ascii?Q?0Bsl/C5Oc0ShxNcR30P4nMadOV3u5PoSHOlHFaA8ZoeygYS47twpw/C02Tpt?=
 =?us-ascii?Q?6jhn/14coFQ3lwk9RRv3fyzhWDvLOauP/eqXYHsBriIRd+CWMMKLXtYz87h8?=
 =?us-ascii?Q?sY3rcB8a+W+RsDRVpQIORYwKCQPOW5IiXfETrP4BzD0K9zscLmDehnmD57Hf?=
 =?us-ascii?Q?4Is+mX0vyPNDAFONRiDTbZrNcngL+EB/eKfHxMQcqOPtnlOmjNAdlxylexsl?=
 =?us-ascii?Q?jhldCgpzzf7idk+wGAXkqM3RSb5zT1Hk3o20YfDqb2BNCm6Q7xbwnTq6npoq?=
 =?us-ascii?Q?wXRG96eLdu6b6N+wyJ9OszZsC/bi09hjXwKzpc/d3xJtUOzlAKNYSD37pjSf?=
 =?us-ascii?Q?9q+4z04XraZDabGZgf09Kzs3lBIELk41xGhRmQ1VgYutD0in2GHFxLu+VidD?=
 =?us-ascii?Q?/Jl9nTS+Q9YhuVHcXVlzJozaurba+DCpr6hHnYgPBQbxIk+/0XZo1etLCHYw?=
 =?us-ascii?Q?gHkwo1L0VSpJPre8guyQ+Rxv1OxvdYCZFYcqkaoPdyuZm0s7OPGABz1s33hb?=
 =?us-ascii?Q?yPKv/bElVeCz/AGrkvgtOdiLN79Agkikq0WrHC417hPbjVBGSl5rajTItV95?=
 =?us-ascii?Q?ymRDmRMU7DfkexQ62Ko39LyhpXktqZb5uGi5qhaXLu99xxu1nPeRiiTrNsnh?=
 =?us-ascii?Q?X/WuUqo/P3SRL8j3i6cD58HfTMiUYTC/VCF9B/0/undvAdvG4lR0DtTMRTG0?=
 =?us-ascii?Q?q1fj8M1BQ8S04lqCKtDe0fP6MhuaCIyGaz6HcUmF2Rs2aeRJ3asqctShCxlr?=
 =?us-ascii?Q?fMaMbqo1kIQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: jwpROSuVEidASsXcTXkPJxx9wVGP7CKN8xn0be2H+IfXhc+6OYDfOzoxqk01095j+AKF/0Hj4D4DS8q8HCVFMXathdMSQ3VwnIPqD6GcoKplMhwv6ix5iJO5jHe8sKhq3YAisYjqBmtCloOlgwpHhEVoI4w+GjPur+lMK6zPTe1Zad7kHI4+yfs9YF9NRIP+
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:T3ePstjOKxXsIRixmhgP+hnMU77TrukeglZxEnvELBi68LSja/UP+eT7Wc4fcW0Wc4lvqjevnywZj5dbczfpCdEMSAJISSGKn22tD6/YFElKuRWvTrerc0GPS8Ty4Qzfy+i7Xu2uYsmFulMxydMYJyQStV8gxfhUh9GBLuDo3CdN3kGyqQ/kXIlR8j3fKD6nyJmE46rItfFJR74Ds665XqfyaFUw07YpJHVGBIypD4fXJFa6SZoLh2/it/s3z73QOfXcMzpevJfL3RSO8pdxLqhahEA/xnAf1+uoSJmAosfsfb43drI8eZHEVtAfI85l8DJGhzZ+KHddK71zNKZmyWp0tf4tgc96fys/agVH8uAfth+tHGz+Lkpfz4t5ZwSON6MUhD9G8RVA/ePjWh+oN7SYoO+2fITHBm/IQirY3HEx/4RYM4yWkCNTQawiIzyScxrOhdMY5+Jwf0GfbtaeIQ==;5:Fz1aUKf2vWxB3LJddLJEoogUXNo6EwqFWtTEUzdfRdUmnHs2hPTYCkKXQqapj6zx3lLuNOQm+Tdxi2fe8wQGThef6TmgrIS56B1XGDgugVT5XLb1y4+MKqL0DCPuPbrxiTQhcew26r4Ubf0MnC7AcXlNp2s3xDevmmJr6vDqipQ=;24:zd5LAfRtwXIbrbCksij/m0LPZLPBKTr3BrMCNt3TusO6wgnQc1yZaK8td8YV1BJtEM4FCfMVQ+ho5fo2kkjvkGEZhYuwL8f1NP2HLZ7HZ/o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:WzbQm9PUVAdo4vqQNFT48XMQIEuTgxzck07/2XsZTm/K9xvN6zZDCq0jTxtP/Cp0g2zLzl3Neow3a71Le08CkmoAPJ7z+eAsukbv+KmCQMF0Y/5QHrM76ceHhhjQsnXsWCfsSLk2oku/PrKBdGNsgRFHmyCoznRr4z6HgAqdLHioVmx9FfAyORbLZECaMeDbwHhPFlhL5N8moSw2tyomGbPpEScNW5AG7xshQvlTGvn8nl0toRko/6aBMk9qwng2
X-MS-Office365-Filtering-Correlation-Id: 3840fc27-19ef-4636-8cd0-08d5b1c67325
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:41.2985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3840fc27-19ef-4636-8cd0-08d5b1c67325
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unused.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c             | 3 +--
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 --
 include/drm/drm_bridge.h                 | 4 ----
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 3872f5379998..df084db33494 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -365,8 +365,7 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 	mutex_lock(&bridge_lock);
 
 	list_for_each_entry(bridge, &bridge_list, list) {
-		if ((bridge->odev && bridge->odev->of_node == np) ||
-		    bridge->of_node == np) {
+		if (bridge->odev->of_node == np) {
 			mutex_unlock(&bridge_lock);
 			return bridge;
 		}
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 557e0079c98d..e77d4c909582 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -377,8 +377,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 	}
 	if (lvds->panel)
 		remote = lvds->panel->dev->of_node;
-	else if (lvds->bridge->of_node)
-		remote = lvds->bridge->of_node;
 	else
 		remote = lvds->bridge->odev->of_node;
 	if (of_property_read_string(dev->of_node, "rockchip,output", &name))
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 7c17977c3537..b656e505d11e 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -258,7 +258,6 @@ struct drm_bridge_timings {
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
  * @next: the next bridge in the encoder chain
- * @of_node: device node pointer to the bridge
  * @list: to keep track of all added bridges
  * @timings: the timing specification for the bridge, if any (may
  * be NULL)
@@ -270,9 +269,6 @@ struct drm_bridge {
 	struct drm_device *dev;
 	struct drm_encoder *encoder;
 	struct drm_bridge *next;
-#ifdef CONFIG_OF
-	struct device_node *of_node;
-#endif
 	struct list_head list;
 	const struct drm_bridge_timings *timings;
 
-- 
2.11.0
