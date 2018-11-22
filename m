Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B78C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E681420645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="nrVzoFli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E681420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404011AbeKVMdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:33:10 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38020 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403999AbeKVMdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:33:09 -0500
Received: by mail-qt1-f194.google.com with SMTP id p17so5981103qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=67w/a7Ij/tu3gR+M6MMWe3ZJ/tnI6CV1l604WGfFbyA=;
        b=nrVzoFli2QKKBDuRKpPDQsTrUbAT09nqOG81cdvVwNOcqBZGlQoQDpIuuZcLtEPclc
         L95xhcz/usI07v+TZKZiWm4ghHC9gaMnWfIloVXUMUSEO1ZkveW+RXCZUMjn5yZSsVOd
         Ve2wo1+KrGK86dBfw0hyEeIxj2PgaO9496W7Ptr33da/DADvwwBzb84kGYo0VHwOzI5O
         SPG8NhYjSMGcae1AlhzRHw3X1gOZ6b1lyvn+9tt9o/UINWw/AvpddPdMKp6svwDgMhSu
         5YQa3+BHtK7N37qlb6O6CyejJwPXOwi7cDB+X20nHr/rpNqStIvAg5pm2KNw+As/2hL/
         YLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=67w/a7Ij/tu3gR+M6MMWe3ZJ/tnI6CV1l604WGfFbyA=;
        b=fPWCAJvJFWf4ruKnx7fPb0OoBFMu+3BFQWIcm8ZSUvK2muJJ2wsjm0z0NYjebO4snj
         OAEXRGEyKeHQc7xgd1SrNWGACJn17O9iqY5F9G1S87Jmji5FGdAHlr5vHpxcEbDM5zSO
         mQ5hxwru/SDn8mhH0WoHIseQB9Qhrs9qKsx723WaVju7a5dTKVDCL9eeuwdpSBw8MU3M
         AG0JM3pv6Ww7BbiSWESSzG0hILztpqb3szYIAqEXybEz2wMKHZIUlkULmMOTNlhTBt3z
         gq1XFQpf4XaYwGUvetfFVVGh/BU7HYjSIS+3HSARe6OwBLQ7xv26xImTV0u2H3dpR20v
         BRAQ==
X-Gm-Message-State: AA+aEWZ6QfKz/sBL+iykGzgPrlAGO2qEIubkbdM5rGXHxpQvZN0MjKyg
        9eHui66Xc79p+HTVglDED9XRqQ==
X-Google-Smtp-Source: AFSGD/Vl2YqvRa4R+8Lv5jh51JgchqOChHhUUf5CQMrQKW9iSiXVXoGyLjNiXKCdU/Wu/RQK6X/zLg==
X-Received: by 2002:a0c:b6c3:: with SMTP id h3mr8688277qve.128.1542851764886;
        Wed, 21 Nov 2018 17:56:04 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q15sm25297721qkl.81.2018.11.21.17.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 17:56:04 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 9/9] drm/msm: set priv->kms to NULL before uninit
Date:   Wed, 21 Nov 2018 20:52:35 -0500
Message-Id: <20181122015237.14534-9-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015237.14534-1-jonathan@marek.ca>
References: <20181122015237.14534-1-jonathan@marek.ca>
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
index 5d7304b5f399..fd5769e4c42a 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -527,6 +527,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	if (IS_ERR(kms)) {
 		dev_err(dev, "failed to load kms\n");
 		ret = PTR_ERR(kms);
+		priv->kms = NULL;
 		goto err_msm_uninit;
 	}
 
-- 
2.17.1

