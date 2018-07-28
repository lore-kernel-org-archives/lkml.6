Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6B2C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2564420842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnJmrdtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2564420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeG1RES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 13:04:18 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39602 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbeG1RER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 13:04:17 -0400
Received: by mail-pl0-f68.google.com with SMTP id m1-v6so3586070plt.6;
        Sat, 28 Jul 2018 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ft7ulf9KrPoL8Oqnc9vCFSde04xHegaQJOgM+n/MNbg=;
        b=JnJmrdtdUA2PaZg32F5EhA1kHptTA/mtRnA1kYVi8NVyCUfv05dOCEQoPHLBAFM52c
         uJwpKF2oaP5Ubmf5nhoh3Vcy2z69BEJLav7r9d/YPQqXC455XmfWvnQBMKW4BJil9vnf
         7GmvGlQluXbVpq4+EhAZWa4noVOd0LdppfAITq9gmCmwQRXfnSdYEY6eDrbV6GkO3JpS
         0MRZhEct+S4NGyiQ/a3zg3Ewkqlka1ZMMYztCdZrTZJuFeqS6hLmxRtrrGnIJobuTYGb
         LH9D037jXYUQTANYkpbk41G5IgGbYHQGC72zVjfVhc4bpZtcz+i4sn8bSLy+R3F4D9DP
         zNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ft7ulf9KrPoL8Oqnc9vCFSde04xHegaQJOgM+n/MNbg=;
        b=oAVFr0YrPrGBk+YVN+FC0UcEeoGnFKc3dA4n2kprVrTL9iTEAjzTJAkFE2auDqxnRi
         Qvyvf2llvmRyCZ1gOE1mjMbRJvuVdUnZTMyP/2IYFrl24KB2mD6NnGBgJJ1ypsGGRsBQ
         c9Be9v6fbdeiqSWyjYelBlf93+RqzLw0zbuC6ENslQQJIX6aJNk7Zs4LVrxEeNuekfSE
         gfJFzQZkrKRvZCSZXeaHIfDXH+iiVIUx3s6nqxJleACdmf1RwX2EByb5uH9395ex48C0
         rGWS09YjtEOasyP8cl1briX2SvmhgUcqImaLG3UmQeZWAdekGG07M/+ogkOyAn0481w4
         psNg==
X-Gm-Message-State: AOUpUlFRHqMmP33pyvBEpfCr+8O4uTb8EqFxEM6WLu9UZSZvWsUYz/Dg
        g2b97drRx96LaICIFceygtI=
X-Google-Smtp-Source: AAOMgpfISJIAlCWvbZH/fiHVu8dKdHt6Gj0TEkqIQXBgTotddbRzehCgwEGhZ5c2hShZwaAillXCmw==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7-v6mr10350468plt.288.1532792243210;
        Sat, 28 Jul 2018 08:37:23 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.18.16])
        by smtp.gmail.com with ESMTPSA id c1-v6sm9525584pfi.142.2018.07.28.08.37.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Jul 2018 08:37:21 -0700 (PDT)
Date:   Sat, 28 Jul 2018 21:10:07 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        ajitn.linux@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@ffwll.ch
Subject: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180728154007.GA28426@jordon-HP-15-Notebook-PC>
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
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 02aee6c..288220f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device *dev)
 static int rcar_du_pm_suspend(struct device *dev)
 {
 	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
-	struct drm_atomic_state *state;
 
-	drm_kms_helper_poll_disable(rcdu->ddev);
-	drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
-
-	state = drm_atomic_helper_suspend(rcdu->ddev);
-	if (IS_ERR(state)) {
-		drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
-		drm_kms_helper_poll_enable(rcdu->ddev);
-		return PTR_ERR(state);
-	}
-
-	rcdu->suspend_state = state;
-
-	return 0;
+	return drm_mode_config_helper_suspend(rcdu->ddev);
 }
 
 static int rcar_du_pm_resume(struct device *dev)
 {
 	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
 
-	drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
-	drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
-	drm_kms_helper_poll_enable(rcdu->ddev);
-
-	return 0;
+	return drm_mode_config_helper_resume(rcdu->ddev);
 }
 #endif
 
-- 
1.9.1

