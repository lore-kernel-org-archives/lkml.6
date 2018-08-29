Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B70C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8EC2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/YkCFfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8EC2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeH2Lxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:53:43 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35705 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbeH2Lxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:53:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so3594577ljg.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zObaoypU2uzVmbj0aozqxiQCeTZ60KpvPIYalSHTKxM=;
        b=i/YkCFfcC+jM4HVp+90ZuD4vJtZ0EfxuG6XIt4Ystcb49J26d2NVWaC77wVAFj7U2a
         FexZAs6M1LfUOEKjCumWJ+TUsDThYLmGzretMbtol+9JcX+o8VURyq6bLr2Wdh+xR41o
         qH7ieaNDYliin5OwconCMi2Sd16Qsw2Y2sPik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zObaoypU2uzVmbj0aozqxiQCeTZ60KpvPIYalSHTKxM=;
        b=kSEwWsckLBEEKXAITHiY1wd5iAQFpCEoJiRLuIsp4fcQs7A3JK590XRjbHms1OnLfv
         ZuAppngo8HtyaJHe+BOZFH1TjbccPMOKmw2idMs+G0DFqxzVE0kgYDZ1dZHvJZb5F4Wh
         7hdjuo/h2E1xxyAOUJFyWYQ60oH33qye7bcVHWlczbOVf/Th0MN2p632Q/SWdblu+jkz
         kIPGKzmCBIkHViY192r7+f53u6N+cdB/CUQ6IzcQV/4toVXAjKk31UjwIinYbZ6QP9Yr
         fa5BzW2nhZUmHNNSXiz19P9+HDHQDrNLPkIMmaAJN2kWGFCS+UW+oYStJjCNICGp2zVU
         aaXw==
X-Gm-Message-State: APzg51Atw1bM1czke8NnY30Bq+vSKpQdGTT5Hw/Wruzv6QYd/Ai4OyYY
        nH5yqV2CnKtgYQHIQ1fGmlnASg==
X-Google-Smtp-Source: ANB0VdZEw3jRwLW5Ekbrqc8MEwf7hYqkg44UtD/oF7gAPAyq/Ar7V99XO/rn5qS42Lk4LrR2czxRXA==
X-Received: by 2002:a2e:97c8:: with SMTP id m8-v6mr3726571ljj.52.1535529484035;
        Wed, 29 Aug 2018 00:58:04 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j9-v6sm592303ljh.40.2018.08.29.00.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:58:03 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/9] soc: qcom: Remove depends on OF from QCOM_RPMH
Date:   Wed, 29 Aug 2018 09:57:20 +0200
Message-Id: <20180829075724.9095-7-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829075724.9095-1-niklas.cassel@linaro.org>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM_RPHM already selects ARM64, which always selects OF.

Additionally, the rpmh driver only uses linux/of.h, which has dummy
definitions for all functions, in order for code to to be able to
build without CONFIG_OF set.

Remove the superfluous depends on OF.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index ac657164a136..cf4ece232897 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -94,7 +94,7 @@ config QCOM_RMTFS_MEM
 
 config QCOM_RPMH
 	bool "Qualcomm RPM-Hardened (RPMH) Communication"
-	depends on ARCH_QCOM && ARM64 && OF || COMPILE_TEST
+	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
 	help
 	  Support for communication with the hardened-RPM blocks in
 	  Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
-- 
2.17.1

