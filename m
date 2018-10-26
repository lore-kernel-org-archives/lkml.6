Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E55C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533F92086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N6nmQWGT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N6nmQWGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533F92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeJZVCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:02:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeJZVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:02:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 79CF56021A; Fri, 26 Oct 2018 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540556758;
        bh=0qShLA5UwzMd23l9eiKR79BKXEg///Km2q3aKAfANLk=;
        h=From:To:Cc:Subject:Date:From;
        b=N6nmQWGT2J67S9q3koSAwmpGThq/vGw1zDiTAdPfY13HVzExkRPOuKQKCKXWGvJI3
         m2pisliWyY3mVq09HslftLkmt8F4VvmZuBOYlBkHOaYOzORVobr6mXzvI4nmqtKGZs
         eyBRawqoQllMPJ0CvmX/PHeHbxiqiLkyThn2LPac=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D1506021A;
        Fri, 26 Oct 2018 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540556758;
        bh=0qShLA5UwzMd23l9eiKR79BKXEg///Km2q3aKAfANLk=;
        h=From:To:Cc:Subject:Date:From;
        b=N6nmQWGT2J67S9q3koSAwmpGThq/vGw1zDiTAdPfY13HVzExkRPOuKQKCKXWGvJI3
         m2pisliWyY3mVq09HslftLkmt8F4VvmZuBOYlBkHOaYOzORVobr6mXzvI4nmqtKGZs
         eyBRawqoQllMPJ0CvmX/PHeHbxiqiLkyThn2LPac=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D1506021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, dianders@chromium.org,
        evgreen@chromium.org, benchan@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] arm64: dts: qcom: sdm845: Add SCM DT node
Date:   Fri, 26 Oct 2018 17:55:42 +0530
Message-Id: <20181026122542.4714-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCM DT node to enable SCM functionality on SDM845.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..fad22acfda4d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -221,6 +221,12 @@
 		};
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm-sdm845", "qcom,scm";
+		};
+	};
+
 	tcsr_mutex: hwlock {
 		compatible = "qcom,tcsr-mutex";
 		syscon = <&tcsr_mutex_regs 0 0x1000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

