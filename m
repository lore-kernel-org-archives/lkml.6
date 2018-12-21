Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE2CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FBC218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kQ2Kf1DA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390078AbeLURXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:23:09 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:58620 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLURXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:23:09 -0500
Received: by mail-it1-f202.google.com with SMTP id p21so5651410itb.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VSW+tLPB26ac+EjuDmMVtQ+PpN5jnpKDYZiSTsubMYI=;
        b=kQ2Kf1DALnxK+MigKJQF44FE6BmFXCn7Ipo5ERYyvgGQAW89sscN1iZ6cCA18Lycx0
         +hNbrBYRCb4Yij1I5NW0c26rRsJi3m6sPPA7ZTSWa/ovh3Gb0jh9UAY7xZF2aPP0alNQ
         HO/VwbzqD/vDX5xox6Wsn9idCxTbp9eVzGu5NWECG1bYA3guh7/eoAFxI9o4tY63CFLN
         F0cXXE/Q1wyKUY5UeUaUzYg17pPhovi2SiI8QwXFCZ0S3OBdnYaAvwhByyyGc4ECsIbd
         gT5Y298ZKCBhnp1n471RePSIdIEzAnuO05eZ78JVlD1jaly7WGI4LSpb7g7qJrBHZWh3
         pP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VSW+tLPB26ac+EjuDmMVtQ+PpN5jnpKDYZiSTsubMYI=;
        b=JzPwPkshiwjU7IANQ9cSVu37M2KKcpm3vtdx8bfOMCDrlqg9lfV3dvDxy8IabcXOTb
         dQwV8vfyuwUn4anWreI4EzcPb298xgJsB2FaY4p+YmIiggareuo5eot3ZZhkGEKFgZVQ
         uvwR2aoZcUB99ZCMvb+efhO14yHHNmfikZTcW+zVbrOkzsp9MEAGbwzkUWPyJknXtOzT
         0bRJTCmB49URvfGExuwNEBAlgSDqdCUIhvmfwJMYeOxhITLj1wpZGkBNk6gmu+rAJJqF
         zCqioHdVokRBC0mlQZG6e3Xs1zfEhDzzhL/M6/FGjIYpKvnECBgcDFsuyUNuqwvAThe+
         EMog==
X-Gm-Message-State: AA+aEWZH5Ql9DR7dFPsgqrSiUN1CeAFJaSpZ7bRpVH1MFJCXgb4bhcP6
        jCH1dhIL1F+aGtp6uaTCyiSURg9lkq9Eh70N77E3G2YLRIJYuIF/x82eiDZIG/IGHxmtpg3dKgi
        bdYk364RMfqe80ZP4/sYrNkRXXXpE6kH5OAe9COfKYPYHFYW8Bfc9jcPAzE2EmAvtjfkjD1LK
X-Google-Smtp-Source: ALg8bN5phf5oadQdE2J0V2jNeGFaGHWwAzZFDiGnmveuhNlR+zdIvPCqPhZCwBCup0UuOkVGOXrtFC+1qWpR
X-Received: by 2002:a24:1f0f:: with SMTP id d15mr2525062itd.31.1545412988207;
 Fri, 21 Dec 2018 09:23:08 -0800 (PST)
Date:   Fri, 21 Dec 2018 10:23:05 -0700
Message-Id: <20181221172305.195943-1-zwisler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH] drm/i915/psr: simplify enable_psr handling
From:   Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jon Flatley <jflat@google.com>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit:

commit 2bdd045e3a30 ("drm/i915/psr: Check if VBT says PSR can be enabled.")

added some code with no usable functionality.  Regardless of how the psr
default is set up in the BDB_DRIVER_FEATURES section, if the enable_psr
module parameter isn't specified it defaults to 0.

Remove this dead code, simplify the way that enable_psr is handled and
update the module parameter string to match the actual functionality.

Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 drivers/gpu/drm/i915/i915_drv.h    | 1 -
 drivers/gpu/drm/i915/i915_params.c | 4 +---
 drivers/gpu/drm/i915/i915_params.h | 2 +-
 drivers/gpu/drm/i915/intel_bios.c  | 1 -
 drivers/gpu/drm/i915/intel_psr.c   | 7 -------
 5 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 872a2e159a5f9..b4c50ba0b22a6 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1115,7 +1115,6 @@ struct intel_vbt_data {
 	} edp;
 
 	struct {
-		bool enable;
 		bool full_link;
 		bool require_aux_wakeup;
 		int idle_frames;
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 295e981e4a398..80ce8758c3c69 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -87,9 +87,7 @@ i915_param_named_unsafe(enable_ppgtt, int, 0400,
 	"(-1=auto [default], 0=disabled, 1=aliasing, 2=full, 3=full with extended address space)");
 
 i915_param_named_unsafe(enable_psr, int, 0600,
-	"Enable PSR "
-	"(0=disabled, 1=enabled) "
-	"Default: -1 (use per-chip default)");
+	"Enable PSR (default: false)");
 
 i915_param_named_unsafe(alpha_support, bool, 0400,
 	"Enable alpha quality driver support for latest hardware. "
diff --git a/drivers/gpu/drm/i915/i915_params.h b/drivers/gpu/drm/i915/i915_params.h
index 6c4d4a21474b5..144572f17a83d 100644
--- a/drivers/gpu/drm/i915/i915_params.h
+++ b/drivers/gpu/drm/i915/i915_params.h
@@ -42,7 +42,7 @@ struct drm_printer;
 	param(int, enable_dc, -1) \
 	param(int, enable_fbc, -1) \
 	param(int, enable_ppgtt, -1) \
-	param(int, enable_psr, -1) \
+	param(int, enable_psr, 0) \
 	param(int, disable_power_well, -1) \
 	param(int, enable_ips, 1) \
 	param(int, invert_brightness, 0) \
diff --git a/drivers/gpu/drm/i915/intel_bios.c b/drivers/gpu/drm/i915/intel_bios.c
index 1faa494e2bc91..d676d483d5cf1 100644
--- a/drivers/gpu/drm/i915/intel_bios.c
+++ b/drivers/gpu/drm/i915/intel_bios.c
@@ -551,7 +551,6 @@ parse_driver_features(struct drm_i915_private *dev_priv,
 	 */
 	if (!driver->drrs_enabled)
 		dev_priv->vbt.drrs_type = DRRS_NOT_SUPPORTED;
-	dev_priv->vbt.psr.enable = driver->psr_enabled;
 }
 
 static void
diff --git a/drivers/gpu/drm/i915/intel_psr.c b/drivers/gpu/drm/i915/intel_psr.c
index b6838b525502e..26e7eb318cf07 100644
--- a/drivers/gpu/drm/i915/intel_psr.c
+++ b/drivers/gpu/drm/i915/intel_psr.c
@@ -1065,13 +1065,6 @@ void intel_psr_init(struct drm_i915_private *dev_priv)
 	if (!dev_priv->psr.sink_support)
 		return;
 
-	if (i915_modparams.enable_psr == -1) {
-		i915_modparams.enable_psr = dev_priv->vbt.psr.enable;
-
-		/* Per platform default: all disabled. */
-		i915_modparams.enable_psr = 0;
-	}
-
 	/* Set link_standby x link_off defaults */
 	if (IS_HASWELL(dev_priv) || IS_BROADWELL(dev_priv))
 		/* HSW and BDW require workarounds that we don't implement. */
-- 
2.20.1.415.g653613c723-goog

