Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B2CC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1147820020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RYNou3E2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1147820020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935388AbeFRRXK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:23:10 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40675 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934963AbeFRRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:23:08 -0400
Received: by mail-pg0-f67.google.com with SMTP id w8-v6so4810505pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zYKY/M5v9IljymNM1No/utpSz2vumnyX/pJFyKFgmOY=;
        b=RYNou3E2SigxWaH8gsAmVqn5/wmx8GABr8L5JBh1nAoPVI5xvjZowkYu/dshn1Qe1c
         H18844maG45H+ybKfk9BKHl2W7cjfX6Hhk/KwVn8dyciky0KCd/ixN5gHe6KJaBa6L4m
         3x38vS5cwQF1zdtfHFuWKvNCPArX0XuMaMrDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zYKY/M5v9IljymNM1No/utpSz2vumnyX/pJFyKFgmOY=;
        b=lMw8EEcAAT+shZq6Z+nP5i5eY6aO8ePI5I3Xi8yyXexFpkrgGzof8g3SqlK7U2bZeK
         ri8KifasaEPmD/qjRHQm2Owvw6yuYainOTYuVcTMDsmToXUmn0GRpboUvCEeSCT0pSas
         ZsYcnUEDu7ZSuLPQ7Q1A+c6Jrsf4MxJQMSWQBIsbWjsl0PL2w3TifcoTTnq9gMoNFAB3
         Ub/2zRhI/AzxDnQ66xW+Sneg41pjoFneRq6JM9Xlmy1kMmCF7nz5opov2a+0b1DMod79
         3rmGI+3af3IDGD29CmkP1U3+Xud3DWHLtrrD86OvzsbSoAQEEoPQSsXGzKaF41tVdiyH
         X1cw==
X-Gm-Message-State: APt69E2MZLV+KoxR857n2D0KgwrvM/bpzR1fg+tTQZqlS5BHqCGWJohu
        VrzYOnWrfh7q1O06X7R3zSImSw==
X-Google-Smtp-Source: ADUXVKJY62YHmuds/GBLqNvvrZCU88nngNdFuFChdyjeV4ncvPQk7MgRvvkvlp64vDDsZAjHe234Cw==
X-Received: by 2002:a62:4c88:: with SMTP id e8-v6mr9819135pfj.99.1529342588389;
        Mon, 18 Jun 2018 10:23:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id z26-v6sm26849091pfd.60.2018.06.18.10.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 10:23:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     andy.gross@linaro.org
Cc:     tdas@codeaurora.org, collinsd@codeaurora.org, sboyd@kernel.org,
        ilina@codeaurora.org, broonie@kernel.org, rplsssn@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: qcom: rpmh-rsc: Check cmd_db_ready() to help children
Date:   Mon, 18 Jun 2018 10:22:29 -0700
Message-Id: <20180618172230.241960-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Children of RPMh will need access to cmd_db.  Rather than having each
child have code to check if cmd_db is ready let's add the check to
RPMh.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This code is based upon v11 of Lina and Raju's RPMh series.

With this we'll be able to remove this boilerplate code from
clk-rpmh.c and qcom-rpmh-regulator.c.  Neither of these files has
landed upstream yet but patches are pretty far along.

 drivers/soc/qcom/rpmh-rsc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 144a058407c0..ad85523bdd3b 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#include <soc/qcom/cmd-db.h>
 #include <soc/qcom/tcs.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -621,6 +622,18 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	struct rsc_drv *drv;
 	int ret, irq;
 
+	/*
+	 * Even though RPMh doesn't directly use cmd-db, all of its children
+	 * do.  To avoid adding this check to our children we'll do it now.
+	 */
+	ret = cmd_db_ready();
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Command DB not available (%d)\n",
+									ret);
+		return ret;
+	}
+
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
-- 
2.18.0.rc1.244.gcf134e6275-goog

