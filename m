Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B62C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7579A20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JsQ2WJlQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JsQ2WJlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfAVGeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:34:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39158 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAVGeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:34:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CBF6B607CA; Tue, 22 Jan 2019 06:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548138849;
        bh=g4BdxC4J7Xh6tBmi9grBoNKEcFBvG64EaMC5Ydxc2tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsQ2WJlQrpH8ZFupOxtNJcuMCoxZPhaWDF0/tC7Mh2wzLhOlUC+OaqB/NCcmpDHFY
         UZx2zZpT9bwe9WGafHxkg9FypKKN1znLIRkZyE8cmQgu+OEsZxhsbQ4LLeBlpIuvDT
         0/yxvl+iP0ClT+5a4Hj0DkhLsvy0tuGFfPUYeGR0=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86F58607CA;
        Tue, 22 Jan 2019 06:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548138849;
        bh=g4BdxC4J7Xh6tBmi9grBoNKEcFBvG64EaMC5Ydxc2tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsQ2WJlQrpH8ZFupOxtNJcuMCoxZPhaWDF0/tC7Mh2wzLhOlUC+OaqB/NCcmpDHFY
         UZx2zZpT9bwe9WGafHxkg9FypKKN1znLIRkZyE8cmQgu+OEsZxhsbQ4LLeBlpIuvDT
         0/yxvl+iP0ClT+5a4Hj0DkhLsvy0tuGFfPUYeGR0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86F58607CA
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
Subject: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for GENI QUP
Date:   Tue, 22 Jan 2019 12:03:31 +0530
Message-Id: <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the interconnect and interconnect-names bindings
for the GENI QUP as detailed by bindings/interconnect/interconnect.txt.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index dab7ca9..44d7e02 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -17,6 +17,12 @@ Required properties if child node exists:
 - #address-cells: 	Must be <1> for Serial Engine Address
 - #size-cells: 		Must be <1> for Serial Engine Address Size
 - ranges: 		Must be present
+- interconnects:	phandle to a interconnect provider. Please refer
+			../interconnect/interconnect.txt for details.
+			Must be 2 paths corresponding to 2 AXI ports.
+- interconnect-names:	Port names to differentiate between the
+			2 interconnect paths defined with interconnect
+			specifier.
 
 Properties for children:
 
@@ -67,6 +73,10 @@ Example:
 		#size-cells = <1>;
 		ranges;
 
+		interconnects = <&qnoc 11 &qnoc 512>,
+				<&qnoc 0 &qnoc 543>;
+		interconnect-names = "qup-memory", "qup-config";
+
 		i2c0: i2c@a94000 {
 			compatible = "qcom,geni-i2c";
 			reg = <0xa94000 0x4000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

