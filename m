Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1C5C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2FE23EB1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cYqMykKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2FE23EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754283AbeFVIKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:10:14 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36487 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754296AbeFVIKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:10:09 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so3105669plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3A44ZW7qxPj/iWo29IiZBe5Y14C0QOYeV6oTMiK0IKY=;
        b=cYqMykKJ4kpv86+XOjlmZ57QrIazkeVKzNSrJZK62txV1rlRR/ttjU6bYzxuE+dQ7t
         3kx7+hi0XQm0UXQS3CQMJhrNRQLsAysAJbPIH5+ia79wBtFKRZOLvSMxTmElgNgAgPbN
         J19yV+UGCT0JfMxWWyME+579KAMQ5dwQleoHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3A44ZW7qxPj/iWo29IiZBe5Y14C0QOYeV6oTMiK0IKY=;
        b=P+/WCivXrSp7yeQZ3U9tBXPOUrT4F0eNKtcmQpXdLWl1XXekpfzQqCPhyF64X7k4g6
         pRToNRufGfViQTR1C6nIRn6vXpsbLbenTwK1qHkoSuIjzEf5YqpbTh3pAuaERrbhHsZR
         LRR0ep549MJv4z4k6ph8LsBxlyoeLjZcwSyN/KtqNUdmEDYjsNdswsIWWjF48fXOqr94
         QYR7hzzxoNsbnYsKk3B1nyLfTxBtneqyEpKQ8uURiJ28Y1UDcoq6gY38JWIXu9uBazXL
         wOWEDlJkRQO/3sjtHIXRpC1Znh69z7dmCrF6/MbvrkRF+WUYZDm/J0suQQQENJZS4kpt
         M7DQ==
X-Gm-Message-State: APt69E29wwV/873pgvZKDdELhx01KdtMr1EP3XcQVd7JdQ1UiV/JtAvC
        UuamXzb4t66RcE9v0aXLPJrIdQ==
X-Google-Smtp-Source: ADUXVKI8UtuuYMpY6XpBY9V8VZIqcJQzoPGqmncguM7FWAPehWBnDQB68kyskPkIuQQ/3IgKD18GFw==
X-Received: by 2002:a17:902:88:: with SMTP id a8-v6mr607893pla.156.1529655008639;
        Fri, 22 Jun 2018 01:10:08 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i65-v6sm22656131pfd.17.2018.06.22.01.10.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Jun 2018 01:10:08 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] hwspinlock: sprd: Use devm_hwspin_lock_register()
Date:   Fri, 22 Jun 2018 16:09:03 +0800
Message-Id: <e5f5f315a882fe5cdd161c8cb1790c9f3de0920a.1529654288.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_hwspin_lock_register() to register the hwlock controller to
avoid unregistering the device explicitly.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/sprd_hwspinlock.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
index dc42bf5..ba5daf6 100644
--- a/drivers/hwspinlock/sprd_hwspinlock.c
+++ b/drivers/hwspinlock/sprd_hwspinlock.c
@@ -120,8 +120,9 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sprd_hwlock);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = hwspin_lock_register(&sprd_hwlock->bank, &pdev->dev,
-				   &sprd_hwspinlock_ops, 0, SPRD_HWLOCKS_NUM);
+	ret = devm_hwspin_lock_register(&pdev->dev, &sprd_hwlock->bank,
+					&sprd_hwspinlock_ops, 0,
+					SPRD_HWLOCKS_NUM);
 	if (ret) {
 		pm_runtime_disable(&pdev->dev);
 		clk_disable_unprepare(sprd_hwlock->clk);
@@ -135,7 +136,6 @@ static int sprd_hwspinlock_remove(struct platform_device *pdev)
 {
 	struct sprd_hwspinlock_dev *sprd_hwlock = platform_get_drvdata(pdev);
 
-	hwspin_lock_unregister(&sprd_hwlock->bank);
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(sprd_hwlock->clk);
 	return 0;
-- 
1.7.9.5

