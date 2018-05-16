Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeEPKXh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:23:37 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:21089
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752338AbeEPKPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:15:35 -0400
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
Subject: [PATCH v3 01/26] drm/bridge: allow optionally specifying an owner .odev device
Date: Wed, 16 May 2018 12:14:45 +0200
Message-Id: <20180516101510.13215-2-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:qJ8FhsPms+1FAxGebO8XyOXot2PhCD8g8jFL88JnPH2X26qg94S4gVhZY0Q1ehx7qmJl81u8LXkrEaTrTMRElhCF0Y3tXLl7R6zpRVgk18ZcSynp7VxJSMmLCjhh7GdrUevXvpFgxRnHMDOb9ln6K6GCbG+WgEIuWZPGuAnTNPYa5bC6xDOTzpHiglFlf1ppbpyfeljQL9J1uuFR6bKfF/2uqJ6fg/MLU5KX6fbSOHSA4fdUgwEObKyCjHRndLzu;25:GbhjQX4cXpF8+RvjSOmtoquc9CDOiQZMcAwLX02UHhBldARq2eRwo8Dwc2JnSeAPfzI7KzNzlSe6RaasRw18ZteN2HzUbYUQU19CawTdqcQeL+XrLQSmA+vLflRhmFMNGPRQjtcrT6Qg/Nxs88ktFTy05nH13nDHoj92uuuZ3OBQYs+40K+kGv9orO9GLPNhw7bdjPngMEZc2YxxH4p3gPM95E2U5xXppRqqkyNb840fm7dTXeo2JlblvJcxN3HSi0ZDd9dpnM+9IOZndEFBjp9xXHb3iPhtvSho+nPUkKjuenomP/H+GXsXHo+PN9G9cPmofV7cgOhLR6xVEh00hA==;31:fUUCCUMnJ7OevgBsKzIHsSySbwyyFRpuc3J0vNDdJWdLpmDYl44UuEKSYFqdL+bXT4BkgFp9hgMvLrH8Kp7pvFwe2fZGqyg9BmAW8Fqc/uRs1jONeRQ+IJmmciHN4TpwXtQ1pm/zyQ3wmEjRA3iISYEmk2izzNGkJLQG+CsAlJbdPmr6w+uy9JjNRYWVDASE0V4+gFkAgm0s/v2EwX1MM63YTdDe8QK+Yy7A8kIWDnM=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB277295C8D9A32A29D0D34876BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(7411616537696);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:bscQNTTaRZeYmn7gIR0bJik3H+jmcVanXB19IpZXWyqrwUe4rwFwLvdyyjzHFS3EZ/KUoU+MUYxXLZLH3rV3BYEotuoAguAZfRpR1Nl0K1Y4XzTunI5YsroFSTNU5n1Ov/VxbzzdjAmr5QJI3O4cVzfQESstpTY6Gj4mFsPzpszTDpcYBtZC/TPs3ezEl/ohaAboRSLq8FKnmSMUkjeeJXmWJ6cbCbekwTh4tdUjvlSkhbToEjNm64C880xPEysuj8rK6YS2ZjwgSlZ40It930LHOABao7bTuwrSuL+ruMN9XKGMBMTWoUQCZJV799XW
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(39830400003)(396003)(346002)(376002)(366004)(189003)(199004)(86362001)(7416002)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(7406005)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(39060400002)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:M9oExva3nM9RGpXAEuEpnV2cvnw0M4vTfDK99LU?=
 =?us-ascii?Q?R0CnFjEniuN7iyO5hsV8ZBon4pO+1ROkLV8KM+Prb+eKn927ZpwB4qhfZUoq?=
 =?us-ascii?Q?wJ8kz5nV0MlSS20qIkpGodZN65umMcD0mQwsuCD1l3qHIlkfvXsFs6zpiYmD?=
 =?us-ascii?Q?Fe9N573oiXp+Vg2CsIBunlbn+kjv9JVkfO8rhzFnXzMlW18rFIs39BlKVThx?=
 =?us-ascii?Q?jRDce2W3e7raeeNJsGsKmqnGaHwnSiecLj1fh/wcLiHoD2k6Ya0auBXCBZYM?=
 =?us-ascii?Q?FSdfHH5Nqb8JvvrtHRrwBr+Tsk/mtetC8VMMOLJF33FOlumV4Fw7fZ+g3Zte?=
 =?us-ascii?Q?Yi9VbO3AELg0EnlS35WSlw5QGWZWUkKB2EDqdtAfrkckxb5ox8Fvwe/9vd2E?=
 =?us-ascii?Q?mSfwsvcOu7E8gKMWQv9whIfUIUJvS6Hyqebs6OlO+zcmQ41CwOftyMslGCOy?=
 =?us-ascii?Q?duC9z83EVUu73sfmjuPYqEm7+hwdy9f0eBF+4EhcHgup8hnpz1o8cKFzybBY?=
 =?us-ascii?Q?2475Xq+rRge9XBwUunfrHSqMfhx6F1cVzU7J/cYstQWZ3bC7dPc24p/HDiP7?=
 =?us-ascii?Q?TNw9bIFlASS2LobtV/1CUGiFgDWXmgTin7skXDMfMGnnnhgmKDFPEg6gSytj?=
 =?us-ascii?Q?S9M84Y+rkAqWMhpIL8TugWZG8alW5XR/33LmWwuOEBW6BHV6VUp0DDcKoE7e?=
 =?us-ascii?Q?/liz8adcFWeuDT2jZlqv473w3rCaadMFGw9eNylL7Wb9zn2UzIJlXlveGY/z?=
 =?us-ascii?Q?7liZhTeIZAbaeWoofDGhy/hyWY1drLYa539mFUSzSsFPDAkp74giWbj98w/H?=
 =?us-ascii?Q?q5/4pHa26nbG+ZFGKC0ixY3t3YNMAX6/siDNHb4PPKr1ijWu0v3WCpYYZCdw?=
 =?us-ascii?Q?sgFwV3SNZ7fcZKPdbqva4trhA+STlQE1yrNYjsKLCdUa8cGuHIo8O+os9nGc?=
 =?us-ascii?Q?AlA1IiCKSELjqtYSA07kEfrwZu3KmJkM+7wH07zsaB4b19nH9gW4pLq4X11w?=
 =?us-ascii?Q?btD08qmpP8A9vgJLtEARPdcStDD7LPYGJdz60SXDsEzADuE6QUOLyR5S44Af?=
 =?us-ascii?Q?KOuuynX0e98Nm3ct65pbYUpv6ytEoT8/bezvuJT+GoduNG9C601+WW6N+5E0?=
 =?us-ascii?Q?KZ/ad5OdgHn9yz7SSyil8dDd9BMXnDtUycaBs1+DvLtnS4/ne8CQU9s+57GZ?=
 =?us-ascii?Q?F1TiWF7cTH28P+3jr66XTiuIxktff6+C9X400vVXi+3d9bLQd6RnRSKAu06T?=
 =?us-ascii?Q?/a24BcDYEI7pHSNZYPIo1odgsjk3EzHcF4hP3yA3nUOsyX1GBxSe5kPZIRCb?=
 =?us-ascii?Q?n4IEvcwx0uARXTY1vNAf+WO3ouQXCC5Ou83zmNpw4ymo7xwOkgZv1a+J/roN?=
 =?us-ascii?Q?SutJhEmEPai7fiMrzTZ6JAmsYpx/ShPVwxLTT84zynZPke4O76YdQ+X3E6pc?=
 =?us-ascii?Q?vQyjjAlPNFA=3D=3D?=
