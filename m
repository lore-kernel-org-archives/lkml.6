Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BFBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541DF21872
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1vFynlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeLRNid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:38:33 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:34724 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeLRNib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:38:31 -0500
Received: by mail-qk1-f169.google.com with SMTP id q8so7264528qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kwbyrKVr7th7uUgx1fkm/6bOB2+rMDEnicy6YFlOrBc=;
        b=I1vFynlR3h/MSBG807AqtQU+P6EEq7/4ac07SnBx67tiOzF8qVjq3iZEI+GoUvfpXF
         JbK5bHSMfYHexVbV1FZ1eorDOhdiMwuZ3kNmG/QV486hRWtkXi9iYDGKyeFDD+q63EwX
         TYlUvi5+e6o+8ZqwrYcH6v1MG2xgjXugTGuMQCmjvZ2ynhmNtzbmaWM/WS1nbobuJc5F
         fEXlzQpytSbJdCbDOse1X0nEra4UnXtGx7ybiM17cZjEIOl1LDEexB7AI01buNTeUJB6
         DlvuNf9XyzkXP3QntzqYYNYAClmWMQexNTIG6CWBPiV+zedY/c5l1VPnZUXUVYvaSUA3
         lraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kwbyrKVr7th7uUgx1fkm/6bOB2+rMDEnicy6YFlOrBc=;
        b=ADC8rGW1rVxpZHT+rCVudJCTIak9nWcfIy3YltuSWlarRTHpRu9S+bZWTlSY9b8xH+
         VTMrLQB6Mo9NRkXhjzMbWeRs+F3IyjI2ZOfqZ37dJKaRvwtTd4QtWwztrElxlIERoAm4
         PUVs4SdDN2Kh6VnnIHHjSRwX0rC6nEMD1BYiyP6lOEUPOZi6Kj54EQF7KDvCjTdV5yP3
         yJoJclsWJSDsU/XRO8UzQSgeX+WI6O4k836PaCpCRX2Qzq1NVvYfKTn70yngSPOE6N81
         ABslenE/b8me4z+IttLVPGfRy973o7reQkxZy3Jv3Y7GrM6ZY8x945lVXFeODmrs+I8E
         7Ksg==
X-Gm-Message-State: AA+aEWZ4Z4iXCQGgx9RITJ5D8Jw3j/2+gcv8HkCk28hKB2A9D5BMRHq6
        IICkm9GytgbzGC7MTUA20auwIUwlxJg=
X-Google-Smtp-Source: AFSGD/XXnc8fvoDqt22yNjJFK4GwWCSNJE1tWxEWt1L4F22pa3zZQIpHOLxCJhFLlxGYYI/dUjJleg==
X-Received: by 2002:a37:8ac3:: with SMTP id m186mr15926589qkd.263.1545140309682;
        Tue, 18 Dec 2018 05:38:29 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id b6sm7702997qtq.29.2018.12.18.05.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:38:29 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:38:25 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] drm: sti: Delete base.id prints
Message-ID: <20181218133825.rdqanhqozsnqp2fy@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes base.id prints from drm_display_mode                         
objects in sti files. It removes dependency from drm_mode_object.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/sti/sti_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crtc.c
index ed76e52eb213..ab7989bc8fa0 100644
--- a/drivers/gpu/drm/sti/sti_crtc.c
+++ b/drivers/gpu/drm/sti/sti_crtc.c
@@ -53,9 +53,9 @@ sti_crtc_mode_set(struct drm_crtc *crtc, struct drm_display_mode *mode)
 	struct clk *compo_clk, *pix_clk;
 	int rate = mode->clock * 1000;
 
-	DRM_DEBUG_KMS("CRTC:%d (%s) mode:%d (%s)\n",
+	DRM_DEBUG_KMS("CRTC:%d (%s) mode: (%s)\n",
 		      crtc->base.id, sti_mixer_to_str(mixer),
-		      mode->base.id, mode->name);
+		      mode->name);
 
 	DRM_DEBUG_KMS("%d %d %d %d %d %d %d %d %d %d 0x%x 0x%x\n",
 		      mode->vrefresh, mode->clock,
-- 
2.17.1

