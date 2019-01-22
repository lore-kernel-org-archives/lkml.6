Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8D4C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6FA21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q+kZdPXC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MPaax8FU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfAVGe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:34:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAVGez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:34:55 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 952AD609C2; Tue, 22 Jan 2019 06:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548138894;
        bh=S8aScYlnfgWymwIvByECwepxe4iUwcdgQAKgKCgjJQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q+kZdPXCylPwKWxyBmQgEOu7DSiV9xGIWlwe/xydB5CsdS+V71hlzvhwNIztwNm+i
         c22LfCJSUgWTIVvgrECBALCpG0jaqGeO8epOjubqVY31677nEDtN8c3j+ZWTlUFXJi
         8+ZbVayT3kcNv+3hWsMDCHD8NARPkB06YPeamrhs=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 417C260989;
        Tue, 22 Jan 2019 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548138883;
        bh=S8aScYlnfgWymwIvByECwepxe4iUwcdgQAKgKCgjJQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPaax8FUMn27QMcJbJOjv4irw6jE3VYadpeV6BWQd2KGQ2GBOf5fLd9VpEOvmJMUQ
         3sbRV0rHFGzStxU2bS8Dq1tSAoYMKaiUU3YaDoGTVX9ZKUIxqgW8mpCbIeTi+qIm6F
         G06bSaukc9ERYKAS07mJNRC3CgKPg29CkPbks154=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 417C260989
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 6/6] arm64: dts: sdm845: Add interconnect for GENI QUP
Date:   Tue, 22 Jan 2019 12:03:36 +0530
Message-Id: <1548138816-1149-7-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
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

