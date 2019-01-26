Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FAEC282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811F8218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoNvlOcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfAZELO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 23:11:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35673 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbfAZELN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 23:11:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so5017687pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 20:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DnQG/HiE2U5xeSz8P1vTnKFViPBKRO7Pu6aoK2typAc=;
        b=MoNvlOcOqo37jI4uIVlvzASCJfgdx8CplJe84HYoIlxS0UuX8yPlRNFinxPV9+hYsS
         NcDdOyyEKURW0i8Afk1f3eAzwDmpOaGIk3hhNuwjRk3nXko4lgsL1xHwQ4a0TRj7KI9+
         xXnsP8BQOMbF3r1DJonTn/EeZizlFbRyKyDGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DnQG/HiE2U5xeSz8P1vTnKFViPBKRO7Pu6aoK2typAc=;
        b=K7UI18maPqRS2AvIXHx3Bq3md6yh5fCi9csuEau0pEMtWNO+tAn4BH8WTwssJ2/QnA
         +vkZLKGQlh9dwOMWHPYnLX0QjmPnm3JH+Iob0DoX8H+Qkpkt7ILL4vBwtge7zzNWGooh
         V14cWmTb5+mkslPsISB2G+JaGkSSxeBKZeBwGCSyDaqt6yQTBfulj6AhuKuNUxixJVuL
         dY+pZ2b+dmMSWDb/bgyrqVW6GXIQotfbcPiBdJAchoxJLWiFB+23sZNoaB0XaqrM53wG
         JMhFtG30L9j0sUxpOTSRDEtp/a5lMuWJuOwdpQIhOj2f4jRi8p3EPjqGJhr6PoVw0ysX
         PUOA==
X-Gm-Message-State: AJcUukf1fVKYzERo67QrLTexo1LQKzlajDL2+k+YdQJNbkExvLBBznCO
        KBnyphsuE5WnRFE1WDrYorrz
X-Google-Smtp-Source: ALg8bN7cbS+ALU+Gv9LnR4FVM55phzdF9O4D9GZv3oDx/IB1WSCNYO2C0fFU2rWSMVD38hRG2pbQug==
X-Received: by 2002:a63:4c4e:: with SMTP id m14mr12549096pgl.173.1548475872284;
        Fri, 25 Jan 2019 20:11:12 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:e69d:b1bd:9891:c622:302d])
        by smtp.gmail.com with ESMTPSA id h129sm75099676pfb.110.2019.01.25.20.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 20:11:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/5] arm64: Add ARCH_BITMAIN platform
Date:   Sat, 26 Jan 2019 09:40:38 +0530
Message-Id: <20190126041041.13173-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ARCH_BITMAIN for supporting Bitmain SoC platforms.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 251ecf34cb02..6bb7db9126f7 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -52,6 +52,11 @@ config ARCH_BERLIN
 	help
 	  This enables support for Marvell Berlin SoC Family
 
+config ARCH_BITMAIN
+	bool "Bitmain SoC Platforms"
+	help
+	  This enables support for the Bitmain SoC Family.
+
 config ARCH_BRCMSTB
 	bool "Broadcom Set-Top-Box SoCs"
 	select BRCMSTB_L2_IRQ
-- 
2.17.1

