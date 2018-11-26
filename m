Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB50CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B165E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B165E20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeK0EaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:30:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37405 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbeK0EaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:30:24 -0500
Received: by mail-qt1-f196.google.com with SMTP id z16so18494522qtq.4;
        Mon, 26 Nov 2018 09:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=bG2RSG/eMmogT9zLKeSpesOwSTJMB/bL447og4JLn/g=;
        b=YElhiznN5hC73rS1A2zVqESqKXEPhpbVH3atOTUiBurTOLjTl9ShbRZOqbSFPzcu73
         B3HmcJfzDtNglfPeFTWOzvarNw2/1+BRTtBKBfYZR5Oq/V4iK+Fy40Td84xL4uGsQ0Vx
         XsiJS9sqv8X7jx1Fki0vA34f+lFhQG9atfxhiCDXR5Dad9Uip6JikUk820BQ0/TdOtyD
         QwOLt/IAw4zlXSe8mcs1ydYONS7dZ6TKW8OXNMmB66rf+YQJ76/YbCwlcK+C6vkl+IhT
         ndUEUvVLG+/ioaxyLkBlq9FPNRiX9XmMZFmJ+8a2UvWyEIDNMm4drslQ9/leM3sSq0pJ
         DpWA==
X-Gm-Message-State: AA+aEWZ/4stm54kf1jBI7md9K/pRSxsZmDEm/0RCgrutkl5oWGFhXc+g
        JSh/H0AUIAO7tU5sOXZ9Hs8F7YWL
X-Google-Smtp-Source: AFSGD/UCrCUN1WJpSOk9xuNGt7e0LZ5eMujXLmMISKrON8UoU0GzN0PPH86z34FvSzdx/GgjgTXUmw==
X-Received: by 2002:a0c:d2f7:: with SMTP id x52mr27044363qvh.35.1543253735871;
        Mon, 26 Nov 2018 09:35:35 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id x7sm397238qti.76.2018.11.26.09.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 09:35:35 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Mon, 26 Nov 2018 15:35:29 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 4/4] ARM: dts: rockchip: Add internal timer support for rv1108
Date:   Mon, 26 Nov 2018 15:35:06 -0200
Message-Id: <20181126173506.24068-4-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126173506.24068-1-otavio@ossystems.com.br>
References: <20181126173506.24068-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the internal timer peripheral on RV1108.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2:
- add binding to doc
- fixup commit log

 .../devicetree/bindings/timer/rockchip,rk-timer.txt       | 1 +
 arch/arm/boot/dts/rv1108.dtsi                             | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
index 16a5f4577a61..d65fdce7c7f0 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
@@ -2,6 +2,7 @@ Rockchip rk timer
 
 Required properties:
 - compatible: should be:
+  "rockchip,rv1108-timer", "rockchip,rk3288-timer": for Rockchip RV1108
   "rockchip,rk3036-timer", "rockchip,rk3288-timer": for Rockchip RK3036
   "rockchip,rk3066-timer", "rockchip,rk3288-timer": for Rockchip RK3066
   "rockchip,rk3188-timer", "rockchip,rk3288-timer": for Rockchip RK3188
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 23ac4b10d690..9683f3b00d9d 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -293,6 +293,14 @@
 		};
 	};
 
+	timer: timer@10350000 {
+		compatible = "rockchip,rv1108-timer", "rockchip,rk3288-timer";
+		reg = <0x10350000 0x20>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&xin24m>, <&cru PCLK_TIMER>;
+		clock-names = "timer", "pclk";
+	};
+
 	watchdog: wdt@10360000 {
 		compatible = "snps,dw-wdt";
 		reg = <0x10360000 0x100>;
-- 
2.19.2

