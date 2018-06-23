Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765F3C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330E524C70
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3NcSQ13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330E524C70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeFWQM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 12:12:29 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35493 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbeFWQM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 12:12:26 -0400
Received: by mail-pg0-f66.google.com with SMTP id i7-v6so4254842pgp.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lyThY3JcGjNBnO+ReNP/irIxhSH65Nk/lsrkpXUda8k=;
        b=J3NcSQ13CsjEhPkpQtNTYTXecfElcolZMxEiZwhoaHpSK+p9tosk/VE38YhYs3bB/p
         JL3D1KyLAiXXjIBsu+7n1ymffiv2fQyLXvyZcIcd5CMbKEUFJrj2aSSWRqJHamrN0xDS
         llVx5tcpjIqNY0OC15oztBQly07Y+WfOBIwHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lyThY3JcGjNBnO+ReNP/irIxhSH65Nk/lsrkpXUda8k=;
        b=BGB0oMKNoD7g26erhElFCKHq9X/F862H1snB1EL4GrJACCD1doCNJlyziTWtTFcnhA
         PfJhBJ8qySBZkxIc6KaYzGCw2TyqYcrFhJrrNkFn59Eb8Tf4BaF7LqQmvwpQWsnHFJj4
         TgQMNJ/CL0iGiJ2/MSA7QZCmJDOF1VzExaqm7Dq+b85kZBYFaUotPHY8gq549tArZRpG
         Lqp+ZGMxxjYZNn1WgOBxH2TZGeYyr3ki/Lxwlekq7CPQSAp8DTUzdhHxyUmqhxz0pIkx
         wZuZlD4gW8LH7BFP0AIKypJw+areygJpsg85NBFKxQXHoeLe6dwvwPo67+c5Cje+SCjv
         MSrg==
X-Gm-Message-State: APt69E06eJyjA8hbGfONnI0iVs8pjHo16VhEqSBig6pjFcMl1urkQ7XO
        wtrClF5x6TKS4VD0g0Bqsv8ZjVOEzQ==
X-Google-Smtp-Source: ADUXVKIfFMuYWTIOv3872qrsjyFtDblvcaOiLC78ahFY7lzjIBqJui+z/L4hnqFzUurKwwxTQuXuhA==
X-Received: by 2002:a65:6157:: with SMTP id o23-v6mr5355998pgv.310.1529770345519;
        Sat, 23 Jun 2018 09:12:25 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:100:fa16:6549:5166:32c7:2dab])
        by smtp.gmail.com with ESMTPSA id n26-v6sm2732745pfi.168.2018.06.23.09.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 09:12:25 -0700 (PDT)
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
Subject: [PATCH 2/5] arm64: dts: actions: Add Actions Semi S900 I2C controller nodes
Date:   Sat, 23 Jun 2018 21:41:44 +0530
Message-Id: <20180623161147.15672-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
References: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C controller nodes for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 60 +++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 7ae8b931f000..6f7b89edbe4d 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -174,6 +174,66 @@
 			#clock-cells = <1>;
 		};
 
+		i2c0: i2c@e0170000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0170000 0 0x1000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_default>;
+		};
+
+		i2c1: i2c@e0172000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0172000 0 0x1000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_default>;
+		};
+
+		i2c2: i2c@e0174000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0174000 0 0x1000>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_default>;
+		};
+
+		i2c3: i2c@e0176000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0176000 0 0x1000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@e0178000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0178000 0 0x1000>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@e017a000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe017a000 0 0x1000>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@e01b0000 {
 			compatible = "actions,s900-pinctrl";
 			reg = <0x0 0xe01b0000 0x0 0x1000>;
-- 
2.17.1

