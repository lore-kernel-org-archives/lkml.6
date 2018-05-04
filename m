Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeEDNws (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:52:48 -0400
Received: from mail-eopbgr20127.outbound.protection.outlook.com ([40.107.2.127]:53376
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750820AbeEDNwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:52:43 -0400
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
Subject: [PATCH v2 01/26] drm/bridge: allow optionally specifying an owner .odev device
Date: Fri,  4 May 2018 15:51:47 +0200
Message-Id: <20180504135212.26977-2-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:H+5QNHtChiE3Syr/VsQsJ7T+wwyuJ5QohlsXYY+QZV+xBTbFHYNRtqW7AtcXWCc4pd+UXOmBTq+DZBhWv0z7jXOG96fWerrZxuEMFL8EZi7ulu+rk59C2fJ+IsJzDYNgTTDZRhFn3CU8j3g+Ae4reFs4vv5QKtPNqPlEOt6YlPPnYF/ls2BNng2O5DdVtPiZxMH65GSwvueWlP4skr8wHrAlVkbTxhPnsXf+9E5yVOYZoao0RsyAAWC0KHGqoUIx;25:MLi72VILmD8eWm/3Qd2SiPJ+yXMzriVDRHXzvmG/DpzB+pcBHFtCFVNup7mxofyeEAifwvGwfBP4TUKZXkVMzvvaZ4DBLk+TMNuMyLZt5fUlWz7yKqRHg2X1Pv0gUYe5kKL9Lt3SJaX1dE+I5diD+Lg/XteqToO4Zc6hc3UY1NGkzPM8Dd6di39bVmHeiUBiuk92flsmk/tb5/axPTLVcSAO84+pMeX69Et8NaaaajR/Fh+JGfcKdJqaXQUIU9hr7GUbktxo8BJCFEOkaYBQw/t5RBFOh4NN7mz+ZEIKITqqRownWrFAPr9MYKHqbGhBuZiLhUTRh5m0PW6jO8g6lg==;31:25CSF8RTfp8HpeqXKsHSO0E/RSG1OZPtT8b8PPH+U3o/sORFd0iamaTb4SRkyFevlotQwSL2d4XEMT8URhkfTw1YH20ycHJVFGcKA7OCrIl2gP/dawyKWCYWDzqZksHBwkGZjsdzWj9zOq+UnHDv36Aov4DHLxmrnhIm3vXaZNBFIyWnf3vriMx47ZGW3m+pCdyjRQmUlp4jT278F30uNeDuJVguaWR1bdgqGL4qrwc=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769064B7446A7894FD8CA5FBC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:pOwN7Mb9hIXBm6q1WdzZk9Mft52nRMHHUP3Y124bZ0+psNzaT+tvA0CarP6nMkHVWVFNvJJvfXvZWIW3WoSgI6F3kQzi+Lqs4Aysyg+4FjZDjRd3Z+BHmA/XvqVLPufD3ZhcB59C7iG8Xh6yaM1VWP0PfYmgCAm1cTdzBuCJoHp1b2qeWVSqI20IcABIQoRqGEFHA/FbMB6rCCuS1RcmxkoakH1qarGQZKGwrOEWb/MvjfdALDjZyrRd9KsIZeWYfVQABVOB2BwLTMZKlyDNsQ==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(39060400002)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(7406005)(956004)(105586002)(2616005)(7416002)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:9NXL9olYUqApj+BnplsHimEpYRk4Cgs6FLkuStm?=
 =?us-ascii?Q?yjwYVE7nzLhESrHUlVWSUv/6SAm3n2g1XD+F4idWURiGI5mHxCrbPFss1oua?=
 =?us-ascii?Q?rYaBg93t/la6X9ZjGqY7k8RffapT7augRTatY1t7uS/uxaB2qxyZZwzZqZ03?=
 =?us-ascii?Q?LGXtD7zhOOKipoF6e0qzLXYAwCia0EgtS0Y9ffCYs2l1hOeJ+D9qEJ2T+8Ke?=
 =?us-ascii?Q?vGtYQP2kroQxqDba4WyHdjNEzz2n7zca+7IYr0F0YLbJr6V15VJ3ADC2OWSu?=
 =?us-ascii?Q?T6hfrO771tjemVpENZCLjvl7t+ba5Eu5rZrjK42HONUOXcze6M4ZxPTFeTrF?=
 =?us-ascii?Q?ZcA36mc/hMjzcjvbl3DZx51ARCAM173+9b8EvhJ93BN51AxqnDr4s11WMWiR?=
 =?us-ascii?Q?5PtumYgFt+EZ/YXRkfXukABy1NRvaSpG/oFJdhfwfPb5aqfOXtibx+pddQE4?=
 =?us-ascii?Q?VsvCcMs3/KNK3kld8GaEspTzrojeOlsB/c/2dKZ5dTTD/gIF5fTvpwdALqaV?=
 =?us-ascii?Q?DVJK1yfDRSd94AV7KjBiVdXn66/D5U+4FFWZx9FfEyXFNTOcYuAg3B5XeyI3?=
 =?us-ascii?Q?djpmwKUVWPo9ww6/q90XazI7EkivcwMdj3/oP5wtfTAB4u5nFaJuGwB+r5iX?=
 =?us-ascii?Q?yJBDP21pq1gWAq5c94WzCdSwBanQF7w2ue9DHLBiffV7cJ9kbKGt//crbXbh?=
 =?us-ascii?Q?5VAlvbCE7dkHB6uTHZiMirtkzp6mPX7RNBR/DUBEbTnHnEjtlRRyKOkAddqW?=
 =?us-ascii?Q?UYiYuEtP97OqadrDJklYdURIV2kU9rVicFNdXue4BBVoNNi9bR7m+GAhD639?=
 =?us-ascii?Q?Fm3jKfF9UjzhipRdFDb2cDTyoIn87DMry0txAroWsdNuUYSulUrlqGSoSOiU?=
 =?us-ascii?Q?aUcDsHr8VEAR2oK47LqoZEDG3LYb60KzUbdlXf2HMOeZ1i3ViuLCxThzESCx?=
 =?us-ascii?Q?T/hQw0GozR10XDmnxZZxO1tK5ewVNLY2MoB7yAZbXHnUFQMfIHlIYbj94Fae?=
 =?us-ascii?Q?Qk+eIMiuv72fROFM6PFnBhydEdZiiuSA3cW+hiiGaZ4vm//HjFEUfKDK7evD?=
 =?us-ascii?Q?hB6vv81lBYS8v4lnqb7s9Tj41vKwkj1XyiLevKC2uJWgZro2qlX5Ymsygppv?=
 =?us-ascii?Q?zALcJJpSkeCDWeHaowWHcz7PinGzSra7ZESqVUHqBDcHVmE+hFsqGiSQFXSS?=
 =?us-ascii?Q?j6sTxvMeeGwfTZAHerNgrY4b7WPEaPKfCTz5hbFyb+Z00NYGGRuasQWwo7+D?=
 =?us-ascii?Q?Nb4xOS+R9D+98ROZoxSrpiqOiH4A3WdihA986seaIWgxknbYNDPhh951uhRb?=
 =?us-ascii?Q?vcz6JysSLrQsDIcuU3NsWC8D7ZKCfqH2Hz4urajZ+7qTg0ghTCTNXWLqDb8+?=
 =?us-ascii?Q?l7YleTT2vsuoJHFAyNy3P/esQVIAqJiVl1qMynu/Uj6FkGk7ZC/NB6heJzbT?=
 =?us-ascii?Q?U6Z5ZS/3tFQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: o/ZhVM16oFk4RNweJCvMN2k1QkTMOcStvmyQgjOvWlld5/+b8YkINTD1/kmqgu+pyzfkXend0c+SOyAR1KTTBr7REJTiecuASa04W8Ei9nY5wdnipaED2d3oTHc16vyEcClUlXqHV2ubDo+6YH+JSWcs25xVBYiRsEmzt4jZIjJhe5HQuCBGu000sLe4yHR/
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:cvVW4v8OcALSwvEe7X6hGmep6hl3sfxm/CjeC4D2MbJ5C51IMUL3koVPVQ1cXm8PJDSiId+8jCSC5tFF4/9LBaq026FY+qKddjB0j+vS3LDIpsylEieiakGAlcSWGUIzKk3u2/EDuTEqEeZ8T20Ckt60Gv8dXmbMrvLdyov0Dau7ltPySUYbsIqQE6d96cBLIEECJfnYAJZvAwrVPwPN+PER1d+s+C+/ggq9H0qcPl536vKjsq7LWIOP2x2WwUReO5Hfy7vFx4F8tGKc0uZl90H5+DexKiSkk6nsZxgpaeAk2/Bu0ZMh8SegWBuZQXtFr4LuJFOuGVYpntbVMxm3Ip8X3/Pr9g6Ips2WD/zFAgZv6GD55UvomGy2g8wymqIabGTDOOhjOEOC/XVtvVLKTGPjmoA5w9oqcjyXf6y8EyqKgtEiyHXSyMkdUETei5zDfqxBAQIkyf3OslisH8txDA==;5:is/78EhGZkxsKmOZZ/FcleFkEXYXsD9gpHzyeZFXXOnGp5euzUGX30qH7JizDoc223718vv58FjIqFiAZ5CKp9yL8INWh8dr0zBCBh93unZrTLm/4kpXtCNeQYWn78z5NF/dMsBsX9Htg1W08Brfdc4On1/Fs//2nH5gtNrAfSc=;24:zC+kjIuWPhW7MmB6AFP+rSR36/wMP78QKTYQMp9P+1EUK+oVB7S3a6aswSYiWqgecZvKfcEzK5nMd1rZMDvwFb0L2Gl8BYJYOZVIF7ooLDE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:ENlR0cndxYH58G/K+YxSE0Z+UINtQWBo665A+1BPj7GK+rR/R/c6Y/PCbqaovxgm+ZTwiYq8RjDT5L+B3GeSAkbMJafIJr6ftfGb40V2xrtIWNnE3D7ogJoAa+38pDc+GpVtNCtobz+LlTF0bHKfdN0Trsz55KuVsXpgs977qit9hmcYgqZogrhkTYnrmnCxRYYOe4K7VYJaw30KMrjewTVLUSAPeeXgaTNJjD4Li2TrPlD3gJVKnzRA5pfxIV+A
X-MS-Office365-Filtering-Correlation-Id: 61a3c41b-8970-46e0-a392-08d5b1c64be9
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:52:35.5308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a3c41b-8970-46e0-a392-08d5b1c64be9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bridge drivers can now (temporarily, in a transition phase) select if
they want to provide a full owner device or keep just providing an
of_node.

By providing a full owner device, the bridge drivers no longer need
to provide an of_node since that node is available via the owner
device.

When all bridge drivers provide an owner device, that will become
mandatory and the .of_node member will be removed.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c             | 3 ++-
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 4 +++-
 include/drm/drm_bridge.h                 | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1638bfe9627c..3872f5379998 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -365,7 +365,8 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 	mutex_lock(&bridge_lock);
 
 	list_for_each_entry(bridge, &bridge_list, list) {
-		if (bridge->of_node == np) {
+		if ((bridge->odev && bridge->odev->of_node == np) ||
+		    bridge->of_node == np) {
 			mutex_unlock(&bridge_lock);
 			return bridge;
 		}
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 4bd94b167d2c..557e0079c98d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -377,8 +377,10 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 	}
 	if (lvds->panel)
 		remote = lvds->panel->dev->of_node;
-	else
+	else if (lvds->bridge->of_node)
 		remote = lvds->bridge->of_node;
+	else
+		remote = lvds->bridge->odev->of_node;
 	if (of_property_read_string(dev->of_node, "rockchip,output", &name))
 		/* default set it as output rgb */
 		lvds->output = DISPLAY_OUTPUT_RGB;
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 3270fec46979..7c17977c3537 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -254,6 +254,7 @@ struct drm_bridge_timings {
 
 /**
  * struct drm_bridge - central DRM bridge control structure
+ * @odev: device that owns the bridge
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
  * @next: the next bridge in the encoder chain
@@ -265,6 +266,7 @@ struct drm_bridge_timings {
  * @driver_private: pointer to the bridge driver's internal context
  */
 struct drm_bridge {
+	struct device *odev;
 	struct drm_device *dev;
 	struct drm_encoder *encoder;
 	struct drm_bridge *next;
-- 
2.11.0
