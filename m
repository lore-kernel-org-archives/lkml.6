Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE1EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3976F2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jCwP6yIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3976F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeI1Tj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:39:27 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:37628 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1Tj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:39:26 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2A21110C1B61;
        Fri, 28 Sep 2018 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538140543; bh=tCETSBm7iosQu/l2vga1+YiXnCQzE3oESrj5exU7j0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCwP6yIOw1ZIaBfiWn+dDR8HvoZX7TWnwjjhJ9ScsT76wTxESmIe0reoKZbgQCukT
         V2SBdUcPcPu5ysFwFCS9WTP8Kr+FcekX2cw+JqEp7JyK3EtycL5PPUaw6uLQMGbzMS
         9zAbojRhhPK78dM4g4BjEO0qitPfqWrlF/rvM3hBqULpQm897BlbGBB1KQmAhs129F
         HIDjtniA/T1UcAQ7P3cHTvpgaKlw/gBUoNWtE2jd01qqw18On1Sj8krqQNqSNyWaEy
         pCvLHvNIjORPCNI2qYtWWJ6+5Jc7ZflIKA3GjHc7fJQ3e/yKZazRMpvDVk661pq7mf
         pXwlY/dEgh0+Q==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.38])
        by mailhost.synopsys.com (Postfix) with ESMTP id 65CD95958;
        Fri, 28 Sep 2018 06:15:39 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v4 2/2] dt-bindings: Document the Synopsys GPIO via CREG bindings
Date:   Fri, 28 Sep 2018 16:15:31 +0300
Message-Id: <20180928131531.4598-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180928131531.4598-1-Eugeniy.Paltsev@synopsys.com>
References: <20180928131531.4598-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of device tree bindings for the Synopsys
GPIO via CREG driver.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v3->v4:
 * Fix #gpio-cells description as driver is used generic GPIO binding.

Chnages v2->v3:
 * None.

 .../devicetree/bindings/gpio/snps,creg-gpio.txt     | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt b/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
new file mode 100644
index 000000000000..1b30812b015b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
@@ -0,0 +1,21 @@
+Synopsys GPIO via CREG (Control REGisters) driver
+
+Required properties:
+- compatible : "snps,creg-gpio-hsdk" or "snps,creg-gpio-axs10x".
+- reg : Exactly one register range with length 0x4.
+- #gpio-cells : Since the generic GPIO binding is used, the
+  amount of cells must be specified as 2. The first cell is the
+  pin number, the second cell is used to specify optional parameters:
+  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
+- gpio-controller : Marks the device node as a GPIO controller.
+- ngpios: Number of GPIO pins.
+
+Example:
+
+gpio: gpio@f00014b0 {
+	compatible = "snps,creg-gpio-hsdk";
+	reg = <0xf00014b0 0x4>;
+	gpio-controller;
+	#gpio-cells = <2>;
+	ngpios = <2>;
+};
-- 
2.14.4

