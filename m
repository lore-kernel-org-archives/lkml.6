Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbeEPKRT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:17:19 -0400
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:55264
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753487AbeEPKQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
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
Subject: [PATCH v3 26/26] drm/bridge: establish a link between the bridge supplier and consumer
Date: Wed, 16 May 2018 12:15:10 +0200
Message-Id: <20180516101510.13215-27-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::26) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:B6iEsG6Ui9mwILQ+6JThpIc4voHNlUEgm36z+LObdyCAQPgAlk/X5RF2zuvTXRX0Sm8saUi7VK5e9lh1/AKvEQ6DMSFhai4iz4L7O/mm5MsoJzzVXEGQRgAnoVmwEOI8ld7ROdKks9mIMyGQjQ6+1ZDQ3AoWF6TH+6i3PQ2cAfmTFHGwuTeMBixM8dCeA/bO5WpoXh+EsvhKt4d8hrg0uUOFRZGmObsm5Pom4bo9loNxvAuqRSBbhIYfQNRIbGqC;25:SKkw9spLOmiiPOZLo4uYovrCBG0KuTcQRO8A1u6CMp2LX2FBSr+a5BIP00mU/O9z7RMzHVF/bw1t0wz1qapE0349hq2uzpPcJtd7UMyVNn5TW/LDjpPapwRlm0738expCPzHkcezDUzUMiJd+TjcTDNd/q79vVLHcLFqkYcKD3fjrfUc5w1cGfHy/ImhwD6Ftgnc6pWx0LPF2V2FV5lGNITV4mMFAhW9ysQDFvQ6Mh4FsTjodrCiUJbLUPWjZpoai+b26UuazD67FNlHIER0UsFkcGCvEEHKLaf00hzmYNmavyWMwJJVtbyI0aZFtlRDsp5vwsg7XCiUak8mQLeTZw==;31:+18sawP+B51kx9z1e1umwFymbQC/i7zIs3Y2kdb0R47T3VTXeB5RvODjdy7Xtx5f56G1g96okS1Sdca2C87hapHWgLpaE0JwTIEd6HLlKSf8yBH226kBWQiMCFeCGBAq5HtNnvCMKYdr0F8eqUdcNPkCKFMEkUqhaezkC2XSGAIjJp/jDPqYUlLE39Lk8hX74QmF/hyW7FxBP5jatQzPJGcJs3Jw7l1rYUz19U0i2co=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772CF2423B707A22F0130E9BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(7411616537696);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:2etWGnmRDOJB1xxjef7EeSP7dg/x0WyQmFX1HmMni0gXCi7tkodf+K60rgzufbxznRNLudr1P1dftqE2JPZBR5nr+Fsm+X6lG8XgCPFLq4Y/VIqULGU/j56u1tAlvi+wmC+CoH8Q+lLmHhY+y0WkSzVVskWy4C9dUA9CtUOuRCyvZmXF3R6s/vnn9K9EQjY96iQRN6jXmKQpcvJ7CcWExWOdWXQx0fOHj93lt1MvEi4YBwf5N5efrIEx0mjFxLfrlXPknh38N6rRkGu1pJrQ30Uaf0lNY8tuFhGw0MszW9P7xOOcsna6sESavcB3whI2
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(7416002)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(7406005)(2351001)(3846002)(6116002)(575784001)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(39060400002)(5890100001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(4326008)(11346002)(486006)(6486002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:a5S923tRNY39QVWSBKs/1063nOeG7NuI0q2c0Yp?=
 =?us-ascii?Q?Cdf/trtVPiqeUmIdc50pyX9E2HCK6vhmSZ0AkaNPp0D2J7bE6pDLp/4xECng?=
 =?us-ascii?Q?/aiZPAll+8DRMo4IiVTDJDWXC+P0OmKb8NOlQfUgHzmY8LZhdUBmF3oCLrt4?=
 =?us-ascii?Q?xK1UACGkESl0nzo/Iia9qTtcSmcNzh1FN42Hc+65dBXKtJj78mQFcT1i4qVe?=
 =?us-ascii?Q?VnAYyNqscQa/qLdsBDuSqTgDbYn6Wb3w7QvvA0WxsS0BHnhX68XQCIJCq/Ly?=
 =?us-ascii?Q?/nBk6XWSQgZ0KgI7xenTlpbqCyz6JuBaB660lf43GTSZFa/CrwMFK6bdVLQM?=
 =?us-ascii?Q?f2FB9+PAuPSWAVU0SlWnAEVQ71SYRoq6GGNJasM8GOpYcQ0qRZhkWchBj1tM?=
 =?us-ascii?Q?G5ZF2rv00SjJhs3v2XiF8RcFiQSmhtGozaUuwq0ftLpTNGdzjEajA29XXrp5?=
 =?us-ascii?Q?uUArYuS7KsqY+19osZ0xNSmRv7icOlLxwQLtPIf7GJ6YMPOk9aNhphfC/5a0?=
 =?us-ascii?Q?PQCzVFk0MIyIaGKOKowFGoo1960FMT6J8z025eNvqw5RC8HOyFRjjaiefV8V?=
 =?us-ascii?Q?O9gHda48ko4JKLrW9WtDZ6xEXivEh5P5tsIvA/q4Ddheri3OkxMtkyfutg+f?=
 =?us-ascii?Q?+M3hVi3xvvBPjg8/5r7hVgKs/G5aaw0We7XlX9j/73gS+wtM+HwD6PL6cRUG?=
 =?us-ascii?Q?mx5L9QbQ7LAOeSXypYjlSLBEwOH91b67VrCChNYt/v2QMZ1eNwyZx4rnG2Z+?=
 =?us-ascii?Q?KtQIkV8BotcQzEBDREEVWZIjFo1Jn4iU3d8W5S9+iu97K9wZ2THZysPapWHj?=
 =?us-ascii?Q?pIp9h8G4PybX6zWlXlWdFuG3BmG1wEkDlLysQpfYQh8BgzynbtsNVjrJdbEi?=
 =?us-ascii?Q?StAMTeZEMUd9xDZjgkg9NgTugw60X/cYYb9Uh/hS0hErWylMoUkWLIyJkNhG?=
 =?us-ascii?Q?tPnXahL/uPJSfbbl3Wa36+t6ih1eaT7JloMNASZ0ahTCmOnfE0LWXOudCgW8?=
 =?us-ascii?Q?KhtxDG3+CrUE3Kzu6WwO+46W2m2rlt4/d35iF5BTJvvCse3UyEQfHtX80L6L?=
 =?us-ascii?Q?InKqjFhk/k+rZ/zjrLDq+/3E8dqSv8/MRTY9cFWSvw3kxwe11Vj+o88WdSB0?=
 =?us-ascii?Q?OBzHPQVho1rEgSplnwti5HLRUF1W3fL5UphcipTvqzjS9oh+0bhv7N48vvxx?=
 =?us-ascii?Q?T4gNHDvcZoHOubWKtT7dB5LFicw55rsUg/6iCBUf/owPY2U6llGbXU4oBjTC?=
 =?us-ascii?Q?PCE/4bXljrHrQvrHUOZdLmD8C6qfR5YUZW3KF9Rfk+DTaJfPrXjITF0kaFWe?=
 =?us-ascii?Q?ZEzwzeipL5QvXWDEWm0ioMRVodAQ9ortMGZIWinIhsA32lYHnL0+zQVW5Nj0?=
 =?us-ascii?Q?3w6NlnqGYNDzQ9+/4w01d3YeEUbVCLFw7Q7Xe27N1ZNVoyXzKZs8uAVko+hf?=
 =?us-ascii?Q?wGdoFYcTPRg=3D=3D?=
X-Microsoft-Antispam-Message-Info: HoZEJeSvWihxEZ4VLdPSys7wJc5tCDn6lcKZRfVodsRqC7iUzFusKU1FHoMlUf6erkTOaZh3QNiMJEmTBO9Cw5bo3vycVUYJi9L9375nLH1LNk9C3Mg/U166EK05vDNt/MXswjYE8GmSPVfXT151xFILgHEMDoUBl2at+QzPDtSTW+Z1bf4NGxdMgVaWsSha
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:LlEcwoeIEWxy7ILT4Db6IxaAT/5iFswyYX4ExRCAPOi6ceIhLAgZZgr65iC8XBDY+GREJj0dqifAXtF6KDUGcUueSv+9FVkPoSYGMKojUg0SM7y+Fn6wNgBzUvSlI3PlAWYNoJpO5MPpISv/b8HlN09DTzFZBh7YM/b5oNHRYCHIkElP1R0uhXaKHnkES11itfujPq59mxqsuRZbE6RhR3NNBs7U7ndbfgmU3MY49GRSWIc3WeT9k/84T4NviETuOtmXweazanoJ7Bao4op2GrM8DAfynde1whJoOnpszvnmwnyG5fkgM1AeVK8XUrhn6oE304QtcB1AeDfRmpQuSo/L2JqQIV2q4DY5mmiwSPCKnczhUeH87QuxYALUbCagQkD7CKKJuWhB3V2ptLqtmC9TKjvUgoq7defy5nBP+vcKZUgfLurScfhVgkhpTo6M/dQE0ngAEn3ohjW446UnfA==;5:+0TZTNXmL0TDOIa9jNHmykp1exRqlhdOMfFUyCCI95yI5Ybe0MoN0Y2TdwCirny3jINCxQDQSFw5FYUbWMk3Hl1R/E8fTrDDvr9nsOD8GACe5/cKqETA6SgQ3J9FP83nALcgAKTyScWuVHecAo0GCm299k/iHFsvWb8t7hLixCA=;24:+CU5X3Y3IfBFpYWuf+XcQVmm1pdhN/Icphb9mDTu4Er4XCTcO5ZqFhhtQCJ3afiYssbih07DvwURjzVSKrhpqthR2/j+BqZqSOqO5xCi+cU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:A+oSDJdwjfreFJyWDvlW7qpqa3ozG6Jgx2DMTsfqv0Ix51NXGLaVvr8MrIOCZ/FQTmx1lkSLsZeVbPP7yjxOJdIG3jAX2wpRieJ2gMCj65Kw/RPaDFWW3etpo2bgmHNiaSAMGKw47bPbt59udGc6iUW1ckrsfQJxQPuz0+5GfX/QghuzyCA4cJCPkQzc0f5C378Qs58VK8XOfmhlRcpYzch2o+AqbfL+Qm+hzkFYmUkA1ImVDyUyr3tfLv9gyegk
X-MS-Office365-Filtering-Correlation-Id: 2cf72349-95c1-428f-6834-08d5bb1625c8
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:51.9661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf72349-95c1-428f-6834-08d5bb1625c8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the bridge supplier is unbound, this will bring the bridge consumer
down along with the bridge. Thus, there will no longer linger any
dangling pointers from the bridge consumer (the drm_device) to some
non-existent bridge supplier.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
 include/drm/drm_bridge.h     |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 78d186b6831b..0259f0a3ff27 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 
 #include <drm/drm_bridge.h>
+#include <drm/drm_device.h>
 #include <drm/drm_encoder.h>
 
 #include "drm_crtc_internal.h"
@@ -127,12 +128,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (bridge->dev)
 		return -EBUSY;
 
+	if (encoder->dev->dev != bridge->odev) {
+		bridge->link = device_link_add(encoder->dev->dev,
+					       bridge->odev, 0);
+		if (!bridge->link) {
+			dev_err(bridge->odev, "failed to link bridge to %s\n",
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
@@ -159,6 +173,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
 
+	if (bridge->link)
+		device_link_del(bridge->link);
+	bridge->link = NULL;
+
 	bridge->dev = NULL;
 }
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index b656e505d11e..bd1265c5a0bc 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -261,6 +261,7 @@ struct drm_bridge_timings {
  * @list: to keep track of all added bridges
  * @timings: the timing specification for the bridge, if any (may
  * be NULL)
+ * @link: device link between the drm consumer and the bridge supplier
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
