Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeCQWQH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 18:16:07 -0400
Received: from mail-he1eur01on0097.outbound.protection.outlook.com ([104.47.0.97]:45132
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752649AbeCQWQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 18:16:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH 2/3] drm: bridge: panel: allow override of the bus format
Date: Sat, 17 Mar 2018 23:15:24 +0100
Message-Id: <20180317221525.18534-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180317221525.18534-1-peda@axentia.se>
References: <20180317221525.18534-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6P189CA0021.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:2e::34)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ed4695d-1080-442e-31da-08d58c54a957
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:Y1Aj5q9Gw8BR0OSm2GXQPgazW2AhRb/tknmazA790ChC3gdX9dVoSfP4OSFlxCDXEg65KUCBLsN5Ww92d2LBHpQjw8h1fvntGwK5Jen53YSEBXi43rBrgj0d3FPCzSmJF9lTRT6EwWINJKiLcIT3h7HauwFXNMNK64+nDBYaHG+ZO8bxUxQDNt3ZUOfEnA1l34JHJG0WIV4UVT77H+hJ54o/PIDSlUhy3txPglMyLs+b+4wXanIkMpEU0g3HHApy;25:AgXoy1C15tqCmgET3tHaWEY2rSedFr4TFNpleoolB0wxu0ye4NAAzPmmYgk8x6is+efn2Ie7wFYTlv3n37PXJYTr/d0RCyKHtp1Q25TX87qB2btcy4knGssShooYSWpXGXIGtH5UAFd7Af09gV8Q1fM9m/Zvax5L22bqQbDc5066xC4H1pwmYKPjCc+n6flJdJkQ00Vfrl5ScftVsTmNZ+RHElHaadLaHWfZjPElrx1zyjIyiZOB6MIzbYRpt7eZPPlyToch39kytJd2JDbBnCC8cEDn8GsukCU5uWxH/EKKAzrZ2Vxpib5ZVojfD9gDBc4Yq9yP6q9funsGmmeOFQ==;31:UQ5w9PD8nTYpcNRqXHBGrGG6l2cfvpIhuBTL2y9TMRZMs9BZC2uyK4S2pYk/iMwSBIEMx4H1l2bNLK0EJ2GNvQGdqxUuxDmNS7lJvFwMtjjxtJdpS0DkSXuGMfnjK8pYq1Xb51uiO+Go5XHqpVB7oGA7vp7AIXt7hC92XwsifLJljA3P5OaOu2iV5lZYHfP5mL/JN2Eczl029PYd2bqpgdkb2JLVER/ycOBgE3tr1EU=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769706BC3BA792E18D375DBBCD60@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501300)(52105095)(93006095)(93001095)(3002001)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:Rx4ChWB/QoIBcaTezbKKycEeWuojS+kjJvMMGTomYAVCDVU7UivHOUwHWLp7SXeIzTSI6rMCA/9Ci57eng8CVhv9dePy1JsyRugIfiyNaBkcvG7RuTS0cEfqGfcHTduepwfIpkfsY/t6on3KLNfMclrxZDPxl+7YEftiuQKW/U1Rh3TKbqK9nNu8e93zccsJOzpR9UYy4i4EIMfIiU6YmRTIRP6q9q5e6bq9JGOPe7VMJF+BYMkG/rY0CMiNtX5fMiSpxbhL/r9wNOzCrnoY5w==
X-Forefront-PRVS: 06141B80DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(376002)(39380400002)(346002)(396003)(189003)(199004)(26005)(25786009)(4326008)(86362001)(50466002)(59450400001)(316002)(52116002)(51416003)(76176011)(5660300001)(186003)(66066001)(68736007)(105586002)(97736004)(16526019)(7416002)(48376002)(386003)(6506007)(47776003)(81156014)(81166006)(2351001)(16586007)(6486002)(478600001)(2361001)(8676002)(6916009)(53936002)(50226002)(8936002)(6666003)(2950100002)(6512007)(74482002)(106356001)(36756003)(1076002)(3846002)(6116002)(305945005)(2906002)(7736002)(54906003)(42262002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:0MbFrwFo+iXepdifBbWTUV4dhC7D68Z90VKidFo?=
 =?us-ascii?Q?uqejp+tuM3OOwW9a/OOakJshQvozEdcJCWI+LoEqq8TP9gIMqJ3P/QxU6kJ3?=
 =?us-ascii?Q?iWIzjliYmsTjDvTHJhbXwtYb1Uc9MJAGL44VBtxttgGFdGI2b8Pzk2vBc/Av?=
 =?us-ascii?Q?12FFbu6N4dbYm1/aatqOBuOATG08Mm4yEHaH1aCaIB3tLfB3/4IAxwetfcjN?=
 =?us-ascii?Q?zKoX3QAgaxLsdzMxqmYVu1ERydBESZeGwR7I/siTtrmz3PYvDjUOVzbGy2ZN?=
 =?us-ascii?Q?jrVZ6O0xo/RfubcHmGqQJnV82ikI3tgpElEE7KvZgIfSG0hI2irLtiFWgLK+?=
 =?us-ascii?Q?FB5TZAqo5dqn9515JFSvckMOZ15XkV2mM5QaP1SNCPzylrIShvYqYraDltVF?=
 =?us-ascii?Q?TpAdFlaL5yCCELpBoRqu0Bq+1eM260V0yo7sBgNrlndzYP/GsRDFnGVzEpm3?=
 =?us-ascii?Q?Sq7+6qEwVb6E6Wp4ou2WkHNsjgPch66x1b7saUQQvswBI4GBtnOpGyQU88+o?=
 =?us-ascii?Q?4SDAYz0ppEn1sx77Qt82My9OxQDDS03zZssgea7tmVLa/EQFjdjdOUEtVbhG?=
 =?us-ascii?Q?tvf/HLTF4e2kbRJhS1Zzh/FE+wlUVJj0hN0rKHBCmoGrXeO4U8vbMWk6oR5E?=
 =?us-ascii?Q?xlcPuj1ChzuJqG3LVwjHORAU4koWrzUDRbRzGcH0Th4b/LQ5BXWzDcm5O2Jb?=
 =?us-ascii?Q?mHmCaki1v0RCsVk+qUQMf88VQyRsBcGMNSntDrcTpubf+/agbU4wXQQ0qrTy?=
 =?us-ascii?Q?8wlF2uW9oI0MM5Nk3GtmzWxuXqCY5OPs4MXt6qdoYKeHCcYf1b+mIxJhNmFv?=
 =?us-ascii?Q?TGrgU5AB8pM/gMzy9J3zz7jLskYSeSDm9HJ+RTEi35YrCVrPbr2DoknptwXB?=
 =?us-ascii?Q?tCZFm0s+c8+U8TJxjm8zfzSSkmViJv6cWCKTnVUzFt3gz8veyqYZZ7kgVyQg?=
 =?us-ascii?Q?smcIiv50qYwZtvnjyxap8U/NCEcJCDnHnLJh2yKBaxyRvUrjDPPLFjC0z6LA?=
 =?us-ascii?Q?pjs5QyIMRilJ9MSbqyOvtIpq5HTUu0acrh1oLY3VrkwS9FRhQXx6agcBzeuD?=
 =?us-ascii?Q?1kGU1M74lkadt3wEME+z3GgMdM6tMDsKcrEufaOBR7SHqcQsEHH8S3EoSF+I?=
 =?us-ascii?Q?zaX8uW1IoPFfkF15oy5MJWYma9zaLlAIqPVX1r1x1V5xKGZDeVk/Q/2At56w?=
 =?us-ascii?Q?w2IWIC8aYLC0Gz2qb2Cem3B6egtwPHKXKv1gFGraVxpTCA25WADorBDxvjYO?=
 =?us-ascii?Q?0BUl0lfS0l9Gdu65EyAHz4utskVJ7auYI02jdIj+VZraViWMRd/uNkKe2u7l?=
 =?us-ascii?Q?q1w=3D=3D?=
X-Microsoft-Antispam-Message-Info: eSPG7TcnlY/rRg3/ytdBZB8PALarG20yutNnaVrAch8iYotIMJT+Nf3FwwVHGJ971lmGBrZTwlg/t2GJXLJaL/oJ0iYv94rqQHZC0kn/vybY1/gzkps1uGTEI8K9Uv0/jmqe/98tB1+LOCHMTg4KuKfhMjGe2mIYs8iljpYFpXAzYTy3qUkNnvAho6WhW/U9
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:SuO00vdUKhGivsy9BgEq/YII6Z/Utyopdr9CE2U5OnttUGUVvnclVkJOvE7QRGwhlZPjJ/EVbbRbzyfzjwXkUsvUaW271DZUmXM9WvjulonrOh7W5EAspLSBMQ7osMxO9lVREHNj37qTz62HVGVXBLxIc5dKEU8svZeu2cEUTsc+ZOwaRXfrfQ0ee4KBbt6bfSTUYLKTuGQeJM6CbJdwMIKeWhlDDdYGB+J+RAE0PXhVadNtP49ls3Ct8pL+EYrKrxiz4IC8s3C221s0OuyI0s39I/du3t+m50K6eSiLD6Xvn2j32sQl/8UzbvpwCDzOup1Fo0SD8YelGiZ3mpL+sw==;5:olveHXZ7a8Fv+FZI4ralhsmHiDip0piFIC1P7Goxj8s5yryY6midEk7bEL5r+IXsIRhZhBKHA3Z6cmsTCZslFGSgElwBPmQeHJQVXsqACOSxSM21kV5u3u28HzxWs952JRXy9veiF6Qanfarm2eVvy4FP1rvdri0+XTSV4TO0NI=;24:fliSZqOM2jK+YrllblkrnbSl6XD/ZRE5L1m5BMBtP7ifW/W4c6MKzsCOzEIiJ9Aps409EQvstiFc1vPgBt9Yb47eyeB0xeIujQ4lbHJjdNQ=;7:mMuHPrlXaBFU8JpIUT7Y7AgNvMihcLy/+PL6HrjQnNRWtfBM12MWzj/M5DxpjSfKCVU7FIY088dtQIxZI0fh8O0bWNYZkXoxlhHZKMLcoqhaHO1PeJU0yIoLxQVKRV3nR0dyuAgl9i8IJueh9O8WoEW73a06aL83priTeS8KtJR3uIrKKFbypKABBQPoIlPygGKGgI1QH4K57dK6ta3X5eePARyNU9GPLxz07nz5snrff7gFN7upedt+2S0t3nq5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2018 22:15:57.9300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed4695d-1080-442e-31da-08d58c54a957
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful if the bridge does some kind of conversion of the bus format.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/panel.c | 22 +++++++++++++++++++++-
 include/drm/drm_bridge.h       |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 6d99d4a3beb3..ccef0283ff41 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -22,6 +22,7 @@ struct panel_bridge {
 	struct drm_connector connector;
 	struct drm_panel *panel;
 	u32 connector_type;
+	u32 bus_format;
 };
 
 static inline struct panel_bridge *
@@ -40,8 +41,15 @@ static int panel_bridge_connector_get_modes(struct drm_connector *connector)
 {
 	struct panel_bridge *panel_bridge =
 		drm_connector_to_panel_bridge(connector);
+	int ret;
+
+	ret = drm_panel_get_modes(panel_bridge->panel);
+
+	if (panel_bridge->bus_format)
+		drm_display_info_set_bus_formats(&connector->display_info,
+						 &panel_bridge->bus_format, 1);
 
-	return drm_panel_get_modes(panel_bridge->panel);
+	return ret;
 }
 
 static const struct drm_connector_helper_funcs
@@ -203,6 +211,18 @@ void drm_panel_bridge_remove(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_panel_bridge_remove);
 
+void drm_panel_bridge_set_bus_format(struct drm_bridge *bridge, u32 bus_format)
+{
+	struct panel_bridge *panel_bridge;
+
+	if (!bridge)
+		return;
+
+	panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	panel_bridge->bus_format = bus_format;
+}
+EXPORT_SYMBOL(drm_panel_bridge_set_bus_format);
+
 static void devm_drm_panel_bridge_release(struct device *dev, void *res)
 {
 	struct drm_bridge **bridge = res;
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 682d01ba920c..81903b92f187 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -268,6 +268,7 @@ void drm_bridge_enable(struct drm_bridge *bridge);
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
 					u32 connector_type);
 void drm_panel_bridge_remove(struct drm_bridge *bridge);
+void drm_panel_bridge_set_bus_format(struct drm_bridge *bridge, u32 bus_format);
 struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
 					     struct drm_panel *panel,
 					     u32 connector_type);
-- 
2.11.0
