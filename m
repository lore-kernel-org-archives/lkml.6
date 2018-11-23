Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A071C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB82520664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmppXrXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB82520664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504700AbeKXBj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:39:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43915 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391125AbeKXBj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:39:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so3174446pgk.10;
        Fri, 23 Nov 2018 06:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BS4LGCaG5favrtzVEmDt8gLebfrgMu8n0Cn8BS3Xxc4=;
        b=mmppXrXd2hMGDa/kUorHnovI/1SSU/qjQgdBQFtFQt1VqRqCO9Ja7jP+XuHxaRllM7
         iZ03CqrrWPBO6j6eIeZkZF0XaO9gq213NhMvXTxdxYh2jlqBRJgKGz07XL2S+qolzzIP
         QfDJN4teNW8YbiG6IwrYX4/7/Ur4zm2Mqh10uugNkGR2I+8CqZpoDvgeP96WiuJps+wV
         CgW5JyuJAgTJ3ZQHB4wzaxt9V3iPAL0tGSVK+IIXpAfFRVFCsdFZOHywHsmFY2klBLtK
         mSCNCrMuOJHddsYme3DflLpyFcm16JMcCBiGjax7Iy+A7987/mzBzBfIubcd3250k3n5
         NCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BS4LGCaG5favrtzVEmDt8gLebfrgMu8n0Cn8BS3Xxc4=;
        b=RJsjAfXtSIUUmfatUJD1DkpAeuic4vktVX7gk1r2/UAvEXJukmnrGQVKY1jNLimGFP
         /42f3/ZQPhzRbQ7J2fP1Aaq3hwbrIqrnnXDUEp3+Dvvy1IdUNkzU0BuEMEEvVV3g6sr1
         jBCjt+F9FhLuudDU99YNOZ1WQCpZH318GkoikXIsIHXBr8PVEJmA4aTxjNQoA0CMre2h
         TSWJIGh2PAPZKDSNPQ0gkDCrCk9wOMsAQC31fmaUtrRMkeZbNVWvTMghEANGj0X//Vzb
         53TvJdLJ9QV7aa+xUYPr0wYWUyz/xOaK0SkyG3Olr6i4t7bhbt+yrGDoRI6HXj3DOIX9
         HFLQ==
X-Gm-Message-State: AGRZ1gJ2wbsY+1d/TwFcWP/cpp/MqC/8eQfPTZkB8zr/1wZURm8IxOmL
        FuxCUanWCJMkJ45bIT5Tx8Y=
X-Google-Smtp-Source: AJdET5cUit1sMsfXCdzkMAwQcMcMVq1OYaknLId87iga93qNV+mTG4FuAQOrliFjjnfR41ZM9E3x8Q==
X-Received: by 2002:a62:5881:: with SMTP id m123-v6mr16430291pfb.160.1542984929266;
        Fri, 23 Nov 2018 06:55:29 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id y5sm43505804pge.49.2018.11.23.06.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 06:55:28 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] thermal/intel_powerclamp: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 23 Nov 2018 09:55:22 -0500
Message-Id: <20181123145523.27248-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/intel_powerclamp.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index cde891c54cde..7571f7c2e7c9 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -708,19 +708,7 @@ static int powerclamp_debug_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static int powerclamp_debug_open(struct inode *inode,
-			struct file *file)
-{
-	return single_open(file, powerclamp_debug_show, inode->i_private);
-}
-
-static const struct file_operations powerclamp_debug_fops = {
-	.open		= powerclamp_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.owner		= THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(powerclamp_debug);
 
 static inline void powerclamp_create_debug_files(void)
 {
-- 
2.17.0

