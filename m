Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2162EC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39D627774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIBUbHvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39D627774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030406AbeF1SMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:12:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36114 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967702AbeF1SMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:12:33 -0400
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so3154300plp.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=NIBUbHvjYBmNveLDr8VbGzB/RXt4GvdUfcOPLfpB8zOgV9RDeeU6wXwbZHc8z7z1Cf
         Un63UdiwCts+A7AjHY0ENYY3FvjuMWN8F1CcjWMJBsobtus2IkIPB1uEE5oflYWxL/Lc
         oLsu9VBxIoEcWEf+cz9WUsw3zqRxTR6FfTtKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=mv5PmGW8oTkkodRkbnM5OHRN5CVwUel+QktQ0TZh6W5CsAdP1cWOYKCY48m3IgY5iQ
         HRuKUisZitc1XknxQbciK2JLnwXOfXehTExMvE6r5+X8UcJwuDhR8jML3oj5mgFw2KNx
         WajWi4VNLeUb1ECLICsbmhbQeau0opzRBsibC26jOcEn/wXoTdf8tU4MUNJ47kEX6Ash
         2y9vbP8tMRintgid3X39sMbyc6e6wxHsy7qyCt2bmNfhXyq+lZ4YiUtoz8GeGlBK4Q+6
         wxsTZOVg4QVA/cNLT+uY2owqJRledUt7HCGl9yN0b9YCK7zQJ2CBFS6Ra7GvxfpKlZip
         h0qQ==
X-Gm-Message-State: APt69E04HNC7KZMMNquul/Ab0KVLQYXUH5O2O+y0gxFI5q6BIItyWBc0
        DV+JcFZGPnVo1zStRPuhMmTl
X-Google-Smtp-Source: ADUXVKKkYvyamec5vElAZQ0kfIDb+9iR3BzsTCdjyyx/BUYHEVoxer7A9+i+KoBulUB+1xyBIQB7sQ==
X-Received: by 2002:a17:902:760d:: with SMTP id k13-v6mr11363111pll.56.1530209553291;
        Thu, 28 Jun 2018 11:12:33 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7141:9f8e:c1c3:7dd1:e694:9dc2])
        by smtp.gmail.com with ESMTPSA id o13-v6sm13293132pgn.93.2018.06.28.11.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:12:32 -0700 (PDT)
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
Subject: [PATCH v2 4/6] arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
Date:   Thu, 28 Jun 2018 23:40:40 +0530
Message-Id: <20180628181042.2239-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable I2C1 and I2C2 exposed on the low speed expansion connector in
Bubblegum-96 board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index d0ba35df9015..57ae374cfb5a 100644
--- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "s900.dtsi"
+#include "s900-bubblegum-96-pins.dtsi"
 
 / {
 	compatible = "ucrobotics,bubblegum-96", "actions,s900";
@@ -35,6 +36,16 @@
 	clocks = <&cmu CLK_UART5>;
 };
 
+&i2c1 {
+	status = "okay";
+	clocks = <&cmu CLK_I2C1>;
+};
+
+&i2c2 {
+	status = "okay";
+	clocks = <&cmu CLK_I2C2>;
+};
+
 /*
  * GPIO name legend: proper name = the GPIO line is used as GPIO
  *         NC = not connected (pin out but not routed from the chip to
-- 
2.17.1

