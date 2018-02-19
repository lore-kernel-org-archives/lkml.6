Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x226xoJa9SWXJ2fEF2rTSsgnxy6Rzqt9G62QKn8axMho8H+WlRz/ZNvyE4n1fHne9Zn5knhIM
ARC-Seal: i=1; a=rsa-sha256; t=1519035262; cv=none;
        d=google.com; s=arc-20160816;
        b=YVWvO2nLyRFhRvplbbxo9VmBAhk4w8qOOU/znDTxrjALJTPkMNdj7LU9r1AvEqjVe8
         J8uqHdTsWfwxOatAhzN0fj/YODjGWhJva7pQoPq11WMtHvtiEQwurPOfiFpzRx8W88LQ
         li6FkbkzV2hwdjE56F+bx7Nfwn7sWhU2MiUBg3nMu+VLONcJc2Gn0Pbgx/QYeYgM4Gzo
         Cl26Ufo+NN82QER8MJ2MKnUlPL0Ia6HPGhgjOXd4dFb7M88uIQHCTzY0qK0NwLeujCg6
         WAUWKRcDK9BCbKgYnEWq9SQ2r7LOqmpGdcZ8U6NzFUURs87l7QhQMnvwMdWHyNJ+bvGF
         Xf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=9tlNaJmQImxCGEgovGBvlohY/2u1zXVnsturf7rUYM0=;
        b=kaKHNqPB+wPP0/nmR9wsOCQ6Mgs5M3VWVDLFnrpLpOl6MdZqmH4izDa2fvnWN/zVpd
         Xhkp7uG/mc3PchoL5+pihqQtPSSMSQaigmyfj8WHnxhrKD4TGB8OJAjFVLVYcaJfpWJh
         2cccVk7j/Z9GjXwKKkciJ69Z7TOkyGKAgAWF3i93sVNF/LTpDk0HTicQRHnJYJwX4zpJ
         7UNuuPwCui3KLpdIhewiKenEcgdE9fTZsZQFmME6IVN+zW0u4HdhfksBPCkq7C6LUMCN
         LBa3U+qcwXuduTERM7HWh+HUNbu2ZfgRvRYDn2HAndZh4iABls0LG+GEiLGa2JKbuhDi
         6t/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.187 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.187 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	David Airlie <airlied@linux.ie>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [4.9-stable 2/9] drm/i915: hide unused intel_panel_set_backlight function
Date: Mon, 19 Feb 2018 11:13:21 +0100
Message-Id: <20180219101343.2922561-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180219101343.2922561-1-arnd@arndb.de>
References: <20180219101343.2922561-1-arnd@arndb.de>
X-Provags-ID: V03:K0:syI17ig/669v7CKzy4JLez8SJzddAwYBFjG3JNgvz/oGUinw0Be
 jMduc6xQvGZcXf5FlO/Az9fuwDT0Z9pjz2hm+coBNStTvRmpHTLaf3WD6BuAVLp360ALxwS
 EwY6KsAqynyE38Y7GFHA4/+OxlQ9+LDLx8ownuXIcSSnJfUxyFPfjTjj5y3ckQmc9su3kQh
 lIUYFGIkMGVpW9+Aq1uPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XHnaQBslcDM=:bGKL52b3bWGd8VrG42bwGR
 BPodTtPPRufGNi8aVVZ9plBLLVfZNmjPdbUX57vD/JgF2kkLl6gWTA4to+ymI7U+phwKtUrid
 mRVCN6bMUXVtaxQHJGTSfaoa0QV5r8+gqo94uv989I2mhbQstXVHzsHKnX3oklXfbkMykTB5+
 7Lb7wMUW0D9XRO//UJGMkLSR9Eu7bUyWAw9TMDOj262DxmzF6poNAhHHdf4HlqsqC5BJOigKW
 2/JXhO9EUCNuY9K2nPWGZ/4whsUKdUs3yuby/l6wyFFYRvk/HiWuZWuBugKeUpMCAGKXQzvaP
 oyAaYZtjDs8Cd+SZTeGGFFPqguEDVHHPYCqwlENjFGa9NEZ8mjq0j44CJXw5O7gj6LvfXShVg
 fvUgkOQmPfxEecA1yDxGfmJRgwZ5VMin5NzIeakd7Aq56JmFCrXZfkRIJ9XWtAGSYpOycJDfj
 0R/RvFL8aSeNBZ7p76qzlAjEYYlTZk/yoGUhAxAkcyItCg25pHMTBZDV1I940+XxO+3lcoXVy
 sqObtMuHRPw1TGtJyVgTz2gLBZ1zbjdXwb1mtqSv4n1VKx8sz3yeLvgtSOeszIBmF28Qy0ZdJ
 uoEHicz95JKriYltgVueNobjHWceMpb49SKBgRNk6WxWqpZOqwxYor+ZQ2HxgP/g+6tVDCFit
 yBZgqLMVke9Un5JIQip56UnSv9UanVciBRTrwtEA/QFL5mlTm+X4xgN5A9eLQkQVH76aKvbFk
 AWN+WHKIETP1igsczYCU3Y+svOX2rQ9K1MnYag==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592823919494046757?=
