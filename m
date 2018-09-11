Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADA4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0641720839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bJEKvIV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0641720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIKUJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:09:23 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:56638 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKUJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:09:23 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EAF0424E214F;
        Tue, 11 Sep 2018 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536678580; bh=JQ2w1TjaJmRj86/EaRFySVFU3qM4zRrI9mZBAhvH0t4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJEKvIV+nnE46Ge13wMfpMgigvWB5ClaZRZM9duuaDqx9TDpvoHKF08z0GOqT4iVO
         xBvh6SrHMQYbsQvtCPs+Ac1CklSRtwzSGytM74Vmi3daq7KLTXZlxz1udRmr4TeX92
         50nBXn7Xbf3PDc7Bz24/VYCDk0U1iy+srClTxsRfHGt8aIZEm5GLsNLCeYH2GiCIms
         YtTryfonNld14pNOfIQBHSErjaAejWeeLAMc97wGOcq9o3sDaaqxT/lp2lJA4ztQxS
         QsGzdosik+J7ErLtlrozM0qeSbYjByj9FlHGmzB8TGji15zcTm7iNsCm+4o46CqFq/
         Y6NPXjEQ1c4PA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.37])
        by mailhost.synopsys.com (Postfix) with ESMTP id 251643B2E;
        Tue, 11 Sep 2018 08:09:36 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v3 2/2] dt-bindings: Document the Synopsys GPIO via CREG bindings
Date:   Tue, 11 Sep 2018 18:09:25 +0300
Message-Id: <20180911150925.19460-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180911150925.19460-1-Eugeniy.Paltsev@synopsys.com>
References: <20180911150925.19460-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of device tree bindings for the Synopsys
GPIO via CREG driver.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 .../devicetree/bindings/gpio/snps,creg-gpio.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt b/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
new file mode 100644
index 000000000000..11aba2f34066
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
@@ -0,0 +1,18 @@
+Synopsys GPIO via CREG (Control REGisters) driver
+
+Required properties:
+- compatible : "snps,creg-gpio-hsdk" or "snps,creg-gpio-axs10x".
+- reg : Exactly one register range with length 0x4.
+- #gpio-cells : Should be one - the pin number.
+- gpio-controller : Marks the device node as a GPIO controller.
+- ngpios : Number of GPIO pins.
+
+Example:
+
+gpio: gpio@f00014b0 {
+	compatible = "snps,creg-gpio-hsdk";
+	reg = <0xf00014b0 0x4>;
+	gpio-controller;
+	#gpio-cells = <1>;
+	ngpios = <2>;
+};
-- 
2.14.4

