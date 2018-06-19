Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA01DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ADF20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F4lY58Wm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AeVT0kHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2ADF20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966613AbeFSNqt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:46:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966044AbeFSNqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:46:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 03BF160B23; Tue, 19 Jun 2018 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529416002;
        bh=f25cTg0FWm163CMRiXPikV45CXoMdVc5kr8c5Ogs9Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4lY58WmiTDBu91ePblYGUgxMDbaP3E3KVP9m+iZTQlvT//zYb7eO0Q9UTJ8nZyBH
         HzaGC//16zUT9Cpn2UknLJJCbgiJSwd3GxP8hohfPCMhsDO80efOr0+0wxjNXi+Ae2
         Ug4bIdu7lPa9103uW9PsEKq7aqgGqZ9z2pWm5dvg=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4280460B11;
        Tue, 19 Jun 2018 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529416000;
        bh=f25cTg0FWm163CMRiXPikV45CXoMdVc5kr8c5Ogs9Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeVT0kHUsVv1yMraitlQVQMtCAMOW7HLj2/xjAD1FkzNZnmqssHLClZlIDqUrv92T
         5T8efAYsFCTNXpljR4I8XRiJZplZLlo4Et9z2d9wctUIS6CPXrUGhIYZ86mpWgbhqz
         7danV2S7nPBpGb3JgpteoFl9JIRaSVkcUbmlYlVA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4280460B11
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
Subject: [PATCH v10 11/14] dt-bindings: clock: Document qcom,krait-cc
Date:   Tue, 19 Jun 2018 19:15:22 +0530
Message-Id: <1529415925-28915-12-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

The Krait clock controller controls the krait CPU and the L2 clocks
consisting a primary mux and secondary mux. Add document for that.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 [v10] updated to include clocks and clock-names property newly

 .../devicetree/bindings/clock/qcom,krait-cc.txt    | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
new file mode 100644
index 0000000..030ba60
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
@@ -0,0 +1,34 @@
+Krait Clock Controller
+
+PROPERTIES
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+			"qcom,krait-cc-v1"
+			"qcom,krait-cc-v2"
+
+- #clock-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: must be 1
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: reference to the clock parents of hfpll, secondary muxes.
+
+- clock-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb".
+
+Example:
+
+	kraitcc: clock-controller {
+		compatible = "qcom,krait-cc-v1";
+		clocks = <&hfpll0>, <&hfpll1>, <&acpu0_aux>, <&acpu1_aux>, <qsb>;
+		clock-names = "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb";
+		#clock-cells = <1>;
+	};
-- 
1.9.1

