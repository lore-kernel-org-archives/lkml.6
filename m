Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E41C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30A5217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkc9yjgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbeLTM3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:29:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45681 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbeLTM2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:28:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so1505127qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BYfZwtNqPkn0guvWm4B86oIzil/V0+VJgO7LgjhvR+A=;
        b=Kkc9yjgS2z3gT9tpwNAhcxGRhX0aiiLe9DeM7uGCnNr1nJO5SWAf+ujrmy7+fpYLmi
         AH+IyM2aJo4SVPFEXzo1ExC0CEXkkf3kLnDoMpuCAbjETqsElgNfn9GIpQs6mXMjtrme
         ULzmeYAVK7Ht9lJMXHR+5dTvy9WPcCRbnE7Ly4ddY1XWVGJrRi9vgehmAWQSLkEbReUf
         55hofJFxwDtthZmfmJ7lSCxssJCa0eOJ8y5M38g0WPdnaWYpEtagq6zhn4+i/i+B16hM
         rOcDAsBt/OSyrCwHWDW1mJBJbcpF4jEBllrJUsfdkPiIShPQGFzG/mnl6ez7ihmjk5l8
         Bzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BYfZwtNqPkn0guvWm4B86oIzil/V0+VJgO7LgjhvR+A=;
        b=dzEbVrkv5VA1UkW1mc7ZHD4uo032rsk0iYoPe/jft3pNgTB99YRQAVqzn78GVN3IFw
         IDJz/MnCeoIRT2O9MkJ6TjoT4mBaWRx/GvNdSLKmP3e/F8Z6WExK3Ipd+4Qzl+a423BK
         aQUha2OeIoLoQvlyU+q2ZNGkqYcctvYru8/mANb7Q3pk5FBznsviU2SnJm/a+lEAlynt
         TxJB+7lbqwPuqZfxX419vCkWJOqgDTIKn2YwovFi/uqcYp5fjBWGVqR+e0aXh6VW9Te1
         38ssPPqc0o4gMR08A9y1X0EAeps6eLYn5HfvY4ayeifAJc/bUEf1xEg0KNErdzoV0kX2
         0WOg==
X-Gm-Message-State: AA+aEWZcmkBxj3qwNib2XHZz3yarF0G2ZIT5gRt3c9lL4jumn2q+J8ZV
        mGRxqazVfM9T4Ax+En6q5jY=
X-Google-Smtp-Source: AFSGD/V24ndGkLR0w2GjefebOysGcqnxgty1oZWtZVGCQJksNhjSS1qjO97OsUq1WeTQl31A3L5ltA==
X-Received: by 2002:ac8:2adb:: with SMTP id c27mr25000555qta.188.1545308883487;
        Thu, 20 Dec 2018 04:28:03 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d199sm2930874qkc.76.2018.12.20.04.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 04:28:03 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:27:57 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] drm: i915: Cleanup drm_display_mode print str
Message-ID: <087e07a388c7c65b6d0ec50db069640e4eb32fdf.1545308167.git.shayenneluzmoura@gmail.com>
References: <cover.1545308167.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545308167.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjust the print string of drm_display_mode object
to remove drm_mode_object dependency in i915 files.
It modifies the print style to standardize the use of DRM_MODE_FMT.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>

---
Changes in v2:
  - Use DRM_MODE_FMT/ARG macros (Daniel)
  - Make the commit message more clear

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

