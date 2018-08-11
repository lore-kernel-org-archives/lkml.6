Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5806AC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E983921A00
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYFSJ53P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E983921A00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeHKS7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 14:59:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41624 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeHKS7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 14:59:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so10733050wrr.8;
        Sat, 11 Aug 2018 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NRWcVmjoZOIq4vF441llFYiAmEEfOx+l/3fWdxYprPE=;
        b=PYFSJ53PzU8o5eMT5RSYcXDhu7OMmMn3c+B4ny0EzauLvElOVPraRhubioYFqgNuio
         1gfTV6aA1aLth3hV6Dp2MYDoJdNID6KmomGLnZ9aDho1MGpyBh6k3m34kuYevpwL8Hlt
         l9MZ2SMiyD0rduneNBLGwZrWvYcQoFO+3PrRkBTupkIUvuPkwEfyE8qFTyg7IsOGuEt7
         7dzVc+XDPnFTM44nWf74mnc+uQPyghpcpmDsdoLELlD5nxILVoNKvEYrazGEmNFcBOw/
         +7fsHJywI7Gnyu+oB3xfzefpP0hZKq1VztAltLOaCAEN/D3DxX1iGoip79C1QI+69jNd
         aCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NRWcVmjoZOIq4vF441llFYiAmEEfOx+l/3fWdxYprPE=;
        b=iqiYSdzb9j3AflNWzl2QZ8c7N4JdRM5IPU/RpQtEhSRqeihrqvAlIoTi4SdHTwGSZD
         REbbNrDc7gR1UnpXaL7Xlg7inkULNq9fmWbFzEa5XLmZ08nN8uk9xU66azHi0tSOQne0
         L5mPa0krftRoqg8ds05wei3qyDqExn+OUPi/PZdYUVYmGIE7H3xwnxVE+RbMz7JJGYQ0
         9gWS5rMp7lUAgizjM5W1ti0pansc27ixNPohhkCKxnOGMNMOC4C6b1lLhuuhIyV0v/25
         hNungyrW2uiJt40aVdsGoVgmFX4P+KaqcfpwwZ6sh6QcciPTc9mCqILrJWZnId2TGdbp
         p5ig==
X-Gm-Message-State: AOUpUlFubQGQlsh7H8fFedEtdk5lhUDhCr+47lTgZ3iDGArzWdUXuZJJ
        2O5SLJMXLZovpfsHApVh5TUAXcbnHg==
X-Google-Smtp-Source: AA+uWPyDn09Z7a2fIiAnKmrVBE2aRtncRP7pqwG4i0vZ3LOMrMWniOswBBzfonz5Xb0CEuVBDzVcZw==
X-Received: by 2002:adf:c44c:: with SMTP id a12-v6mr7000137wrg.20.1534004700569;
        Sat, 11 Aug 2018 09:25:00 -0700 (PDT)
Received: from localhost.localdomain (host86-141-127-107.range86-141.btcentralplus.com. [86.141.127.107])
        by smtp.googlemail.com with ESMTPSA id x82-v6sm14015342wmd.11.2018.08.11.09.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 09:25:00 -0700 (PDT)
From:   Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: [PATCH] firmware: qcom: scm: Add sdm660 soc compatible
Date:   Sat, 11 Aug 2018 17:24:50 +0100
Message-Id: <20180811162453.10930-1-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for SDM660.
This does not need clocks to do scm calls

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
 drivers/firmware/qcom_scm.c                             | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index fcf6979c0b6d..499608fcc864 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -11,6 +11,7 @@ Required properties:
  * "qcom,scm-msm8660" for MSM8660 platforms
  * "qcom,scm-msm8690" for MSM8690 platforms
  * "qcom,scm-msm8996" for MSM8996 platforms
+ * "qcom,scm-sdm660" for SDM660 platforms
  * "qcom,scm-ipq4019" for IPQ4019 platforms
  * "qcom,scm" for later processors (MSM8916, APQ8084, MSM8974, etc)
 - clocks: One to three clocks may be required based on compatible.
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index e778af766fae..ee113ceb5d41 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -603,6 +603,9 @@ static const struct of_device_id qcom_scm_dt_match[] = {
 	{ .compatible = "qcom,scm-msm8996",
 	  .data = NULL, /* no clocks */
 	},
+	{ .compatible = "qcom,scm-sdm660",
+	  .data = NULL, /* no clocks */
+	},
 	{ .compatible = "qcom,scm-ipq4019",
 	  .data = NULL, /* no clocks */
 	},
-- 
2.18.0

