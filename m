Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595E1C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A65A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsjVkACW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfAUHjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:39:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44305 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfAUHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:39:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so9384786plt.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WoGfmBXbkp22eB752R6+rnQEzLObCNo8qMMo8guRvqY=;
        b=DsjVkACWlqglSNGhM3nJdcZLu4R32jh+mLpC+C0R8ZR2N8fnNBvR0EfJ1B5kSLvCEc
         9GJ6T6u0AmmNjTpYIo1ypZtvKSnigJjdVVwpSLIjNnGqHFUjL/PyHAWW7NcqDIFaH5XH
         SoioOQbIvDHzqYpVTvIJACl9xl/c6lIO4SJLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WoGfmBXbkp22eB752R6+rnQEzLObCNo8qMMo8guRvqY=;
        b=XIwU5btIwuJ0IhjK5Tf97ujRCVfKmLFpfrDChsKOpP7PbUw2xOKJazhCaJ84YBmqRz
         cB2mFw9HDGDgV9Gctsm2t33E6BgPE5L1QyRd5wvTweJlfirMUXSjh+1OQrnp5CGgcpBE
         K9PHmzdZjN9meTd3mJOzQ9UIHkQ5B78DyXCgk84PO8DrOCDufpKLVO5AoVDAh5wEMmRQ
         V0ifSrOWLPFUBiSfH30XB8ir92NeTPAiqe8FH+XqkM2OY/PjopmtgfWhiVojgcPVsoKG
         mPUKJbxpyRtmkzwb30opR9lTXeNHeyeN0ZVCk6H3gNE/LDqIxAxJdIdcNLCyRGcMLg35
         34Pg==
X-Gm-Message-State: AJcUukeq9pgq2sHBHHCED1mJ2nUN90VS7d5EYSH89rAA2Wzqz62/Yzqg
        LfVexoN6Cba7TtqW4aIrRe+1ZJVABJZjNw==
X-Google-Smtp-Source: ALg8bN5phe2gfmZHmrs7HD1M36IyUe38XNvyBx/Zbaen/C/WOb2DfwXvV2jTQT8QrlNCFvhT0I2S1Q==
X-Received: by 2002:a17:902:2ec1:: with SMTP id r59mr29453151plb.254.1548056378468;
        Sun, 20 Jan 2019 23:39:38 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h19sm15583083pfn.114.2019.01.20.23.39.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Jan 2019 23:39:37 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        olof@lixom.net, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 3/4] arm64: dts: sprd: Add SC2731 charger device
Date:   Mon, 21 Jan 2019 15:38:30 +0800
Message-Id: <1f57f120e915ea9af75a45f48c8ef2f446d10486.1548052878.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add charger device node and related battery node for SC2731 PMIC.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi      |    6 ++++++
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |   16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index a2edc25..b52eaf0 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -17,6 +17,12 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		charger@0 {
+			compatible = "sprd,sc27xx-charger", "sprd,sc2731-charger";
+			reg = <0x0>;
+			monitored-battery = <&bat>;
+		};
+
 		led-controller@200 {
 			compatible = "sprd,sc27xx-bltc", "sprd,sc2731-bltc";
 			reg = <0x200>;
diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 3bd18e3..2a963bd 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -41,6 +41,22 @@
 		#size-cells = <2>;
 		ranges;
 	};
+
+	bat: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <1900000>;
+		charge-term-current-microamp = <120000>;
+		constant_charge_voltage_max_microvolt = <4350000>;
+		internal-resistance-micro-ohms = <250000>;
+		ocv-capacity-celsius = <20>;
+		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,
+			<4022000 85>, <3983000 80>, <3949000 75>,
+			<3917000 70>, <3889000 65>, <3864000 60>,
+			<3835000 55>, <3805000 50>, <3787000 45>,
+			<3777000 40>, <3773000 35>, <3770000 30>,
+			<3765000 25>, <3752000 20>, <3724000 15>,
+			<3680000 10>, <3605000 5>, <3400000 0>;
+	};
 };
 
 &uart0 {
-- 
1.7.9.5

