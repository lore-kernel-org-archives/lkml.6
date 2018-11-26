Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBAAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F46620862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DqxAnt5S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N4TcUpFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F46620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeK0BQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:16:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeK0BQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:16:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 646F560227; Mon, 26 Nov 2018 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543242104;
        bh=QfUfkF1X77OEQTD8aWqxIYz8QzPnynb9DKmJbob5SKA=;
        h=From:To:Cc:Subject:Date:From;
        b=DqxAnt5S15Lg5+ZizIV5/TPo00ZilQkMDGu+mTEW9c8MEURTYHA2OQvDmWdyYL/X/
         OpDd+cjj2archRqZLmljMvJnOHMXhC0lBoLMuYGSCY+Wg4XoQzkb0JylL4cxqSdmB2
         wcerY0KSgWE4vAZl5xG+9tFe7oFOebFL/SeYt0qQ=
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 669B460A9B;
        Mon, 26 Nov 2018 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543242103;
        bh=QfUfkF1X77OEQTD8aWqxIYz8QzPnynb9DKmJbob5SKA=;
        h=From:To:Cc:Subject:Date:From;
        b=N4TcUpFTN7+0oW1L+5VFLfeLVUPnlp6WcGaXvC+FFdkkxCvbTVYrm6LimIf+BR25z
         E/+OyluCUWb4sBGnArZFWnCTbc2GyMc5lE7zBcWoJl5uCh3duczokgH4xcEGbieWMC
         7+pyFEtSFRg3z4SpxAgUq0SvduY4VLHQ0Jv5VM7U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 669B460A9B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH] arm64: dts: qcom: qcs404: Add WCN3990 WLAN module device node
Date:   Mon, 26 Nov 2018 19:51:33 +0530
Message-Id: <20181126142133.16966-1-govinds@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for the ath10k SNOC platform driver probe
and add resources required for WCN3990 on qcs404 soc.
Optional clock and regulator controls are not yet available in
upstream, hence add them once available.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9ca4f061ecc5..1a401a32d4a1 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -958,6 +958,25 @@
 				status = "disabled";
 			};
 		};
+
+		wifi: wifi@0A000000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x0A000000 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_msa_mem>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	timer {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

