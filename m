Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE8CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155F420BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xxKxnAeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155F420BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeGLLvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:51:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53179 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeGLLuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:50:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id w16-v6so5328643wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 04:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GWCnE4XLO94EGLzXXq6qe9iCogYHx+8v3kWsPqTzVAM=;
        b=xxKxnAeo1Gij3N/PTWZC1RiPqIOF5Swl4FZsm7mDCz4LNsMpirWpy9EJlxtEW3ADZI
         E0UV9Fkf7FsLzn0+nrxr6tbYvLVJAXdC+iPs/RVk03h+VQtjfOoWMikU6shz2FvmacYG
         r3qi4sVHRRVaGA8kO2HfdJo/I4mUoGGDTdwx5S59CZoPoem/dI/muON4AWrB5fhsr47l
         NfJpQiwUE9p+2aA1vL3e7qKxYxPU0dJ1qyV2XRu7YdBP/tobgxqx0zr2uKuZX8Vgy3PJ
         I3mKkxYtRxnQmXE9CtbwekwDxyiA0jmetbpH6QP69r1Yczl3c9iULA2H81tcgT02uOMr
         IlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GWCnE4XLO94EGLzXXq6qe9iCogYHx+8v3kWsPqTzVAM=;
        b=JGps6OhrFix2BwwmcE5QF12qAhZCC6Lu4mvyodRVQl30R/OJbm1vpFk4pL806Xc4oh
         YdByvh5bE7RepKP+E/tful9bgtU/LfHKFeqvfNW5D0OPNJhqor6N37MhY6+/ZnESZsjJ
         b2FAHWPRSZalktwBZRiDS0ZrP75nFy+ZRX1+gM6G8n+6He68oTBxdCMSXBkfYmtUq4wO
         npOKWqa0R2eVbUEH8fQDk2gRoTcek7IfRldc63utbAdIDZmPNMube++V/IXrLEncqfl3
         cryOJL9i4T+2bQaHszVGtvUXVwUrDE3k9iGETjNeyeouAX4RO6objcSnrDjirkyQjewV
         5XUQ==
X-Gm-Message-State: AOUpUlEP1mVNwf+ASvWzixR3KGAZh7o0cp7N+JNmbhfiMVMpCPjXIQXJ
        T/E0gHrdpK/z1Qgcn2t8FRyPPw==
X-Google-Smtp-Source: AAOMgpeDKgs0X3CqEUcVbvP6D9ByYYaErSn6fDidkCX9tFLEX2RlzvhYtvtrH6bDIQ9IjSVLSu1B5w==
X-Received: by 2002:a1c:1748:: with SMTP id 69-v6mr1124265wmx.75.1531395703735;
        Thu, 12 Jul 2018 04:41:43 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l3-v6sm7716939wrb.34.2018.07.12.04.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 04:41:43 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, tj@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/3] ata: ahci_platform: convert kzallloc to kcalloc
Date:   Thu, 12 Jul 2018 11:41:30 +0000
Message-Id: <1531395691-4653-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
References: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better to kcalloc instead of kzalloc(n * sizeof())

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/libahci_platform.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 70052c046559..be9f54423a9b 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -351,7 +351,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	struct clk *clk;
 	struct device_node *child;
-	int i, sz, enabled_ports = 0, rc = -ENOMEM, child_nodes;
+	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
 	u32 mask_port_map = 0;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
@@ -403,14 +403,12 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 	if (!child_nodes)
 		hpriv->nports = 1;
 
-	sz = hpriv->nports * sizeof(*hpriv->phys);
-	hpriv->phys = devm_kzalloc(dev, sz, GFP_KERNEL);
+	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
 	if (!hpriv->phys) {
 		rc = -ENOMEM;
 		goto err_out;
 	}
-	sz = hpriv->nports * sizeof(*hpriv->target_pwrs);
-	hpriv->target_pwrs = kzalloc(sz, GFP_KERNEL);
+	hpriv->target_pwrs = kcalloc(hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
 	if (!hpriv->target_pwrs) {
 		rc = -ENOMEM;
 		goto err_out;
-- 
2.16.4

