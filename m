Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49993C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4532145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwRLqOCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4532145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeK3SFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:05:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38590 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeK3SFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:05:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so2332696plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LF71b13fgHPUHtTaiyfpFN0HFsoifOk7GMClP6Pim6M=;
        b=DwRLqOCfpAVYJps1zp8SYE8f89V3+uASAxRMngDArrSPT7Yupa8PVK+ZwhA2lQ4qvz
         2yAoWZVXpmgLyJgttOdozstTiy4Trnmav5JVPe0Ubld/KT1m/PGWD+12RpjKSGv6ofrW
         hYSzsNtMwGpA243VGnSpL5xZ87XNpYO3i6KNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LF71b13fgHPUHtTaiyfpFN0HFsoifOk7GMClP6Pim6M=;
        b=X2haIQ+hGq8ZGvnx6FSbG1IhrZyEm8XN1m9adeZqV/TwiFqI8LzHnOP8WEKLgjI2FN
         9vI9pf81bTUbl1Ux3rq9F1hwaDHO8SLTxz1xBSjvsXu56Mh5YzN0wjdWV+4EJeUz3lY5
         KOyCL15MxNjX6ahYQpkk4M120/byhHdd2GVXIMf8EhvVpINytCTlwzjm3997yS36b12T
         Eug9O2INeSsmy1nVWphJust/MSK47BhOmMpjZTlxr6+DH6nkFKYjzqtmF2NbMaHGMHcv
         ErfZ3j8isoaerw9xOSdkpMhPKtHFC1fKkPz/WVZLHWhzuHH3OoBI9yNhnRjcGd716XLO
         HGSQ==
X-Gm-Message-State: AA+aEWa+oaw03akI8hK01/+1JykCxzuDNajaxAYvDmolm+etHw6NbhWN
        LrgL+7zN6i3/FH929+xC9HF5AQ==
X-Google-Smtp-Source: AFSGD/X4EFFyZzm9grDUXkAYDjUiKAgWI6uYWzBLaWgwgC9B48+GkYcy9lKT57pK1H/e3eiSg+vmJA==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7mr4616497plm.212.1543561024868;
        Thu, 29 Nov 2018 22:57:04 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m3sm3950596pgl.69.2018.11.29.22.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 22:57:04 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH] arm64: defconfig: Enable GCC and PINCTRL for MSM8998
Date:   Thu, 29 Nov 2018 22:54:56 -0800
Message-Id: <20181130065456.26605-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the GCC and PINCTRL for MSM8998 to make upstream boot to console.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1f1f4eab89df..206f50d121ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -348,6 +348,7 @@ CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8994=y
 CONFIG_PINCTRL_MSM8996=y
+CONFIG_PINCTRL_MSM8998=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_MT7622=y
@@ -605,6 +606,7 @@ CONFIG_IPQ_GCC_8074=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
+CONFIG_MSM_GCC_8998=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
-- 
2.18.0

