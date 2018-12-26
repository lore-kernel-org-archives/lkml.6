Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC8AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972A921726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Sqzp571m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeLZBRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:17:09 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:41334 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeLZBRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:17:08 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id D58D9A2C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 01:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MGjx7l_ZsX5K for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 19:17:06 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id A93309F1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:17:06 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id t4so3532264iog.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 17:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rQzrh5S0ze8VHOJQZ5zBvkOzGOJzy34s2xVvDwFLXd8=;
        b=Sqzp571mDdB9KG/w2UMWuFMfY+JDbTgBSoG6JfKxNzB8IfYYLclIHpeD5LyWbaE0p8
         fE3HEaYH7hrbitjnJn3ddJKqc9Wifk3x76KZaOT7oEGPqlNfzIpx/GYZXIbifd9oWKg7
         RW1cQyrxvEKJNkqSv+EcaXdqnGH/jetwWLJSoGLOYRhuNKret6pi6H9TP0qzE0Xq+lUC
         mEaJ3/7nsocCS4wPzywCjVNEqjFpYn/U52OvAbnPOqOh47qKFmEWf4PwWuDOBv78+og8
         eWjenysWHP5n7BXfibglNseJJeNlNorouXANgtSx2+yoArQ8HDXj3ww0ziKN/141TdIL
         5vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rQzrh5S0ze8VHOJQZ5zBvkOzGOJzy34s2xVvDwFLXd8=;
        b=Gg1zhOJDMazAzoCtxx7+t/Xy8NcUW0m6a3QSz5PL4YHYwimaLxdVuNH2D37J7Pp8kR
         4mbf+FoXndX60edBPQdpeeLMkk8YQZ9XUvLpgGPQ1b5Pnlq3ZDVFn/o2YUcbbv+VTDM8
         5b75UD4Ceh8iVUWY2v63+ifpLZ7egKOd4vwO33bb6Cwfv/jQBN0U2RTACil/lQ8Opnc7
         yAuYMoLBRnM6GZZcLm8DfMzuOvbzz0wqVdb2NPqmF4Wy6am8lf9nQ1M5mRVmdU7V8sEN
         lcjwl0hnKo+5TOHWCkMW0R/GGtZODC1MNN0gDqzeXl7D/pDkdqfSJiTRingS1EyVDOgB
         At5g==
X-Gm-Message-State: AA+aEWbJvfeDkGiMol+iYfZCnYnqb3NnDpSfV3ESIJzvn5lnbcrORUQ0
        pDLuRwf2s8DBf/Zj5Ee+zBsHhQ3x/oevRjPf0ETAQv6yUXesHRI+qsuBoKxNDGJ5DMTKa9pDWIu
        J5ugbBbz1sPnbcMkr2kvbA4c+vbu1
X-Received: by 2002:a24:45a1:: with SMTP id c33mr11481751itd.90.1545787026283;
        Tue, 25 Dec 2018 17:17:06 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XT0v3oS4tx1L4rRc5/m4DnAghmNDpcgXWnxo3tV9QJW+NkMoCEQSymo/eHNt8M/FG7IFPe9Q==
X-Received: by 2002:a24:45a1:: with SMTP id c33mr11481743itd.90.1545787025970;
        Tue, 25 Dec 2018 17:17:05 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id j1sm754612iok.79.2018.12.25.17.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 17:17:04 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] slimbus: add a check for the status of platform_driver_register
Date:   Tue, 25 Dec 2018 19:16:33 -0600
Message-Id: <20181226011633.70420-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_driver_register() may fail. The fix checks its status and
issues an error message if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 1382a8df6c75..5b923c8dedb2 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1443,7 +1443,9 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	init_completion(&ctrl->reconf);
 	init_completion(&ctrl->qmi.qmi_comp);
 
-	platform_driver_register(&qcom_slim_ngd_driver);
+	ret = platform_driver_register(&qcom_slim_ngd_driver);
+	if (ret)
+		dev_err(&pdev->dev, "registering driver failed\n");
 	return of_qcom_slim_ngd_register(dev, ctrl);
 }
 
-- 
2.17.2 (Apple Git-113)

