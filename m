Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE66C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E2824C6C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKdWxPGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E2824C6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeFWQMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 12:12:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40303 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeFWQMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 12:12:16 -0400
Received: by mail-pg0-f66.google.com with SMTP id w8-v6so4247272pgp.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aNqyghA/+YELYPCfAy6P30ix4otp9ywUK1kCBsmdfz8=;
        b=TKdWxPGbA2P8mJ8pTPUEymQDMHiAV/hb8buSDOTUxI/giKhi3IhCSLPROJQ7PEHEg4
         Am/7DhH2PvxmsXhWS1dN4VQ7U6h8K1KdFdSYCfA0QynoQf47CX/ekCkXNLH0bWuHyQH8
         z403H4Jfo4RU/+jKy2qKY8hs1xZHr+7anY8aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aNqyghA/+YELYPCfAy6P30ix4otp9ywUK1kCBsmdfz8=;
        b=t2g5a/Yaj+vcwehK+G+chy3he+es0ttm1wsQADZgMANC6Dyf5LrIQL1oPzx5rVZwjl
         0zIuqd4xkn4z3c85v50I1GzzMAbt2/dTl6ukvjsp1UxdlL1KsaNZZ/bw4WXnTw8GzRzY
         6Ty+VjbfPKp7XGH6Eekuq+B8tLoJ4rX73lzPp97ps9ZODmgI3DfDinUGltBJ4gorL3cP
         ELm6wnd5YzZVH6Hsw7jVbkW0Z7DZHyuFEsSLTrdanK0/4SqotpWVDtSGISn51A2hSriG
         tXjgtZ2bMVt9/GzTqFD6ZL1jvbQkUWkdk0pntT1HY2rgyG3VYLAuZeJYHuVWwZJ7nc/a
         Fj2g==
X-Gm-Message-State: APt69E34WWi72CPzo4YP8AO5twLy6nrzCVFNLQ+cptejIktKIovC61pi
        Fn7DNuIIUWf9po2AtWdgC+ez
X-Google-Smtp-Source: ADUXVKITb1R6Z18vRUZq7FtWFrHipA6gSepbsIOEvq36HtyslJCpBRANJCtc7K0WY4xpWuHKvZ9n3g==
X-Received: by 2002:a63:bf49:: with SMTP id i9-v6mr5330556pgo.342.1529770336159;
        Sat, 23 Jun 2018 09:12:16 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:100:fa16:6549:5166:32c7:2dab])
        by smtp.gmail.com with ESMTPSA id n26-v6sm2732745pfi.168.2018.06.23.09.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 09:12:15 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de,
        linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/5] dt-bindings: i2c: Add binding for Actions Semi OWL I2C controller
Date:   Sat, 23 Jun 2018 21:41:43 +0530
Message-Id: <20180623161147.15672-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
References: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Actions Semi OWL I2C controller

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-owl.txt       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
new file mode 100644
index 000000000000..9b691968cffd
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
@@ -0,0 +1,27 @@
+OWL I2C controller
+
+Required properties:
+
+- compatible        : Should be "actions,s900-i2c".
+- reg               : Offset and length of the register set for the device.
+- #address-cells    : Should be 1.
+- #size-cells       : Should be 0.
+- interrupts        : A single interrupt specifier.
+- clocks            : Phandle of the clock feeding the I2C controller.
+
+Optional properties:
+
+- clock-frequency   : Desired I2C bus clock frequency in Hz. As only Normal and
+                      Fast modes are supported, possible values are 100000 and
+                      400000.
+Examples:
+
+        i2c0: i2c@e0170000 {
+                compatible = "actions,s900-i2c";
+                reg = <0 0xe0170000 0 0x1000>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&clock CLK_I2C0>;
+                clock-frequency = <100000>;
+        };
-- 
2.17.1

