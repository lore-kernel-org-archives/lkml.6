Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07A7C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2FD218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SzoX7d+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfAXUYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:24:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40588 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbfAXUYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:24:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so3556436pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5vW46nrjFVoZsnMcgT1mEReDdf43fF1J2psQEiWFOU=;
        b=SzoX7d+HKT5NucVKzZ22vuD4IMyi0BUeNEq+nZsXxgjwCVzKVfDBPnrJjg9VIXt4FV
         ESbJQqmYfE47OwYqfFizlKN95G5CdKqjuagakR0MmwNaLmoQCmTUvHdmuWZS+VbPhetq
         hQUngAFjUQ7/6Zm468Hmlhpzg7Q3xIUJTjHrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o5vW46nrjFVoZsnMcgT1mEReDdf43fF1J2psQEiWFOU=;
        b=JC44CBIfmcWN6g8Dw6AO4PVTkGanG7EHeyyEvKllldwYJIJFjEZATr7yZSPCRciJ3F
         MU5K2X3K58KkJe6hCe9IzH1tqzlM7NDqi98qd8CKCATD3a1rVaRAgZk+h26RiIIC92Lj
         17zwoEJ6ek8PQCWZZvDqziE1FS95hBiONg9kEL2t5cLqiDh9k59RA/G1r+HU1ZHNtjIt
         dF62wU2oGYvvXj6Ww4GNO7vtvC6g1nQOUIQeZjDICc/3MC7QOKgz4UuMexdEX3X/N1h7
         liBPud1AMxB75ZTMCmX5agixZm3nwpM9wQtI7uR8ea/CgKGwWPmCaSNzA5sWt90Y3/zV
         uX4A==
X-Gm-Message-State: AJcUukeevl5UgqePfIBA8Fn8dAxrcTpQRA0D2uOTLjsej16rBVtkJn9R
        +mfp7DQ8SbRLhj1EUj9cs9ZNtXNt2ykGiQ==
X-Google-Smtp-Source: ALg8bN53AUnDLmlfA5CanT+1yUS8gKuszSeTS3DYr7MsI/bOcmzSj4lSCbjz6YablM37qmPTUwrN5Q==
X-Received: by 2002:a62:37c3:: with SMTP id e186mr8138281pfa.251.1548361477400;
        Thu, 24 Jan 2019 12:24:37 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c72sm45263309pfb.107.2019.01.24.12.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 12:24:36 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 6/8 v5] arm64: dts: hi3660: Add dma to uart nodes
Date:   Thu, 24 Jan 2019 12:24:21 -0800
Message-Id: <1548361463-28372-7-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to add DMA support to the uart nodes following
the assignments made in the dts from the victoria vendor kernel
here:
https://consumer.huawei.com/en/opensource/detail/?siteCode=worldwide&keywords=p10&fileType=openSourceSoftware&pageSize=10&curPage=1

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3:
* Remove dma enablment on uart0 which would use reserved channel 0
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 20ae40d..4c8d682 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -478,6 +478,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf00000 0x0 0x1000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 2 &dma0 3>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART1>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART1>;
 			clock-names = "uartclk", "apb_pclk";
@@ -490,6 +492,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf03000 0x0 0x1000>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 4 &dma0 5>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART2>,
 				 <&crg_ctrl HI3660_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
@@ -514,6 +518,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf01000 0x0 0x1000>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 6 &dma0 7>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART4>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART4>;
 			clock-names = "uartclk", "apb_pclk";
@@ -526,6 +532,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf05000 0x0 0x1000>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 8 &dma0 9>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART5>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART5>;
 			clock-names = "uartclk", "apb_pclk";
-- 
2.7.4

