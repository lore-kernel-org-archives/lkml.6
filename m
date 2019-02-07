Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F39BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D656E21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ho/8mP4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfBGX2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:28:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42413 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfBGX2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:28:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id r15so1297601eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 15:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szaf2uJAgssLbFJ9fk1DVjNOf7TVO+Qt3SlgBscvgUg=;
        b=ho/8mP4oD9JLLci6xgsOGv2oUuUmPvlygcrW6DeXjX3C4OaeAajoMYwiJL3HrNxLP9
         39WY2P0kcnKll+1Cn87DTr1b8b3o5GMrPRbsaqpqCJw6L3yoFZC4eIVgwGPoJrhekUqN
         Peu4i5tkC9p39G7L71X+Fh4l4NuOOydX56e/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szaf2uJAgssLbFJ9fk1DVjNOf7TVO+Qt3SlgBscvgUg=;
        b=CF97TK9n3yEKIVq7nUyWfqrK3jlO0y9sNan8fRdEGy+Su1akkQD+lxtQqtAkNdhI23
         5JtihGiQUybF7cFx+K52XwiG6mMrRBLRDveAMutl4UNp31Y7ZGhM/bdXbesajE1ynV0g
         JGte7kOeJ2ytqAy3sQlkFPFceIkYdS9ir2Kx/lZPdWIaUGD4xhii3rx7JGKu/JoViDUr
         EzwFiRU1bNUL5NrZBWRwJnYy6Yqbtn+LUH5bRd76wNeFXKtinMpvS0jbKMIzpDkHx59I
         gnnjKNrBIxCY/v6Qg7KDYwe8fIiLH1a8mRv26cmqJ1qWXW8Tv+ajap5LgfVuFQ6A5wWw
         E39Q==
X-Gm-Message-State: AHQUAuYF4CMDwIUFZmBy0GriUU32G0hLwzTdGiVz2cKoyv467VwwZggA
        4TYViC4GMFnoSOG5gnqIq1SQgw==
X-Google-Smtp-Source: AHgI3IYXAgN503ZSxMKhuvwqHplhBH92DvldEdTJCAXrcl5Wz1z92qKLqs6GOiGYsOON9UOGV8Lkbw==
X-Received: by 2002:aa7:d41a:: with SMTP id z26mr4962957edq.224.1549582089990;
        Thu, 07 Feb 2019 15:28:09 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p7sm145079ejb.15.2019.02.07.15.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 15:28:09 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Takashi Iwai <tiwai@suse.de>,
        Ramalingam C <ramalinagm.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH 4/4] i915/snd_hdac: I915 subcomponent for the snd_hdac
