Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757275AbeDZWdl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:33:41 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:61408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754611AbeDZWdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:33:17 -0400
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
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 24/24] drm/bridge: establish a link between the bridge supplier and consumer
Date: Fri, 27 Apr 2018 00:31:39 +0200
Message-Id: <20180426223139.16740-25-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0366.eurprd05.prod.outlook.com
 (2603:10a6:7:94::25) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:PM5WwE5TFPqmAMNN+66YTOmdMUtUMylnfROHlkDWk62Gr1a6fO4j1PCtHMxfMW3NVBAMSilRN6TewB0EV7R/Zo+Z4wUIKDlB2dT6yhKmGjUvBoksy9Fvmc0XN+Y77D+eWuh3bEMtUGnXKU1yZFMI/xJcCK839u5T6zCT0LKFSJJQ/r2tKrIyIti4Ex7GEx03S6sa5VnxtB/S5fCfmo1h5fv2MjNiTs6Cuz0QSFvyz+Z2LmHhDj3vP7zucJ3+xgqO;25:1FoOChwyaWMR1RbgB7g2Z8YeiZX5PCz0omwlqXB5daQPGUZtvIXql9XVf6osJN22NNQJWUdAr5faGHwAQBkg2Wv5f89TaSj4WBLFaTTL/ZurPloK7PvmVXqLQ2zmgxYhxWJ4wWFsyNkXYXyCtJsUNEGOQXd8jtT/4ZJ+VgqfEwyT7jT8g1zJmoyc3gA2WUxd+Dd9mYXvwDsG21EXuqmrdQPaq8AaM1i0VQEM0dv9mIXdBFQzuJdtn++bFjEYYOWe6xsZfNuuxKUVVwqUhr89DyxXa7Tvee1qkqzalPdKvMNb6cYptuZSIherPbEOpgdA+SCX4MPHnVKrlOfYlHqpxA==;31:5wunQuyMfEc9xkUmU+/5OzLaaDB0D/399LqVbtdtFkAEo1m8uZJCg7SWqRz/sPyFRzt9O5Y/qGXmvPjzcfvGHK1PYA6a1YdF618bu56RcOgLwWQ0gb3chJw2ghZTfB69t/AKrq2aRVNYywlOif5grcRpHGUm2vtvCe4JLllew3tXVhNZppK7I6Eb4Npo4EVNjB2mMmuk9azXIKAd6k6tlcas7scVo0PoqAazqLTS4/s=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27821A255C4797B1F2AB8C49BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:IfV4f6OGIM5sH7jGXbvV7Lzqy/65knQIhbBpn9p04PbRmxSv0UuLGCgzC8hFahbMfoDbifV7VtLTpXjwHoFhxkM8FRoiriA/mEAqadtcmzv7lCPaAzfq/AFQPjmI4RkkBzqVwnywS2u5VkGyrjIGF+7Re0ka/tGx3Bv5+4sotZaEU5bAKo1hzU/NrtbzvyE4D/TBAS+TBWssZdH2twoyXSJX/1HbU14Spc8WBE1vQhTAv8OMEyTiTKkP2lz15MycBiVZM8hHH6Lo2TjLHC60eQ==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(39840400004)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(2361001)(66066001)(16586007)(6666003)(105586002)(3846002)(7736002)(6916009)(6116002)(36756003)(74482002)(6486002)(48376002)(2351001)(25786009)(8936002)(50226002)(47776003)(81156014)(2906002)(16526019)(1076002)(81166006)(53936002)(11346002)(51416003)(54906003)(68736007)(97736004)(478600001)(446003)(186003)(5890100001)(50466002)(4326008)(476003)(2616005)(86362001)(39060400002)(956004)(8676002)(76176011)(26005)(7406005)(6512007)(575784001)(486006)(6506007)(7416002)(52116002)(386003)(305945005)(5660300001)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:u3xV3X4QBavGmOXMLZPM+eic0Q2T86yvUzZAJr2?=
 =?us-ascii?Q?wKe7nWnNIwUtrdI0nBTfDxbEh4S4rcW65gg55eBwikontjyXV8z7g4GFEwqE?=
 =?us-ascii?Q?4RzWixl4vwVVxMRt3R/195/a/jw7cCEjyOvzRVXckOrIcclMtthHIosydOkO?=
 =?us-ascii?Q?SO2ohrM/SFRvoOqGQbxoGBMKbv7vm74nNumpZPochKV3uzw3KB4hn4tMVdmL?=
 =?us-ascii?Q?erQajpnUnLTjOwTNLRSa+2MKoeJ9PIe6RjfffKFxVO3N0cSmf7aK24bUNSx9?=
 =?us-ascii?Q?qCSa+vG0QdXCXWGIXWWnzNpNwT1jOAEmgCZUa0afMEBYQOqRNZGRLneVaUyf?=
 =?us-ascii?Q?0Xp+NCgilnbtJb2/Rd9RGsji/9slJQBdBxY6JWDeT4WRPB+N+0y5F/EY1e4v?=
 =?us-ascii?Q?EkUIAoHw1m0KjZJxw1Rk/jql/1znJbc9L3coSwxV1jX+eDCvNBVlGGgvvbGD?=
 =?us-ascii?Q?LG7BRd7/qzjQC7AoPQVJ9qPN3aNQNmhwdi1wnQYtFdUmdqGiZZsOKUpcQ+2q?=
 =?us-ascii?Q?xAobwY8KcaK6ud5Yd16No+rz+ZetihrFSUmhqTR/uJkJ9xrz0fPqUbxXtaFO?=
 =?us-ascii?Q?X2X0kikZnSqx02AKOcZBm4rZoSXLfp9MHa/3uDxqBU/flbih3Ry6z64Prx3G?=
 =?us-ascii?Q?OQ+WGNj+dB1WmtrwXXuPiXYFhx7Ugba7rHQwgz7q8i2/PiDh1cyxGwpiRUIq?=
 =?us-ascii?Q?e+oPtbJISIEDNHE9VoAkG8PHP+1+roGUuHtZRcZ9godZ+1ItoOrSnkxE45PN?=
 =?us-ascii?Q?T+hpHtPHn5Sli/P49Rg2//0utm9uxC/y6yX2TSdtsHn5cVHf2tci4T4KL8Uf?=
 =?us-ascii?Q?eS7/989DGkmTeE0q9xd3rqEWYcJi85NeXUVmsspwg2XkkFmtmMML0//Wy0+i?=
 =?us-ascii?Q?ABGWoj3Pl6Mk6OCJVTxxvcP6ds6Xy5FzssbdGGGlE9/TgD2AorIvEuF7rypW?=
 =?us-ascii?Q?Xz80+10shV+HsFX5DEGcM95u7kriKxrHUhVhFrFlpodIr3kjn/LONBQnkiKf?=
 =?us-ascii?Q?L823qIIzC6DHtfm+FUGO9jRBFeSM3DceH/IW3K7lsoKJT+j0+eb+2nNXAoM1?=
 =?us-ascii?Q?k4MOe30VoUEMAOdoUiGsfiC3W2pXHrD3nBzJid/23dgAijL5hfdDpvkcTPDp?=
 =?us-ascii?Q?+1t5t+TjDyfXIqTBwii463/IB8XcP+kKt7wTX+xoIVLj2d80Wu4Qi1JeTUkj?=
 =?us-ascii?Q?7P+o3MkDiVWuWG+vc7OuG2xjZkSJuvaJ8EKjY+Vxgt3Q3ese1eliz2bPd7z6?=
 =?us-ascii?Q?g7OUn1Yq2+1NiQhCB39TDcl+D0v7Df7uSOBBwJI4IIiRUQsZtl8dl9sdF1Qt?=
 =?us-ascii?Q?Ld8ywHMYslrKUjn0TMqL45sAaINdD6ArZ59BUeFjm7Pg4sJuwvJ+0hCsL+XD?=
 =?us-ascii?Q?TZX+yCZZg5HzBpEbzOvWyPbUuPaI4KYsWiy0xKqT2IoTjgh9zSSt/vhlK+dN?=
 =?us-ascii?Q?rFRlrM921h3tXkQNWtzV2SQae70W+O0Q=3D?=
