Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDBEC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0214E24267
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avIXNv0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0214E24267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933801AbeGCJ0h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:26:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52470 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932471AbeGCJ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:26:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id w16-v6so1528055wmc.2;
        Tue, 03 Jul 2018 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nu/FJNgD64YmotN84uV2r0IN3JTthtczd7CappcHDzY=;
        b=avIXNv0kylM5zUE4QvCkIARmGkvq6BU0VvHBZMXdUCUX7UB2BDwd5sN+IIzz0q+cVm
         T9NjCBUjbD1SVfxd9TXps3Ey/yDjjxRAjgCuG1QYIueiibci5crr88wt3P19a21o3RnB
         I37A/Pn+qS5uwYbNYplNVqIlBN928UlHtqKDmKdr/jkT1zDpl9AhGdr/San3uAsRgvF1
         OSELwNHAB8xFr3yZgeNuEGMEtBgbWY5bizGCwJOGBD1TF/e0oqMbXdoYCEC3tBCX3PyL
         XpSNaSLMdWlcsoeP0dJk50Oj7OtSpnW9POM4Is3Szf02+FgRrwmu6bt2tZWJZKqVyArJ
         TBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nu/FJNgD64YmotN84uV2r0IN3JTthtczd7CappcHDzY=;
        b=aQm7EfD4Ee9dzpBOGyP9jo+jzZL9ew35BTGAhPK2mtgTJ2TTOzvY2C1VMBvG8Xb1Dq
         T7hvDTNgaHyNViRjJRNl8jnAduEniXd5QKvhq4+qfAywzgA8F3s31AC5nrN7CCj3zKud
         zHQCHUuLeRpEFu+u08ekM96549QTXTZ0QWQO+7P3ZMT0gN9Vb6X7qEjbM7U1ctt1rZwn
         FuiOclMi4a5bIhLObRTtCMf80GcWEHKBmiI29KsYXeRaZPNC4qjENrEYt6wDHXoMPvxP
         Yc6KILwfERANGxLI0DOer+PEkD7wSsbijtmL6UcnUcnvXQmdjBlrslQOterFht0FJMNb
         A1XA==
X-Gm-Message-State: APt69E0sVyl6Q09rRpu87HlSjIA6zMu9SOEYUmAcPF6paCg2XLrlriRC
        U0PZ6/PxVWYt8vF/JLLY7mc=
X-Google-Smtp-Source: AAOMgpcWw2999ulKabFNa0y6WqC3X42ts+UD69tCYxFf6KyYupkCeAeit8Qzn2Z7QgveH1ULedhIYQ==
X-Received: by 2002:a1c:15ce:: with SMTP id 197-v6mr3660978wmv.99.1530609958604;
        Tue, 03 Jul 2018 02:25:58 -0700 (PDT)
Received: from xpert.denx.de ([62.91.23.180])
        by smtp.gmail.com with ESMTPSA id r194-v6sm1819280wmd.36.2018.07.03.02.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 02:25:57 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, sboyd@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        support@cubietech.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, linux@cubietech.com,
        darren@cubietech.com, mp-cs@actions-semi.com, pn@denx.de,
        sravanhome@gmail.com
Subject: [PATCH v3 4/5] arm64: dts: actions: Enable clock controller for S700
Date:   Tue,  3 Jul 2018 11:25:23 +0200
Message-Id: <20180703092524.1697111-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180703092524.1697111-1-sravanhome@gmail.com>
References: <20180703092524.1697111-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added clock management controller for S700

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 66dd5309f0a2..19998f19af60 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/actions,s700-cmu.h>
 
 / {
 	compatible = "actions,s700";
@@ -44,6 +45,13 @@
 		};
 	};
 
+	clock: clock-controller@e0168000 {
+		compatible = "actions,s700-cmu";
+		reg = <0 0xe0168000 0 0x1000>;
+		clocks = <&hosc>, <&losc>;
+		#clock-cells = <1>;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -87,6 +95,12 @@
 		#clock-cells = <0>;
 	};
 
+	losc: losc {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.14.4

