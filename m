Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF09C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619E620861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jVTEVnrv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PPJTUBDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfAULW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:22:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfAULW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:22:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AE660608D2; Mon, 21 Jan 2019 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548069745;
        bh=S8aScYlnfgWymwIvByECwepxe4iUwcdgQAKgKCgjJQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVTEVnrvykWuOBZtw2FZNslAaWX3Ix5hkZzF06C5vZ3ccBCPERxCGjaxzZPY/fwRT
         lCMb5wspUdH/iHT/hPgp4JMjCSEgIHFkRT16WTEXcQMEATaiSFipT70CO3MuLvreC0
         K75cqIsj2tGbRl3uhBSwZGP0NDHseyG1aG7Gp0Gs=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0336B608D2;
        Mon, 21 Jan 2019 11:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548069744;
        bh=S8aScYlnfgWymwIvByECwepxe4iUwcdgQAKgKCgjJQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPJTUBDbFMsx1Isvi1U3xzNXurrGiu6hQU1XVrrucKIM0Q0st77E0jtcmhGritIBH
         nV2nbP4rCu8Yq/BikJLbwodvLl1eV0SLjpN4Kg07Z3ijl2ljaGWVmD5XSrrQL1UUQf
         cJnVIR1XmTEm4zV6UJ8is/UVWrSRneG3PDG45MBA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0336B608D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 6/6] arm64: dts: sdm845: Add interconnect for GENI QUP
Date:   Mon, 21 Jan 2019 16:51:43 +0530
Message-Id: <1548069703-26595-7-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
References: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnect ports for GENI QUPs to set bus
capabilities.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3..fb0a8a7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -374,6 +374,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+
+			interconnects = <&rsc_hlos MASTER_BLSP_1
+					&rsc_hlos SLAVE_EBI1>,
+					<&rsc_hlos MASTER_APPSS_PROC
+					&rsc_hlos SLAVE_BLSP_1>;
+			interconnect-names = "qup-memory", "qup-config";
+
 			status = "disabled";
 
 			i2c0: i2c@880000 {
@@ -682,6 +689,13 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+
+			interconnects = <&rsc_hlos MASTER_BLSP_2
+					&rsc_hlos SLAVE_EBI1>,
+					<&rsc_hlos MASTER_APPSS_PROC
+					&rsc_hlos SLAVE_BLSP_2>;
+			interconnect-names = "qup-memory", "qup-config";
+
 			status = "disabled";
 
 			i2c8: i2c@a80000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

