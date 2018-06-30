Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA53BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F55324670
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjTKDmE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F55324670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeF3NeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 09:34:08 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42950 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeF3Nd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 09:33:58 -0400
Received: by mail-pl0-f65.google.com with SMTP id y15-v6so3922801pll.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3sErEIs2TdQVU1vCbLuXOpei3kXzzcqD58jTzbNExU=;
        b=YjTKDmE4YaMqwRk6V3v7r9XY4w3noRKkarDChMw1xBVbWHgNR2k6XknTw0g0MQazO1
         BttlBO+FdjP5f1p+yKMPR3c93d/76Tx1DdNMl5EFj69k7gEED7aYJYYD355Ry6B/k47u
         Q5TJXdVof4VD46xJvbKXBY1VJgaW2BYU2Kmrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3sErEIs2TdQVU1vCbLuXOpei3kXzzcqD58jTzbNExU=;
        b=hfl9m4Q+6azBhK7PKigQ9hdDtPxQH5j7eA8eHaiHO9HAlAe+NcNRiTD7xhU93oJMg6
         ZH77stPpMgS1fdsc7Ke4gRciBo7/OYABKn1nUXj5QrqvCjSa0O/LBrFUTTxFavQKJYnw
         1pMtPlh7V7h5O9YyDq8pz9PFwqvk9ncfhb29ru2L/KeCr2KXQ5kr5VXVBVXgiHgbYNPs
         1GA5L+Vf7yyPZZn9FtaKJ4Z969qQZ2HcGtm4OaAPybnwRgbR/iB2VDS0ntsaJNqxrNDO
         z9I8sN/3UFiDsCgwcwuxsxw6dNFkxzmw8jiuOySIo1vS4nOH0K7Sym/faLsrri0HhlLA
         AC9w==
X-Gm-Message-State: APt69E3CNrHsp6RTWJLmo6ZkPuw/+5FLWTv0w0l23c350qBsaP0CtQNK
        qmztPKAVW6glzhjHUtrDFMFd
X-Google-Smtp-Source: ADUXVKK0Ry6Xa3z4/aFwuwQXUcVyc/XI81oWKDdz5d6VdosythuoEcev8WLEBKj9VGth+UZbvU0uCA==
X-Received: by 2002:a17:902:3303:: with SMTP id a3-v6mr18890105plc.209.1530365637165;
        Sat, 30 Jun 2018 06:33:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73ca:b257:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id m10-v6sm18738778pgq.89.2018.06.30.06.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 06:33:56 -0700 (PDT)
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
Subject: [PATCH v3 1/6] dt-bindings: i2c: Add binding for Actions Semiconductor Owl I2C controller
Date:   Sat, 30 Jun 2018 19:03:25 +0530
Message-Id: <20180630133330.23858-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Actions Semiconductor Owl I2C controller

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

