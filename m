Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4607ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF74214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="weV0aE0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF74214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbeISRHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:07:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35671 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbeISRHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:07:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2-v6so2543995plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 04:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uHErZwZRianEsjMA4CKWP9i7/BVOT+GBXD0SqIEUjfc=;
        b=weV0aE0PDEDRy/PcMlLMyAPU8O4yAadItZ16jc/kAzLCLh4YBPYTt8/bFAsphL3jQH
         t2PFQlRFf4wv7KVSMTkvvaGyyU4UEwSuzSzDQa5Xyyk3cBFY+WoANa64qHRSkrWWFejk
         cuSnqffLyb0gSaG+Qgj/8GfmaxqL40XuqCjntrJCuWqeTUaBGJHxVKqcWjR3mhP57WzA
         9z4A++PS52aT8rntIuqHBYZNOngHD1bqr40bhmF8Ct2vy8aTuzTNQBlLcwONiUgekxqZ
         743KOkejT6tKjWkepS4sA16NJVUxxuMNpgvZvg1BLNuTidDvHDQO9pDi/dncZa1a2GxX
         oJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uHErZwZRianEsjMA4CKWP9i7/BVOT+GBXD0SqIEUjfc=;
        b=OC9zLWjHzCwLogQdux//yYAcPPsST44ZjhG+gdLeGu7Gj36dK/2L6yU++X6MaqW/ZO
         XVByx26CTfMGSUkAYjQyhui2KdyYEGSBaKvar2uh/Qet6FsaxTvU/R0acebarXvmGZ32
         FSJiCk4JP2pTTirl9+5JwveGIElP9IZMoWD2YVzprMHEq3v5eOJrioTxathOU8VSAizu
         7PAaoPNheJJfVNbhUUtVO62jgpqjZDDyb0KbzhD10uerlED0otr94PdzkkbWQ74hT3XX
         Fwc3E3/5uyduqRK5QIp4wcDAWEYR5xsr2FW8KVfKoXHC2o4lkE9Yza7KJYFiS6sgAszK
         MNZg==
X-Gm-Message-State: APzg51DOLxAVLmWPf/5G3zF0iCg0vYrGABhLqPBJ/yIrwLYFC30PnD1Z
        bXiQv7rTEDuAiHKvq/1GRp/WJA==
X-Google-Smtp-Source: ANB0VdbUTQ4Lj6tVJZPycE+8Rw41RxLOWx6J6OQnfz9KDMQrHpzBHao34NSizeQ9z+z+XVngwBBO4g==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3-v6mr34104820plb.80.1537356605690;
        Wed, 19 Sep 2018 04:30:05 -0700 (PDT)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id g7-v6sm27386862pfi.175.2018.09.19.04.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 04:30:04 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     jani.nikula@intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Chris Chiu <chiu@endlessm.com>
Subject: [PATCH] drm/i915: re-check the hotplug with a delayed work
Date:   Wed, 19 Sep 2018 19:29:33 +0800
Message-Id: <20180919112933.47382-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have few ASUS laptops, X705FD(Intel i7-8565), X560UD(Intel i5-8250U)
and X530UN(Intel i7-8550U) share the same problem. The HDMI connector
status stays 'connected' even the HDMI cable has been unplugged.
Then the status in sysfs would never change since then until we
do 'xrandr' to reprobe the devices. It would also cause the audio
output path cannot correctly swicth based on the connector status.

This commit kicks off a delayed work when the status remains unchanged
in the first hotplug event handling, which may not be the perfect
timing in some special cases.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/gpu/drm/i915/i915_drv.h      |  1 +
 drivers/gpu/drm/i915/intel_hotplug.c | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index d51d8574a679..78e2cf09cc10 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -286,6 +286,7 @@ struct i915_hotplug {
 	} stats[HPD_NUM_PINS];
 	u32 event_bits;
 	struct delayed_work reenable_work;
+	struct delayed_work recheck_work;
 
 	struct intel_digital_port *irq_port[I915_MAX_PORTS];
 	u32 long_port_mask;
diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
index 43aa92beff2a..089a24588ec8 100644
--- a/drivers/gpu/drm/i915/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/intel_hotplug.c
@@ -349,14 +349,15 @@ static void i915_digport_work_func(struct work_struct *work)
 	}
 }
 
+#define HPD_RECHECK_DELAY        (2 * 1000)
+
 /*
  * Handle hotplug events outside the interrupt handler proper.
  */
-static void i915_hotplug_work_func(struct work_struct *work)
+static void do_i915_hotplug_check(struct work_struct *work,
+				   struct drm_i915_private *dev_priv,
+				   struct drm_device *dev, bool do_recheck)
 {
-	struct drm_i915_private *dev_priv =
-		container_of(work, struct drm_i915_private, hotplug.hotplug_work);
-	struct drm_device *dev = &dev_priv->drm;
 	struct intel_connector *intel_connector;
 	struct intel_encoder *intel_encoder;
 	struct drm_connector *connector;
@@ -396,8 +397,31 @@ static void i915_hotplug_work_func(struct work_struct *work)
 
 	if (changed)
 		drm_kms_helper_hotplug_event(dev);
+	else if (do_recheck) {
+		spin_lock_irq(&dev_priv->irq_lock);
+		dev_priv->hotplug.event_bits |= hpd_event_bits;
+		spin_unlock_irq(&dev_priv->irq_lock);
+		schedule_delayed_work(&dev_priv->hotplug.recheck_work, msecs_to_jiffies(HPD_RECHECK_DELAY));
+	}
 }
 
+static void i915_hotplug_work_func(struct work_struct *work)
+{
+	struct drm_i915_private *dev_priv =
+		container_of(work, struct drm_i915_private, hotplug.hotplug_work);
+	struct drm_device *dev = &dev_priv->drm;
+
+	do_i915_hotplug_check(work, dev_priv, dev, true);
+}
+
+static void i915_hotplug_recheck_func(struct work_struct *work)
+{
+	struct drm_i915_private *dev_priv =
+		container_of(work, struct drm_i915_private, hotplug.recheck_work.work);
+	struct drm_device *dev = &dev_priv->drm;
+
+	do_i915_hotplug_check(work, dev_priv, dev, false);
+}
 
 /**
  * intel_hpd_irq_handler - main hotplug irq handler
@@ -619,6 +643,8 @@ void intel_hpd_init_work(struct drm_i915_private *dev_priv)
 	INIT_WORK(&dev_priv->hotplug.poll_init_work, i915_hpd_poll_init_work);
 	INIT_DELAYED_WORK(&dev_priv->hotplug.reenable_work,
 			  intel_hpd_irq_storm_reenable_work);
+	INIT_DELAYED_WORK(&dev_priv->hotplug.recheck_work,
+			  i915_hotplug_recheck_func);
 }
 
 void intel_hpd_cancel_work(struct drm_i915_private *dev_priv)
@@ -635,6 +661,7 @@ void intel_hpd_cancel_work(struct drm_i915_private *dev_priv)
 	cancel_work_sync(&dev_priv->hotplug.hotplug_work);
 	cancel_work_sync(&dev_priv->hotplug.poll_init_work);
 	cancel_delayed_work_sync(&dev_priv->hotplug.reenable_work);
+	cancel_delayed_work_sync(&dev_priv->hotplug.recheck_work);
 }
 
 bool intel_hpd_disable(struct drm_i915_private *dev_priv, enum hpd_pin pin)
-- 
2.11.0

