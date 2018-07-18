Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA06ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B25A2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI4aVZDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B25A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeGRNhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:37:25 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39500 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730245AbeGRNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:37:25 -0400
Received: by mail-pl0-f67.google.com with SMTP id p23-v6so2013456plo.6;
        Wed, 18 Jul 2018 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GU6MOQ0tS6vswTEuh9z760UOZZ2jllZroLz8D5yDImU=;
        b=TI4aVZDcgpaif3uHITqGnEzHqBZeVSq8y+kjgTGiAdtpRtKFEuXg289rrM42yjnhRt
         O+yuqYlVDNHs+VwklPdpcqPNBinmwAS5AzIJi/GDS9cqq8/j4Ek6QNr41yA86I4w7a9R
         6CfM6uNBUfQqNVMU28+c09GwnnXqK6sxFZAs0WZ+vyfqWoSeCKUONgyu5C3/FUWS1X2M
         0agOKmXchBKM9WFeLq+bP2Gc6zpMAweNeP/95pTM9WtYF5MkPiyxCv8e+7AcroOHBYJX
         Qfv1HPkBG8O1nFlabFQNKmjnPvG6AO/6RfJp2ru1BJ7t/YoQygyZqyuHAprEFvHzL9Xp
         bzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GU6MOQ0tS6vswTEuh9z760UOZZ2jllZroLz8D5yDImU=;
        b=HqjpHkNNSMKx1tcdTeha1PMIFYF/QhN3yfQ4GCp8abrxs390ijw9chMPAb6nMbi96b
         IdjYcPURBZzxF49tzvCzlkOCAtHk4gFSvgnxSWnIvUhdFvDbtpTrUpiJO2qjifbl8/1j
         wh4d0itjbK66Glq1GZz06Ncveya8LcXM3J0SDEUktPpWhlua2zTxplmpRLRcWO20Cffg
         poUF6qYCBAG9AReQHvKIDzRUqpdyXCKpHINXIQUuoRtMBl0uXb6IGtqOSlq4KPDH2BWr
         S4F0D347xma9wIK3lO1CrBFXvdhm7+w/cuxnCSD4Fl+SWovCA1m5lIM8BCoVMANRRyU9
         Gq9Q==
X-Gm-Message-State: AOUpUlHLGuP1NRXTUhdTsatGZ349afuf8HjXYTDl11NY9X9DSS2Rk2jW
        xnLvfEktKcvAv6/okVooM1o=
X-Google-Smtp-Source: AAOMgpdowLsatI8QLAUnd8tBod7jz4RkxGjHngrpe6EaRQfdOhpmRh2LoMAxwl4qs1jXb2zTNqET+Q==
X-Received: by 2002:a17:902:b7c6:: with SMTP id v6-v6mr5678830plz.49.1531918775742;
        Wed, 18 Jul 2018 05:59:35 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.135])
        by smtp.gmail.com with ESMTPSA id m15-v6sm10671439pfj.171.2018.07.18.05.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 05:59:35 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv2] ARM: dts: exynos5: add missing interrupts for pwm node
Date:   Wed, 18 Jul 2018 12:59:27 +0000
Message-Id: <1531918767-7177-1-git-send-email-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing GIC interrupts property for pwm nodes.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Fixed the patch indentation issue with all tabs.
sorry checkpatch could not figure out the error.
---
 arch/arm/boot/dts/exynos5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 5d2f0a0..f48fb9b 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -169,6 +169,11 @@
 		pwm: pwm@12dd0000 {
 			compatible = "samsung,exynos4210-pwm";
 			reg = <0x12DD0000 0x100>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
 			#pwm-cells = <3>;
 		};
-- 
2.7.4

