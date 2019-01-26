Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A677C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBCF218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="jtHafKrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfAZPWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:22:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39635 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:22:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so6041386pfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 07:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9J8tCfYEcyYaA6hgxPPb/Z+eto4Izp9XCFAcwk0CJt0=;
        b=jtHafKrq4hsnUdE3ck0oRzjRA1bdl5gmIAsaAxTC326OBR7/2N1Gl5uRm4lb89+FaM
         eaoz3t5G4HbANwLE80Z2nH/oyNeYvLoeK47gh7q2zfpefUpZW1agOozDBIpT0qnsBgHv
         Q3wCoLjk+BY3vrr1Mzj7HbhDC1UB8sKhu5L5Jh5fLZzTLJNbQhX3PmEPjqKPeSBtLGxn
         VsCphL+flYt7BKILQOf25KaWRv0pAsyw/yzrevotpOt4ZTm92Xy0b/b9LnvwLZ2opf6C
         PyoDZrJ8ws1wNNPm8b+0hr9vXdPro4bd/+Bd2uN0Wn8e7iS9bAIvtdofWl/960ufbS4W
         5eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9J8tCfYEcyYaA6hgxPPb/Z+eto4Izp9XCFAcwk0CJt0=;
        b=I1C7Qg2GBFERcmNpvJ/Rx6GiJ88f/trD5Oh+UuEuPyROi1r9mKBeGZyIygfvqLORBD
         LjzTP3bJwOrPoLdCdfiUPfqTTEoTdjdb7jsnpLlBtlWQSooSr8LPKs2e7/Wk2WoqECW/
         c8EpBb9uTHFjlP2jDxTac0UT0S5lprt6KyeHng7x1QlEn8xiQH8xUV67pbeazJVjxeju
         F0HSBMopr48gMW6ChU0v1D7toWXDrQZ33KqCK3INMDb57Imt/v095mBjTN/zEK1Xp8DN
         hqaa7TY70niIXLqEXS+6kPFW8VUUrzxuEBhZnGQDRI3pijd9wII1hixrTz4aY9X7KVKw
         lqWA==
X-Gm-Message-State: AJcUukcAVtKYWqgCEahgbL2nsfrOtmyN1zT4KZpubb9rYH0vl8ZJb1JW
        rbdtyL/d1h+MNTGuj7PJsydOAg==
X-Google-Smtp-Source: ALg8bN6Y4Z8pMdXbpAgma9WZxhZVctmqbFnd6oPSP/JyjZxVBcMJCZgUPEbmw6CnIGed+aUIRU70tA==
X-Received: by 2002:a63:3f89:: with SMTP id m131mr14034731pga.115.1548516169468;
        Sat, 26 Jan 2019 07:22:49 -0800 (PST)
Received: from localhost.localdomain (36-239-222-123.dynamic-ip.hinet.net. [36.239.222.123])
        by smtp.gmail.com with ESMTPSA id g28sm46024849pfd.100.2019.01.26.07.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 07:22:48 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     S Twiss <stwiss.opensource@diasemi.com>,
        Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: da9063: Check return value of devm_regmap_field_alloc calls
Date:   Sat, 26 Jan 2019 23:22:34 +0800
Message-Id: <20190126152234.3091-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126152234.3091-1-axel.lin@ingics.com>
References: <20190126152234.3091-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since devm_regmap_field_alloc can fail, add error checking for it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9063-regulator.c | 29 +++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 8cbcd2a3eb20..85c45577bad1 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -835,21 +835,40 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 		regl->desc.type = REGULATOR_VOLTAGE;
 		regl->desc.owner = THIS_MODULE;
 
-		if (regl->info->mode.reg)
+		if (regl->info->mode.reg) {
 			regl->mode = devm_regmap_field_alloc(&pdev->dev,
 					da9063->regmap, regl->info->mode);
-		if (regl->info->suspend.reg)
+			if (IS_ERR(regl->mode))
+				return PTR_ERR(regl->mode);
+		}
+
+		if (regl->info->suspend.reg) {
 			regl->suspend = devm_regmap_field_alloc(&pdev->dev,
 					da9063->regmap, regl->info->suspend);
-		if (regl->info->sleep.reg)
+			if (IS_ERR(regl->suspend))
+				return PTR_ERR(regl->suspend);
+		}
+
+		if (regl->info->sleep.reg) {
 			regl->sleep = devm_regmap_field_alloc(&pdev->dev,
 					da9063->regmap, regl->info->sleep);
-		if (regl->info->suspend_sleep.reg)
+			if (IS_ERR(regl->sleep))
+				return PTR_ERR(regl->sleep);
+		}
+
+		if (regl->info->suspend_sleep.reg) {
 			regl->suspend_sleep = devm_regmap_field_alloc(&pdev->dev,
 					da9063->regmap, regl->info->suspend_sleep);
-		if (regl->info->ilimit.reg)
+			if (IS_ERR(regl->suspend_sleep))
+				return PTR_ERR(regl->suspend_sleep);
+		}
+
+		if (regl->info->ilimit.reg) {
 			regl->ilimit = devm_regmap_field_alloc(&pdev->dev,
 					da9063->regmap, regl->info->ilimit);
+			if (IS_ERR(regl->ilimit))
+				return PTR_ERR(regl->ilimit);
+		}
 
 		/* Register regulator */
 		memset(&config, 0, sizeof(config));
-- 
2.17.1