X-Microsoft-Antispam-Message-Info: kCf071f74gtIfVYvpn4ESn1lgmjlEn1qBaf3iPKRfbPpOQLZ0eOZhTlXM+/RXQkXAQrJ0TwMq4Tiy4pVkN/uMgQI99Mo76hYyEmibIzSiB9Ej8Ggvslax73Zt2S5zRqA/RRhhygi9uAsd3Q9fUwsRs8fXDAVPDslXMoIz9+zW9uixOI2JMemZ5XFMe8epXBL
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:Qc9We/fQXzCMThhmAzusHlcgE3EDqzg180qXcOTGH2M1zcBIOCQlG8NzdrHgn1FKFM1KJFPvEg8Ijj3aMwzNXu4iaUDWiX1UcQS1+UM0jXp9P94si2f1Myj6irhYeP+8ngQhssMAekn1e1BZAJZuPMiproUs1eb1hLp8xVggaryv/h6p9Ot67h90uTfIhW5ATPLthbyKyq0qfVUUQpKARYygUhHNMMsjTMl/icSRKVcT04WZjsQfh27n0bp997N0fCzOMOvvNExcdEBcarfz9zZSUBPg4KWtJ+d5EkRDchuF9hUFPZc81rcl1YfEb+J12AQeVNSxzwsd5mU4HUeRenplJYND+dhprnMNccMs/kGRw4uZWsvOTh/WEbfFRvoyPg8ekc/kLqIG7Tm/SvmX41vlsXUWwcshLm3jaYSm3pi3W+JFxjUgTCFKsXnSHXt1VJ+pXg7bHhqeJgwsiXRIIA==;5:6JjrtTMEjKYqwWJVWy76yrxzksOE4BwwQUbwYH993rUBnVaxXsYFPYay0t1saV6msf8/npfdseiEswWDP5tgXGe9xVC5CTBvRXYZhtz/yC3k7/ciq/rWXOUVuDHxIHdpupiwCAYf7ClYjfnjW+We42US81z+MlYvKrhFSsLJqXA=;24:KEY+KzLpTLpfx9DO9vGpojpgYSeY/oajhN9RJ7J2edJ1b8Bvg2Sx5KE4HCYoqIgBa+Gipvr3OpEZ1mGCP311AHZJ4o/Sbkv7axyEW4U76u0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:bNZR9HjQw9J76eahnkx2XyCqS/5tC2SwCpXaBN53jqOQ+di4mLoenxV3JTgohXQDR/ngikwucRuA7ukytzhZSrXhmJspk5sYhmzPkTj0E5tre7aAPpZbAcsJ9yqYuMck6YHGJVql9e/pEjuWdZOn0W3n8cy9G+gq52WR49q+JLc57JdzkXXc5AOTmvjoHUAJb1Gv8j6HMK5/Wb7mv3+E/vzRsffW0JBFvzJmebNm4HWE9DipoX3oWj4vow0vNCYc
X-MS-Office365-Filtering-Correlation-Id: 6b4fe766-b2d5-4728-6825-08d5abc5b0c5
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:33:08.5270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4fe766-b2d5-4728-6825-08d5abc5b0c5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the bridge supplier is unbound, this will bring the bridge consumer
down along with the bridge. Thus, there will no longer linger any
dangling pointers from the bridge consumer (the drm_device) to some
non-existent bridge supplier.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
 include/drm/drm_bridge.h     |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index a038da696802..f0c79043ec43 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 
 #include <drm/drm_bridge.h>
