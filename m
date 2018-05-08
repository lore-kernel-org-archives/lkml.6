Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbeEHKfY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:35:24 -0400
Received: from mail-db5eur01on0060.outbound.protection.outlook.com ([104.47.2.60]:39580
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754408AbeEHKfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:35:22 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com;
From: Lowry Li <lowry.li@arm.com>
To: liviu.dudau@arm.com
Cc: daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        brian.starkey@arm.com, nd@arm.com
Subject: [RFC PATCH] drm: Add per-plane pixel blend mode property
Date: Tue,  8 May 2018 18:34:36 +0800
Message-Id: <1525775676-32158-1-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR06CA0086.apcprd06.prod.outlook.com
 (2603:1096:3:14::12) To DB6PR0801MB1973.eurprd08.prod.outlook.com
 (2603:10a6:4:75::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1973;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1973;3:OPh7kzQUQ8G5mjgodkG6a+A1D/8K2alW24BfWU8/0UdUqPg8SsecZ/d8zQeNC/WsfzqYVvouW5GOHU1n2b7ZpK1YHJqAw914uBuHmvSJoBag9ulWqi2bz9BP2P3AwjjJMp5b9M8IhUcHmJau7CsFNmyI+4a9EpX46ZWeFFBQjaA5UBgyLpo/GHvN2km6QeaGNAvdFTwWy5UgnzYwJHd5p3HDi/cWzIo8Zg8K5vnkQYUt1By8yllh5LmENWSZqNvo;25:VI7H0BbSLpG0x1dgg+M+XbAdhOeOZKHrCYElMAhhqk/W0fpeKobdIDG49xnQ2lx49pwJyPvo8FZsBsbJq6UkmXwacuzt08omFDQFK7JIFBU5VSfBC21IYYau86goLilxVbTaNNp4MW3nQwAngKhzuKAMHDv3GopnqWTUFrd2GvbTJPqd/skamfwiGXtNKi0vH4dyhOmkMJlnNM9P/q1oPbrioMUDnqDSKjAk4K/5jwMnv6iCt9/rcGk/NpvlQwz2ydJq+30z1maPmQvgJBH35k9HsVQqM4CZN/6WUbG/rdyWJTQ45Misdt7UM3axLqIiSc+k1eEsHzoBa+oiV53Qdw==;31:4MNTiEdfZ0Cjr1Umf3S3DvlTazNsDQpJrZ9YZ/IZ1YSlF486nqk9S+BBvpQ/UdVakT19m+ZibYRnHnBFP8sGl8QOuwK1rK109A9HA0qJNAkyYzA1z47krdGX8VdtfQ8QFg0H0KX73Harf9fPX9c7Z7cHBiBHLIgfZGY1KUQbNYTmBYz9b4uUzgDYSaVqPyiF5Tk1XE8CKT3iR2ZSXWhUY2gKKi6SYt6G6PlTqZQYzHU=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1973:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1973;20:jU3v5NqsukbfOTVS+OrzsJ4Zl9gKazf8iKVRmUZinjTVQ1HyVyKby4f/u+qYNjmg6FS6Zj9g+v+nA7QIogseQiO7is7YdO01noBx16CKaQP5x4yMdzk5Yw+zH0WcBk1jFkH2xOpMxXvuPoA5JLwqRAV3kuxBjtDGQsGl5urRCXjH9cTtgkw0V52+Rm+nowJvnsSUC+aHV4z/4M3Y2w9fyYugqovISyPCN6Q+CPYeNOQltKutMXc87uLwX/yUV6zb;4:l/yHkC9nHK9lPsg5fYrmTeYMuZ7YVUoaa39XQ538q01itQ2uxmr9Ekj/muWFX0vwScLTOlHvCM6EdQBbXNBf6N9LtVDhuZZhB7Xh2F5r03C4PcvLx6uaw3FnqYlEwJWGs8fbduBL3T3GYiE3cDFBbxGIwYrdQGwKK9Dth/j835XvSmPV5REO9pTtgOTfS0cwwn+WX9Nk85dQa5+4Z74xihJIkNSKnYZ4RPBtQcmt99MN5TQRQq8d23fVpuXzO1Qs1NtAxIJpot2JvxrcF1ML+iU75R7lZ2WwjTz4kFZ0C+BhbKjUYNAE95cfZ4vOcIvE
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1973F042C8295488DE15A8FE9F9A0@DB6PR0801MB1973.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR0801MB1973;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1973;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(39380400002)(396003)(189003)(199004)(6486002)(6636002)(50466002)(386003)(25786009)(106356001)(72206003)(86362001)(7696005)(105586002)(66066001)(51416003)(52116002)(2616005)(47776003)(476003)(36756003)(48376002)(478600001)(6666003)(68736007)(956004)(8936002)(37006003)(316002)(5660300001)(53936002)(8676002)(81166006)(81156014)(44832011)(34206002)(97736004)(4326008)(16586007)(486006)(2906002)(7736002)(26005)(305945005)(16526019)(6116002)(3846002)(2361001)(2351001)(5890100001)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1973;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1973;23:m/j7HJcGs2jTxUzKbc4dgzCiT67AgmKrCRH2uXr?=
 =?us-ascii?Q?WYm8QXy1qI4+vy2ho5XEVU/MfxxLPt4EtKbFgQsaxGByMTETUsnW4ujrGvBS?=
 =?us-ascii?Q?ieru7YaZuSR00wWIshafFhtFLMdKFL/0h7H67AYQBCIL1ckFM09XYv6a0kbg?=
 =?us-ascii?Q?PD4gm21eDFWJSb6LLo+5r+EiuaAFo9mDCrdxM524Gvm5y47ptOp5czKThj2o?=
 =?us-ascii?Q?FnaeftZQBRU7dA75HR3bPTwWpSuspyAFzxqZODVpXNxSV4U2D5IIw/ysFH97?=
 =?us-ascii?Q?zF/yng5zLm3/vfI8efU42FxQSKdJHrfCsVKlqdUlqJEy2ZC2KNDiLMldkPUe?=
 =?us-ascii?Q?Y6bLwF6/RMXDqMJhKWLaB9hNB15L8Byyxx4lRAbTfNWoYko05yz9oKNuDlEg?=
 =?us-ascii?Q?cYYMobBMFvpaMe8raJlqubtBhXsFN40bUa+D3neZ9BZ1ccVigAmnPxJx0I9j?=
 =?us-ascii?Q?UQgpoIzantv6vqMZA7mj78yczQ7bIwKmPlOw4vP8s8YOOKmH0fDtZ1wLv4Js?=
 =?us-ascii?Q?o+22Z2wlBqudQLt7WJoeyOeOSXXOjsLymVtbUGRJFQhxUR2HKghZKFN6UQZS?=
 =?us-ascii?Q?tzPg9HNPOWIhhYMl7IlZeP+juM5tIqFKtbcP7sgyW9sH97V8/1xAPzrTLilA?=
 =?us-ascii?Q?MW3AIeuQtiZvDkUiBOCAYH0opnI3SVMBTXjbYmrQHyAw05xSlZv39mCAmPdk?=
 =?us-ascii?Q?c+Squ3FbSmoiU/NGJmqzvrzIjnKhmC0B/ewNVC+GpvCsAUnEgKFT5IpN1lkE?=
 =?us-ascii?Q?02dA6l3H7p2fGN9Vg+LdRANxEn/Z3n+syjcUf6RZuSpHKlTzoA0doGDd0FbT?=
 =?us-ascii?Q?8m+I0DzFAphANXwYSJyoa5VfURpbFa6oFyKSmWktIIQ4vDSYXQbqilRJDAAg?=
 =?us-ascii?Q?cAWeLqkwB6IpqJGCky0L1I/vN7Jvum8ooZ/MPjLGAGv8vGUBDU7facMMw+3q?=
 =?us-ascii?Q?n5Ti3GnpBwYGcshO5Vvo0UMngIrP2eb3LTFcOh73ukx4qpHeApafqUEFaVK7?=
 =?us-ascii?Q?ALSe9K2Qycl5gwhhgWPSo4QerZkt3Ls3M+aLi2om1aidEDUE7IrnEcjY6ml9?=
 =?us-ascii?Q?GOOO3aM//OgnpmAeZ1cRKCd11HyrXZFjMJqF0789XOsWgV765xjK/WRFHyvk?=
 =?us-ascii?Q?FdtYehw3dxqTqXvHc0kqOJN2gy3AZgsXf+ZgZLNdgJvr/5i+kz94Zz3cAEWL?=
 =?us-ascii?Q?Z6ao1pqcRsa+WB5XKQ3xTJBMYYkl6gIffQSKI80OBL28yPxIjCmtv41tZXQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: cE3gUDBbrX9EZDvTogJTSA764qIp5+RGCC2yfG6I1WukY2t+C5o1gN9qftrrVF51f7FViGxfoEhSuojiDDKVg+kVfbFIQP5gLb6KeE8C6V39tnyPEFINvGgFg4K19kPOdE2/GngOZ5S7YAb1CE4cNqYUnbvmOhzkGYf/oJN5K/uRxujWGVoMjjp/nV1bsggH
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1973;6:6cncQVKR+s1XijBnzAIdMiCMj18E1ZpcLh8uKH24/nWXTcbNyeQcHUNKr76oiHyeZgteJr2mvMFb4ckyIlrOeZ+FHU8pBc1ymZrqq1sxKjgw7UVvqBCnz8HQMNM3EzXXHPBD4YEDQk+60FIJ1f9j46ObMhDJnWiGy1kVWhBZ2Bzo5Tqn57I/9I3OMK1TMlfAE5OAN+I4qT3ZiD2zcVTQSkcwx8uMNbQLfGuyJ1r2dpFWxqpFHV96nCjNhIatl75HqKjKc897gdSVEfpGmZd/668PCDi9QqptS51qXRWaQqKHqxmLpcUlPh7IuseiM5CpUREricxigETYLWgnLs2KD/V/1y51gFgp/vI7+j6Q7DZVJ4Vl2qmYxQ0tq2A8GOEhPUKu/ejvSTZrRWuMj5B+6D+q3jC+c5ullRUBaf5twBmPGBWmVYL8PydgHBFKp4inTMVz9E7Qm4jGlHxY6MNxkA==;5:CrJwzP7RZHlDb4ghFtFMfN79TnP/mad8QXt1Ow2wmlBq+s+AWcmcxhoBPaqeUkX6Lv4IWhXXPEU6EVJ0UL7gqWBCYd9oxAQu8x8w3M2H/WSq4hwTLfZIsMVySrkda54BPFfp5TTUhfKO4wtdJHz0XZh9srMtrPpaDdD8ftUbPzM=;24:CPvgXketKG5I96dmUwKM5pkZ/hPiUo1oXs+Ln7uJDeHe+4u1oAKNm8NkZSf9oQDscehMg5CeBEISqNYiHHOkszITGvZlZ4KZ272KMteC8nU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1973;7:PIr6g1K1frJJzdxoxOY3ynWldFP72YU451hl0gkXTGch1TxIkotcAq/Pnhu1MYdGmVkJPuZRxkVQCFyzAJb5uLPxBdnxr4MfcBLO+Uk8L6EZTXlORgyuiV2yHhK0ZKepMEIDWzixvPYK6hgU2MiTHFYnedalTIR0cMHxf0H3QVAFmSP5+9qMHpMV0pxd6Hkb49KuzGgmVZV5oezQAQpm0Co8bN1s3kb+TEuzsPKLJXfBl8iT3sxFf/WyabEn4vrz
X-MS-Office365-Filtering-Correlation-Id: 13d95e9c-fe76-415d-9021-08d5b4cf65cd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 10:35:16.9805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d95e9c-fe76-415d-9021-08d5b4cf65cd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1973
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
 drivers/gpu/drm/drm_atomic.c        |  4 ++
 drivers/gpu/drm/drm_atomic_helper.c |  1 +
 drivers/gpu/drm/drm_blend.c         | 95 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_blend.h             |  6 +++
 include/drm/drm_plane.h             |  7 +++
 5 files changed, 113 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index a567310..0bb6de1 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -764,6 +764,8 @@ int drm_atomic_plane_set_property(struct drm_plane *plane,
 		state->src_w = val;
 	} else if (property == config->prop_src_h) {
 		state->src_h = val;
+	} else if (property == plane->blend_mode_property) {
+		state->pixel_blend_mode = val;
 	} else if (property == plane->rotation_property) {
 		if (!is_power_of_2(val & DRM_ROTATE_MASK))
 			return -EINVAL;
@@ -826,6 +828,8 @@ int drm_atomic_plane_set_property(struct drm_plane *plane,
 		*val = state->src_w;
 	} else if (property == config->prop_src_h) {
 		*val = state->src_h;
+	} else if (property == plane->blend_mode_property) {
+		*val = state->pixel_blend_mode;
 	} else if (property == plane->rotation_property) {
 		*val = state->rotation;
 	} else if (property == plane->zpos_property) {
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 01d936b..e4377fd 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3133,6 +3133,7 @@ void drm_atomic_helper_plane_reset(struct drm_plane *plane)
 	if (plane->state) {
 		plane->state->plane = plane;
 		plane->state->rotation = DRM_ROTATE_0;
+		plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index 665aafc..bb938de 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -98,6 +98,12 @@
  *   planes. Without this property the primary plane is always below the cursor
  *   plane, and ordering between all other planes is undefined.
  *
+ * pixel blend mode:
+ *	Pixel blend mode is set up with drm_plane_create_blend_mode_property().
+ *	It adds a blend mode for alpha blending equation selection, describing
+ *	how the pixels from the current plane are composited with the
+ *	background.
+ *
  * Note that all the property extensions described here apply either to the
  * plane or the CRTC (e.g. for the background color, which currently is not
  * exposed and assumed to be black).
@@ -405,3 +411,92 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
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
+ * DRM_MODE_BLEND_PIXEL_NONE: Blend formula that ignores the pixel alpha.
+ *	"None"
+ *	out.rgb = plane.alpha * pixel.rgb + (1 - plane.alpha) * bg.rgb
+ *
+ * DRM_MODE_BLEND_PREMULTI: Blend formula that assumes the pixel color values
+ *			    have been already pre-multiplied with the alpha
+ *			    channel values.
+ *	"Pre-multiplied"
+ *	out.rgb = plane.alpha * pixel.rgb +
+ *	      (1 - (plane.alpha * pixel.alpha)) * bg.rgb
+ *
+ * DRM_MODE_BLEND_COVERAGE: Blend formula that assumes the pixel color values
+ *			    have not been pre-multiplied and will do so when
+ *			    blending them to the background color values.
+ *	"Coverage"
+ *	out.rgb = plane.alpha * pixel.alpha * pixel.rgb +
+ *	      (1 - (plane.alpha * pixel.alpha)) * bg.rgb
+ *
+ * This property has no effect on formats with no pixel alpha, as pixel.alpha
+ * is assumed to be 1.0. If the plane does not expose the "alpha" property, then
+ * plane.alpha is assumed to be 1.0, otherwise, it is the value of the "alpha"
+ * property.
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
index 13221cf..6bf95a4 100644
--- a/include/drm/drm_blend.h
+++ b/include/drm/drm_blend.h
@@ -26,6 +26,10 @@
 #include <linux/list.h>
 #include <linux/ctype.h>
 
+#define DRM_MODE_BLEND_PIXEL_NONE	0
+#define DRM_MODE_BLEND_PREMULTI		1
+#define DRM_MODE_BLEND_COVERAGE		2
+
 struct drm_device;
 struct drm_atomic_state;
 
@@ -65,4 +69,6 @@ int drm_plane_create_zpos_immutable_property(struct drm_plane *plane,
 					     unsigned int zpos);
 int drm_atomic_normalize_zpos(struct drm_device *dev,
 			      struct drm_atomic_state *state);
+int drm_plane_create_blend_mode_property(struct drm_plane *plane,
+					 unsigned int supported_modes);
 #endif
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 20867b4..f9cbfee 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -41,6 +41,8 @@
  *	plane (in 16.16)
  * @src_w: width of visible portion of plane (in 16.16)
  * @src_h: height of visible portion of plane (in 16.16)
+ * @pixel_blend_mode: how the plane's framebuffer alpha channel is used when
+ *	blending with the background colour.
  * @rotation: rotation of the plane
  * @zpos: priority of the given plane on crtc (optional)
  *	Note that multiple active planes on the same crtc can have an identical
@@ -104,6 +106,9 @@ struct drm_plane_state {
 	uint32_t src_x, src_y;
 	uint32_t src_h, src_w;
 
+	/* Plane pixel blend mode */
+	uint16_t pixel_blend_mode;
+
 	/* Plane rotation */
 	unsigned int rotation;
 
@@ -459,6 +464,7 @@ enum drm_plane_type {
  * @state: current atomic state for this plane
  * @zpos_property: zpos property for this plane
  * @rotation_property: rotation property for this plane
+ * @blend_mode_property: blend mode property for this plane
  * @helper_private: mid-layer private data
  */
 struct drm_plane {
@@ -506,6 +512,7 @@ struct drm_plane {
 
 	struct drm_property *zpos_property;
 	struct drm_property *rotation_property;
+	struct drm_property *blend_mode_property;
 };
 
 #define obj_to_plane(x) container_of(x, struct drm_plane, base)
-- 
1.9.1
