Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5D3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429DD20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gHaykFQp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cezAk60x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429DD20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966465AbeFSNqI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:46:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965599AbeFSNqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:46:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EA25A60BB0; Tue, 19 Jun 2018 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529415962;
        bh=AP+KtJrgdVyilsZRwDfXGyemVvYpwYU48Lx3/m/BE90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHaykFQpdVyVO+BsTfKU4k+mVXdc3z9fHpqLXoFdqJYn5zKiC+8skt9naXxnrfaY2
         nPlFtO94opL11tRtuQegrhv2oBdkotOhMM3w5Qg2/gd1WHdZ45DSEp0y3haCGlAU2t
         Ns3iNMvGp4bnx61uJER/njpjdLnQVa8A47KdvmnI=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AEA9B60B19;
        Tue, 19 Jun 2018 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529415960;
        bh=AP+KtJrgdVyilsZRwDfXGyemVvYpwYU48Lx3/m/BE90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cezAk60xKUoWEM2i15A88pKVdr/jLXEGWqpRJ38Vm5CZKsIDTDbPIfR5YVAmDB0sK
         H/GmzjO/Su4z39iy//aBbGxiFeE6iv50pRKMTncbJ9xuUXx7MFBsJUWjLmOJ/uqLA4
         E+Vsw9LUS7W7Q9AUyUR1XqfZeV+ZPUWsPTIQZSAY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEA9B60B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk,
        thierry.escande@linaro.org, ctatlor97@gmail.com
Cc:     sricharan@codeaurora.org
Subject: [PATCH v10 04/14] dt-bindings: clock: Document qcom,hfpll
Date:   Tue, 19 Jun 2018 19:15:15 +0530
Message-Id: <1529415925-28915-5-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
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
[v10] Updated to add clocks and clock-names properties newly

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
1.9.1