+#include <drm/drm_device.h>
 #include <drm/drm_encoder.h>
 
 #include "drm_crtc_internal.h"
@@ -124,12 +125,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (bridge->dev)
 		return -EBUSY;
 
+	if (encoder->dev->dev != bridge->owner) {
+		bridge->link = device_link_add(encoder->dev->dev,
+					       bridge->owner, 0);
+		if (!bridge->link) {
+			dev_err(bridge->owner, "failed to link bridge to %s\n",
+				dev_name(encoder->dev->dev));
+			return -EINVAL;
+		}
+	}
+
 	bridge->dev = encoder->dev;
 	bridge->encoder = encoder;
 
 	if (bridge->funcs->attach) {
 		ret = bridge->funcs->attach(bridge);
 		if (ret < 0) {
+			if (bridge->link)
+				device_link_del(bridge->link);
+			bridge->link = NULL;
 			bridge->dev = NULL;
 			bridge->encoder = NULL;
 			return ret;
@@ -156,6 +170,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
 
+	if (bridge->link)
+		device_link_del(bridge->link);
+	bridge->link = NULL;
+
 	bridge->dev = NULL;
 }
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 3bc659f3e7d2..9a386559a41a 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -261,6 +261,7 @@ struct drm_bridge_timings {
  * @list: to keep track of all added bridges
  * @timings: the timing specification for the bridge, if any (may
  * be NULL)
+ * @link: drm consumer <-> bridge supplier
  * @funcs: control functions
  * @driver_private: pointer to the bridge driver's internal context
  */
@@ -271,6 +272,7 @@ struct drm_bridge {
 	struct drm_bridge *next;
 	struct list_head list;
 	const struct drm_bridge_timings *timings;
+	struct device_link *link;
 
 	const struct drm_bridge_funcs *funcs;
 	void *driver_private;
-- 
2.11.0
