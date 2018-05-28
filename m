Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932821AbeE1SCi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 14:02:38 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38713 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932686AbeE1SCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 14:02:11 -0400
X-Google-Smtp-Source: ADUXVKLL9tTkons99QyRC8L8aUsvvqdQRhNDE36jc6v0trx7g71iHK+GRnS7VlNIAxWZVHqFV4EQeg==
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 5/6] arm64: dt: set initial SR watchdog timeout to 60 seconds
Date: Mon, 28 May 2018 11:01:36 -0700
Message-Id: <1527530497-10392-6-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set initial Stingray watchdog timeout to 60 seconds

By the time when the userspace watchdog daemon is ready and taking
control over, the watchdog timeout will then be reset to what's
configured in the daemon

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 99aaff0..1e1cf49 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -420,6 +420,7 @@
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&hsls_25m_div2_clk>, <&hsls_div4_clk>;
 			clock-names = "wdogclk", "apb_pclk";
+			timeout-sec = <60>;
 		};
 
 		gpio_hsls: gpio@d0000 {
-- 
2.1.4
