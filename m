Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85967C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5582920855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCRgEPob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfAVEWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:22:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34254 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfAVEWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:22:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so11125880pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 20:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cru5fUZcAQInENZrdcyg+x0Ztwsn5ae0UMz5WQRLO18=;
        b=HCRgEPobXdqHttzbeiuJnCe85Tmytm+W+vD2MDcZINqbJRvpu1Y08HUArUb1Rb3pSr
         tTFP6VbfnKNxzbG59b0NvN91Ln6i20TdUdbuUwkwoPhQnRKbmzN6+Bp0mWb4angAhvUT
         j3+NWw8M0eAkCCipI/lS9upxh7sWFBzbY9aEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cru5fUZcAQInENZrdcyg+x0Ztwsn5ae0UMz5WQRLO18=;
        b=Dv14WcDFiJUF4eRFk3CIrYmRf1Q9i53cwIZBgJ6Fspt5Dn8p25ov5ecKVilsjL3G8k
         p2D8Mi/cEo2UHj4tZKhVKFVT7n6rD+btXoDYUdNjvBuu01ZHCsRpolZfKCBmYWdOCA2R
         uhmaiBK1US/wC0Pb8W1OtOXegF3uNZLeFnwXgUFDyy4jyysKS+Q0gWwATdMN4eL1lEdF
         k7mcR1sauIR8x+0dv4zTPkydRDJw4OBBqq9JeBbjybLfyrU3/xCulDf8H5KPfNXAK1Lw
         3IQavkgS+UrjnZ6Iej3hy0297ZLMdxZQJUaEeGaZTRC6yC4EFnwy7oTK5D1UbrMQultt
         YDdg==
X-Gm-Message-State: AJcUukcmIWh7VadXMqB6S8vRV6FYPmf5zyGhaxOIIlkKJnPopTeFPjgu
        K4GPqq8H/wOdfABq4L7I36Ba
X-Google-Smtp-Source: ALg8bN4ioSoUadOHvZuwQ6WlKjt/aHoSgxworlT/2TT7kHDoD+zoTCW5BHU5r2bdOtWIOx/cxiN0tw==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr30006124pgd.110.1548130929254;
        Mon, 21 Jan 2019 20:22:09 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7344:8fd1:3551:e475:9265:ab6d])
        by smtp.gmail.com with ESMTPSA id q199sm25083953pfc.97.2019.01.21.20.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 20:22:08 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/5] ARM: dts: Add devicetree compatibles for LS1021A based boards
Date:   Tue, 22 Jan 2019 09:51:44 +0530
Message-Id: <20190122042147.5424-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing devicetree compatibles for the following LS1021A based
boards:

ls1021a-moxa-uc-8410a.dts
ls1021a-qds.dts
ls1021a-twr.dts

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts | 1 +
 arch/arm/boot/dts/ls1021a-qds.dts           | 1 +
 arch/arm/boot/dts/ls1021a-twr.dts           | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
index 6a83f30029ea..ba1ddd93b8f8 100644
--- a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
+++ b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
@@ -18,6 +18,7 @@
 
 / {
 	model = "Moxa UC-8410A";
+	compatible = "fsl,ls1021a-moxa-uc-8410a", "fsl,ls1021a";
 
 	aliases {
 		enet0_rgmii_phy = &rgmii_phy0;
diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 923a25760516..ca60730dda40 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -51,6 +51,7 @@
 
 / {
 	model = "LS1021A QDS Board";
+	compatible = "fsl,ls1021a-qds", "fsl,ls1021a";
 
 	aliases {
 		enet0_rgmii_phy = &rgmii_phy1;
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index 8b48c3c7cd21..97e1fb7ea932 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -51,6 +51,7 @@
 
 / {
 	model = "LS1021A TWR Board";
+	compatible = "fsl,ls1021a-twr", "fsl,ls1021a";
 
 	aliases {
 		enet2_rgmii_phy = &rgmii_phy1;
-- 
2.17.1

