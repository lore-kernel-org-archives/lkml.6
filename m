Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE11C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 01:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9062145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 01:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu694a1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9062145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeIXH2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 03:28:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46346 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeIXH2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 03:28:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id k18-v6so407766qtp.13;
        Sun, 23 Sep 2018 18:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jtUBTyE3+1G9QsPQA273Xo9sXUESs+UgJK80568o1t4=;
        b=Tu694a1ZdZcnhzz3pOrPb+TN0CmtBPrNZdcv95bzoTc3h8jZEzc1iNvZcMCNgOSEUy
         WAAzTgcZsEff83aFBiyvIlzW77kjQ5NtEz/weEy93VexfzVjhpS3Vk+Y+Ng+HhZah5Ci
         AP1qCvKr69Ti1AdyvXmDKqzIcrnCiilUCRoT5ESO5KL7zYx4MhgIRK3P/59d1aekabDx
         y/Fe7ZnJMCI2/5LwhruwU3Y9t/YIP10lY9Wpq4NBAX7rktFFQdrd/ehycsEfE3sz+gLV
         55M08IwyD6Kc6KFmH2h2gK3kqsCwEh6ypB+iqnkAWHvQCXxJyWQmFSoYRZW2HILy9EGN
         vVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jtUBTyE3+1G9QsPQA273Xo9sXUESs+UgJK80568o1t4=;
        b=LkjOBv8BWEfxAbQVVWjAfnqXYfdZbm54+YhiKJWEv9071QBT06gnJWFTfal/NmQSdG
         0c9O8F9n9snMoIwyXXJi3//SRZNKeBVkByqVmva9XoVr3bamdYmruIyWRgzHsqLfXNTJ
         5RaAcKDZ9W3RO1pZ+Ls3uicItC88MxiVeES5q9UqZ5pMj+z6r2WEBac1R2DZ3qw8YL39
         EkPAWWvMAruM5pMFrqDF1uPEguaPJi/sMDM4q8c5Uv2YQM9KwifI90neEcrOrT1anM0c
         /LIFyUPljzg6Rbq2UUto/Yg+1WbzvqgBah0i/l+ywO4PNUaW/flltISKvaWZbPpew8yj
         bVUw==
X-Gm-Message-State: ABuFfogbyAIH+WvG/6TbT0a1PwkZKHgFYiniQjpzXRXeLpvz7IVdtCkM
        Q5v47SG+4vVNdKI/C4VEJZfQImy7TyI=
X-Google-Smtp-Source: ANB0VdbKQ7qeLIx3vYA8cm6z8Sr9GGHW9DZ/dSnU1YnHJHfE8JbiwAf1E0udkATru0Ke6bSiVOjkig==
X-Received: by 2002:aed:257d:: with SMTP id w58-v6mr6050267qtc.110.1537752545802;
        Sun, 23 Sep 2018 18:29:05 -0700 (PDT)
Received: from josh-ThinkPad-T460s (65-120-91-61.dia.static.qwest.net. [65.120.91.61])
        by smtp.gmail.com with ESMTPSA id s21-v6sm7118160qtc.71.2018.09.23.18.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 18:29:05 -0700 (PDT)
From:   Josh Abraham <j.abraham1776@gmail.com>
X-Google-Original-From: Josh Abraham <sinisterpatrician@gmail.com>
Date:   Sun, 23 Sep 2018 21:29:03 -0400
To:     vinholikatti@gmail.com
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        j.abraham1776@gmail.com, kernel-janitors@vger.kernel.org
Subject: [PATCH] scsi: ufs: use PTR_ERR_OR_ZERO in ufs_hisi_get_resource()
Message-ID: <20180924012903.GA24400@josh-ThinkPad-T460s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses PTR_ERR_OR_ZERO instead of IF_ERR() return PTR_ERR().

Signed-off-by: Joshua Abraham <j.abraham1776@gmail.com>
---
 drivers/scsi/ufs/ufs-hisi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 46df707e6f2c..e79499469cb3 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -505,10 +505,8 @@ static int ufs_hisi_get_resource(struct ufs_hisi_host *host)
 	/* get resource of ufs sys ctrl */
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	host->ufs_sys_ctrl = devm_ioremap_resource(dev, mem_res);
-	if (IS_ERR(host->ufs_sys_ctrl))
-		return PTR_ERR(host->ufs_sys_ctrl);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(host->ufs_sys_ctrl);
 }
 
 static void ufs_hisi_set_pm_lvl(struct ufs_hba *hba)
-- 
2.17.1

