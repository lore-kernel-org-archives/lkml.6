Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7241AC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081302170D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nZzsXSXx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GH8CWlCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081302170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeHNPCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:02:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42090 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbeHNPBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:01:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B2BA160DCF; Tue, 14 Aug 2018 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248859;
        bh=k+PDrJ+sgYSKbqLbcbbrkavD1yZRkjUqUImSj5QNVm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZzsXSXxPv5qg62iDnHQ6J+vTN7r8RDvwMj+ivR8Zq82NyNYXdKSlw8zM+CD9Z7Yn
         AILYm3f9SfpkzNccKnziEpD/nr0niPtlZjfNH70TBhQqMAc3nQsqzE+mbEsQCPX/aw
         Y6nZbWDrBNholpm/6QSsYHSJ4ZuV82N5kEEtHRYY=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38C1560C4F;
        Tue, 14 Aug 2018 12:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248833;
        bh=k+PDrJ+sgYSKbqLbcbbrkavD1yZRkjUqUImSj5QNVm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GH8CWlChOMuCq0fGviqvrpvVUz2dqf7/CYhVx8/TdDUgUFBqkhoEkOdpaaCNns87R
         ugLJ9Pzc4Zo+5vaJX2pDcbKbCsYb29gqOyfIccQWCV1tj/TScInZzWwidQ3EKY2Oz0
         8OtZVZ0J6nOv3ksGe2RdvOBjf6HBriRApOkTdgZQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38C1560C4F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, sboyd@codeaurora.org,
        linux@armlinux.org.uk, thierry.escande@linaro.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        niklas.cassel@linaro.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH v12 09/14] dt-bindings: arm: Document qcom,kpss-gcc
Date:   Tue, 14 Aug 2018 17:42:28 +0530
Message-Id: <1534248753-2440-10-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

The ACC and GCC regions present in KPSSv1 contain registers to
control clocks and power to each Krait CPU and L2. Documenting
the bindings here.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  | 19 ++++++++++
 .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  | 44 ++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
index 1333db9..7f69636 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
@@ -21,10 +21,29 @@ PROPERTIES
 		    the register region. An optional second element specifies
 		    the base address and size of the alias register region.
 
+- clocks:
+        Usage: required
+        Value type: <prop-encoded-array>
+        Definition: reference to the pll parents.
+
+- clock-names:
+        Usage: required
+        Value type: <stringlist>
+        Definition: must be "pll8_vote", "pxo".
+
+- clock-output-names:
+	Usage: optional
+	Value type: <string>
+	Definition: Name of the output clock. Typically acpuX_aux where X is a
+		    CPU number starting at 0.
+
 Example:
 
 	clock-controller@2088000 {
 		compatible = "qcom,kpss-acc-v2";
 		reg = <0x02088000 0x1000>,
 		      <0x02008000 0x1000>;
+		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
+		clock-names = "pll8_vote", "pxo";
+		clock-output-names = "acpu0_aux";
 	};
diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
new file mode 100644
index 0000000..e628758
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
@@ -0,0 +1,44 @@
+Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
+
+PROPERTIES
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: should be one of the following. The generic compatible
+			"qcom,kpss-gcc" should also be included.
+			"qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc"
+			"qcom,kpss-gcc-apq8064", "qcom,kpss-gcc"
+			"qcom,kpss-gcc-msm8974", "qcom,kpss-gcc"
+			"qcom,kpss-gcc-msm8960", "qcom,kpss-gcc"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: base address and size of the register region
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: reference to the pll parents.
+
+- clock-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "pll8_vote", "pxo".
+
+- clock-output-names:
+	Usage: required
+	Value type: <string>
+	Definition: Name of the output clock. Typically acpu_l2_aux indicating
+		    an L2 cache auxiliary clock.
+
+Example:
+
+	l2cc: clock-controller@2011000 {
+		compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
+		reg = <0x2011000 0x1000>;
+		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
+		clock-names = "pll8_vote", "pxo";
+		clock-output-names = "acpu_l2_aux";
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

