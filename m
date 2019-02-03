Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45558C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC942083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDj4zeFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfBCJnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 04:43:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44941 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfBCJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 04:43:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so11347660wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 01:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8XOxIvCn+tPqztnOtB+DmxQtvKnZOv32CIqS78Vdko=;
        b=TDj4zeFk2rmANOX6en9DCjFXy0cc3lbOFqMerckA5yPMMjAa39GSXPsKxDVPqyO5Dc
         eQVkLeu/5gmSibpvLTp1eTKwUj3S6B3yCIOTI0J2RTTmkaidesiTKTdJ2DRdD+PHgsxc
         ei4lU0CrhhzFRKeTb3JsIK/p/TsppEZstztgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8XOxIvCn+tPqztnOtB+DmxQtvKnZOv32CIqS78Vdko=;
        b=POC0iuk8y3R9vnloDiAi0xXYqXu5nd4jEbHVSSLL8qK6SVOqobSa1TDAZ+at/xWFX4
         v6K9vDuOo9e3+u/3WwVfUvriOMvwWyEYNaolJWC3k5GaLkkwwdeJnfJlMJHMZMAQlj9g
         SVyEVekPwDLqWVOGtRu6BDwEBesqGsquWuH9AsR+qmitfySCn8y/yWDxMk4nS4WifO6L
         Eoq3Uu1XWjd2Tp+2RXyBhzYf0f3OxR9azG1F+C5/1Yd0Etb7hGoILBG5Mq61Mj+hbdHp
         ZG82RXC5jClCkVq0juK46eJxAx7VPSfbP67gojfWC3ZCNiCnkkYnzHfbvOm1n5F/x984
         XTAw==
X-Gm-Message-State: AHQUAubIgfsNZfETPpIgO4mh3hnDDmEjJoDf9QW49qvtTo+STFGQFrr3
        g7lMy4DgtKUkhFZD1N53d+q1MTY3v0g=
X-Google-Smtp-Source: AHgI3IbKimrYZ5ij5q06NvxRhkXMYgOhKiz+mYKdFg26zcYEWaX3PwjkRomT+RsfbADtGMcrkgrEIA==
X-Received: by 2002:a5d:414c:: with SMTP id c12mr6842757wrq.204.1549187019194;
        Sun, 03 Feb 2019 01:43:39 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id v6sm21221964wrd.88.2019.02.03.01.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Feb 2019 01:43:38 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: allow to select i.MX nvmem driver for i.MX 7D
Date:   Sun,  3 Feb 2019 09:43:37 +0000
Message-Id: <20190203094337.5063-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

The imx-ocotp nvmem driver supports the i.MX 7D SoC too. Allow to select
the imx-ocotp driver even if only the i.MX 7D SoC has been selected.

Fixes: 711d45477931 ("nvmem: octop: Add i.MX7D support")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Hi Greg, 
If its not too late, can you take this patch for 5.1.

Thanks,
srini

 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 0a7a470ee859..9bbe2816400a 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -26,7 +26,7 @@ config NVMEM_IMX_IIM
 
 config NVMEM_IMX_OCOTP
 	tristate "i.MX6 On-Chip OTP Controller support"
-	depends on SOC_IMX6 || COMPILE_TEST
+	depends on SOC_IMX6 || SOC_IMX7D || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This is a driver for the On-Chip OTP Controller (OCOTP) available on
-- 
2.20.1

