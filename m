Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084AFECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86E920874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkEAWk/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86E920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbeGWEkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:40:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38279 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbeGWEkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:40:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so11214151pgq.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 20:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bcvpf2JwZdjv59xkZ4zzQ6yiuLiqFtQKkQsfAovx0i4=;
        b=LkEAWk/jxwInJjyVokLoHnrMBYPHjXb6L7XK+wzezY+GCpnsHRlxBA/RaSOSimBnBB
         +zBgvDr7dEir7CJg20AXUyVDnbQGBB9/zjlrofWe1+Bbs0uIAwSBL1cIHwobLdJlOrkQ
         AsXuKhHEL3/E2K4mSbmW3NcJSZmgr+Gb9jugU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bcvpf2JwZdjv59xkZ4zzQ6yiuLiqFtQKkQsfAovx0i4=;
        b=EKvgHnXYmFB2b0e+EX61hIfRP0unb9TDWrjjITndQu7P26aCOBlFKjNUCWdtn/UUbl
         ejwhh0g778CGtbimVloxQ+7+qcgo3OSagyOjlNSkwPoEkWfCOAFjLh31oltS2m+yDzoP
         lq6Jk0Dapmk+YCuCa0vlfufCr1FaycDEVLhcJCsUQU84mc4hyXmWLgnS/S9iuqWisai6
         GBb5nllACfnZ60hUwwnc9LWYaUCJFpf51Xj+QITRaTT6hX3YDuqPzKtov7ug2FYpsgRg
         Ps7/jPQanb89yJQ8NW4DDjKNDANNCkGjz0H3OGCsHwwYGHtcby3Q9qDXesQmh3zQ4iAq
         qWfg==
X-Gm-Message-State: AOUpUlGJkt6SB7RIdgEBVpbWGdyhdz4VwzJv5hqwNaoRusmUYFTesKQG
        rn5I28ETne2f7PrDcim+AyZs
X-Google-Smtp-Source: AAOMgpdJ7nchzNBQkSqZM0Tova9FfZBlf9rteD7bpZcgutigo/zbixVZ9pjKFUhpXdcoDZCfNukD3w==
X-Received: by 2002:a65:60cf:: with SMTP id r15-v6mr10575099pgv.41.1532317275960;
        Sun, 22 Jul 2018 20:41:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:802:a98c:b568:c01f:49a2:2aa5])
        by smtp.gmail.com with ESMTPSA id s184-v6sm11340248pfb.56.2018.07.22.20.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:41:15 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 1/6] dt-bindings: i2c: Add binding for Actions Semiconductor Owl I2C controller
Date:   Mon, 23 Jul 2018 09:10:20 +0530
Message-Id: <20180723034025.5763-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Actions Semiconductor Owl I2C controller

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/i2c/i2c-owl.txt       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
new file mode 100644
index 000000000000..b743fe444e9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
@@ -0,0 +1,27 @@
+Actions Semiconductor Owl I2C controller
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

