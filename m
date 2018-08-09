Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FD2C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134E621DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dp3z1FdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134E621DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbeHIO5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:57:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40818 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732137AbeHIO5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:57:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so2689494pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LajXdiR+UMjFusLCr0IrH9cyGv2mk15+PoiKf/4cna4=;
        b=dp3z1FdWV+2UM/p9OwFhQgpvGV9I72sQcZflwuQf1PLFveTjtGNRmQRLkaqTvrlLZG
         Kle5slvSSIksbdlO2jCJIJLCf4OoH1XLPjsxpBKiEldKEGwFKXEMyc6k80Hlm2OGIiVv
         UK43GFrevkBifNAgnt2y+h3hEQ09q4Lde6deg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LajXdiR+UMjFusLCr0IrH9cyGv2mk15+PoiKf/4cna4=;
        b=q2JxVD02ozdjs1JB+XHSd8lEmOIqsimZbnb07kuD8pwLhvxcR7r82T7I28yesB5os7
         tTe4oQ9/CB6uo8jvKfQIcnlfQCJqpd297wScPCXNJUNocuWjK75RnjZmB2HRniuLKSBP
         +m1sQAtKGKbrObscgpRXRZV/M7wdczOL2oKE0t5VfKxa9gSMuhnF1XuzjD+vzj4TAUSR
         V584kDmep5VNRXTtXMSOKvQBdrISrPs+lu3Ll2716gjUTzPFnej+LhXu3JJjjtpMvu4q
         Bec6JsrQSjVszcZTBlCzyyZ8gz1nxle4psOGF+2brdVz1LU9rhvmUdGRcD0KwbvMIBEw
         /IpQ==
X-Gm-Message-State: AOUpUlGTTCWvItNTtn9SSa41FJOu21z+T1HJp8q3nh5UagH4iiCF77eQ
        ioMYJru49TPHX1xkcxH9nooCdzrvX8s=
X-Google-Smtp-Source: AA+uWPzPyMgdO2kkhyzzGXNytsX3lfBz0ko88moZSlQql0zPIDYOhZx0SwmKuPf8U1iJ7VcpSHDntQ==
X-Received: by 2002:a63:5660:: with SMTP id g32-v6mr2029301pgm.227.1533817990565;
        Thu, 09 Aug 2018 05:33:10 -0700 (PDT)
Received: from localhost ([45.113.251.134])
        by smtp.gmail.com with ESMTPSA id i28-v6sm11592220pfk.108.2018.08.09.05.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:33:09 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v1 04/10] thermal: tsens: Get rid of dead code
Date:   Thu,  9 Aug 2018 18:02:36 +0530
Message-Id: <0f945a83190de17df94a1bfcab48e6a86805cc9b.1533815718.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hw_id is dynamically allocated but not used anywhere. Get rid of dead
code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 90bb431cf740..9a8e8f7b4ae1 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -80,11 +80,6 @@ static int tsens_register(struct tsens_device *tmdev)
 {
 	int i;
 	struct thermal_zone_device *tzd;
-	u32 *hw_id, n = tmdev->num_sensors;
-
-	hw_id = devm_kcalloc(tmdev->dev, n, sizeof(u32), GFP_KERNEL);
-	if (!hw_id)
-		return -ENOMEM;
 
 	for (i = 0;  i < tmdev->num_sensors; i++) {
 		tmdev->sensor[i].tmdev = tmdev;
-- 
2.17.1

