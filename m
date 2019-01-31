Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC55C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3490A2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Argfay4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfAaRjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:39:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40591 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfAaRjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:39:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so1792180pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 09:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TPW8HtY0tlIfyE5OIWdHHRfrDRsLzci3JRYvnDZjIXE=;
        b=Argfay4eoSAA7qfNICb5mQx9JMrMHxSPOZvasCmmrQmFaIbp6T2WAJKibyNCyN3HJV
         cNol8UVqHP4Gt+8ImYApeG5OYFt3JhtVRO41MIQ7VNkGBih9Gc4Rk0EQ9p0Qe42vNur4
         U+/Gs6Zddr+HIWnBpkdRIQJo7jnRtt16obpmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TPW8HtY0tlIfyE5OIWdHHRfrDRsLzci3JRYvnDZjIXE=;
        b=JCeEkxHEB8QQHn46egKtH8oRTCyNWICdoZGw9olkp+z3dR0adaJ45tnnOfPVQ34jkG
         aVMdDVPlyoFpgfiLJt76x7D560DHBo5xpNbCWNGVbK8Pehcedh2nZmlBpbDzJv78C8FE
         VjvF5U61FolOm2slwBifYIagNsx0VmdmAdfRJh7aDsiU+m/mVqJer9XiBXks0WPT1c1h
         FGyF+x4hsU7ny4YjyzqN3bIUSIKRlDpcmavE6+6kAOkyGTC/9lEm5TGTC0VjF2BF/Kxj
         m8zARJxGE0Fpi3P/7zIoh8uWVL6VScBshk36XSRisqyt035FiKCeJNv7EhDSK0+LP2XE
         +wsQ==
X-Gm-Message-State: AJcUukem9+Q8vziNHGNQw6N7zbbzKjVrbbg1ZK9qWTlY21wu86pltRV7
        Ym4WWdXtFEzr4USQdmyz8y6+rQ==
X-Google-Smtp-Source: ALg8bN6WLHUFthYXTErAKFpY9fy9wskPrNu0hjpGJ2K+9SsyMEetA09AEH4qxmPv3XwVgGoafSvNDQ==
X-Received: by 2002:a62:c711:: with SMTP id w17mr35983046pfg.50.1548956347955;
        Thu, 31 Jan 2019 09:39:07 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e16sm6532393pfn.46.2019.01.31.09.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:39:07 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: qcs404: Drop unused UFS_RESET macro
Date:   Thu, 31 Jan 2019 09:38:53 -0800
Message-Id: <20190131173853.27706-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFS_RESET macro serves no purpose on QCS404, remove it.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-qcs404.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
index 4ffd56ff809e..1c6ba978c69f 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -95,31 +95,6 @@ enum {
 		.intr_detection_width = -1,		\
 	}
 
-#define UFS_RESET(pg_name, offset)				\
-	{						\
-		.name = #pg_name,			\
-		.pins = pg_name##_pins,			\
-		.npins = (unsigned int)ARRAY_SIZE(pg_name##_pins),	\
-		.ctl_reg = offset,			\
-		.io_reg = offset + 0x4,			\
-		.intr_cfg_reg = 0,			\
-		.intr_status_reg = 0,			\
-		.intr_target_reg = 0,			\
-		.tile = NORTH,				\
-		.mux_bit = -1,				\
-		.pull_bit = 3,				\
-		.drv_bit = 0,				\
-		.oe_bit = -1,				\
-		.in_bit = -1,				\
-		.out_bit = 0,				\
-		.intr_enable_bit = -1,			\
-		.intr_status_bit = -1,			\
-		.intr_target_bit = -1,			\
-		.intr_raw_status_bit = -1,		\
-		.intr_polarity_bit = -1,		\
-		.intr_detection_bit = -1,		\
-		.intr_detection_width = -1,		\
-	}
 static const struct pinctrl_pin_desc qcs404_pins[] = {
 	PINCTRL_PIN(0, "GPIO_0"),
 	PINCTRL_PIN(1, "GPIO_1"),
-- 
2.18.0

