Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB259C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B29D20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2jjblP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfBVKT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:19:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41934 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfBVKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:19:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id y5so902579plk.8;
        Fri, 22 Feb 2019 02:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AooKzWveTVvTjP20/04jj799GvM5xIpT/iogDO3xN9A=;
        b=P2jjblP2DbX0scovVwuuZMh2AahuNzYnvArUx2qWaUl1TWzbf9qG7DIdNq9W5B/YKH
         J9t1d+3GUnSlt42t110jIGlPBLKOFeqKl2h0Hhy40UjJNx7/WLwepfBfAoOX/AwDr4Vi
         /yoHlcbA0NkRk3YrN19gkOFKSRSQiRoqtlolM8HOWc+LMfydPbJSMewiHsOZ0g6gtLBG
         /U1QbY2NLbYCMYAe6JacziHldc861GeIF4OF+0A+B/T8xjUkn/2H4CdzD/HLgddNEM1r
         tam6g3kJyX2bTcLpbbqmamVbhH3VJlct0HtIF6vIzyN2J4c3ODbTOgeijsdx2mXtyg+5
         oqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AooKzWveTVvTjP20/04jj799GvM5xIpT/iogDO3xN9A=;
        b=NqBHL0d4PwDiseV/XLqOX70IhpCKLKLkdiSMgHwhhq5SSLvi7l+TvufwfWo4t5gC4M
         vASEAv8oeAzFFNQ32TlzH64BYrMyoCXzVfCgWV056xgsanPkoeOWFiaqsXc0BRPWgaRw
         YWTUtLboNNQMkoD1kDMoaIWP2QqHMWprviX9cbmJTY+owlFGhOjdKUvhPNnxh70iHESR
         boEuv2RncViHuyUexWJcgzsFS3+vpG7k/QCqKCwfZ/6YKMgWoXoRhHt06EIJ7LnTA+y5
         N6VOI/f+wPfZIrivYncPOSPKjwMM5LGECg+H037hIjlwRWR06mIqngh4yCRKJR/A5uWp
         3UbA==
X-Gm-Message-State: AHQUAub7CeCpRbVwhC79Zo4O5gDA+bjs7AdHIu4MQRfRyREBjrmUt0gZ
        UMF9BAbrfcbatE0955IcLUYH6bz9
X-Google-Smtp-Source: AHgI3Ib48zeEI1RhGoWcBODxTQfC23HdTer3t+Pap+ZtDoh6i9w4y3jmXfc1R4JFp+VExQMm5uJlvA==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr3287702pla.276.1550830795648;
        Fri, 22 Feb 2019 02:19:55 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.158])
        by smtp.gmail.com with ESMTPSA id v15sm2835352pfa.75.2019.02.22.02.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 02:19:54 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Add pin configuration for read strobe for Odroid XU3/XU4 eMMC
Date:   Fri, 22 Feb 2019 10:19:48 +0000
Message-Id: <20190222101948.848-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Read Strobe RDQS pin configuration for eMMC to support higher data rate read/write.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 6 ++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index b82af7c89654..4fb3865e082a 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -206,6 +206,12 @@
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
+	sd0_rdqs: sd0-rdqs {
+		samsung,pins = "gpc0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
 	sd1_clk: sd1-clk {
 		samsung,pins = "gpc1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index b299e541cac0..d41397748ed2 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -411,7 +411,7 @@
 	samsung,dw-mshc-hs400-timing = <0 2>;
 	samsung,read-strobe-delay = <90>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_rdqs &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
-- 
2.20.1

