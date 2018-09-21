Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310EDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A0E21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNOuoybd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A0E21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390443AbeIUQOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:14:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33111 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389264AbeIUQON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:14:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id r1-v6so3806649wmh.0;
        Fri, 21 Sep 2018 03:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jr2Guj4IS+KaSpQIhd5X6b3SqJiQa+YzNCwuQumn9r0=;
        b=nNOuoybduFOKNSwFgG9MWSKog5EthQjw2mp59zTfdsNQOC1S5T0lyx10Cfqd3leIMz
         3JHxL3LE/OZjkYq5PeHDgdgZOD1s7LuyeB8kGMpZIUiEszoV6itJda8VZ2h8unsFrLbC
         iC7jAEyE/kCU3PxOD5DqSVZGZUTAo3f4+zT9HFnbHcsdkYmjOEZ70PkL/23OEGQ0Xc3R
         cwaVOLa79R78+6jbe9p4Cx/mN3Qb82SSO8d4mNOm+620SOMpZo/VhRTnUq/JVGNK4GfL
         4CXset+4j+33Nsxy0qrAoMD8uUfKmLxfL0b5HX2GXJbjdkM7+ImnwLi2EnOpTw0J/O0C
         ilng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jr2Guj4IS+KaSpQIhd5X6b3SqJiQa+YzNCwuQumn9r0=;
        b=sTXp/58XqVVmoQr0pTczfGionG0LxYdcAGw7xIk5X573Nj4Noy2oOb0ZBWOKUKU813
         A5AiH/VW0B/UH/Bi4xiHtsngJsatxJq3AAm/rXk/9LepJ0Gk+qLXe82ATYIuW0YbzfX4
         tyW+Dvy285P5rPaJ80nl1JGZx4V4BdoCCBdVSh9sKlz1PWAYKWoHu69hTqMlLzmupVqS
         YCnvjaJ1tLZlPukrpbWjpAF6tF9GEGGTPh8IbO7j5PQyRTavMGmhFLjnw1miCRB6IIFH
         b4qK9WMi3ZKSOnRt7v3X+42nle/TyH+3XF02cZ91Foy+aZavczoO52kNfUlHBACkMcvZ
         vdsA==
X-Gm-Message-State: APzg51A8AyEN914yuFzm9SR1kD3OB7dxuuA3uqNkZxN6C1z95IwTISAQ
        5hwRYYqnNWfRNFYFWSWVnak=
X-Google-Smtp-Source: ANB0VdYWn21FZZ+t2W1B4ur7HqFpvtJq51al8+6bCWZ0SVlxPMA6qkV6xHxkbANY1CkmtYongBNx0g==
X-Received: by 2002:a1c:e5cf:: with SMTP id c198-v6mr6258019wmh.113.1537525558907;
        Fri, 21 Sep 2018 03:25:58 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id x65-v6sm5573042wmg.39.2018.09.21.03.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:25:58 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] dt-bindings: tegra186-gpio: Add wakeup parent support
Date:   Fri, 21 Sep 2018 12:25:44 +0200
Message-Id: <20180921102546.12745-8-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180921102546.12745-1-thierry.reding@gmail.com>
References: <20180921102546.12745-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Tegra186 and later have some top-level controls for wake events in the
power management controller (PMC). In order to enable the system to wake
up from low power states, additional registers in the PMC need to be
programmed. Add a wakeup-parent property to establish this relationship
between the GPIO controller and the PMC.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/gpio/nvidia,tegra186-gpio.txt      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt b/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
index adff16c71d21..cbb51a8990c3 100644
--- a/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
@@ -127,6 +127,11 @@ Required properties:
             - 8: Active low level-sensitive.
             Valid combinations are 1, 2, 3, 4, 8.
 
+Optional properties:
+- wake-parent
+    A phandle to the Power Management Controller (PMC) that contains top-
+    level controls to enable the wake-up capabilities of some GPIOs.
+
 Example:
 
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -148,6 +153,7 @@ gpio@2200000 {
 	#gpio-cells = <2>;
 	interrupt-controller;
 	#interrupt-cells = <2>;
+	wakeup-parent = <&pmc>;
 };
 
 gpio@c2f0000 {
@@ -162,4 +168,5 @@ gpio@c2f0000 {
 	#gpio-cells = <2>;
 	interrupt-controller;
 	#interrupt-cells = <2>;
+	wakeup-parent = <&pmc>;
 };
-- 
2.19.0

