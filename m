Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AA5C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB4620841
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQgCFLG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB4620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeG1O3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 10:29:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43448 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbeG1O3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 10:29:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id d17-v6so326567pgv.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 06:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cKVmWbsmRatw9lLoErXDgnioJWcQrmaPhuuoM37+lJQ=;
        b=qQgCFLG1IBsip9ghRe9nZotP5C5/QD5mK+fDA57Yzsve6XaTbwF9JiqAfteqhBirZ7
         67r+KpkXz3/gXbgEsRpeIhPjrLP1xL/8ha5BY5QGTdEhEZ0/J+lHRp/8efOvwZkIBpmL
         JNTu0RvfuqRuhmwOLD0CVKolOtcvHnwoHxUOheYAZ+nqJQ+UCM5ZCSW3dLT7gA1uOtdu
         bHgHsOejMmwBdzzYTZeXjMLBHNg6LDnXKIicKTvrx2wEDcYEoLNyEfacdVxkS4MUgv5z
         IWG+vbAldJ6IdwXxP1uNWvqplvf6+WLwKHZB1irS2BEKmic+cVBXgIsHvIjSaZrarDlD
         0Tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cKVmWbsmRatw9lLoErXDgnioJWcQrmaPhuuoM37+lJQ=;
        b=EP87U4rDkTsJURvJ8YRXJfGXjvh8yiidWsH7zLIV7TGCZoL8+iL6131Ob+c74W55kM
         DNDV16XCZxCdRAjl5BHjIutM58WMNPUxzG7OyeOeem57T2vg4qnyVd2GNbzYUNg08UxU
         0nTDlToQYTcW4IpNgB574xOhtP1cGkyQwMnrYXYaEaomn17/nsOKRzxtdZCI9y/LTjBx
         wwDiQxXvcmdQ3pNh+g92rFsp7PtN0XEmfbU/2SAtPVGBd+QnltQIdoCLpTuy4TSFil2t
         yEcpBq6RGxyF/NGK6m0GqDDct1gfurNuYWzj++DTG18oTsVzL8igtFbR45CxP8NeZUZa
         OA9g==
X-Gm-Message-State: AOUpUlFOLYYs0aCDpWcj0Ib2IqqZS+p2/ARXiLFcGyzMFakzi5DF7M5s
        M8ax1axENp+0krfXWsksopQ=
X-Google-Smtp-Source: AAOMgpe6KSAiJg5Zdyd2XLOjJOb73B4v609aLWjA1iaa5Cn0998EKp+TydO6JAPfoDNUGREf4LT32A==
X-Received: by 2002:a62:3ece:: with SMTP id y75-v6mr10697621pfj.7.1532782957075;
        Sat, 28 Jul 2018 06:02:37 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.18.16])
        by smtp.gmail.com with ESMTPSA id 13-v6sm9595141pfw.131.2018.07.28.06.02.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Jul 2018 06:02:35 -0700 (PDT)
Date:   Sat, 28 Jul 2018 18:35:21 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     p.zabel@pengutronix.de, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ajitn.linux@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/imx: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180728130521.GA6336@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert drm_atomic_helper_suspend/resume() to use
drm_mode_config_helper_suspend/resume().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
---
 drivers/gpu/drm/imx/imx-drm-core.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index 1d053bb..cdd83ea 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -355,37 +355,15 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
 static int imx_drm_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct imx_drm_device *imxdrm;
-
-	/* The drm_dev is NULL before .load hook is called */
-	if (drm_dev == NULL)
-		return 0;
-
-	drm_kms_helper_poll_disable(drm_dev);
-
-	imxdrm = drm_dev->dev_private;
-	imxdrm->state = drm_atomic_helper_suspend(drm_dev);
-	if (IS_ERR(imxdrm->state)) {
-		drm_kms_helper_poll_enable(drm_dev);
-		return PTR_ERR(imxdrm->state);
-	}
 
-	return 0;
+	return drm_mode_config_helper_suspend(drm_dev);
 }
 
 static int imx_drm_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct imx_drm_device *imx_drm;
-
-	if (drm_dev == NULL)
-		return 0;
 
-	imx_drm = drm_dev->dev_private;
-	drm_atomic_helper_resume(drm_dev, imx_drm->state);
-	drm_kms_helper_poll_enable(drm_dev);
-
-	return 0;
+	return drm_mode_config_helper_resume(drm_dev);
 }
 #endif
 
-- 
1.9.1

