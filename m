Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D9ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBCC2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MShnanCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBCC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJZG4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:56:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35762 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJZG4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:56:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id l17-v6so4898359pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=neUKq1cuoz4/oKiks/GsHVXngMnTcPnfmEeTBUxyFyg=;
        b=MShnanCg69KmxODEm+UD+bcmQMTz4pzjVCGBcXmoP7oKfcst2ZTAgw9Ubo8bm1EwpA
         sHjX+BoGsmck7iFweAoCrQF6pOxBmLCQTBDg46RCtvuyE9tCWfM0/TI7K9nYtxbFf5so
         i2RXA1fQUmDluKfru+9GuZXhokVFARfSq6zSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=neUKq1cuoz4/oKiks/GsHVXngMnTcPnfmEeTBUxyFyg=;
        b=GgGkPC0yqxrZml+PZ9nUoVEvuFvqdUzIcvS0m1IMITrb8Ypc4kD5JPL3Iq1QDveuxw
         L7/j8xnTnLNNkBLjRkvjwe6+uSHvIYPytCRBVkU1QxKUGFn4fKwFfIHuvfs05qqD5nma
         ZadhwIgQVx/oEZBbBH0TrwR6r4ytgZyl7sRAXaLNvRKSJXRBtsRKHazl0u3ozg6bJy92
         +HmZ8d9KfizK+dcr30svx/BJZYYihalxmlBCaWedWSfvimVRq5Y8mmoO97nSijb1zsj9
         IeW7IFC85/PkD20aTuHp23fZShvQ1/wfrXUTOQjsfGhQf8eJBF76cFVJ//sH7LRTtcmG
         lVfw==
X-Gm-Message-State: AGRZ1gIrccyRC3Jpu8t7eyGv9CFnz+q8Q/8PJCgkalZ3fPReFnl+CPol
        M6zQ1ye/7Vh/FMrkkZYUoTj0vg==
X-Google-Smtp-Source: AJdET5dTvtSUFcfnEqsE47nbgEmd/VJ9nhPqfZeCLGcdyEot1aGHtkJlLeEzIzTqRmdWS/eqfcs07A==
X-Received: by 2002:a63:9343:: with SMTP id w3-v6mr883015pgm.343.1540506129169;
        Thu, 25 Oct 2018 15:22:09 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id x73-v6sm19813778pfk.139.2018.10.25.15.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 15:22:08 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] drm/panel: simple: Support panels with HPD where HPD isn't connected
Date:   Thu, 25 Oct 2018 15:21:30 -0700
Message-Id: <20181025222134.174583-2-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181025222134.174583-1-dianders@chromium.org>
References: <20181025222134.174583-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some eDP panels that are designed to be always connected to a board
use their HPD signal to signal that they've finished powering on and
they're ready to be talked to.

However, for various reasons it's possible that the HPD signal from
the panel isn't actually hooked up.  In the case where the HPD isn't
hooked up you can look at the timing diagram on the panel datasheet
and insert a delay for the maximum amount of time that the HPD might
take to come up.

Let's add support in simple-panel for this concept.

At the moment we will co-opt the existing "prepare" delay to keep
track of the delay and we'll use a boolean to specify that a given
panel should only apply the delay if the "no-hpd" property was
specified.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Use "hpd_absent_delay" property instead of a bool + prepare delay

 drivers/gpu/drm/panel/panel-simple.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 97964f7f2ace..687fd087b9fc 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -56,6 +56,8 @@ struct panel_desc {
 	/**
 	 * @prepare: the time (in milliseconds) that it takes for the panel to
 	 *           become ready and start receiving video data
+	 * @hpd_absent_delay: Add this to the prepare delay if we know Hot
+	 *                    Plug Detect isn't used.
 	 * @enable: the time (in milliseconds) that it takes for the panel to
 	 *          display the first valid frame after starting to receive
 	 *          video data
@@ -66,6 +68,7 @@ struct panel_desc {
 	 */
 	struct {
 		unsigned int prepare;
+		unsigned int hpd_absent_delay;
 		unsigned int enable;
 		unsigned int disable;
 		unsigned int unprepare;
@@ -79,6 +82,7 @@ struct panel_simple {
 	struct drm_panel base;
 	bool prepared;
 	bool enabled;
+	bool no_hpd;
 
 	const struct panel_desc *desc;
 
@@ -202,6 +206,7 @@ static int panel_simple_unprepare(struct drm_panel *panel)
 static int panel_simple_prepare(struct drm_panel *panel)
 {
 	struct panel_simple *p = to_panel_simple(panel);
+	unsigned int delay;
 	int err;
 
 	if (p->prepared)
@@ -215,8 +220,11 @@ static int panel_simple_prepare(struct drm_panel *panel)
 
 	gpiod_set_value_cansleep(p->enable_gpio, 1);
 
-	if (p->desc->delay.prepare)
-		msleep(p->desc->delay.prepare);
+	delay = p->desc->delay.prepare;
+	if (p->no_hpd)
+		delay += p->desc->delay.hpd_absent_delay;
+	if (delay)
+		msleep(delay);
 
 	p->prepared = true;
 
@@ -305,6 +313,8 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 	panel->prepared = false;
 	panel->desc = desc;
 
+	panel->no_hpd = of_property_read_bool(dev->of_node, "no-hpd");
+
 	panel->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(panel->supply))
 		return PTR_ERR(panel->supply);
-- 
2.19.1.568.g152ad8e336-goog