Date:   Fri,  8 Feb 2019 00:27:59 +0100
Message-Id: <20190207232759.14553-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207232759.14553-1-daniel.vetter@ffwll.ch>
References: <20190207232759.14553-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we need multiple components for I915 for different purposes
(Audio & Mei_hdcp), we adopt the subcomponents methodology introduced
by the previous patch (mentioned below).

	Author: Daniel Vetter <daniel.vetter@ffwll.ch>
	Date:   Mon Jan 28 17:08:20 2019 +0530

	    components: multiple components for a device

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by-by: Ramalingam C <ramalinagm.c@intel.com> (commit message)
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch> (code)
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Russell King <rmk+kernel@arm.linux.org.uk>
cc: Rafael J. Wysocki <rafael@kernel.org>
cc: Jaroslav Kysela <perex@perex.cz>
cc: Takashi Iwai <tiwai@suse.com>
cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
cc: Jani Nikula <jani.nikula@linux.intel.com>
---
 drivers/gpu/drm/i915/intel_audio.c | 4 +++-
 include/drm/i915_component.h       | 4 ++++
 include/sound/hda_component.h      | 5 +++--
 sound/hda/hdac_component.c         | 4 ++--
 sound/hda/hdac_i915.c              | 6 ++++--
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index de26cd0a5497..5104c6bbd66f 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -984,7 +984,9 @@ void i915_audio_component_init(struct drm_i915_private *dev_priv)
 {
 	int ret;
 
-	ret = component_add(dev_priv->drm.dev, &i915_audio_component_bind_ops);
+	ret = component_add_typed(dev_priv->drm.dev,
+				  &i915_audio_component_bind_ops,
+				  I915_COMPONENT_AUDIO);
 	if (ret < 0) {
 		DRM_ERROR("failed to add audio component (%d)\n", ret);
 		/* continue with reduced functionality */
diff --git a/include/drm/i915_component.h b/include/drm/i915_component.h
index fca22d463e1b..72fbb037f9b3 100644
--- a/include/drm/i915_component.h
+++ b/include/drm/i915_component.h
@@ -26,6 +26,10 @@
 
 #include "drm_audio_component.h"
 
+enum i915_component_type {
+	I915_COMPONENT_AUDIO = 1,
+};
+
 /* MAX_PORT is the number of port
  * It must be sync with I915_MAX_PORTS defined i915_drv.h
  */
diff --git a/include/sound/hda_component.h b/include/sound/hda_component.h
index 2ec31b358950..d4804c72d959 100644
--- a/include/sound/hda_component.h
+++ b/include/sound/hda_component.h
@@ -20,7 +20,7 @@ int snd_hdac_acomp_get_eld(struct hdac_device *codec, hda_nid_t nid, int dev_id,
 			   bool *audio_enabled, char *buffer, int max_bytes);
 int snd_hdac_acomp_init(struct hdac_bus *bus,
 			const struct drm_audio_component_audio_ops *aops,
-			int (*match_master)(struct device *, void *),
+			int (*match_master)(struct device *, int, void *),
 			size_t extra_size);
 int snd_hdac_acomp_exit(struct hdac_bus *bus);
 int snd_hdac_acomp_register_notifier(struct hdac_bus *bus,
@@ -47,7 +47,8 @@ static inline int snd_hdac_acomp_get_eld(struct hdac_device *codec, hda_nid_t ni
 }
 static inline int snd_hdac_acomp_init(struct hdac_bus *bus,
 				      const struct drm_audio_component_audio_ops *aops,
-				      int (*match_master)(struct device *, void *),
+				      int (*match_master)(struct device *,
+							  int, void *),
 				      size_t extra_size)
 {
 	return -ENODEV;
diff --git a/sound/hda/hdac_component.c b/sound/hda/hdac_component.c
index a6d37b9d6413..5c95933e739a 100644
--- a/sound/hda/hdac_component.c
+++ b/sound/hda/hdac_component.c
@@ -269,7 +269,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_acomp_register_notifier);
  */
 int snd_hdac_acomp_init(struct hdac_bus *bus,
 			const struct drm_audio_component_audio_ops *aops,
-			int (*match_master)(struct device *, void *),
+			int (*match_master)(struct device *, int, void *),
 			size_t extra_size)
 {
 	struct component_match *match = NULL;
@@ -288,7 +288,7 @@ int snd_hdac_acomp_init(struct hdac_bus *bus,
 	bus->audio_component = acomp;
 	devres_add(dev, acomp);
 
-	component_match_add(dev, &match, match_master, bus);
+	component_match_add_typed(dev, &match, match_master, bus);
 	ret = component_master_add_with_match(dev, &hdac_component_master_ops,
 					      match);
 	if (ret < 0)
diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 617ff1aa818f..7aee090e3d27 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -82,9 +82,11 @@ void snd_hdac_i915_set_bclk(struct hdac_bus *bus)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_i915_set_bclk);
 
-static int i915_component_master_match(struct device *dev, void *data)
+static int i915_component_master_match(struct device *dev, int subcomponent,
+				       void *data)
 {
-	return !strcmp(dev->driver->name, "i915");
+	return !strcmp(dev->driver->name, "i915") &&
+	       subcomponent == I915_COMPONENT_AUDIO;
 }
 
 /* check whether intel graphics is present */
-- 
2.20.1

