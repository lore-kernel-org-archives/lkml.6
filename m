Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41452C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08E52170D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="drWozzT8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lh1HEjZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08E52170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbeHNPAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:00:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbeHNPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:00:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 50CCA60D7C; Tue, 14 Aug 2018 12:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248822;
        bh=4B2qv+0YsvV/stjGfH9ZirfqD8TnSJziz7SDcxhd94I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drWozzT8T9HCMempolPOi8aDByTYoPfv6ARiaS6NP4mO8TjiMEOhtr2o7Gqy81NoL
         szTrtZugzD4Nrx2DNm8eyJgtF00Mc6ahvceEaEqCqjkUV4NCKQPievgnHDtFzlW6bU
         wcsDeWDw1q8xkapkynRxhp4VI7t92nBFEPT6Wzfk=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F44860CEF;
        Tue, 14 Aug 2018 12:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248795;
        bh=4B2qv+0YsvV/stjGfH9ZirfqD8TnSJziz7SDcxhd94I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lh1HEjZ17UmALQ7ruLCS+m908s6QE7wQEC1qkMXD+WX2XvvOGnGn50HQyYea2snAT
         Ufc/gTQoZ9Hg2lzXZRM8kd2UA2vHpwnHslIicEbbkAAfvRGYr1/yIX7gHD0oncldwR
         9F7jG66bWKvWgkqX2x/u8ZafjXMUWgcJsAcYgtyw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F44860CEF
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
Subject: [PATCH v12 04/14] dt-bindings: clock: Document qcom,hfpll
Date:   Tue, 14 Aug 2018 17:42:23 +0530
Message-Id: <1534248753-2440-5-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Adds bindings document for qcom,hfpll instantiated within
the Krait processor subsystem as separate register region.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,hfpll.txt       | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,hfpll.txt b/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
new file mode 100644
index 0000000..ec02a02
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
@@ -0,0 +1,60 @@
+High-Frequency PLL (HFPLL)
+
+PROPERTIES
+
+- compatible:
+	Usage: required
+	Value type: <string>:
+		shall contain only one of the following. The generic
+		compatible "qcom,hfpll" should be also included.
+
+                        "qcom,hfpll-ipq8064", "qcom,hfpll"
+                        "qcom,hfpll-apq8064", "qcom,hfpll"
+                        "qcom,hfpll-msm8974", "qcom,hfpll"
+                        "qcom,hfpll-msm8960", "qcom,hfpll"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: address and size of HPLL registers. An optional second
+		    element specifies the address and size of the alias
+		    register region.
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: reference to the xo clock.
+
+- clock-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "xo".
+
+- clock-output-names:
+	Usage: required
+	Value type: <string>
+	Definition: Name of the PLL. Typically hfpllX where X is a CPU number
+		    starting at 0. Otherwise hfpll_Y where Y is more specific
+		    such as "l2".
+
+Example:
+
+1) An HFPLL for the L2 cache.
+
+	clock-controller@f9016000 {
+		compatible = "qcom,hfpll-ipq8064", "qcom,hfpll";
+		reg = <0xf9016000 0x30>;
+		clocks = <&xo_board>;
+		clock-names = "xo";
+		clock-output-names = "hfpll_l2";
+	};
+
+2) An HFPLL for CPU0. This HFPLL has the alias register region.
+
+	clock-controller@f908a000 {
+		compatible = "qcom,hfpll-ipq8064", "qcom,hfpll";
+		reg = <0xf908a000 0x30>, <0xf900a000 0x30>;
+		clocks = <&xo_board>;
+		clock-names = "xo";
+		clock-output-names = "hfpll0";
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

