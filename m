Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D6CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131062145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="JfYJOEHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131062145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbeKUU2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:28:43 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33535 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeKUU2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:28:42 -0500
Received: by mail-it1-f193.google.com with SMTP id p11-v6so12343864itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=hdZf1VE382pYo3IvUdgDs25LetDkW2NEeNw5O3jQkX4=;
        b=JfYJOEHjnf3dtUpn/Nmgi2ECej5aAkSCbuHPxuKE6UAFNe8SRSS7Mqkck3CsCi+cEj
         taQqceYq7JU30VA8e8S7ipU9JvUiwF+WoScbtGG2INZI+HYRWU4826At+tdgR9soAJTQ
         Gn52kzyU+EgDEFyuOPEbACmTYP3+dnwd96lU+OI9h9ugDwUbRHiCa4a1qCjudwcXImLJ
         b9dPpwtvIBn5B5m7XnJSzvABY/AfcmIjokdbkORYaP/xlioPph0mu9n5F/zTlT6WwaJN
         7LK+ND8JxlsLz8frmv0ftsmrF0TYedGG9BVnE5zGhteeq2YCdsMbnnfQ0AchYTN8hMm7
         k0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hdZf1VE382pYo3IvUdgDs25LetDkW2NEeNw5O3jQkX4=;
        b=gUX3uP3oYPi4+rbCiH6saL4d7EXglEf1N7sP7AU+Jsys+tQKXltgHg/dUhbffAyNuJ
         IRm9cNcbuc/u704ZpTIF2iISoHOpwPwV1U3MXPa6vDWQ9h19RRq6xcFZxaQluwBrY4BT
         5qJ1sIVz14XoOTxXvZUC3p3Ux1/zMrIxzd69lNdIlpdYroqXZujqG6mJ6i27gck7cDsZ
         u2fa3m6aocKh0rnK9Sq+lzVMpR+cGX5c6QlOGAQCgaGO7J58LFhbkpK6DTjXd1+jx2d1
         4nN3CrbWhbVXoxcSM3PJVQgN7cgEQ/05REVXTf3iRVFkpdEzwvqc9tMLIRtlou1Z2WHS
         R/3g==
X-Gm-Message-State: AGRZ1gIRafz/oZYKQ2lqCJScZMG4byRy6I4CfZgdxtRob2LJGeyjAD7l
        hoQ84iAFXm7qGAGJ/dXcsJxlZw==
X-Google-Smtp-Source: AFSGD/U3f0W4YxHNeOTPIFVjvFuepZnApik4o+ULuVvQiWA/AImDQAtucejXLQwfdBxBRiJEJb3Gwg==
X-Received: by 2002:a05:660c:1d1:: with SMTP id s17mr5361985itk.79.1542794095351;
        Wed, 21 Nov 2018 01:54:55 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id g16sm5259710ioh.40.2018.11.21.01.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:54:54 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     David Airlie <airlied@linux.ie>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] drm/i915: avoid rebuilding i915_gpu_error.o on version string updates
Date:   Wed, 21 Nov 2018 10:54:23 +0100
Message-Id: <20181121095423.20760-1-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

There is no need to rebuild i915_gpu_error.o when the version string
changes as the version is available in init_utsname()->release.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 8762d17b6659..958e1484a3dd 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -27,7 +27,7 @@
  *
  */
 
-#include <generated/utsrelease.h>
+#include <linux/utsname.h>
 #include <linux/stop_machine.h>
 #include <linux/zlib.h>
 #include <drm/drm_print.h>
@@ -650,7 +650,7 @@ int i915_error_state_to_str(struct drm_i915_error_state_buf *m,
 
 	if (*error->error_msg)
 		err_printf(m, "%s\n", error->error_msg);
-	err_printf(m, "Kernel: " UTS_RELEASE "\n");
+	err_printf(m, "Kernel: %s\n", init_utsname()->release);
 	ts = ktime_to_timespec64(error->time);
 	err_printf(m, "Time: %lld s %ld us\n",
 		   (s64)ts.tv_sec, ts.tv_nsec / NSEC_PER_USEC);
-- 
2.17.1

