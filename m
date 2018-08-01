Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529EEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0861B208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RdF/OcGG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CwZZHkrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0861B208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733175AbeHAHXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:23:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51606 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbeHAHXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:23:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4B87A606AC; Wed,  1 Aug 2018 05:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533101965;
        bh=svhKuuwb/cVy1S1ckhF4E00Qbwt87n6Tvgn3udtySbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdF/OcGGANMW6PxC5I5mSM53QocXttJhtOrvJ+obztrYoqnykzq5KaA1Xktp6EtqD
         vhTVDDJoyKwDI5DiW3nqBHnDr0UfsVySm0u4s+cK3yQ6wlQkhIG5TG9HOekVRlbZ/M
         96GROahWPllcVwIV/fMuFd6ErO8vs6T6g6jhS9rQ=
Received: from corebsp04-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mshettel@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A051606DD;
        Wed,  1 Aug 2018 05:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533101963;
        bh=svhKuuwb/cVy1S1ckhF4E00Qbwt87n6Tvgn3udtySbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwZZHkrX4OgtspSijQGx8KPT2vJVQl3ByMBfBTcncrXbzhnB0bP0/YpPf+0+/A3Mr
         Dh4kUmJbD/GRhJuUP4BGLmvsZNfv3tV8FSo14MYSXRkSPBqMf5sICybGJJl5dA6nfu
         fklmrWCRu0rq+Tes/hhSTnMbz9oy+PXz2JJP2U5Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A051606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mshettel@codeaurora.org
From:   Mike Shettel <mshettel@codeaurora.org>
To:     gregkh@linuxfoundation.org, boris.brezillon@bootlin.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     Mike Shettel <mshettel@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, bjorn.andersson@linaro.org
Subject: [PATCH v1 2/3] dt-bindings: i3c: Document Qualcomm GENI I3C master bindings
Date:   Tue, 31 Jul 2018 23:39:01 -0600
Message-Id: <1533101942-29442-3-git-send-email-mshettel@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
References: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Shettel <mshettel@codeaurora.org>
---
 .../devicetree/bindings/i3c/qcom,geni-i3c.txt      | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt

diff --git a/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt b/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
new file mode 100644
index 0000000..8b76fda
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
@@ -0,0 +1,44 @@
+Bindings for Qualcomm Geni I3C master block
+===========================================
+
+Required properties:
+--------------------
+- compatible: shall be "qcom,geni-i3c"
+- clocks: shall reference the se clock
+- clock-names: shall contain clock name corresponding to the serial engine
+- interrupts: the interrupt line connected to this I3C master
+- reg: I3C master registers
+
+Optional properties:
+--------------------
+- se-clock-frequency: Source serial clock frequency to use
+- dfs-index: Dynamic frequency scaling table index to use
+
+Mandatory properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- #address-cells: shall be set to 3
+- #size-cells: shall be set to 0
+
+Optional properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- i2c-scl-hz
+- i3c-scl-hz
+
+I3C device connected on the bus follow the generic description (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details).
+
+Example:
+
+	i3c-master@0d040000 {
+		compatible = "qcom,geni-i3c";
+		clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
+		clock-names = "se";
+		interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x0d040000 0x4000>;
+		#address-cells = <3>;
+		#size-cells = <0>;
+		i2c-scl-hz = <100000>;
+	};
+
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

