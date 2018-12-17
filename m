Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E58C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32D320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ciafpNPp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mw3Z6aPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbeLQKIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:08:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeLQKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:08:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 48C6D60908; Mon, 17 Dec 2018 10:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545041287;
        bh=D9vg1Rm/LM0gjwWLBpTtfq5/snLKQ8o/SsDbxZKrzKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ciafpNPpXmzFlz601LKgOChJi+/IbIF9ZdvqHK9Rr/WaWtlxHlzr70VLmCGiJEZUD
         cazKHTeRzcc/JUgaE9DhQm+uSgSblg6NwabIrMFN1B3y+ALxfYaNkUq6okbzdsfK6X
         r0pxspdONjZsnKxiTQvo7RJhZdqwXQ1V6uOa7NwM=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D233608D2;
        Mon, 17 Dec 2018 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545041285;
        bh=D9vg1Rm/LM0gjwWLBpTtfq5/snLKQ8o/SsDbxZKrzKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mw3Z6aPjnw2YcJsiOeGAul1yYb+2Dlh8AJ1O1QJ/boGu5tNk/aOA8GvR+///ZBP4c
         4WDqffkYeec2+g9+LcovULq7GDN1flsHEgimR7F+jqLCPJy5cMafp8Zkez9Dx1K1l8
         ghZdOJO4OtF1L66p2g5r3hT0kNP2y5tjOWUfB32I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D233608D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        dianders@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        evgreen@chromium.org, briannorris@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 4/7] dt-bindings: remoteproc: qcom: Add power-domain bindings for Q6V5
Date:   Mon, 17 Dec 2018 15:37:21 +0530
Message-Id: <20181217100724.4593-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217100724.4593-1-sibis@codeaurora.org>
References: <20181217100724.4593-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power-domain bindings for Q6V5 MSS on MSM8996 and SDM845 SoCs.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v2:
  * Add load_state power-domain
  * List cx and mx power-domains for MSM8996

 .../devicetree/bindings/remoteproc/qcom,q6v5.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 98894e6ad456..50695cd86397 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -80,6 +80,22 @@ on the Qualcomm Hexagon core.
 		    reference to the pll-supply regulator to be held on behalf
 		    of the booting of the Hexagon core on MSM8996 SoCs
 
+- power-domains:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the list of 2 power-domains for the modem
+		    sub-system on MSM8996 SoCs
+		    reference to the list of 4 power-domains for the modem
+		    sub-system on SDM845 SoCs
+
+- power-domain-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "cx", "mx" for the modem sub-system on MSM8996
+		    SoCs
+		    must be "cx", "mx", "mss", "load_state" for the modem
+		    sub-system on SDM845 SoCs
+
 - qcom,smem-states:
 	Usage: required
 	Value type: <phandle>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

