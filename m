Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED797C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B401D20645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="yQPVVobv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B401D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403910AbeKVMcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:32:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33927 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403896AbeKVMcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:32:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so5978201qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yi+83lbDblZvbXPQbq7ZeugGAkOASemcPW1GqEcxWA4=;
        b=yQPVVobvCBmtDsu0VzzDYZ8ElDKZl6XiVAs6b69QZLVKhj0cHpOwW1bW1y8k94hE/e
         UlbVjjgJRVgeNBF/m5ICFHbnUHj0K8ZhMF86qJ90TrOQnag0eFl4gRJ8N3finYIvEibU
         KOLM0Km+ZfV5bOqcaZOvO0JXH8tCTMkMSlR4VuMWmdTZAhRZm7LZVUO9IKELNQV5dFB/
         TGSsV8LqxIyykINyaGrGToRKT/i+3vBlcNtK3l7Swox5TfkyoFXl4+VrqXhl07xdTPWN
         nXfcfe3GsVKU/f5MTjSH7fs83bxWeKXzLaeMdG78sAigJAz2abaT3uZ1jE7aTcvzJbKM
         b06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yi+83lbDblZvbXPQbq7ZeugGAkOASemcPW1GqEcxWA4=;
        b=Y+OnTXrtbTTzgLWWxhAorGXKsO8szNNbL3nDVyIo0vtMbOnyrrOrfWhi5z0gcXaOz5
         d2ImSY3rH29Vsj6lMYxK9cSXdoCEPzxj8H5CvlR1OpQQNKNYEHnDHW7tlgw5SyCVBkz9
         V2fmYfiy3y4FzgcggbZysb6DiP08Tk8RcFCn4S/j6K0FS4Ot7T2NtHA/NdVc2h5V3pfD
         KTwsEgNbr3kVjCPdYs35qJvkwacp7NAf5vC5hUAUhWGwRnRbxTUbF2y7011+WLoyodi3
         9H1XB07Rhviedx+rbwPNQCKuZiHi8/eBreH8eQzWpNfYE9NCbycE1HqBEv0jAaKd6jor
         LQBQ==
X-Gm-Message-State: AGRZ1gLa5q7/7XsUoSWaFlAPNYXL7VdhVEAh37oPFNszpDr/w5INuDOe
        VH5RZnT5+j8q8DGwwM5ITU+OFA==
X-Google-Smtp-Source: AJdET5eL6mvcb/us0bH+XrmTgUPc1BaATQCGAt52H00E79htcNF0WOfrPjucOShYxhw2Eb/47tN+hw==
X-Received: by 2002:ac8:1b4d:: with SMTP id p13mr8179731qtk.56.1542851727567;
        Wed, 21 Nov 2018 17:55:27 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q15sm25297721qkl.81.2018.11.21.17.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 17:55:27 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Steve Kowalik <steven@wedontsleep.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/9] drm/msm/mdp4: allocate blank_cursor_no with MSM_BO_SCANOUT flag
Date:   Wed, 21 Nov 2018 20:52:28 -0500
Message-Id: <20181122015237.14534-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015237.14534-1-jonathan@marek.ca>
References: <20181122015237.14534-1-jonathan@marek.ca>
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

