Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F64C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687A120874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM6KEgEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbeLSV2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:28:24 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39351 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbeLSV2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:28:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id q70so12590594qkh.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 13:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hep8fWC7PXeGKqq4nDejgH8vpvSUZlLt51OOLamFztU=;
        b=ZM6KEgExp6lvEJTyOqDbr7Wzi7fMnpp+gikdyCQMODVHGFkwnCBZKBJX8aFWoLdLpv
         uiXBPftF5ZmiPyCUvTU6mnE3i/gTGH9O0Hsa+97Buw0gKIuO5XeAMHrw87OCsgKia4Tz
         Dgpe0JZ/PRTBws89cMumoTt+q/+d+DbH+KTuajOmk4FNVH/8T8EtSqqcG3x8MyCbeeXY
         nAGKoYwsgsxcIWfYDHz4yI5HfFtJSL63ehwMrO90If5eEJwa3IHYSQdUsPY7Pl2xqI17
         OFVclG4gvIi21daZtv1fCtS70/PRNCVk5GVpXAd8rs3oZf3B4zhE/JiLuIERR2A6lGek
         EfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hep8fWC7PXeGKqq4nDejgH8vpvSUZlLt51OOLamFztU=;
        b=fsY74rHskq6xLcTtVvH1NXuBpelEHIPYtvUxfKl2KsuFfD71WO75SW7FoI6wMiNiwI
         kkOEt9a5z97u9L1Mgw9kEe5IwKzST6B+arLeQWWNMYUGhJ0Buw2Ht4g7zWe+mBj7TCrb
         KKFFxFhqlgjBOa6oogoA9tB6Anu/ZNGlUpkACfxxQYHdAsU/hrcqhIR5vbkYteTrW3/t
         oLk9O653tPKsKPPcsFTe4ZzWJ0A17ICW0MNFa8anDmuMf5w3PkO5424zMfDHJ9pJSjDS
         sc8te2t38PrI6nWUzuAVdFj/fnwmAj9xTvVu9pOpBrRgUB4qRU6DuVIUe4+/bIRtk9K8
         5ymQ==
X-Gm-Message-State: AA+aEWZ8+zG5RhVmD32qhXom83NpVBGk1s3fxpXobuQELc503LOU9xx5
        R+IkNWhLMWOw0Mc309FF+F8=
X-Google-Smtp-Source: AFSGD/V0EzPW0RAfO5zH71wPZPurgIr2E5bDmhZmWY+vesZsgEmQTn9szBny1lll+CwMTYaCJeK2uQ==
X-Received: by 2002:a37:6517:: with SMTP id z23mr21877053qkb.161.1545254902574;
        Wed, 19 Dec 2018 13:28:22 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 5sm3006519qtw.50.2018.12.19.13.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 13:28:22 -0800 (PST)
Date:   Wed, 19 Dec 2018 19:28:17 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] drm: i915: Cleanup drm_display_mode print str
Message-ID: <fbd3a70c8566de1269c2ed377cea909bb6d223e2.1545254191.git.shayenneluzmoura@gmail.com>
References: <cover.1545254191.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545254191.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjust the print string of drm_display_mode object
to remove drm_mode_object dependency in i915 files. It modifies
the print style to standardize the use of DRM_MODE_FMT. 

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/i915/i915_debugfs.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index 7f455bca528e..a63d084c8e96 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -2948,14 +2948,7 @@ static void intel_seq_print_mode(struct seq_file *m, int tabs,
 	for (i = 0; i < tabs; i++)
 		seq_putc(m, '\t');
 
-	seq_printf(m, "id %d:\"%s\" freq %d clock %d hdisp %d hss %d hse %d htot %d vdisp %d vss %d vse %d vtot %d type 0x%x flags 0x%x\n",
-		   mode->base.id, mode->name,
-		   mode->vrefresh, mode->clock,
-		   mode->hdisplay, mode->hsync_start,
-		   mode->hsync_end, mode->htotal,
-		   mode->vdisplay, mode->vsync_start,
-		   mode->vsync_end, mode->vtotal,
-		   mode->type, mode->flags);
+	seq_printf(m, DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
 }
 
 static void intel_encoder_info(struct seq_file *m,
-- 
2.17.1

