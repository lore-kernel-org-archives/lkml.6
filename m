Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415091-2-5817774586430256724
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415090; b=l1jCXxhqKzzwQtEpT8S+29mS0bu08wJFdu5Al7r56qHzlGY
    S9LwohXxJMwZsr3oCiP0wrDT3i6CS7vPfkHr4Ay/H5VYOEM0dM+5HzhcqHQ16sBc
    iucOTVX3nDHm1VWcjXSehUNpcVPrI11JC9PvMiYGji0p4DI6zOmE20q2otkzNYqc
    I8n+rA2pSo7Q9h7H43TiwtfOtsezQDzib+saTJujj6xIKK+se7iJtSHAS9Tybk97
    ex9QE/tL2iCa1Uno65w0uXR+lW63mb/N2wRggr1aj5svSaR6Er5twaCcy9PKvwM9
    kDgA7z9bh8OHwY9fDBwoYfzdpl/0+u86mDJFzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415090; bh=bVDqvbewGWhETiK9GARdH1+nxu
    f2451qyiXfdpCGy04=; b=nncdKuCarRoi3Y1dX54bqYDaVTdzQKe3/lvrGQVNy6
    bLCe5QkSBEKkhZMq0EvHosxznbHyv/NdJlfrwU2mCZsoY2pQ8SZDVtqEO+S8Lbde
    +A0EuhalFQ/src7D5scZSxvAgaaLjxOtH8TRUpbZqh0EYH817g6Pu/yLdrpPs+A/
    B6NZNOrojzQkIUiJa6oAsQ+VGUoVusU7666gQOeIjk+OVqx+u8MpygPM7wpOe4Ir
    49Cgis2kUaEw+RkdIYeO/wgtHbPgQT/d3WV2qpc5OlFijjZ5DbqGhWcmiACrD0qL
    v82k8fqnDuWz7dYo1/ST8yckeor57eVwstrZtKdR8i3g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754871AbeBWToc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:44:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934356AbeBWSsU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:48:20 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.9 134/145] drm/i915: hide unused intel_panel_set_backlight function
Date: Fri, 23 Feb 2018 19:27:20 +0100
Message-Id: <20180223170742.096376139@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/intel_panel.c |   86 ++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

--- a/drivers/gpu/drm/i915/intel_panel.c
+++ b/drivers/gpu/drm/i915/intel_panel.c
@@ -544,25 +544,6 @@ static u32 pwm_get_backlight(struct inte
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
@@ -646,30 +627,6 @@ intel_panel_actually_set_backlight(struc
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
@@ -1122,6 +1079,49 @@ void intel_panel_enable_backlight(struct
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
