Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02561C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD55820855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="h8baJeh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfBAPnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:43:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40852 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbfBAPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:42:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so6167833lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TH0lXAyrlRomYAB02Yycn9wsztLPFIbpq6Vqme/PXxg=;
        b=h8baJeh8eqxrIVootpLq2OYoRrmsbDASLzW6ZqrWxBZSKlWAQh7NWC0OVPOuqCu8mB
         MWEfYfZw1kebF0iHaX90L4thZQPmL58v592JE2OJ7qGXB/uAShdRezQsfWtRVRBqPp4j
         zACYt6d2b3yNL8oHExk3pfBTTduVNG8/CaW7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TH0lXAyrlRomYAB02Yycn9wsztLPFIbpq6Vqme/PXxg=;
        b=DHFJSnKVPcLd/r1/q4s7XUNpcUnFyWdlXhzG5pmiz1NcL4mbD4eelLkSPKZDxWwWGU
         jfRET9ifOXOJ4H7ITswIoxzA3OpHGSxQd8fyJu3J3I3LWi97frsPq5/ZBrPpXS0bw4+v
         LFr6WtnCvsVbf47Ef+MAtS+/fGv1V7EjkLTHqSelB9uFrZxB+Je2IVjqf+Nkx/1QyAbj
         jrPwOTcA5oNcdK3cuR22vfdFePemIvD5IozTx+0NLQd4HqCwnhiOQn76vMLSdtQ9ZjAp
         cCkwvpj0kjSKv0ZsjOL3nv/eeJDMlrt5/44lUYwo84l/IJJIaAZt6N7FzX+v9vaPXFMF
         V6Og==
X-Gm-Message-State: AJcUuke3vOBdeQeAcyx3r2mLojicm5trE0rOnzTFv4fcXCMHDpuppjZz
        OMau7iG7wcWLpTp5NqqZN5su9Q==
X-Google-Smtp-Source: ALg8bN5UdmzEooJr/VOlZo7l7VOObC/P0rkzz7HNwWOblM5sif7MlFRwx/aytTeQBHAxsLn/zfJv6g==
X-Received: by 2002:a2e:3803:: with SMTP id f3-v6mr32242287lja.169.1549035773896;
        Fri, 01 Feb 2019 07:42:53 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:42:53 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 05/23] drm/sun4i: tcon: Export get tcon0 routine
Date:   Fri,  1 Feb 2019 21:12:14 +0530
Message-Id: <20190201154232.10505-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes tcon attributes like tcon divider, clock rate etc are needed
in interface drivers like DSI. So for such cases interface driver must
probe the respective tcon and get the attributes.

Since tcon0 probe is already available, via sun4i_get_tcon0 function,
export the same instead of probing tcon explicitly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 3 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 0420f5c978b9..3da75a0c5c5d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -221,7 +221,7 @@ EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
  * are located in TCON0. This helper returns a pointer to TCON0's
  * sun4i_tcon structure, or NULL if not found.
  */
-static struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
+struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
 {
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun4i_tcon *tcon;
@@ -235,6 +235,7 @@ static struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
 
 	return NULL;
 }
+EXPORT_SYMBOL(sun4i_get_tcon0);
 
 void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
 			const struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index b5214d71610f..a52696db14a5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -274,6 +274,7 @@ struct sun4i_tcon {
 struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node);
 struct drm_panel *sun4i_tcon_find_panel(struct device_node *node);
 
+struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm);
 void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
 void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 			 const struct drm_encoder *encoder,
-- 
2.18.0.321.gffc6fa0e3

