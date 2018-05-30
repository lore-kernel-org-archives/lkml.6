Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeE3L0n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:26:43 -0400
Received: from mail-ve1eur01on0081.outbound.protection.outlook.com ([104.47.1.81]:12793
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753224AbeE3LYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:24:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com;
From: Lowry Li <lowry.li@arm.com>
To: liviu.dudau@arm.com
Cc: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        brian.starkey@arm.com, malidp@foss.arm.com, nd@arm.com
Subject: [PATCH v2 1/2] drm/blend: Add per-plane pixel blend mode property
Date: Wed, 30 May 2018 19:23:53 +0800
Message-Id: <1527679434-13228-2-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527679434-13228-1-git-send-email-lowry.li@arm.com>
References: <1527679434-13228-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:3:1::15) To DB6PR0801MB1975.eurprd08.prod.outlook.com
 (2603:10a6:4:75::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1975;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;3:2HmkGceQuSTT/7njNmcS1BAb94xiAJwbNQnm7AT6o3ugQdxSXfItPsUBDSotl4R3qgcBDC7OMdBACO37Vd0iHGWFtVTDTa3wn+iGm4GlAUAQqRLhaDVi3QC7rkGZt/fg0SksSLMHbO+prDYxbXpFrgWkuT0o2jZYmFmfkf0W3NggHMj5h5Rf39sD3Vli+uFpr5goQjBANbusZu0MgEa7cVS5qOWeqd8FyvoNx777FKOdr6eq+N1YLuuY1C0jo8/3;25:+tXhL6sts0BebyNIGZhKeQnjdF3aLb7FzayUtIGcA/PV93ftik238DlTVTDj+tl2tcHIegfh2MPF74DcMHnHtEqcET2I1jyPjv7vtKovNF7NKYMXc0TK4gSE3kyIQSqA1ksivhO5BCre/jrKyyiYfz+QjmqEPUbvP+Sg6PIbBy5VVMYYhu5ecMedpwt9hhYvFnwJ0OGtSTU3kgpOSEHO4but2UuG2DPDZN5mVCQPDNgijjhBSgOu0y5yrbZckcJd7ljGu9KCGegLzq3i1NbsjSY2saY6qZGRtLcqDxlIEmA/sE342X66RAF5Yxirc/zHmV+ETClvsYEmrBLJDVAXdQ==;31:srxyewynPNHeh2TG7f2XakWw4NlEIDZB24Qr13TEnM1plzf3VGLXxYO2LlCKR23gITdlG6HquLJnIz1ketmZ0Mh53UXITvJiH8AwtlaNOA5dAxC+G/dpxgiG1m1quTJNrZKGxa5n4iM0cMJNzn3Mi3wmn8qDElr9yPRRfCeNJ+SU3DPfxfKiUynLgNhPL0+sQhrqZG+2IkqWD2GpoAC0UV9qt0PfX8kt/dCjuDjE2/Q=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1975:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;20:JnCvczlsZUqpH0N6XEvLYOP32Av+KYaNjZXagmy2X8kusohK62fvNNCXa3dzYy/MEQNIxtnuRSevzRxAIugnYblynJGp3ckan3tQoAtxwfM1IXBxKh3gOkOpIjAsG7q/EfUJIOxjbjjaX2Gj8DrXcNvk0fMH2OspyhPmqZXf+1BV1Rvo/Q+BSJSCnPwFFOT1NHX7Q9rph1fx/piIw69R02ZiSffMrh5Cs7R86L6vp5w2125HTDlJWBTXrXwOSiKl;4:hQoeSqq6fPofzlx6jsx6GPD3/9d4WPjDA+O4ecWex0nFXZRzWO0wR2Iage7t/T0w9aJY20b6b2BGsAtEDmcygAv4Xb5gj4msRCNJscp5GxTPsfeIfV9G2/42q55AdMaz3ajADzWjjZgKdmdYCqq20DHXgh9wjNojr842y87Uf3Ycoyjy890NynWxIOsSPtthwpLEljS3KfHc/gwr2vA7fXn/2/es2Q8ANRm6XdbhU9woVE3oUNroDxJF1NwUGwKUEFXOJX/ryN1IHvDoAIiRNDH5IQ0n+DOCQPM5xZQflYSPBjD4kY7GhH0mWVcLUB+8
X-Microsoft-Antispam-PRVS: <DB6PR0801MB19751DC51F5A6C307E30672A9F6C0@DB6PR0801MB1975.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1975;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1975;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(6636002)(6666003)(48376002)(8936002)(8676002)(105586002)(50466002)(68736007)(2361001)(97736004)(2351001)(106356001)(50226002)(81166006)(575784001)(5660300001)(6116002)(3846002)(25786009)(305945005)(81156014)(86362001)(7736002)(36756003)(47776003)(76176011)(51416003)(7696005)(4326008)(16586007)(478600001)(476003)(2616005)(956004)(44832011)(5890100001)(486006)(37006003)(386003)(16526019)(316002)(11346002)(26005)(446003)(2906002)(53936002)(66066001)(72206003)(34206002)(52116002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1975;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1975;23:+N+/cd2pLDjmfcUaajeZbMW+Md4mIUSAkM6D454?=
 =?us-ascii?Q?N3DUVMSY7+XRsnoKIhY6g9+zcD3vYUK5yKpWaESY9DVhTA/hsEyBuVkfmbYO?=
 =?us-ascii?Q?EbLCxQ6qsX3x6HZebnk/SkuskKrQsFyZuIj5JzUry2qsnNyjN/RgaZ9RYmVL?=
 =?us-ascii?Q?UqEgVfjqrvz1+flHStkpZ7s2EQQ/e8HS7rLSfJYwTT7M2V/EVCW062BEoQJ2?=
 =?us-ascii?Q?yOXkkqNjYEl8vTJzO71+T2JLvWX8WlmRkTg77PbI4qtK1OJZWiIQQBTl1o28?=
 =?us-ascii?Q?oMXdmk0UfTrRRPESg9hEBqonCV4UsTsFgtndIMM1+bROQXMMZ9SL6Vh4p8aN?=
 =?us-ascii?Q?yYDriaiZmKFxG6iIw25H96PasQVHCqsjU4/MuIAAJXHyJb7bc4XTDzFX3hkO?=
 =?us-ascii?Q?Gdv2dUgwNwtQikTwzV7PkgJLAgtnYGIg3cZq9EUuOK+DlX5IuGJBEcG6yojb?=
 =?us-ascii?Q?2Tm+EnRiN2H/RqMG8lSGqw1F/wEXMUeg2UiWIRS6fJSU/bMvlTo3jY+csGRy?=
 =?us-ascii?Q?cWwBVbQJ352wv9LDWt26RhKA9Gx3qLNkGVLJHfzlnqL5IuwxjSXGoHZfJ+Kh?=
 =?us-ascii?Q?INosp77g2EJA4Xz4fVm6+ED/aSi80cZ9oe/qFLqHY1uc3lpuBMGYJaVqUTqL?=
 =?us-ascii?Q?V9g86xcpBUmbCGhw6pTZ7LfX9PItAVT8QSvdiYc97lIEZ/bN2HmE/9xnuZ3w?=
 =?us-ascii?Q?Di2TswsNYv2uQ8H4xIbPTynp4lvKMI1kVQ2fG5BPyTjU9JURenH4BDHa5N8h?=
 =?us-ascii?Q?qUN7HJDb5wFObSw9VxRcoaM4aP0isUABEmsDNkI1fbzI1Z2sF4ox35a4YlXh?=
 =?us-ascii?Q?UIaXNXd6HqHteofr8xHC77umMry/+O+So6Uj0aoo5NXIusnblS7cGH0Qq9U7?=
 =?us-ascii?Q?gQBmSis/DH7C1dLtBqggQ+T4LLkQKoEbop87JD5INBPdigVLP8RCr7mWkNRX?=
 =?us-ascii?Q?OZTk+AkNiAOnH71h8YrjH5bM1qYlEW4mjGHaDNkECzTiCKWLZdUZBCARMLyu?=
 =?us-ascii?Q?f6A0dGUwhVgfLJPXPsm4I18L45YASWyq1rFO+7NXR92vvmKp0KZ0D09GE4Up?=
 =?us-ascii?Q?L4Aqi2sX2LXeHczWOLNgjkS8ezgsNSFbUo2zcqYCfKGdOPhmb37ozMlUoI/f?=
 =?us-ascii?Q?OSXuvmYgE3a0mDF17PFdNyGi2UGZE/fkQwzJ9BvBrXCqgVUFPzWY+haa50Bx?=
 =?us-ascii?Q?tPx7LvQm6+fMFo/MXvQs/vn+4yCayiDhM7U7T/WeOnflRbxYvJsj/Mcvbhb7?=
 =?us-ascii?Q?w/e1bcEyfBMm/eiMc7FSx9v8SwiQofT7pDaB6ooHsSM9zApk9ziVQiXdYOHp?=
 =?us-ascii?Q?5LVnjoOy6ze1IBUe5EqS2FvU=3D?=
X-Microsoft-Antispam-Message-Info: CUjhEXXgzLIiq49ULa7dwrmIPolooevvsQzgnX13YkhrFdP9EScDI4xghoFw19gRMp+EcLsnOqm6Rl9dTdRlLat3ZmPvOPyCv+KaMU88G4hINpGCZ97eaeyIX4dSwBPMrzRy09x4r93Tgt4AOBP7ZGzqxbgT1Bxnl+zidfEm4d9r7UrpXJ5gTOaisNLz2lV9
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;6:ZuDWrz2FZ/38C70HM2n+cy/BOhb3nc+AhmbptidXU8xNN7zlAZy7laN5yBfHQELPvtvowMa4qZ5YEx2PMk0tXdyJgKsU2Kycm1eCjm2vIUN4M7+EkQqD6ayP/PLdjdXJ1K7sHlf+AlMQqLnwRTn04PbYiEOdhbiOqBTkFoEzAtsOyvaaWDoKsWRlzQ9V5sz8zDa7FaLiUjLcjGoGFmf5pdz0hXZoSsnSdg3MCefwDjUY1+4Vmr1XJR6VuM/NtVdoVB3bWyPaQFku5N5S6UB+9yw9a5xrq7X6m+QmD8FxZQk3nR8R0zEhiZ2rDUTD04ipHHC8I8lZ0z05cRBpwRJNwYR5jIpCtKDC/jvUgD7JXjlTVR6v1qr5tXehSvBvEExBQBmr74UdsZfInBPn59+/j1E9FdqCM219uborRLGKsPMa6GzuflLsDGUFc+1AFRnJQlVt5XwJzcJMCXR0OuOkhA==;5:+P5F6O+kyhdIENYoE90++IAeDxwrXgTtWhQhY3ywXprtcynmslLhTBSz6qB4aviz8uab1pqB7Y29HaitmVcyj1xTpB+S2Z1Ak3trQz2rzD6WdgaDObtt9wJ2SAhPkdHy7+AJOdI0ns383geqPPEgHlyiWHn/XXVrbOXkwioUNpM=;24:1ZtgnjPCKOs4exqAnWaR+wASxxoHY2zXDGIrpgzZenJc3Ms/Y/ZyT/wM7CkOCw1A8SIZySsUoEnBTS/sEu2soFxqPV4rebGZQfmt+Ndrrm4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;7:sz6QoSCmYKstdgVEnyx33yWuYAHjIIFBlqyCXGIBocdjzRe35clwgKL2h05dIpfiTpNar/mJGZvFKxnDuUviKYSHxDkyKclkQY1+rObABWp/boe4BMXm6IdgphMMTuAwhT6ShdL8HuviGLAyDZiHfRU9sF+N4ayaXU4u9t3tC8+FsjL/vsBAZ2K7Pw7TdriW2Ux8p+BDQqI41y/elvfElCVjgPCc1Xlk94x4dA5Juoij3S0o+KberwPMi5RmZyyy
X-MS-Office365-Filtering-Correlation-Id: 617be9b3-3c8d-4cb9-8351-08d5c61fea7e
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 11:24:27.9021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617be9b3-3c8d-4cb9-8351-08d5c61fea7e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1975
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pixel blend modes represent the alpha blending equation
selection, describing how the pixels from the current
plane are composited with the background.

Add a pixel_blend_mode to drm_plane_state and a
blend_mode_property to drm_plane, and related support
functions.

Defines three blend modes in drm_blend.h.

Signed-off-by: Lowry Li <lowry.li@arm.com>
---
 drivers/gpu/drm/drm_atomic.c        |   4 ++
 drivers/gpu/drm/drm_atomic_helper.c |   1 +
 drivers/gpu/drm/drm_blend.c         | 110 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_blend.h             |   6 ++
 include/drm/drm_plane.h             |   6 ++
 5 files changed, 127 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 7d25c42..467f8de 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -783,6 +783,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		state->src_w = val;
 	} else if (property == config->prop_src_h) {
 		state->src_h = val;
+	} else if (property == plane->blend_mode_property) {
+		state->pixel_blend_mode = val;
 	} else if (property == plane->rotation_property) {
 		if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
 			return -EINVAL;
@@ -848,6 +850,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		*val = state->src_w;
 	} else if (property == config->prop_src_h) {
 		*val = state->src_h;
+	} else if (property == plane->blend_mode_property) {
+		*val = state->pixel_blend_mode;
 	} else if (property == plane->rotation_property) {
 		*val = state->rotation;
 	} else if (property == plane->zpos_property) {
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index c356545..ddbd0d2 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3484,6 +3484,7 @@ void drm_atomic_helper_plane_reset(struct drm_plane *plane)
 	if (plane->state) {
 		plane->state->plane = plane;
 		plane->state->rotation = DRM_MODE_ROTATE_0;
+		plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index 5a81e1b..4ac45da 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -100,6 +100,41 @@
  *	planes. Without this property the primary plane is always below the cursor
  *	plane, and ordering between all other planes is undefined.
  *
+ * pixel blend mode:
+ *	Pixel blend mode is set up with drm_plane_create_blend_mode_property().
+ *	It adds a blend mode for alpha blending equation selection, describing
+ *	how the pixels from the current plane are composited with the
+ *	background.
+ *
+ *	Three alpha blending equations(note that the fg.rgb or bg.rgb notation
+ *	means each of the R, G or B channels for the foreground and background
+ *	colors, respectively):
+ *
+ *	"None": Blend formula that ignores the pixel alpha.
+ *	out.rgb = plane_alpha * fg.rgb + (1 - plane_alpha) * bg.rgb
+ *
+ *	"Pre-multiplied": Blend formula that assumes the pixel color values
+ *	have been already pre-multiplied with the alpha
+ *	channel values.
+ *	out.rgb = plane_alpha * fg.rgb + (1 - (plane_alpha * fg.alpha)) * bg.rgb
+ *
+ *	"Coverage": Blend formula that assumes the pixel color values have not
+ *	been pre-multiplied and will do so when blending them to the background
+ *	color values.
+ *	out.rgb = plane_alpha * fg.alpha * fg.rgb +
+ *		  (1 - (plane_alpha * fg.alpha)) * bg.rgb
+ *
+ *	fg.rgb: Each of the RGB component values from the plane's pixel
+ *	fg.alpha: Alpha component value from the plane's pixel
+ *	bg.rgb: Each of the RGB component values from the background
+ *	plane_alpha: Plane alpha value set by the plane alpha property (if
+ *		     applicable).
+ *
+ *	This property has no effect on formats with no pixel alpha, as fg.alpha
+ *	is assumed to be 1.0. If the plane does not expose the "alpha" property,
+ *	then plane_alpha is assumed to be 1.0, otherwise, it is the value of the
+ *	"alpha" property.
+ *
  * Note that all the property extensions described here apply either to the
  * plane or the CRTC (e.g. for the background color, which currently is not
  * exposed and assumed to be black).
@@ -409,3 +444,78 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
 	return 0;
 }
 EXPORT_SYMBOL(drm_atomic_normalize_zpos);
+
+/**
+ * drm_plane_create_blend_mode_property - create a new blend mode property
+ * @plane: drm plane
+ * @supported_modes: bitmask of supported modes, must include
+ *		     BIT(DRM_MODE_BLEND_PREMULTI)
+ *
+ * This creates a new property describing the blend mode.
+ *
+ * The property exposed to userspace is an enumeration property (see
+ * drm_property_create_enum()) called "pixel blend mode" and has the
+ * following enumeration values:
+ *
+ * "None": Blend formula that ignores the pixel alpha.
+ *
+ * "Pre-multiplied": Blend formula that assumes the pixel color values have
+ *		     been already pre-multiplied with the alpha channel values.
+ *
+ * "Coverage": Blend formula that assumes the pixel color values have not been
+ *	       pre-multiplied and will do so when blending them to the
+ *	       background color values.
+ *
+ * RETURNS:
+ * Zero for success or -errno
+ */
+int drm_plane_create_blend_mode_property(struct drm_plane *plane,
+					 unsigned int supported_modes)
+{
+	struct drm_device *dev = plane->dev;
+	struct drm_property *prop;
+	static const struct drm_prop_enum_list props[] = {
+		{ DRM_MODE_BLEND_PIXEL_NONE, "None" },
+		{ DRM_MODE_BLEND_PREMULTI, "Pre-multiplied" },
+		{ DRM_MODE_BLEND_COVERAGE, "Coverage" },
+	};
+	unsigned int valid_mode_mask = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+				       BIT(DRM_MODE_BLEND_PREMULTI)   |
+				       BIT(DRM_MODE_BLEND_COVERAGE);
+	int i, j = 0;
+
+	if (WARN_ON((supported_modes & ~valid_mode_mask) ||
+		    ((supported_modes & BIT(DRM_MODE_BLEND_PREMULTI)) == 0)))
+		return -EINVAL;
+
+	prop = drm_property_create(dev, DRM_MODE_PROP_ENUM,
+				   "pixel blend mode",
+				   hweight32(supported_modes));
+	if (!prop)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(props); i++) {
+		int ret;
+
+		if (!(BIT(props[i].type) & supported_modes))
+			continue;
+
+		ret = drm_property_add_enum(prop, j++, props[i].type,
+					    props[i].name);
+
+		if (ret) {
+			drm_property_destroy(dev, prop);
+
+			return ret;
+		}
+	}
+
+	drm_object_attach_property(&plane->base, prop, DRM_MODE_BLEND_PREMULTI);
+	plane->blend_mode_property = prop;
+
+	if (plane->state)
+		plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_plane_create_blend_mode_property);
diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
index 1760602..2966c0d 100644
--- a/include/drm/drm_blend.h
+++ b/include/drm/drm_blend.h
@@ -27,6 +27,10 @@
 #include <linux/ctype.h>
 #include <drm/drm_mode.h>
 
+#define DRM_MODE_BLEND_PIXEL_NONE	0
+#define DRM_MODE_BLEND_PREMULTI		1
+#define DRM_MODE_BLEND_COVERAGE		2
+
 struct drm_device;
 struct drm_atomic_state;
 struct drm_plane;
@@ -49,4 +53,6 @@ int drm_plane_create_zpos_immutable_property(struct drm_plane *plane,
 					     unsigned int zpos);
 int drm_atomic_normalize_zpos(struct drm_device *dev,
 			      struct drm_atomic_state *state);
+int drm_plane_create_blend_mode_property(struct drm_plane *plane,
+					 unsigned int supported_modes);
 #endif
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index f7bf4a4..447ebe7 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -43,6 +43,8 @@
  *	plane (in 16.16)
  * @src_w: width of visible portion of plane (in 16.16)
  * @src_h: height of visible portion of plane (in 16.16)
+ * @pixel_blend_mode: how the plane's framebuffer alpha channel is used when
+ *	blending with the background colour.
  * @rotation: rotation of the plane
  * @zpos: priority of the given plane on crtc (optional)
  *	Note that multiple active planes on the same crtc can have an identical
@@ -106,6 +108,8 @@ struct drm_plane_state {
 	uint32_t src_x, src_y;
 	uint32_t src_h, src_w;
 
+	uint16_t pixel_blend_mode;
+
 	/* Plane rotation */
 	unsigned int rotation;
 
@@ -498,6 +502,7 @@ enum drm_plane_type {
  * @type: type of plane (overlay, primary, cursor)
  * @zpos_property: zpos property for this plane
  * @rotation_property: rotation property for this plane
+ * @blend_mode_property: blend mode property for this plane
  * @helper_private: mid-layer private data
  */
 struct drm_plane {
@@ -573,6 +578,7 @@ struct drm_plane {
 
 	struct drm_property *zpos_property;
 	struct drm_property *rotation_property;
+	struct drm_property *blend_mode_property;
 
 	/**
 	 * @color_encoding_property:
-- 
1.9.1
