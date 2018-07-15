Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AF2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B526B20844
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9qlmUWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B526B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeGOU03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:26:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34277 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbeGOU0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:26:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id s13-v6so8405589wmc.1;
        Sun, 15 Jul 2018 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y56U9Qy5luv40h9ja9fLysGeD/BwAI8wDVI6U0Xt3oU=;
        b=b9qlmUWTclqi34v4DWGac1QsNqJ8gN+Tdl1qXaKc5ECjJPyXCIU932R2JMM9Y7SX46
         DKNUr6OgAn4jf8ArobQH3WeRT6hFCSDvdGtl4WvTZ/xwbhK5Wq0oOyd8CFDpe/cGRnwv
         B9HiF189f4en+sHxmuVPqt84onazC4JcDH/m7ZblQNCFGFchSuf077XCj6uDQPoId3b9
         mypvWPJ1gLk6S1liRpx1d0hY8jdMNbe/LIbJuY1AbHMdel4mEb3ODAxh4HtKzDxNe0gs
         kEW3K/Xt0ktsrezTwGDOXIoOyQz8ABf0EPe0RSROOYxcg7Mo9TMSPSamnbAEPnu2OGaj
         BJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y56U9Qy5luv40h9ja9fLysGeD/BwAI8wDVI6U0Xt3oU=;
        b=bE57alR9C/wQDQRRw2Ro4MifR5gGewBJ+E0uhxCcqJr7BjjzJp0ONNEHfphqMHDQKK
         Id/SgzPwKfIXlk+yMn5FeNhDC/JlDC34T6u274VfbdtnAuC68ixv4ZkBQw5grDDUrbgU
         lngO5+jmt34bi/LDrVTVsdXHNEN6JOkfGtdq5uVhGP/BEAtICYRLgpBS3y810PnC4NNQ
         fZGgwHc7nQ9Yly+y6V8+ACwPGzYruAOx9jkeMqDc/GZ4nShD5Wu6icJ39NZJAPMKzkuJ
         dlneAfX1qMku4QQoe09zP3dk9+w9dvKErPv66sHUOQV4WE5ElSTwpshep/d41IydQAwn
         iJMQ==
X-Gm-Message-State: AOUpUlF60AQbt3NGgh+lSUJ/af/cem4z6At+qTqlfjrHH5AodFa3948F
        VJeyAPmZuQCEDaJbYTv0aTw=
X-Google-Smtp-Source: AAOMgpewGKoR/oph89oN3bfejlgOd3T5yFqx/D9iH6OHbcXsSWp1jbA6fWYeejEu8HCce8VTZwCVdg==
X-Received: by 2002:a1c:369c:: with SMTP id y28-v6mr7808434wmh.34.1531684940339;
        Sun, 15 Jul 2018 13:02:20 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id z7-v6sm20816234wrh.85.2018.07.15.13.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:02:19 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: [PATCH v5 5/5] arm64: dts: actions: Set UART clock reference from CMU
Date:   Sun, 15 Jul 2018 22:01:51 +0200
Message-Id: <20180715200151.10416-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715200151.10416-1-sravanhome@gmail.com>
References: <20180715200151.10416-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
index ef79d7905f44..c08808ca3346 100644
--- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
+++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
@@ -28,12 +28,6 @@
 		device_type = "memory";
 		reg = <0x1 0xe0000000 0x0 0x0>;
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -42,5 +36,5 @@
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
+	clocks = <&cmu CLK_UART3>;
 };
-- 
2.18.0

