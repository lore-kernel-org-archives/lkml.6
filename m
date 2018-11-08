Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA05BECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9FB20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQkkWxy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9FB20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeKID3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:29:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbeKID3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:29:33 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A6B320827;
        Thu,  8 Nov 2018 17:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541699576;
        bh=4mVvOGmLoK/j1UzTtWFxubzoeCORtdwIjv0ieSA0yzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQkkWxy4kDaxdvWOtEAs1HlfA9PBKlPutHX7HpSFZguEQx5nZl28O/3s9OjF3Adzk
         YwkLDSbD0zhVEUZNAKywh/vdA/vNvX/UflT9goPrqGVMl8/T0qdekOMKys1N3789LQ
         clImcd6RYlSnqL2K4CbEw24d/es8YK7+mkvSCHGw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 17/18] arm64: dts: qcom: qcs404: Use BAM DMA for serial uart2
Date:   Thu,  8 Nov 2018 23:20:48 +0530
Message-Id: <20181108175049.7090-18-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108175049.7090-1-vkoul@kernel.org>
References: <20181108175049.7090-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use BAM DAM for serial UART data transfers, so add it

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index f7ac3d0662b4..46a4608db214 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -341,6 +341,8 @@
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 5>, <&blsp1_dma 4>;
+			dma-names = "rx", "tx";
 			status = "okay";
 		};
 
-- 
2.14.4

