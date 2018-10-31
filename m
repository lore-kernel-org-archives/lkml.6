Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A034FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D2720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjbNUFog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D2720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeJaXnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:43:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44484 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbeJaXnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:43:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id n12so9826571qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DzQ95udb3n4k7li4ukgA9aHDB5NmQ3yb/l+IWXqV4/8=;
        b=pjbNUFogSJrmo6ELDcd5kP6gO0PUTlOyUr0i9bb5n+Apec/EfdEZN5mtcXV9vaFpeX
         R7d/BUBXHkV/yXWvaB3oRuCWrf1HRbkNyvqPwzFnKDNcMWDS8QMAnsjO46/ogAaXbwQV
         Jjevnw78GHsNS0UM2gpc6N4cxFqEyumHHKXXPpydeK4t5VJzpwbsed35k4QcFcrZ43Li
         nsTJD+ARHce5clxuR65UMHb1b7Xm+nMWVwGWTMUFDULr5xDsxqTs/rtl4oBrwzJtTHsh
         D/kigeadt9WtytjhUSMOI01cs6m5t5041OqKTfLGPrKvjkimJi6XqMgSje6Prei6hUg0
         vKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DzQ95udb3n4k7li4ukgA9aHDB5NmQ3yb/l+IWXqV4/8=;
        b=JOPL9Qow6hSXWQXb74Ajqj7LjAWVaKCKcSXJb2YtPNipZgIeilyywfDhFO6YJhezhW
         z85Se0fDpIc5c6SzSIXx6kugU6LbLV4hDcJWT5+eN1q5fkaMMTnClxO5OB7A13qBZfOG
         Rp/6Tk668+KI6v6bU4Bp/wQH6RyutUW7HSvga3HUuCPJehxmBsIca7hHHIorUbkGgt9q
         /GMQ50dyAEkJAtcsKGuI5mW16KczTU24e9HcbSghRj7H9pxtHgqx8RVeb9AbiUrDJfF7
         iZOn0uLOE3r/vbOMPolf5XqiwQRSw2ycNSnZS1OTKahHTYSjgAul2QSKrqPMwughbUHQ
         hNDQ==
X-Gm-Message-State: AGRZ1gJJPURKOViBKpiNbPODEapfseZZoNARcxRxnyIaffEhRAhqytCi
        gQipf6F2oCEdpvsG5+eOj5U=
X-Google-Smtp-Source: AJdET5e+f6WkV7QlABVMA3NieNIicv/0KjMia2/Bxea9LdshSzoyGGFganXgtqWsOmAA8aelK8fKjw==
X-Received: by 2002:aed:3024:: with SMTP id 33-v6mr2955485qte.29.1540997090322;
        Wed, 31 Oct 2018 07:44:50 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id j128-v6sm6298409qkd.5.2018.10.31.07.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 07:44:49 -0700 (PDT)
Date:   Wed, 31 Oct 2018 11:44:45 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] drm: Remove 80-column line in drm_mode_object.c
Message-ID: <20181031144445.vrdngzj3jclforta@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new variable to make the drm_mode_object comparison before
idr_alloc and decrease line size.

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/drm_mode_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index be8b754eaf60..4b9eafddb409 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -36,9 +36,10 @@ int __drm_mode_object_add(struct drm_device *dev, struct drm_mode_object *obj,
 			  void (*obj_free_cb)(struct kref *kref))
 {
 	int ret;
+	struct drm_mode_object *obj_tmp = register_obj ? obj : NULL;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
-	ret = idr_alloc(&dev->mode_config.crtc_idr, register_obj ? obj : NULL, 1, 0, GFP_KERNEL);
+	ret = idr_alloc(&dev->mode_config.crtc_idr, obj_tmp, 1, 0, GFP_KERNEL);
 	if (ret >= 0) {
 		/*
 		 * Set up the object linking under the protection of the idr
-- 
2.19.1

