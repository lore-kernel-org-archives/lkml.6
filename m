Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDA9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A91320874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xk0nDYhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A91320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbeGWEkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:40:51 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41968 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387747AbeGWEku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:40:50 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so7633566ply.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 20:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=Xk0nDYhO+Z2Qvn1eHZiZMymsNqRA1xBQ8VvAG+0VjRI1+VNkPPR2lB9aliZxK4FXzN
         Li99OhCkqWP0CWSB24VKuIK1769jIsjYIQA4gSWYRh3F5IvTeG4P97GIpCkPVVHQCIhE
         kXnHlhRQIONcnySl6w51ATvjeTd1Wov6/vN/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=lfeTpLxNbe5Nbf9+0KvLGVPFBQie29T/EHk38MG86Pt7Xc0ODOaLFW7wmKB17edJ5R
         JYV+EFVq12q1wMbXHZg1tJkknxWHnEf82vvEDeJQgkdwCAHxX2EaEpU06ikZInfwC7N1
         0ILiYRvcgEFc8lgr6wNNpmcpRA0t/raMpoQOQwSJVfYyZUFgLCRKpsLCWEnnZriAyvs2
         R0YMe+fTiaSvww34skFr0h7FnYb88aSPs731lBn5ruc14IljAVYoG8wk2zTN7xzmRgYF
         ycr/pDepRSWcoxY+etm20ylftauLvo7mXDFnfIBpv5eSw/dGaMLrioRpD18MS91UlrXP
         jYCg==
X-Gm-Message-State: AOUpUlHzQLBEx0A4GLOD4EEX49qoCGBiPoJDln5mkqUKzfazFZOV2Ovw
        rI00FroMEaO2YkBLzOHZTLNo
X-Google-Smtp-Source: AAOMgpdJ8bwHxPbCFmmz9C6HOXS3IEGFWL6/FxUTPDJ+NFKdPrrFov8/NqyrvDQTenKm2O2eaf7yjw==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7-v6mr2430884plm.90.1532317304355;
        Sun, 22 Jul 2018 20:41:44 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:802:a98c:b568:c01f:49a2:2aa5])
        by smtp.gmail.com with ESMTPSA id s184-v6sm11340248pfb.56.2018.07.22.20.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:41:43 -0700 (PDT)
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
Subject: [PATCH v6 4/6] arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
Date:   Mon, 23 Jul 2018 09:10:23 +0530
Message-Id: <20180723034025.5763-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
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

