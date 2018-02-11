Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325074-2-13363744343471129222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325073; b=Gbbr3/0bg0BCxS1nLofUTfLMutxO9d1LTVokwA2faosWcon
    w6BDLO0I7TepdNZdkLyKv+VZRlLym3Jw9rFGM16ON3ynIOqcG+Ul5d9xN5ReiIbM
    JVzIxNH48LGsLsvf1HQjFJYUE7tjVuqOfqxP0orY7Bm5O1+br1f2fkv1CKIdx1ox
    Av3hHWUAo1SAMOOTqoatJ7374FSGWng4m0mdU3mYBrSFF3OYRoXKi8pzsDJywmIM
    AIXxbRmbiifNPtLWJZxAXD7V9a5OXOIt5X6KhAmQ4e97G6xoKpJ53uj3vkRq/8+V
    r0bUrjcYgFEfu+B3lJWCXW3nsGWwY16K0WsHbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325073; bh=JDbJW245DmgWzmxtJ+U
    OFtIWD7Jhw2uVCT6AXMnrwUg=; b=sLjyFAGkAt7FDFoBQzx0wiqvRuuTS5QasoD
    O2NMXEIMuLCWuZOKd2tDNo7oWr1F632HEkjxryk5gtRgsuZ3qSS9ZXsghxX0wO9t
    xPC/YZZJISr8Vyk8hXLcBSrm22SFLSnhDbvHQgI2RoUH0jU/eLJX76c5cMwa53RZ
    HLbrgiPQ7hChhGdwA1WeesjRbY45NdZdQTIk794p1CkAOnePI4uKVc7Q3FrDRzHP
    XQBoARtos9vcw4nX6XdLB7QUW6PYrkmHxqj2FOJt9aZ//i3+k2VlL/5EWwUIEoy3
    x8YgXEDj40EVrjBSgYbLXIf5no//9UHug2mDtTveSwOQ+/5Xcig==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbeBKEz5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:55:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41719 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752801AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?="
        <ville.syrjala@linux.intel.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Chris Wilson" <chris@chris-wilson.co.uk>,
        dri-devel@lists.freedesktop.org,
        "Rob Kramer" <rob@solution-space.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.618166626@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 013/136] drm/i915: Read timings from the correct
 transcoder in intel_crtc_mode_get()
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit e30a154b5262b967b133b06ac40777e651045898 upstream.

intel_crtc->config->cpu_transcoder isn't yet filled out when
intel_crtc_mode_get() gets called during output probing, so we should
not use it there. Instead intel_crtc_mode_get() figures out the correct
transcoder on its own, and that's what we should use.

If the BIOS boots LVDS on pipe B, intel_crtc_mode_get() would actually
end up reading the timings from pipe A instead (since PIPE_A==0),
which clearly isn't what we want.

It looks to me like this may have been broken by
commit eccb140bca67 ("drm/i915: hw state readout&check support for cpu_transcoder")
as that one removed the early initialization of cpu_transcoder from
intel_crtc_init().

Cc: dri-devel@lists.freedesktop.org
Cc: Rob Kramer <rob@solution-space.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reported-by: Rob Kramer <rob@solution-space.com>
Fixes: eccb140bca67 ("drm/i915: hw state readout&check support for cpu_transcoder")
References: https://lists.freedesktop.org/archives/dri-devel/2016-April/104142.html
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/1459525046-19425-1-git-send-email-ville.syrjala@linux.intel.com
[bwh: Backported to 3.16: pipe_config is a struct not a pointer]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/intel_display.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -8662,13 +8662,10 @@ struct drm_display_mode *intel_crtc_mode
 {
 	struct drm_i915_private *dev_priv = dev->dev_private;
 	struct intel_crtc *intel_crtc = to_intel_crtc(crtc);
-	enum transcoder cpu_transcoder = intel_crtc->config.cpu_transcoder;
+	enum transcoder cpu_transcoder;
 	struct drm_display_mode *mode;
 	struct intel_crtc_config pipe_config;
-	int htot = I915_READ(HTOTAL(cpu_transcoder));
-	int hsync = I915_READ(HSYNC(cpu_transcoder));
-	int vtot = I915_READ(VTOTAL(cpu_transcoder));
-	int vsync = I915_READ(VSYNC(cpu_transcoder));
+	u32 htot, hsync, vtot, vsync;
 	enum pipe pipe = intel_crtc->pipe;
 
 	mode = kzalloc(sizeof(*mode), GFP_KERNEL);
@@ -8690,6 +8687,13 @@ struct drm_display_mode *intel_crtc_mode
 	i9xx_crtc_clock_get(intel_crtc, &pipe_config);
 
 	mode->clock = pipe_config.port_clock / pipe_config.pixel_multiplier;
+
+	cpu_transcoder = pipe_config.cpu_transcoder;
+	htot = I915_READ(HTOTAL(cpu_transcoder));
+	hsync = I915_READ(HSYNC(cpu_transcoder));
+	vtot = I915_READ(VTOTAL(cpu_transcoder));
+	vsync = I915_READ(VSYNC(cpu_transcoder));
+
 	mode->hdisplay = (htot & 0xffff) + 1;
 	mode->htotal = ((htot & 0xffff0000) >> 16) + 1;
 	mode->hsync_start = (hsync & 0xffff) + 1;
