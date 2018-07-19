Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48264C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0920B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+GT+hGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0920B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbeGSSai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:30:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32977 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbeGSSah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:30:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so4414822pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=P+GT+hGYtOtwESvb2op4lug6Y9gEkTb0hzk7+7XD22mkVrxZbYyGwIqUDWH295j6+l
         IQvXSRjggw+UbAYjWb1A860HB9JVMmmw/0rkE5eAvTZQggpwOR4/mnrujg9JqLuuM847
         28rdp2SVrU6bEt+AlD6/MWjN2roPNAhZqMd8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=Fa305Qwyya0dfdmzIoxWQto89aBwOORjYb6St+i7qFL2oV12GaYHGSqBY+g5oO63b4
         mEQ7Fkkyi43k6GEW3eu7HghykSMXGIAarqBORThzAFkycE1wyGJcgxi50Lpyy45xvN0c
         mgvhtMfEI45dEzOhJ0aJ3MXO3PtEqnTxNfts1wxGuU1HFZi3oTkiYSskkbcZcbnOyutE
         hKToKQoxv7T12UgtttJr3mpWou717QzAMuxOKosqt5OPu46vF/WK1ztjei7hJuyd2cIq
         Eg+qVu6vGph3zi0dub4692IcO+cbd95znV9WvkVnUT/PNaxog8pBzgfR4Yqkhu8BowX+
         5M3g==
X-Gm-Message-State: AOUpUlGg7AVsLaHlwnxAqkrdFscuggMBI0N+vDpxXHa4jY6awnB5GiMW
        lUi/DrpdTVBCn5BI2lXd/nyt
X-Google-Smtp-Source: AAOMgpeCo8Ci32eY606quQE3Yw22gvxtmiiOJlacNN26lT7Fb9K6dizDG9qao3jkyuFTlbOmCl2iTg==
X-Received: by 2002:a63:f002:: with SMTP id k2-v6mr10751193pgh.8.1532022384636;
        Thu, 19 Jul 2018 10:46:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6081:b056:55fa:fd42:61de:739])
        by smtp.gmail.com with ESMTPSA id h2-v6sm10114639pgc.90.2018.07.19.10.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 10:46:23 -0700 (PDT)
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
Subject: [PATCH v5 4/6] arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
Date:   Thu, 19 Jul 2018 23:14:03 +0530
Message-Id: <20180719174405.7210-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719174405.7210-1-manivannan.sadhasivam@linaro.org>
References: <20180719174405.7210-1-manivannan.sadhasivam@linaro.org>
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

