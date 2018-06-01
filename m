Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeFAMmI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:42:08 -0400
Received: from mail-eopbgr50057.outbound.protection.outlook.com ([40.107.5.57]:40689
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752082AbeFAMl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:41:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com;
From: Lowry Li <lowry.li@arm.com>
To: liviu.dudau@arm.com
Cc: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v3 1/2] drm: Add per-plane pixel blend mode property
Date: Fri,  1 Jun 2018 20:41:10 +0800
Message-Id: <1527856871-3007-2-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527856871-3007-1-git-send-email-lowry.li@arm.com>
References: <1527856871-3007-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:4:54::30) To HE1PR0801MB1977.eurprd08.prod.outlook.com
 (2603:10a6:3:4f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1977;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;3:rGXHEDRr5VvwLuiXd3nm2S8DtzqXONF+cdtiqJchSCTIZWhBqrVcBGtFcuyeB6NndEbu9PWSBC5GS7NeWpIBd6RgrejJzJs4CcuxTQFybvFFE5sGKl52W5Dr47Lnp+q0oTon5r3qP5fB0bRJpJK06LaXAJIQFwLAVbVu1XD+Q/GigoNI5w1I6iKAK0dw7jY4PF1e9zosEGzho1Ka/FJiZomZ4dC8vZcTwAJw238k+RVfmTuk23yPp6Fsj/Naj+Mo;25:BT9XkVEJK7oycHaFV6G5DtcM3CEXTsTEcdPazdXD+jmgSifmloi9mHU7Al0CbzEEpxhezV9yATNz2U4gSVPcycRLsI2ydXp904PUKJGeVW1egr5qb8vXsUqEr8RnpdR0VQ0Y1/1TnYFyHMk6sWNAQzlqnxMQeMiDu8MWfwKtlYuDRWhIUOWnyf6YFEwtxJyzh8YTakQsizTaoGw5UTPPyL03e1KEeKiEaZOVYgOgEgfgoRLaWgurRMAFFVaXiHj5QB1aEk9vTAfocqa7lfwDOyxlKpEA8lGv/V/IMlHrabPwLzLnqP54TMnYAYtKEfQExVykgt+E28MCk65pupqSig==;31:aF9OtPcLESvN3nvzVjSOvckK5IDtO6pY+AyiCh3aWA+YFd3dv/HNXIO3Vce39AccY27F/SrUVhiIEksfdgj1r7YPBBfMuE63ufoAKWrMTJXcmLYLSHxpu7hQGF+xUcmeCcRcN/6tMpCUSj+6vBbT5OZjSxACGstQSTzQmrm+5MBb2flPTEvO8D4mCHA+4agdgjT2FEy4sCrjS1lkQL+GbjRBSWM8J6igH0ZcqTSld+8=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1977:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;20:1/HVTdQ2n2gt0KY6axxrURr6M5mC7CrfRz+ioAgKqXrsUMCpeymAqzA62k/gbeleN7o+LzFImJz8beWiMaqTHADE4B/KmwugX99QdwIYqSKdcSwNVTRY13UbzI5L4jIsu4aRglhvp2bPsOjn6HB6/S1WwaCGc2b+/k1sO4qEbMGyzRkxYy930kLx6xp96fSwg9wFoAnW88GA/9hHlkNBuQF3BJVvIaoSrBuGkjJ5Z62wSeMj31SaLbmyGSJeWunP;4:EnJFHeVYjmLXd+Xfz2rsss6LX1DKpKvsnk2OsXqkOYrPXWZyy9eVlRivydogGuRJmyOHUc2BmtsZ+Nwhj/xcND+wj5/ZFHvNxg3IqvQXdZ5Z/rplXj3KtNeKAD90VQif+TTHoFDaRcS4UgKkVhtWvorzCFjOL21E3hD5hOo395M+ViBUna6e9bSFi14GYEWrLgrgQWBZT4AOpAt+/JX8XuSXrspjnGjWw0cjODbHMVCnX3MI56QU4tQI2J+NfeTGXfpvKKbTsVI6yU8LsZyoCgwSMzWk1pR3X+nAip/FKe8OW5AjqYwiD4AMQSdmJ50+
X-Microsoft-Antispam-PRVS: <HE1PR0801MB197778E1AE0027B119C6A2189F620@HE1PR0801MB1977.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1977;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1977;
X-Forefront-PRVS: 0690E5FF22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(39380400002)(346002)(189003)(199004)(97736004)(478600001)(72206003)(47776003)(6636002)(6666003)(6486002)(66066001)(86362001)(50226002)(76176011)(386003)(105586002)(37006003)(16586007)(5660300001)(305945005)(36756003)(7696005)(52116002)(48376002)(51416003)(2361001)(106356001)(26005)(8676002)(16526019)(11346002)(50466002)(446003)(316002)(53936002)(4326008)(81166006)(2616005)(44832011)(7736002)(486006)(39060400002)(34206002)(476003)(6116002)(3846002)(5890100001)(956004)(25786009)(8936002)(68736007)(2351001)(2906002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1977;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1977;23:j1DyeYiZjwH53sYXFjoxHC1SqbMKYRFwtQjmWLz?=
 =?us-ascii?Q?oPth+YwAEr1/14/xUJau9hHV66uuKC2nhFupnvJz5j90rpD+bUpzYN1lXIPx?=
 =?us-ascii?Q?PX21HpsHhtp47kbW9PIAdX6yOeWy9I6+WjqpWh9jB97XA35oHXWRnvAVb0Oo?=
 =?us-ascii?Q?vQvDiUSiRUr1nYVBTRFJJApBglv3tK96M19OTacxs6m5RlhhLJTJ6ZGd+Lbw?=
 =?us-ascii?Q?H8nFUMmI2ZLlyOucBoV5KMX8TDdp4yqpOpyt7715LQCns7B2VPxetnRuFKJX?=
 =?us-ascii?Q?6v01PnCbjF/YFkUQ1ysiIDdg+15OSVpOC1Gbgj7JkhscB8EvYhTfGxGyMHL6?=
 =?us-ascii?Q?KqNnl4fkns0TGw15FnquJSgw/8TIE8XKgSGGRAXluO4QIa+jO8oqLcB8n4gS?=
 =?us-ascii?Q?ejq56ArdLIinI6iYhv8+wd9QMiGDzvo+vSXi9KqNSzs4yF8BV/4rikZPiGsu?=
 =?us-ascii?Q?VZN+vfaO2gT/F9HrScaA8FFyd4NDtyphcO6LX72oHwSJjZNk1z2Lub213IPW?=
 =?us-ascii?Q?UWCxY17WitqntNQDek3LAUdFn3AnQCWOMLVefVGEIyCWgq8PqkBHoW5hXfN0?=
 =?us-ascii?Q?WJcpNHbxdy6reuKobY3sZnodjneK+R+iQtJmmKCKGU5k7c2sldM7pMeE4utQ?=
 =?us-ascii?Q?PAgYuFUXCiqUNlK6GnG4gkS/avL/qvclASHn/8HCCKZIke8YNs6lJghcwHzg?=
 =?us-ascii?Q?Jg9IZQQwaVxTe2rhC+gXQDZzd9DxIm8jEv4w2TpLG/1y6Ge2d0nM+MgkWgKT?=
 =?us-ascii?Q?xgQ5Ev+07J5Uobf1D6WjlozuQxNEaM4Ek6CGj17lmLW9BD7rEuT2qxekUEY2?=
 =?us-ascii?Q?JUWjy0+haoNgFKxYIX1NR7B989AO8uPt7thmdYZy/sDCKBMIJ8rEy2A5YnUg?=
 =?us-ascii?Q?kw5RIS22JD7ESGq6wkTnYt1AyYeYQh7+oSzLeytO0yTJBKM+ZZG71tMvxscA?=
 =?us-ascii?Q?R/oYEmYq7rsp8vX50UVYl4UrJAImQiPObF3P0+FgsubOWZTBlMB+yF+tPuds?=
 =?us-ascii?Q?86och7gC4PNqrRcRdmdlDZI00/bHzWuEivD1yKlpGhoP3R6Rd905nnFG7ArL?=
 =?us-ascii?Q?Zge8Kuyfrpp7tU4UiqPlPJ7B6Cq78MOdxPGpA07M7MgQN0DeQYeoFlw1yaB4?=
 =?us-ascii?Q?fs8ayJRX6yuMYIw4E29u1wtR2TvE7GsymXnvOqGiBjt6x6/OGgweVqDtwB1D?=
 =?us-ascii?Q?23MXFJmQpQqEc9FzZDVfRphE4QUvR1uEN1qNMqitP2EacKRj8lq8CCdZZn46?=
 =?us-ascii?Q?1pGpHRgvrAq+qHtnglhtlUOpWdvGJ6zuFVXxB1eRBujZFpjY1ljsGnYnvXil?=
 =?us-ascii?Q?5RM2WXh0GPjj7Be+492Ljy+8=3D?=
X-Microsoft-Antispam-Message-Info: mBGT/7aUkvI5kY40x9b1NGpu/LrXku6HbVWyhbA39Di1bXF8oOZXXxzDo4DyDnmQWHN5gqPmZOhXygVTAoSiENrFIk/pQKZr3JfNK4LA+jqVr9pHmBbJXaYcdV2ZWoQ4nlzKarZV16IJ4fPa/S56MkFlf/E1BaL3Irg5xYA63gIKJCrZUijSVEb20gN/fJ03
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;6:2oh7eh383w6qbmP0ESHQBOFpCeHNX3vXZv2srRJ0EQRmFcIkbSBny42YxcHXBR0gFJFsGEi21VxMrxWblJcC5khu6lk+LtnsLu8THHLQ8/KyNQxV1HBpPqKAVxT2s96L68sCQODTMhny918uFmCmeArUEn0wG76EUuC1L6KKuAgnhjOEFm7EBowWvmTfI07Lcp1olE6CoDjPwfsTcd8yy5pnpVzrsdWI/s/CyV3b1AiSE/XCa6VJ3IczYVAMHS9juO1OIaK544SSrmyYcgO12VPzfJqcNpvEP0TpHcpY0FKX3sboOevBbtK3wMrn9xzs/P/rRcB7VzY+KYHCLdEe5zzUgp1hZvfL6I3g+yymwfIUEynp+o05JkvMQ43D2kjWbfQZNIMOYt4QdxmByy2GvInyfZkAcdKoQ3PfVXTGEkpR53SDS2PRX8cbp9958qMnW1JaGHen/mrlvT6kKaKZDw==;5:exs4QUZRIPhVo6qNRMsG//qeQV1JrllRYGKAtARFFb009gg9BfH80TkPk0INmpXPhKmVE4CfMWD+VaUQioJvmn0VKdD8xu6WeIs39gyH5nqG6/3XiPrQj/fuRwBkjzFBHfU0t/87rfo4K1ZzX3CiTYmTkfvVhEn1lrg5U8p0Y00=;24:ipqA4IzRmyJPD/hs3nfy0CXDVQEEfDn+rfaiDLKmom2U/kKfbuz5bUVr4Qm176hI5d0X/s9xSJz/IJuwSYJlLp5HGO1L92mJnFSHD2xpdGc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;7:pLYexBX8jz111xeeHtEAtDsTqiCGNXgJDeR+areYsNJMVnfdrYu3bmgdfRPBnbijZGAEhiuoll/97Lxw8qQ0kS+POZM+7RlnNACdBgNtbvha38qpngzSxeUSYIPxYVuxEKrVUXaniQCvSZitw2vGqdj6XSCNvrh/0xBBbgFle3r2a3US0Tr7kHmeC5XGPLZHAaVxK3uYnMxAc8u9LhGfCEhwGuktKpJ0Yg+RB2BGbbplyWHzoaj5C/S4RMpxzmvz
X-MS-Office365-Filtering-Correlation-Id: 1858ed96-77f0-43c2-ea5a-08d5c7bd0eaa
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2018 12:41:50.4277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1858ed96-77f0-43c2-ea5a-08d5c7bd0eaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1977
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
 drivers/gpu/drm/drm_blend.c         | 126 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_blend.h             |   6 ++
 include/drm/drm_plane.h             |   5 ++
 5 files changed, 142 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 07fef42..1d18389 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -785,6 +785,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		state->src_h = val;
 	} else if (property == plane->alpha_property) {
 		state->alpha = val;
+	} else if (property == plane->blend_mode_property) {
+		state->pixel_blend_mode = val;
 	} else if (property == plane->rotation_property) {
 		if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
 			return -EINVAL;
@@ -852,6 +854,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		*val = state->src_h;
 	} else if (property == plane->alpha_property) {
 		*val = state->alpha;
+	} else if (property == plane->blend_mode_property) {
+		*val = state->pixel_blend_mode;
 	} else if (property == plane->rotation_property) {
 		*val = state->rotation;
 	} else if (property == plane->zpos_property) {
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 130da51..7f5d463 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3515,6 +3515,7 @@ void drm_atomic_helper_plane_reset(struct drm_plane *plane)
 		/* Reset the alpha value to fully opaque if it matters */
 		if (plane->alpha_property)
 			plane->state->alpha = plane->alpha_property->values[1];
+		plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index a16a74d..ac6f19c 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -107,6 +107,52 @@
  *	planes. Without this property the primary plane is always below the cursor
  *	plane, and ordering between all other planes is undefined.
  *
+ * pixel blend mode:
+ *	Pixel blend mode is set up with drm_plane_create_blend_mode_property().
+ *	It adds a blend mode for alpha blending equation selection, describing
+ *	how the pixels from the current plane are composited with the
+ *	background.
+ *
+ *	 Three alpha blending equations are defined:
+ *
+ *	 "None":
+ *		 Blend formula that ignores the pixel alpha::
+ *
+ *			 out.rgb = plane_alpha * fg.rgb +
+ *				 (1 - plane_alpha) * bg.rgb
+ *
+ *	 "Pre-multiplied":
+ *		 Blend formula that assumes the pixel color values
+ *		 have been already pre-multiplied with the alpha
+ *		 channel values::
+ *
+ *			 out.rgb = plane_alpha * fg.rgb +
+ *				 (1 - (plane_alpha * fg.alpha)) * bg.rgb
+ *
+ *	 "Coverage":
+ *		 Blend formula that assumes the pixel color values have not
+ *		 been pre-multiplied and will do so when blending them to the
+ *		 background color values::
+ *
+ *			 out.rgb = plane_alpha * fg.alpha * fg.rgb +
+ *				 (1 - (plane_alpha * fg.alpha)) * bg.rgb
+ *
+ *	 Using the following symbols:
+ *
+ *	 ``fg.rgb``:
+ *		 Each of the RGB component values from the plane's pixel
+ *	 ``fg.alpha``:
+ *		 Alpha component value from the plane's pixel. If the plane's
+ *		 pixel format has no alpha component, then this is assumed to be
+ *		 1.0. In these cases, this property has no effect, as all three
+ *		 equations become equivalent.
+ *	 ``bg.rgb``:
+ *		 Each of the RGB component values from the background
+ *	 ``plane_alpha``:
+ *		 Plane alpha value set by the plane "alpha" property. If the
+ *		 plane does not expose the "alpha" property, then this is
+ *		 assumed to be 1.0
+ *
  * Note that all the property extensions described here apply either to the
  * plane or the CRTC (e.g. for the background color, which currently is not
  * exposed and assumed to be black).
@@ -448,3 +494,83 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
 	return 0;
 }
 EXPORT_SYMBOL(drm_atomic_normalize_zpos);
+
+/**
+ * drm_plane_create_blend_mode_property - create a new blend mode property
+ * @plane: drm plane
+ * @supported_modes: bitmask of supported modes, must include
+ *		     BIT(DRM_MODE_BLEND_PREMULTI). Current DRM assumption is
+ *		     that alpha is premultiplied, and old userspace can break if
+ *		     the property defaults to coverage.
+ *
+ * This creates a new property describing the blend mode.
+ *
+ * The property exposed to userspace is an enumeration property (see
+ * drm_property_create_enum()) called "pixel blend mode" and has the
+ * following enumeration values:
+ *
+ * "None":
+ *	Blend formula that ignores the pixel alpha.
+ *
+ * "Pre-multiplied":
+ *	Blend formula that assumes the pixel color values have been already
+ *	pre-multiplied with the alpha channel values.
+ *
+ * "Coverage":
+ *	Blend formula that assumes the pixel color values have not been
+ *	pre-multiplied and will do so when blending them to the background color
+ *	values.
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
index 330c561..28c5076 100644
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
@@ -52,4 +56,6 @@ int drm_plane_create_zpos_immutable_property(struct drm_plane *plane,
 					     unsigned int zpos);
 int drm_atomic_normalize_zpos(struct drm_device *dev,
 			      struct drm_atomic_state *state);
+int drm_plane_create_blend_mode_property(struct drm_plane *plane,
+					 unsigned int supported_modes);
 #endif
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 14b1607..6e2c045 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -44,6 +44,8 @@
  * @src_w: width of visible portion of plane (in 16.16)
  * @src_h: height of visible portion of plane (in 16.16)
  * @alpha: opacity of the plane
+ * @pixel_blend_mode: how the plane's framebuffer alpha channel is used when
+ *	blending with the background colour.
  * @rotation: rotation of the plane
  * @zpos: priority of the given plane on crtc (optional)
  *	Note that multiple active planes on the same crtc can have an identical
@@ -116,6 +118,7 @@ struct drm_plane_state {
 
 	/* Plane opacity */
 	u16 alpha;
+	uint16_t pixel_blend_mode;
 
 	/* Plane rotation */
 	unsigned int rotation;
@@ -513,6 +516,7 @@ enum drm_plane_type {
  * @alpha_property: alpha property for this plane
  * @zpos_property: zpos property for this plane
  * @rotation_property: rotation property for this plane
+ * @blend_mode_property: blend mode property for this plane
  * @helper_private: mid-layer private data
  */
 struct drm_plane {
@@ -589,6 +593,7 @@ struct drm_plane {
 	struct drm_property *alpha_property;
 	struct drm_property *zpos_property;
 	struct drm_property *rotation_property;
+	struct drm_property *blend_mode_property;
 
 	/**
 	 * @color_encoding_property:
-- 
1.9.1