X-Microsoft-Antispam-Message-Info: MPvjSu1Ugl4DmyxLjbTsccCht0nbG76khy5UIf9zpG3tBA1Ywe4kgbi4uj/CgEk+O0k+ovHLtdvV8aRnmYz1FDr5t038yG5uVTX00lmGbQLm3PZLVtlVQY1EzyZ4pwmDhlg01oWpsc6n5Bk6yjTeAeDpHdp+PSa4XyjgOaQ5O0PUA0UML9h7Ab00nAMbsu86
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:h9fhHR2973TRbemtqMDgbtOIJN0D6x5qj2eFhiLoBfFqUV6vOflhMR24zrubJqin5UfXQDlwm75mSbKCxqntF5R4gQsZQWrqMocfDWutO2VYvXcepYqp376AYQ7IUBFSr0ETM5OaYcGy1m+8wJYGQralRT8oje2jUgvVKUJx4FyoQZQEFD9+xRfN8E0eQPSXXZedCHWuTnCayVtXahh13vQ3Ng37+Y0p4PI/BdXwvs0HVuRdvhvFyS0/2CgMbIoW2Ao3aeNVVN0WKBArZbCB+srM0iDbYi+txEDFmrMKoLjf+C9QEZwrmDvcEez2pnERlpsNanLLyVGMK5Q9VD5rkUA9lhliJSzIMNWhuzWSJYg8lHOUPGJgK0PTspo/QqOETuXekFhAyto83ox8E3+RhHLen3QrHcBh4YIkydIMyzKzQOvNnPBZg7D9bfKNugCP9BI3ip3tpqeHRAAPFMGMig==;5:4WX4lwPysnQTkL8LYCZ8JsLgYkJTPGfTn1aOLRM5iIAAYrNR/kF47xMpm1ise41VgxKQlUpJJ7qthDCuT3ybaJqEk1bn46ebZSMwbOhNVeJbWtloen0zQLUEYdtq/vKHU1pVdio37XNcEcddoZrhOooF4ZN5FwzSOnCEPRS9q4U=;24:l2X7sKuVWLT5UqR2Rb1XAJJEDYgrvoInYggnrHtLfVF9iYnSA2U70sMJJ/txQGWbxCVM1N1K7HOJfH/Q3nhOdX6dDYtyUqP1Gzb7WqtI6r4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:wXuFDBw7DDp7chdOaDrgZhxGndPVHswBABIA4/jRCdbO12tSp7SZE1F9FGZdC33Va0VPdrJ4BEpwUB+WJP448g46ZqzQDspLLZ3ij0Sgj37kwpwGE3MyRkb7aDW9aXoVY3P5sVoaeyBnHZgt6OyVgf0ed9gfqu36tM33DVjpKjVi3hMbR/ZevzGfIeiUJM/7SXS/Y5iak4nsil24rtSKRuZEIAeLfvZdCyKGCK/WJSEGHziWrMztkqXMPbnkVKJh
X-MS-Office365-Filtering-Correlation-Id: 026c54d3-cb4d-4bce-a6ed-08d5bb15f39c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:15:27.7923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026c54d3-cb4d-4bce-a6ed-08d5bb15f39c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
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

There is an interaction with the rockchip lvds driver, since that
driver peeks into somewhat private parts of the bridge struct in
order to find out things about the remote bridge. When there are
now two ways to get to the remote bridge, the rockchip lvds driver
has to adapt. That said, the correct thing to do for the rockchip
lvds driver is to use some other way than DT to find things out
about the remote bridge, but that is orthogonal to this patch.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
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
