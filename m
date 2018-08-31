Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3251C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5373D2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BFCccr+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5373D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeHaTKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:10:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38758 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbeHaTKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:10:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so11512929wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rTKTL3h8CLAcV690tHQAj0sNlkjrhHX0Jxmm+mtIbgI=;
        b=BFCccr+WlPAoSaPNQ/a3MetRnGCW5ZlAqlcsJPiHv49cUDSqHMXazuAbJbYWFWEEbX
         WlQkb7his3CJPORmgpwJ0Zf0gNr/uLL/J49Jx6GjPgKIVmCtsGXw1mpmsWfOQMroi+Zh
         CHsmqFRhvbzDn891J1DOm3P3hCDffaCjjZ3gVjbBe1Awv0IKw5a+we8uiY9FQjpBv4Dc
         Az7V/jyEuWeh0vZTS8CNaBUKGZ5JYUCZc7yl813TopyWQzmXYg0ipqEywY4HiRjlYRiZ
         oo8gFt3rmTmEkzWOs2noWoC/700pPprQXLRkReKc6NCrY3g6bczjOFgGYDgS6HRARL2+
         TWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rTKTL3h8CLAcV690tHQAj0sNlkjrhHX0Jxmm+mtIbgI=;
        b=nDwyAy9vtDJwKZ2AzsMja10mQwja05jER68s1wCB3LFPiwTf/pXtvE1R6FwmoeG63D
         DbJeMzuqi2Y3YMe8n4A08mGQlkh993LbgK3KL9BuyMHEfLdsjWadut7deqMOQgbUk+Xh
         t0fPlN/CSaXDXP+pIGv766/abJhe30/0ruqBDFHN4E+fuU0oIVVrn5Qfw+IIsvbQ9KBa
         2FJDJ1+OnxjQmIdKGXGM8zjpsqR6aVhJ+KbD51tir2NyJ/SuEFKC9A5s2O/Et1t5T6jW
         imK876+qkEb0DpiDAx95gqzJOeloAojwGiRn1EB3iL+Pwgf91H4JJQ5accmQZj8vOXaZ
         fu4A==
X-Gm-Message-State: APzg51A1CENGpfwBcpdD5cakL+g5866E9he+m7f0D+vkXUcRhVvVihDs
        GJSLBW3OB8aqVsJc806LhTSmegzLPWo=
X-Google-Smtp-Source: ANB0VdZzaPbeW9P8oJkvEiOd33crIAd5+c8v3rtWH0NEAIppgnIk8PHHSJFboGvslpcP/VlJ3nzxMQ==
X-Received: by 2002:a5d:5383:: with SMTP id d3-v6mr11287520wrv.191.1535727744966;
        Fri, 31 Aug 2018 08:02:24 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 184-v6sm8759797wmv.6.2018.08.31.08.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:02:24 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] arm64: dts: meson-axg: add pdm
Date:   Fri, 31 Aug 2018 17:02:16 +0200
Message-Id: <20180831150218.8307-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831150218.8307-1-jbrunet@baylibre.com>
References: <20180831150218.8307-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PDM device of the axg audio subsystem

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 36be63d69e7f..883ddfce2374 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -152,6 +152,18 @@
 			status = "disabled";
 		};
 
+		pdm: audio-controller@ff632000 {
+			compatible = "amlogic,axg-pdm";
+			reg = <0x0 0xff632000 0x0 0x34>;
+			#sound-dai-cells = <0>;
+			sound-name-prefix = "PDM";
+			clocks = <&clkc_audio AUD_CLKID_PDM>,
+				 <&clkc_audio AUD_CLKID_PDM_DCLK>,
+				 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
+			clock-names = "pclk", "dclk", "sysclk";
+			status = "disabled";
+		};
+
 		periphs: bus@ff634000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xff634000 0x0 0x2000>;
-- 
2.17.1

