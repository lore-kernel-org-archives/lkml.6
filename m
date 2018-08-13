Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF887C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC4321782
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cl/PNuI1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I+Hk4bi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC4321782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbeHMQTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:19:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55540 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbeHMQTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:19:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C2A2560D98; Mon, 13 Aug 2018 13:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534167444;
        bh=dhr+pb6GaVvWStMTWWXWh1P2MaTfd+aUP+1/3nQM5wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cl/PNuI1N5uJPSYud71zIhmtg684Y1nYgcPb/mRF7lnrVNLhgLwVLNFVae0NSRNG2
         gfRYpmLxl3iUJyKPY3LiaW2JboiKoOJLmj0+ZwdHP1e+zVPk4hOJC/wNnBKYzggeWm
         /thzlnuk4EDf/SQqjP8BxRnMxK8kIKHeCBT5FtRE=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EFDBC60C4E;
        Mon, 13 Aug 2018 13:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534167408;
        bh=dhr+pb6GaVvWStMTWWXWh1P2MaTfd+aUP+1/3nQM5wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+Hk4bi4N8Kll2efxONWhw7y+voFsBWLX3tZB0FRvRkIQEkFFhB1XfJwZZ9LWUCqS
         ZlxfcYGL7Gbskju7du7TN1sGhDpKPrPJLXuEkbdiukI7L5VmxgPAvhUQoqVXJMbQa6
         cuXYCc9KX8vV+YKaZlM+aBioG9eiWFqHlagMcPOs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFDBC60C4E
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
Subject: [PATCH 04/14] dt-bindings: clock: Document qcom,hfpll
Date:   Mon, 13 Aug 2018 19:05:57 +0530
Message-Id: <1534167367-17545-5-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534167367-17545-1-git-send-email-sricharan@codeaurora.org>
References: <1534167367-17545-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Adds bindings document for qcom,hfpll instantiated within
the Krait processor subsystem as separate register region.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
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

