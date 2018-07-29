Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711BCC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2046620882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVqi21sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2046620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeG2VdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:33:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51544 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbeG2VdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:33:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so10844609wma.1;
        Sun, 29 Jul 2018 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KvkLiju2xn1xOVtC/S2dKkUhVY4gBNsDlkCwG0IPKBc=;
        b=mVqi21shx0ekmCzJL3uKjI4Z+PvvOpS+5KPTx5DgNQvmebGqNtOkvToSS4PVI2/kLb
         xa5Af6YOAwh25sy/BPqdunwjpWvnZtExiu04ymqwZSKQ5ot+Uo2TPuxlozVr3TVncHAl
         q+Ftw3bQHH0l3oM0PXlF5Ejll13XNiGMbwdP/6mDI/VAidO9MhBzQgO8n1TeiBXgKhQN
         pDcbGgV3qITmYshgfiMX8nWVdRHoq65+7ghpBSNuxqHGOBoTc8CxBU8AYcR5ij5igCPb
         R5Y2ls01Otr/TIJdigEHe8M936+etalH5TspTyVDnkD5nBY5zQv38dFla0IhBEkZ7wPc
         saRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KvkLiju2xn1xOVtC/S2dKkUhVY4gBNsDlkCwG0IPKBc=;
        b=DkFmwwdqMwEWF0eBeKxvwU+k5UaOZqHKnDqqX4XX72GpLBPOajaDz1wD9HDBRz7qqG
         gxSnpp1XQJ01+0TMLkXcq6GWZ4KEccmJ+6uT+ckmmy3swj9Yk2qbFBHcLflEvYht18Wp
         O1Q60lVSBOKguqmbTnDj1uoyhc2VoJNLiZToTEWhzGQEGQ4ZAJuqV7qt0M6yMJiYq0Ik
         DT1gB7tOis60pTP6a0vnN/6kWGmE4stBNK8A/hPngdJF5cTUEiEeAaTUGiU8d04qR3nI
         8ZnhfLid6Zp+Ekf4dhQ7y7xq0O+jaSW/GA8xbBbMPWaiqKVLWFjW4WbE257/5tITkt4N
         cl0Q==
X-Gm-Message-State: AOUpUlEM1+Bjw1IvkM3ESbpDc1TVrIlaVlRDsefLH3ap9maZ4dO3SxmT
        ofwwjEYNjsR6FbDBxKLcQuA=
X-Google-Smtp-Source: AAOMgpeRE2/i/mpFyAzvXmdiERVq8t4CNzRXQTU59es7Yt05XlrfnZmlKJCA/EQ0mdJn/C1QB+Gf8Q==
X-Received: by 2002:a1c:1d58:: with SMTP id d85-v6mr13230026wmd.140.1532894481991;
        Sun, 29 Jul 2018 13:01:21 -0700 (PDT)
Received: from localhost.localdomain (p5DCFE1FB.dip0.t-ipconnect.de. [93.207.225.251])
        by smtp.gmail.com with ESMTPSA id g15-v6sm12334213wrh.48.2018.07.29.13.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 13:01:21 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 5/5] arm64: dts: actions: Add pinctrl node for Actions Semi S700
Date:   Sun, 29 Jul 2018 22:00:38 +0200
Message-Id: <20180729200038.11795-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729200038.11795-1-sravanhome@gmail.com>
References: <20180729182551.19383-1-sravanhome@gmail.com>
 <20180729200038.11795-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl nodes for Actions Semi S700 SoC

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 66dd5309f0a2..8fbd7b1570a7 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -165,5 +165,21 @@
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "timer1";
 		};
+
+		pinctrl: pinctrl@e01b0000 {
+			compatible = "actions,s700-pinctrl";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			clocks = <&cmu CLK_GPIO>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 136>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.18.0