X-GMAIL-MSGID: =?utf-8?q?1592823919494046757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit fd94d53e55bd487368dfee9f1af24da78b2bb582 upstream.

Building i915 without backlight support results in a harmless warning
for intel_panel_set_backlight:

drivers/gpu/drm/i915/intel_panel.c:653:13: error: 'intel_panel_set_backlight' defined but not used [-Werror=unused-function]

This moves it into the CONFIG_BACKLIGHT_CLASS_DEVICE section that
its caller is in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20171127151239.1813673-2-arnd@arndb.de
[arnd: manually rebased to 4.9]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/i915/intel_panel.c | 86 +++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/intel_panel.c
index be4b4d546fd9..1cb1b01e4471 100644
--- a/drivers/gpu/drm/i915/intel_panel.c
+++ b/drivers/gpu/drm/i915/intel_panel.c
@@ -544,25 +544,6 @@ static u32 pwm_get_backlight(struct intel_connector *connector)
 	return DIV_ROUND_UP(duty_ns * 100, CRC_PMIC_PWM_PERIOD_NS);
 }
 
-static u32 intel_panel_get_backlight(struct intel_connector *connector)
-{
-	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
-	struct intel_panel *panel = &connector->panel;
-	u32 val = 0;
-
-	mutex_lock(&dev_priv->backlight_lock);
-
-	if (panel->backlight.enabled) {
-		val = panel->backlight.get(connector);
-		val = intel_panel_compute_brightness(connector, val);
-	}
-
-	mutex_unlock(&dev_priv->backlight_lock);
-
-	DRM_DEBUG_DRIVER("get backlight PWM = %d\n", val);
-	return val;
-}
-
 static void lpt_set_backlight(struct intel_connector *connector, u32 level)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
@@ -646,30 +627,6 @@ intel_panel_actually_set_backlight(struct intel_connector *connector, u32 level)
 	panel->backlight.set(connector, level);
 }
 
-/* set backlight brightness to level in range [0..max], scaling wrt hw min */
-static void intel_panel_set_backlight(struct intel_connector *connector,
-				      u32 user_level, u32 user_max)
-{
-	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
-	struct intel_panel *panel = &connector->panel;
-	u32 hw_level;
-
-	if (!panel->backlight.present)
-		return;
-
-	mutex_lock(&dev_priv->backlight_lock);
-
-	WARN_ON(panel->backlight.max == 0);
-
-	hw_level = scale_user_to_hw(connector, user_level, user_max);
-	panel->backlight.level = hw_level;
-
-	if (panel->backlight.enabled)
-		intel_panel_actually_set_backlight(connector, hw_level);
-
-	mutex_unlock(&dev_priv->backlight_lock);
-}
-
 /* set backlight brightness to level in range [0..max], assuming hw min is
  * respected.
  */
@@ -1122,6 +1079,49 @@ void intel_panel_enable_backlight(struct intel_connector *connector)
 }
 
 #if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
+static u32 intel_panel_get_backlight(struct intel_connector *connector)
+{
+	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
+	struct intel_panel *panel = &connector->panel;
+	u32 val = 0;
+
+	mutex_lock(&dev_priv->backlight_lock);
+
+	if (panel->backlight.enabled) {
+		val = panel->backlight.get(connector);
+		val = intel_panel_compute_brightness(connector, val);
+	}
+
+	mutex_unlock(&dev_priv->backlight_lock);
+
+	DRM_DEBUG_DRIVER("get backlight PWM = %d\n", val);
+	return val;
+}
+
+/* set backlight brightness to level in range [0..max], scaling wrt hw min */
+static void intel_panel_set_backlight(struct intel_connector *connector,
+				      u32 user_level, u32 user_max)
+{
+	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
+	struct intel_panel *panel = &connector->panel;
+	u32 hw_level;
+
+	if (!panel->backlight.present)
+		return;
+
+	mutex_lock(&dev_priv->backlight_lock);
+
+	WARN_ON(panel->backlight.max == 0);
+
+	hw_level = scale_user_to_hw(connector, user_level, user_max);
+	panel->backlight.level = hw_level;
+
+	if (panel->backlight.enabled)
+		intel_panel_actually_set_backlight(connector, hw_level);
+
+	mutex_unlock(&dev_priv->backlight_lock);
+}
+
 static int intel_backlight_device_update_status(struct backlight_device *bd)
 {
 	struct intel_connector *connector = bl_get_data(bd);
-- 
2.9.0
