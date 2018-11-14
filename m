Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF78FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A567620866
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="OrJHM/Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A567620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389482AbeKOIcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:32:41 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40636 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388803AbeKOIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:32:40 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so28788790qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yi+83lbDblZvbXPQbq7ZeugGAkOASemcPW1GqEcxWA4=;
        b=OrJHM/Pk8nNRHKzhds3wxUeU/H5h1M3HZSy17Is6AbJIVqqtY2HsB0mc/O3vjEyH3X
         ku0orbLLoyn2jN5CZqyB4HkwVOShckp9N4JC/+WF+gX46kCwZTCeRrzfKxvPqsW+XrPA
         4X/NDNtG4byqacTa5V4Z9RohtEWHTEnNufoUNofUGZDPASC+7um3/NMEY1hqczxbx+FP
         MMBe5kLgB78vcczZ2Fu89VYDv2sw7GsznoAPcD1uEj53AXBjSA3Ydpb49mP7ozs6iRkO
         T3VmmOa+U+0ZKC9st+3OLLBaQTKK7Zpr/8dqbOfxrBsCkbHsB1HPpqdTBENT5h3vAnhw
         Kizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yi+83lbDblZvbXPQbq7ZeugGAkOASemcPW1GqEcxWA4=;
        b=B37Y2D3KMXC9s+HlxPtO0ob1FWczqOwDQ8U/xHLdup+I5+fbNo52bHpP6MUw6DgXAU
         Ir4NioVzacixpfu641Fzo29FsJfSjBA2cz0VrB9zleDPioSuR57nCJAbrreRTskF2Yj+
         bOrf8jWRR3mPbacG5qckwlZ4qOpR8pCm9H9yEaej1Y8yXSuxjuvQffqsrhUXVFeYlfAZ
         Auw+MeB2xaJzH5s0eD3yiwhyG5C8B46UwqCFGqXvicD4A+1P+L+5kskpJNyfe0ujuGzV
         Q4TKPaThD1MUEZtfzYW9qNp2azNzTxWkTtutb2hW8AL8Bz5fCDxuh9jt4FIFNKqctZ0Z
         7KGA==
X-Gm-Message-State: AGRZ1gLiLz2eUJahZdtmymZWN98dcq3ZCtpYN/WbWAKKhmFpg/XvYIn7
        4+qvdH0/4qELDy30EE8S7ux3AA==
X-Google-Smtp-Source: AJdET5eNPCpIGGtL7x6ndEVRA1r9wHQ5sO1csWatKdUH8OhoKU/Y2Uw30ferncCu2LHDiawq1dFq/Q==
X-Received: by 2002:ac8:66c7:: with SMTP id m7mr3626847qtp.114.1542234454883;
        Wed, 14 Nov 2018 14:27:34 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id 24sm24067595qkp.65.2018.11.14.14.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:27:34 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Steve Kowalik <steven@wedontsleep.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/9] drm/msm/mdp4: allocate blank_cursor_no with MSM_BO_SCANOUT flag
Date:   Wed, 14 Nov 2018 17:24:09 -0500
Message-Id: <20181114222418.15960-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222418.15960-1-jonathan@marek.ca>
References: <20181114222418.15960-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For allocation in contiguous memory when the GPU has MMU but not mdp4.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 8f765f284d11..484d2fc2f415 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -534,7 +534,7 @@ struct msm_kms *mdp4_kms_init(struct drm_device *dev)
 		goto fail;
 	}
 
-	mdp4_kms->blank_cursor_bo = msm_gem_new(dev, SZ_16K, MSM_BO_WC);
+	mdp4_kms->blank_cursor_bo = msm_gem_new(dev, SZ_16K, MSM_BO_WC | MSM_BO_SCANOUT);
 	if (IS_ERR(mdp4_kms->blank_cursor_bo)) {
 		ret = PTR_ERR(mdp4_kms->blank_cursor_bo);
 		dev_err(dev->dev, "could not allocate blank-cursor bo: %d\n", ret);
-- 
2.17.1

