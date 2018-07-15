Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6296ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EEC20870
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaKTBWzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EEC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeGOMyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 08:54:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44740 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeGOMyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 08:54:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so29207143wrt.11;
        Sun, 15 Jul 2018 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=abDJQ6owpwoujitNLOqWSS193V5K8f5lBLMm4tSQJak=;
        b=MaKTBWzvoD/QpNSmzOWQE58BdPpyLCXwLB5+1IuSfkl4b20mS2F/39QbYcUa0ckPeI
         q3JyGWnQB+YrkdsmIcB9nUDeATePIItOfSm/AuFanwaBQacl9bzsYJ4f99d74ybVdoyS
         gP76Q4fkURNiYDoZSLgdlkYvbLNfSsh48Min0qqsGjMCFj2tiX9g9UxOy1kUVGopPcwb
         kpMbFtZZnjq9U6Q+LhnfKGt0lc9tXb3OZPMsBUG+1rIbuA4ZT8kuEWfBUFC1urrhk/JU
         p1YrJcDRhGbMclyFOFagJuBqV0VXfm2qrbjGkvmVvE6uTIN55aI0mp8/5Zy63jxGX3/I
         02ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=abDJQ6owpwoujitNLOqWSS193V5K8f5lBLMm4tSQJak=;
        b=I1uyVI18MlrQiytJJackrsrEZmKGp3knk+dbgPty9YlEgc7qH1faMaRjsqF3KN92Sy
         jScKAEv6pWE9HRVeD4IcqP0zIzr+lu/FgzeQ5uHP8UPp3cWZTxjqs+KE777XIuBmQnXA
         +C7aF28crUHzhtVPgUJpW0ApZh/mX3KcyzhEMElpNiihx1RUJ1wPsPhrFqpm39C8VxWi
         41GY/vc7St7RXkoZ0Z9Hne0vCiFJdiff6RffiSofmUsKhCDnz4VK0AxNsO616yTBRHr+
         2gZGrGxbDdZrRdrqZ+b1o0xO0qjslPXgVaalARL5POhC33LK3FYK7+xLqpdry1pqpmz9
         Ew2g==
X-Gm-Message-State: AOUpUlElSX/q0Simlf3Ue6M1EAoaS3lDpDTkoBOd2oKJ/8RaxrhxCKIm
        XCiFfXuxX9MOeT0JRJOSy5o=
X-Google-Smtp-Source: AAOMgpfB/lKuaDX+VSAZFPWPnzJy5dPKErHGe1F44CVfEsXmSNI0at2t/Ufmfx97/RORnhO2sHX0dg==
X-Received: by 2002:adf:81a3:: with SMTP id 32-v6mr10298223wra.9.1531657916195;
        Sun, 15 Jul 2018 05:31:56 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id s10-v6sm16358688wmb.12.2018.07.15.05.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 05:31:55 -0700 (PDT)
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
Subject: [PATCH v4 5/5] arm64: dts: actions: Set UART clock reference from CMU
Date:   Sun, 15 Jul 2018 14:31:45 +0200
Message-Id: <20180715123145.16975-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715123145.16975-1-sravanhome@gmail.com>
References: <20180715123145.16975-1-sravanhome@gmail.com>
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
index ef79d7905f44..388a5d8bb48d 100644
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
+	clocks = <&clock CLK_UART3>;
 };
-- 
2.18.0

