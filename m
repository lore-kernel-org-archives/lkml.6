Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C9AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4DC2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTajQg8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4DC2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbeKACnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:43:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34506 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbeKACna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:43:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id z2-v6so18126726qts.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5h9H/t/58iT5wJlL5hclCitkHk3Y96u4UemtKet/OsI=;
        b=FTajQg8/qHkirymCjQyRFhKri7SKuVSwg/+2L9okOxvQHNS/uHTVhWocZf3o51lF+y
         ua9QtAmDP9eWFu3xHG+4onqFQGdr5Vf5rSh3lBNroDG1HAB+iq4EOme33k6DAnfiN/yt
         rFNxxspnvZ0uW1sEHQdu22ADQMjYnAonZlcF0LEMeN6iE1pLbEIhpa10WEjG1Mb8SNne
         u9P7IjpO+cUYCelgZb61CKKEwPxxw4wZdyuEwonWA+C4y5S9xP/OcsF2zeUORZ7KTkrJ
         ke20Ojsl3DsMvu89NP1cqQ/X1yhoYfFB5ykI/cIS4qETLi5dUuCjlt6biVTWw1/wg15i
         jfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5h9H/t/58iT5wJlL5hclCitkHk3Y96u4UemtKet/OsI=;
        b=I8QeM77sSz6wU0Pjez6AVREDUrfyswNZgkXPf4fUw5EOYSgrFokgfRaj04t9FL+gBb
         T/QM9+IL6oWnhp6XIGjNYP/uSgqK3WrE6S5PtDyF2NAFfTEel2SWe4JuIxmOcKoI8uqW
         DCa3jEIbOzSIKPtw6uuWxp6IQk7JmfW69Aky+r6DPBG62E+YXwZHyhsb84z6lJF/SBP0
         0ozGUVsU7J468bApbgTGAuT+lufwr7MSrdOrCpeyN7qppdIycihaW9xQ+ORhGHW1iLte
         ivVqzEtVf9CzA9o4qDx4fSDQolmTWS9ZrOonH2QPKVLKmLfYwRCWe8nxeuPGWybf8zWT
         Ht2w==
X-Gm-Message-State: AGRZ1gI+J3IRytWu5xEyVNVvwVgktz6trrxWPKFTqElgNK2QyG4Cf7A2
        TryrMQC1AEemZGzDi400vTg=
X-Google-Smtp-Source: AJdET5ev5K9zVNFytAbsCJWIBtu57VRccfIaVoxSYVCr3N7WT2k44abar0L1GvVKbubhRWGax2DIrA==
X-Received: by 2002:a0c:b0c3:: with SMTP id p3mr3642744qvc.174.1541007869688;
        Wed, 31 Oct 2018 10:44:29 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e4sm1357430qka.31.2018.10.31.10.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 10:44:29 -0700 (PDT)
Date:   Wed, 31 Oct 2018 14:44:24 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v2] drm: Remove 80-column line in drm_mode_object.c
Message-ID: <20181031174424.odljb6obj25wm47d@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break line after NULL to decrease the line size.

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>

---
Changes in v2:
  - Remove aditional variable added in v1 and add a line break

 drivers/gpu/drm/drm_mode_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index be8b754eaf60..cd9bc0ce9be0 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -38,7 +38,8 @@ int __drm_mode_object_add(struct drm_device *dev, struct drm_mode_object *obj,
 	int ret;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
-	ret = idr_alloc(&dev->mode_config.crtc_idr, register_obj ? obj : NULL, 1, 0, GFP_KERNEL);
+	ret = idr_alloc(&dev->mode_config.crtc_idr, register_obj ? obj : NULL,
+			1, 0, GFP_KERNEL);
 	if (ret >= 0) {
 		/*
 		 * Set up the object linking under the protection of the idr
-- 
2.19.1

