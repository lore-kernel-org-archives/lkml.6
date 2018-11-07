Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24217C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDE720883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwZL/D5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDE720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeKHIld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:41:33 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35976 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeKHIld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:41:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id d13-v6so1201320pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 15:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a54bpJWkTONWX4xBh3sap+Bcri1qS8QIiPLNgbLvU28=;
        b=AwZL/D5dLy8phDigaMDGifD0erJIZ1zZs17j10a1S2Wl9x2zrDCMOxv9zAtFQhLSIV
         bk6jqEYxmJY7WT8BWaw/e51xYAo9YqgAlauZFLAPZdLTqieu3i4LXT1XxRZNBEqSeMkb
         EqSbDShuUBvk9T8TybIQXX2uDXWRvzyiks4dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a54bpJWkTONWX4xBh3sap+Bcri1qS8QIiPLNgbLvU28=;
        b=CfBXqKfXqhHilK8Q1RNPX0JJfOuCYCAv3oudkQTXZltvbQxNf4+iNvMUUWt6QXjH2O
         hUQveuJoeSmCaS+vjRCibR/v9k/H1X9A+LV+vGgkEN09pVcSN7Eo9kWwTJzc7b+8K1SA
         NMqnoxpFFRPZ1mM2N5QjQEEj1kqtu3oNc0vcSHW0zyEE7bzDuG3naqkioIGtNN2M10ir
         0VRBNjqkrj70X4mgN+U+n9LtHvl+PoJHhdNnPoAPSvYfxIwsWRMXBpTi/tGOYWrNonwB
         MNuMSvsGD/LNx7+adec2urNMk1NiSAcndJbzQcdWWFq8/pMgsISfP1ptAumUsBwbZ0Fq
         v/cg==
X-Gm-Message-State: AGRZ1gLG989sTsS7AGauCd6rgzm7GCt2e8drsOXBVBcrhOrF5jZH7hpr
        2XSWQSF4iXHbYRSYR4/REhBnig==
X-Google-Smtp-Source: AJdET5dpyeTDDwVw8Ii7UTx9Irp/YxjU71VqGAmt1rNhVrymFvkEsMTERD3lN1XK/PJHYOFugqlBkw==
X-Received: by 2002:a62:8208:: with SMTP id w8-v6mr2219657pfd.150.1541632137587;
        Wed, 07 Nov 2018 15:08:57 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e70-v6sm1802034pfb.113.2018.11.07.15.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 15:08:56 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] coresight: etf: Release CLAIM tag after disabling the HW
Date:   Wed,  7 Nov 2018 16:08:50 -0700
Message-Id: <1541632132-1252-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
References: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch rectifies the sequence of events in function
tmc_etb_disable_hw() by disabling the HW first and then releasing the
CLAIM tag.  Otherwise we could be corrupting the configuration done by an
external agent that would have claimed the device after we have released
it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 5864ac55e275..a5f053f2db2c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -86,8 +86,8 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
-	coresight_disclaim_device(drvdata->base);
 	__tmc_etb_disable_hw(drvdata);
+	coresight_disclaim_device(drvdata->base);
 }
 
 static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
-- 
2.7.4

