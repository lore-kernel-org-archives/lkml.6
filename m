Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D03C18DF5
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0980D20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qR0f03U6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0980D20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633231AbeKXGjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:39:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34509 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633205AbeKXGjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:39:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so8227136wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 11:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BtJ8/ior5XarJZafC0TR6eFgTbDH+g1bBywq7Yhl7So=;
        b=qR0f03U6jWYKzWGUGH3Ph79PNSbD7rSU5e0OCOchMQ5LltlzWJstK21WaqTS7Ltrlv
         1/EDaagXtFhRFrfktQAiSC31Xkt18nMrHH6my6jA1v9yrgalDiZiYxwjXFhM49c2wzoX
         wptUhAiEnbZcuKmPP1DAyFWB+ViwqeR6zuADIwx/14Qjmp669WB4iWGDvLWwuAueE844
         5dSjWQMmggv2ijkjT8GDpFmj9fCrb6c8n0AiAKDpDzkim6WZLw0cszsOI8ihDoo2/yhH
         tLsC3QT6R1khbJAt0qHct66OyXjPAgfPC+6DWRqSUianamqRZvSIBTP+xKIfAAAZ7Jny
         4a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BtJ8/ior5XarJZafC0TR6eFgTbDH+g1bBywq7Yhl7So=;
        b=pTnyabNQYxqx4oO+OSjnxSAWzzYhMGEFWuMKdNsYCPQixWJ0Es8983vS7oPQ7QhR7O
         p7ZoSht+KsHGMdVo5cAkBzjuFVtseTy1SniIiqvMqF+61TMD3jfxLC4LwEdFu6Ej+5+y
         2AtvEq84ceDO1DYQnNiCpt+B4qtkQHRmK/bCSbluLezxirJnBqW5GnNVbzEY1TGHTa4B
         529fLoRtIjc9gDhdhD2AeF3fYIPJIH6myFbZv/VuPjRSRA6/qyXCcSa9+xgmvaalh+NC
         H28bi+Mb9Hj8eNR/z4KaHzPMxkDPs3+/hILzI92B51puBnDG40wBcztID9toNJmEVhNM
         puUw==
X-Gm-Message-State: AA+aEWaDgL/Oep6FY20OnIl5hN1ZKb94gwHgjelnQP8h+pNt7n6naiuD
        LnMiXqLsbMV4AC6nKP/s4w0fuRlO
X-Google-Smtp-Source: AJdET5ee544o4sAtCgcDvUAQK9C61pvQfASctCobRHUpaOycLuWuhWdwDBPxowV1KIrVxu66+Ryr0w==
X-Received: by 2002:a1c:1dce:: with SMTP id d197mr15751793wmd.66.1543002811237;
        Fri, 23 Nov 2018 11:53:31 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F500597D16A631573221.dip0.t-ipconnect.de. [2003:dc:d732:f500:597d:16a6:3157:3221])
        by smtp.googlemail.com with ESMTPSA id g198sm11495337wmd.23.2018.11.23.11.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 11:53:30 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     carlo@caione.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 6/6] ARM: dts: meson8b: add the Cortex-A5 global timer
Date:   Fri, 23 Nov 2018 20:53:11 +0100
Message-Id: <20181123195311.4578-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson8b SoC is using four Cortex-A5 cores. These come with an ARM
global timer.
This adds the Cortex-A5 global timer but keeps it disabled for now. The
timer is clocked by the "PERIPH" clock whose rate can change during
runtime (when changing the frequency of the CPU clock). Unfortunately
the arm_global_timer driver does not handle changes to the clock rate
yet.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index a3a5649e32fa..a38d187d3d6e 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -350,6 +350,19 @@
 		reg = <0x0 0x100>;
 	};
 
+	timer@200 {
+		compatible = "arm,cortex-a5-global-timer";
+		reg = <0x200 0x20>;
+		interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+		clocks = <&clkc CLKID_PERIPH>;
+
+		/*
+		 * the arm_global_timer driver currently does not handle clock
+		 * rate changes. Keep it disabled for now.
+		 */
+		status = "disabled";
+	};
+
 	timer@600 {
 		compatible = "arm,cortex-a5-twd-timer";
 		reg = <0x600 0x20>;
-- 
2.19.2

