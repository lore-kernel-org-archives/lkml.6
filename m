Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91523C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C67824028
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2BCnL+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C67824028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933177AbeGFNEE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:04:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56137 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932379AbeGFNEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:04:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so14849463wmv.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Tb7st3shVAR02PPI8VyW+WbQUABCRQ96wJt2tDBcs10=;
        b=D2BCnL+Mrc+KgJj//9YPtLr9bh+gYxTmTmmx9Arxb202g+OLQ/q4hHnYK6R5b79bHP
         19KLkzH4Nce/PE78UKGDajanZmFzQvhxeiJxXLr+p/JKPDc5dqR4zc5rCZ0WRE8IQFGn
         buXAJDismfW48pTy+tozPJrAOXAOibeH4p+zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tb7st3shVAR02PPI8VyW+WbQUABCRQ96wJt2tDBcs10=;
        b=VoZEHIhBjerBclNWdXpr8z1VLCGb6Kakfz6bTxUkKHRdwN2PmwauYppxRpioU36GFh
         8kUDkZ+NK/7EcWzqkOmjTWTjYfq1hQ7pSUa8lC6aBFV+xqzxCJ0IcNWQedgx46ELEvp1
         GLSsrx0vAmlYhis2CmtCr7ov56UF5ol16lDtFi0vXcemfBFCIzX62FEJCTqRBPVbTIzf
         EPVrlBUcViQsE1agO/0k67HXIUol3+gyU36/4K/qNbcgtJ2ssxKEgw8RZ4YmxZgcK3Kn
         N7IheKiypzAzx2huvYZ6N96XfpIRmmEWZGkajONfQ8E65FoO/mce7s5UdbwWTsMIeG6J
         pD4g==
X-Gm-Message-State: APt69E23Ia1x4RET5oC/soNmY1OJB2UEHKnXw1Z9HlaFG1oKFFIMPqON
        zBeMt5BGFdKwy4//MKuHh22apg==
X-Google-Smtp-Source: AAOMgpc7B1ODgndxltMrhFsksPumiltl6beIJJNJgxNi9POYMDZcmYgiX3gGm/C0L3EbhHgvxq+F4w==
X-Received: by 2002:a1c:be10:: with SMTP id o16-v6mr6095374wmf.132.1530882241629;
        Fri, 06 Jul 2018 06:04:01 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([80.214.65.221])
        by smtp.gmail.com with ESMTPSA id h102-v6sm13219199wrh.60.2018.07.06.06.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 06:04:01 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     mchehab@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, hans.verkuil@cisco.com,
        hugues.fruchet@st.com
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] media: stm32: dcmi: replace "%p" with "%pK"
Date:   Fri,  6 Jul 2018 15:03:55 +0200
Message-Id: <20180706130355.22100-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 2e1933d872ee..fe90672cf16f 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1753,7 +1753,7 @@ static int dcmi_probe(struct platform_device *pdev)
 
 	ret = clk_prepare(mclk);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to prepare mclk %p\n", mclk);
+		dev_err(&pdev->dev, "Unable to prepare mclk %pK\n", mclk);
 		goto err_dma_release;
 	}
 
-- 
2.15.0

