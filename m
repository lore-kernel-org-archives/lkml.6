Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287BE20868
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="QKZ5pI1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287BE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbeKOIdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:33:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40776 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389439AbeKOIdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:33:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so28791492qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/bfKcwnq24c7GQi8+QH2x+kJfYvWUyEGaldZxXhKaVQ=;
        b=QKZ5pI1bCT7/DOJNRodcpFW2+FjFGAvbRmPyw+gmRGvrGv8nVQINYAN2zniAefu7ci
         zIpLKh8Sh05TTfEV/TlSEqfDg8bCdFo7lNcSrMua2Cm6PGS7U6CTtpeo+Q20AJ6zEQt6
         N20f80YcJetdTymcNAZPv/mUuqCImxBRr1zG7HcWMr/bCChnk8KtmujailTeuA/6WSec
         1i2RolnaFzIFme/fkHhecYkXFj8zRkuVI9RupqwyNghNlyOGb+gzpRYJK4mgmlkfy+o+
         GfyBOtb0hdQdBTXGaUY/pViYYz2spMW5AXccJcs1hPzt1ipjsveObAD7ppngTQgqO7Qk
         RF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/bfKcwnq24c7GQi8+QH2x+kJfYvWUyEGaldZxXhKaVQ=;
        b=uO0QilUCfXDdXvFwKr4kutXuC+krv17NT4cSLvplOrszLz7ELgxjDdKbyuKHouU4Nf
         iO2OHG5xJz9WVkJNLDIXheJZP53nilhoutT2ZNNocf/1X4U9fboZTl0WiZJYzmO+9KTt
         S4lwbbS6GfGgPzvb9FXmZQvqGlVGZsnZsEOWeXoaxSu+D0C9GN92/Cm18M+Ec1DwRuvb
         jCXdLBEWm2ZWiJ8z3VRBDVy3X/vNchNJAp5LUJuFWTh1Bu5a3dKhtbL3dQjSudIsT0y4
         IADxGOEaEarNS6zpjdFbyjF2BHnZ9x3Xf/NuWJHFBzje5ztuRT+jvEVtf4+TxWYkloT0
         xo8w==
X-Gm-Message-State: AGRZ1gLIXNg9ydk1nMncadKE0JNgbWh2UHaks4344Y/jxd6ib3wuJKkG
        RNCqUXdvv+MJvOffbgFbRLGIZg==
X-Google-Smtp-Source: AJdET5epL6+ReeWFys4n1HAC8S4qwmwIIA3xO6f9HkBmSqPYapFnJDyUgIc+8U2r19cShRkqDkE6Xg==
X-Received: by 2002:a37:6005:: with SMTP id u5mr3457068qkb.219.1542234496099;
        Wed, 14 Nov 2018 14:28:16 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id 24sm24067595qkp.65.2018.11.14.14.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:28:15 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 9/9] drm/msm: set priv->kms to NULL before uninit
Date:   Wed, 14 Nov 2018 17:24:16 -0500
Message-Id: <20181114222418.15960-9-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222418.15960-1-jonathan@marek.ca>
References: <20181114222418.15960-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

otherwise, priv->kms is non-NULL and msm_drm_uninit will cause a panic.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/msm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index bda23011494d..94b0593f6090 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -533,6 +533,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 		 */
 		dev_err(dev, "failed to load kms\n");
 		ret = PTR_ERR(kms);
+		priv->kms = NULL;
 		goto err_msm_uninit;
 	}
 
-- 
2.17.1

