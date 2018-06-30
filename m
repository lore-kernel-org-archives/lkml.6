Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341F3C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DAB2531E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eU0hdtR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DAB2531E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeF3Nee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 09:34:34 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45051 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeF3Ne1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 09:34:27 -0400
Received: by mail-pg0-f67.google.com with SMTP id b10-v6so5172695pgq.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 06:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=eU0hdtR8uNLcMd2hl4GHV89rE1ltQyYKrqkwTws8YS9m9IrBx5BglDqxrgwJxW+u1J
         3H6oU72dB/pBsRd3d0ORfB4lMpeNvBb2ZLKcClhJt+VEz/s8kOZ082R1GjAbCAsh/8Wl
         a+KE17eHnJLNSyEbU0cOmrDBv+obiRA2I5t3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=G1zYPmruRNXz+SD9mnHceUxAmej8P8e5PIxZObiUn4gTJcGnY6CdFXe6LY6Ixza2SP
         cvoepxsDWx+/edipPpq231KE0/ZbAgwT06GsQGO5j8YmWClIf7NZH6cR/x31OyXNxgPO
         Aa0LZeXS2yI9KfQ/vw2sLdbx2ruYg9j+7fWIUPvIRCSsW6h/C33T7Ef9PzwRSI2pZ6Qw
         foBgkAvi1Naach9zTVGm2G16b0uBu9wt+C4d820L+ZLgMHtNiLGDSOxha6/01ajyiu6y
         +NrHFVjzlGO/hZfDvnLcqFKBiSANFcgG2bP9fo0W8+mbPxfBrmEcwFTigJkmRUxPEU0/
         g2/Q==
X-Gm-Message-State: APt69E3ke+CHwoATJAiTJeJHIde42AXRyk87Sa15agOMQ+LrZgbfSXZf
        Lp/XJJoL/p9BYzBiMdxxjQ45
X-Google-Smtp-Source: AAOMgpcrrHqpZcGYV3Nrb4GGhFPfjrGmlRS3cT4a6PHrHrbQWq/1JsK3diaCIvjTH9FS8RUKf1Vu0Q==
X-Received: by 2002:a62:e903:: with SMTP id j3-v6mr18524433pfh.228.1530365667207;
        Sat, 30 Jun 2018 06:34:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73ca:b257:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id m10-v6sm18738778pgq.89.2018.06.30.06.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 06:34:26 -0700 (PDT)
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
Subject: [PATCH v3 4/6] arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
Date:   Sat, 30 Jun 2018 19:03:28 +0530
Message-Id: <20180630133330.23858-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
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

