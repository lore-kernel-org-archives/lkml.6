Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E577DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 05:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A412173C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 05:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lr6y0AKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbeLYFRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 00:17:48 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45394 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLYFRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 00:17:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id EA053C37
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 05:17:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BxFZop6db1Pc for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 23:17:46 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id B2948C18
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 23:17:46 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id x82so15977612ita.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 21:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FdFrkmqprfCYQfxfSMzPTnrTdkT0taszbpGJk+aizVs=;
        b=lr6y0AKHwEbrQNWpS4yyVrtbjsh5bUA2XnRjNEZh+yRrOUVrVqUMkO1U9ngxqzOH+m
         KrUaLcX37Xg1B0Z3ni8i3bOMzR5Clc/bUmlfP7+RS5oNjE2h7mhb/mOJTlWqSTjCliiy
         4V5r8xr2VupQi0jkY0Xyav4yqe+pv3rlUzInpIhb9v+llUXawj9QmiQqLP2IQVUZsc6X
         uJP+BTOWF0FOo/8uGLjQG9tlPvDL8TdG25IJrerMlIQYSRMrFljMQ8074FqzHnVfEu3d
         Fq5eJxya2qXSA6YAfUMqsBytz4C4R5ooOxp0kwfSe+oq+k+1PL2Fwmdw/3sUS4AZ9+Cy
         /bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FdFrkmqprfCYQfxfSMzPTnrTdkT0taszbpGJk+aizVs=;
        b=KomKW4M1n/aqdH655p1x9MScVYxjG/KnCNmrG4zIrbAkJTOMczEY34LzyHVDNqkAcu
         k92Aqs3NgL5QhS89fwisfjfZqDbNSOJDLN0yd/eayd3dw3jMKzjfgl9mqgI3t4Vwzfta
         mHRGbc2pRnKc9RUOuYDmjFLAoR3MeESeMlMw9uY1sqLUvNCATPqpmVxLmjYwxu8tmjB0
         A/TX76oPHhXxmiQdkqsqESjF+Ih8rah/e9yLBtqotoDsTb/l75XT1/ceMloVBf/6tC5v
         x5XSlpizDthJpPdTk1E0P9ZuytqA4+TPYt/ojQVNwzl2WnjJmwnBT8qcnFL60r5Uh0+U
         r4Jw==
X-Gm-Message-State: AJcUukf3wy1Y1txviisVJ+rJq1knAiTybD/JF0Mv81ZbRkPW4bn05XS5
        WjR1yMv18tF90lREJCpfXtn8JctBnccnQVz4y5a7A42/LZr9BLSn71DiI12yeIun9uSiaoZtDZv
        Jq7yWsp723L7iYEKjUmB9wejk3dK5
X-Received: by 2002:a6b:3b85:: with SMTP id i127mr10187796ioa.177.1545715066310;
        Mon, 24 Dec 2018 21:17:46 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7Tp/MTBMpXmifTRotIpuk2jIY1VhA1oHeJRDDT2VSLHS6nkXZcya7rJzN9QoUnwY2WjLaRjg==
X-Received: by 2002:a6b:3b85:: with SMTP id i127mr10187790ioa.177.1545715066088;
        Mon, 24 Dec 2018 21:17:46 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id w24sm3527596ioc.11.2018.12.24.21.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 21:17:45 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpu: anx7808: fix a missing check in anx78xx_poweron
Date:   Mon, 24 Dec 2018 23:17:20 -0600
Message-Id: <20181225051720.66433-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both anx78xx_set_bits() and anx78xx_clear_bits() in the poweron process
may fail. The fix inserts checks for their return values.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/bridge/analogix-anx78xx.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index f8433c93f463..3b0fe2b188db 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -638,10 +638,22 @@ static void anx78xx_poweron(struct anx78xx *anx78xx)
 	gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
 
 	/* Power on registers module */
-	anx78xx_set_bits(anx78xx->map[I2C_IDX_TX_P2], SP_POWERDOWN_CTRL_REG,
-			 SP_HDCP_PD | SP_AUDIO_PD | SP_VIDEO_PD | SP_LINK_PD);
-	anx78xx_clear_bits(anx78xx->map[I2C_IDX_TX_P2], SP_POWERDOWN_CTRL_REG,
-			   SP_REGISTER_PD | SP_TOTAL_PD);
+	err = anx78xx_set_bits(anx78xx->map[I2C_IDX_TX_P2],
+			SP_POWERDOWN_CTRL_REG,
+			SP_HDCP_PD | SP_AUDIO_PD | SP_VIDEO_PD | SP_LINK_PD);
+	if (err) {
+		DRM_ERROR("Failed to set register bits: %d\n",
+				err);
+		return;
+	}
+	err = anx78xx_clear_bits(anx78xx->map[I2C_IDX_TX_P2],
+			SP_POWERDOWN_CTRL_REG,
+			SP_REGISTER_PD | SP_TOTAL_PD);
+	if (err) {
+		DRM_ERROR("Failed to clear register bits: %d\n",
+				err);
+		return;
+	}
 
 	anx78xx->powered = true;
 }
-- 
2.17.2 (Apple Git-113)

