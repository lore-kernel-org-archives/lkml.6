Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B2CECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3DB20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3DB20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineageos.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeGUNp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:45:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43796 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeGUNp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:45:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id v13-v6so9017721pgr.10;
        Sat, 21 Jul 2018 05:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nd8TRqG3Zzb2FOV1SNN3bGArF9UXbDFiREj4up1N8GY=;
        b=j+ioPixNKb364iPHJLJ+iJtGHHXVL75TKL+4nlnJ6VGyAMkIexZjfncF9xckN1oGWJ
         j9pZ4yV2R5/jVp44JGimSjqK8agFUXN29XswGSR9Ax4YvGvKZwI+4cdacwgFwhNZyiuM
         Cqo2J/qCHPWSAVrdC/QntbAVyceS12C/UIWVJ08o14At6QWiuD74NqBd+EcNJIfCUmw4
         UE31xoWH1Jw1ufGZlvCVAVJUtwYhXR8giofSPsL5zg2e/mYVwD5SmbCB4RsJ7x2oG8fg
         bXt5puNejz9dtf7XhuvPufvS4NHpNpvEeQr+D8GBOkhm0JTnOfUxi30mNV7VI3VLCYd9
         aVHw==
X-Gm-Message-State: AOUpUlF2V2bjS13hnhGqLjU+hPff7Io2hpoyc6VNbA7KZEkSae+YFIQH
        XwbKi9mHz7zPzOOipdsVEaDF4MigZs4=
X-Google-Smtp-Source: AAOMgpcKEJN/JEq1+qpQ+510YotKz7l7EbAeHHWi9xV4b9TLG99bnlAO/tCxGundPOPpWxKjCkojbg==
X-Received: by 2002:a63:6b86:: with SMTP id g128-v6mr5655941pgc.344.1532177568611;
        Sat, 21 Jul 2018 05:52:48 -0700 (PDT)
Received: from forlindon.lan (27-32-42-49.static.tpgi.com.au. [27.32.42.49])
        by smtp.gmail.com with ESMTPSA id o72-v6sm6625945pfk.76.2018.07.21.05.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:52:47 -0700 (PDT)
From:   Simon Shields <simon@lineageos.org>
To:     linux-samsung-soc@vger.kernel.org
Cc:     Simon Shields <simon@lineageos.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: exynos: configure max77686 IRQ pin on midas
Date:   Sat, 21 Jul 2018 22:50:52 +1000
Message-Id: <20180721125128.31498-5-simon@lineageos.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721125128.31498-1-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pin is externally pulled up, so we need to disable the
SoC's internal pull-down.

Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 6a6364a9debd..d69bc3c2d0ff 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -685,6 +685,8 @@
 		compatible = "maxim,max77686";
 		interrupt-parent = <&gpx0>;
 		interrupts = <7 IRQ_TYPE_NONE>;
+		pinctrl-0 = <&max77686_irq>;
+		pinctrl-names = "default";
 		reg = <0x09>;
 		#clock-cells = <1>;
 
@@ -1135,6 +1137,11 @@
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
+	max77686_irq: max77686-irq {
+		samsung,pins = "gpx0-7";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	max77693_irq: max77693-irq {
 		samsung,pins = "gpx1-5";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-- 
2.18.0

