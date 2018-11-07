Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB25C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5350321104
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XqPxgS4C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fmtuRtRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5350321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeKHHXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:23:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeKHHXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:23:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3D6AE607F7; Wed,  7 Nov 2018 21:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541627480;
        bh=DRuV+9jI4DaGTOlcgBBdFCcB/E3pSZzODZ/wPHHMxpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqPxgS4CJ6ewYN2xx87/+tuMHmNVPFAsk201K2esChq630cq1lZccoD7+OscBm1Qe
         9RUtJso4991cB1EabUk00OqPAIZD9uVQBRMU4E6ND+jSzvfmX2/IVtlE13MsHiFQ8C
         fRCp1P6IX44Fg02D09f5pVey92qwyESz1Lcm0uh4=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D7C360591;
        Wed,  7 Nov 2018 21:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541627479;
        bh=DRuV+9jI4DaGTOlcgBBdFCcB/E3pSZzODZ/wPHHMxpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmtuRtRNbD+xWLKn6jJo6njeWiSJcWwtam7dC/WK2vADSYQTLY9CAfZ0X/gASsL8K
         +APzdRJ53JWvGNk2i1bjvZa9qPwlV++Et0qmLo52WhnyUciRKW1dSbq19lR6rfCN6h
         mJ38lzHah07/UsYBdAKQB7POFQGFRUhmQniw+2Ss=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D7C360591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        bjorn.andersson@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RESEND v3 2/2] dt-bindings/interrupt-controller: pdc: fix example to match actual bindings
Date:   Wed,  7 Nov 2018 14:51:09 -0700
Message-Id: <20181107215109.10720-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107215109.10720-1-ilina@codeaurora.org>
References: <20181107215109.10720-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PDC map should use the GIC SPI port and not the vector. GIC
internally adds 32 to SPI hwirq numbers.

Fixes: 1ae8862e27e ("dt-bindings/interrupt-controller: pdc: Describe PDC device binding")
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.txt     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
index 8e0797cb1487..803831479aec 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@ -55,13 +55,13 @@ Example:
 	pdc: interrupt-controller@b220000 {
 		compatible = "qcom,sdm845-pdc";
 		reg = <0xb220000 0x30000>;
-		qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
+		qcom,pdc-ranges = <0 480 94>, <94 609 15>, <115 630 7>;
 		#interrupt-cells = <2>;
 		interrupt-parent = <&intc>;
 		interrupt-controller;
 	};
 
-DT binding of a device that wants to use the GIC SPI 514 as a wakeup
+DT binding of a device that wants to use the GIC SPI 482 as a wakeup
 interrupt, must do -
 
 	wake-device {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

