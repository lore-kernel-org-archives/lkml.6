Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D92ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC49020856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC49020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineageos.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeGUNo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:44:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46499 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUNo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:44:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so228688pfn.13;
        Sat, 21 Jul 2018 05:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ZurJhUy8M8P7tZREOr7iqN9qKZ+3ZX75lYAOktSHmg=;
        b=Am6BMw++HW4pfo2pvaaNlIxWRLSo5jxgduPR5fwBcWDk1wjHzg3nMLJkV+3pvtWsTo
         6OupEeWqq0eaDnQjGkrcPzRJzpuEkIKLg4E1jCRG6+rW+/VsGcJ5OSYnDYe4pwoj+3v7
         UMFIwmooumwrPf+8jLuEA5AiT7AQJeGHaJgZVx1DlezS79z4me2kpPYrLs1yKka1AilN
         oG/qIVm69Mkfah1NBfEKBlqVEcmV+cBCMl4jO7m5RnbrmEKWNQwiZDrVtPwC9VLjf2uC
         r7car5YJRyBdEMhgaGAJKf5wdBMNCVM6qABD/DPG/3oxuUh8UtriqF8NTSXINfZM+gvd
         fCXg==
X-Gm-Message-State: AOUpUlGKAfvEWeLZdMuUIFcVxYcaS5UuYGmrOH2fuZHtgMM3sSswcm5E
        IeP9trjOtf/uwHe5BzM6zh1KBzbzOPA=
X-Google-Smtp-Source: AAOMgpeekxAVAcTJqRCFhSny57tvo50KOGA22Np2u67IvTm2hmZpf9Agu4ydiA5AGqeD0C0zqsectA==
X-Received: by 2002:a62:ccd0:: with SMTP id j77-v6mr5975333pfk.22.1532177537373;
        Sat, 21 Jul 2018 05:52:17 -0700 (PDT)
Received: from forlindon.lan (27-32-42-49.static.tpgi.com.au. [27.32.42.49])
        by smtp.gmail.com with ESMTPSA id o72-v6sm6625945pfk.76.2018.07.21.05.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:52:16 -0700 (PDT)
From:   Simon Shields <simon@lineageos.org>
To:     linux-samsung-soc@vger.kernel.org
Cc:     Simon Shields <simon@lineageos.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ARM: dts: exynos: add max77693 pinctrl config for midas
Date:   Sat, 21 Jul 2018 22:50:49 +1000
Message-Id: <20180721125128.31498-2-simon@lineageos.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721125128.31498-1-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we assume that the bootloader has correctly configured
the interrupt pin for max77693. This might not actually be the case -
so it's better to configure it explicitly.

Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index f12372509061..ee7cda1432f7 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -156,6 +156,8 @@
 			compatible = "maxim,max77693";
 			interrupt-parent = <&gpx1>;
 			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&max77693_irq>;
 			reg = <0x66>;
 
 			regulators {
@@ -1124,6 +1126,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep1>;
 
+	max77693_irq: max77693-irq {
+		samsung,pins = "gpx1-5";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	hdmi_hpd: hdmi-hpd {
 		samsung,pins = "gpx3-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
-- 
2.18.0

