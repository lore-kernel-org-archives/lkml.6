Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9694ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7019C2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EVLOQZ03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7019C2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeKHXaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:30:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38217 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeKHX3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:29:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so21343672wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6wN89PoGt3bKaR1gaIBVeliRc8f7Zk35/q79yr4xdc=;
        b=EVLOQZ03k5jca71fOCeEafYR13Fz/ywvjnKqpE/iRuuvehi/s1Avjl6xn/r/ixuGYg
         JMpX9/4c6EXXB0Ke519yhje6f60hzvbfGhfOXjBwN55/6MOmNtm/ipeqxyi1bF1kQxmr
         UyAs4yeierU8TQXwJ+eCEeTI7L3Xh5tl4QnJC9Q28pEQ0ZlAH2piq3Pe86DpNjQmIySa
         BRiJSJVnyX/jDOOEfJOorUWxySlXwcRdUGh0JXCZm4+ORcFq5OTqn4wEyW4quMYOgoVc
         Isuob/KyUzlShijPn2wVv2uoZ76UIkqBIFX9z2mrHfSBNYhumpxBHwFqx3Q5ympuhX5W
         CS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6wN89PoGt3bKaR1gaIBVeliRc8f7Zk35/q79yr4xdc=;
        b=kocW0qJSDl5Vf279CFGX5zUcab0554ErFx6UNL522eeOsyhVasnFlvnhIlU369NQJb
         9ILK+ftfIwxAaTwdrepJbMyZYDgwv41iA7hQje/9wDjgkI2vcetele//chRm2MF2ItIJ
         7JGw09FVJHXSaqsMYXjRJuI2NOOFaN+72k/PFf1C9YfLbUgc9TNX8v334cb90V9vU81Q
         7ZDpRv8Gs6LDvmnXeazYjwgzkcqdAAP8HUYX1AQXJUIuF24Bm3GBGLPgEedr4iR4Ztbt
         eBUoYVWAi3Bd7PeRuRpjjx2CBK2MnTkvw2x0Q5b6wlS5LaRR56r8tctHkYAjmAyBtB8s
         13AQ==
X-Gm-Message-State: AGRZ1gJLENnuVyqDeET9v0qhIURFHq943yGyDLMQWPSuPAiDpETn5/H8
        eCvNdRLD7D9i5E1sg8dB9YIplg==
X-Google-Smtp-Source: AJdET5fHuLcNr+6JQ1+U6U1lkyAKgXs9U989wCaDAnTcT/skHgYnlzWgX4g6zUkwEVbvanGCucajOg==
X-Received: by 2002:adf:a409:: with SMTP id d9-v6mr4288460wra.190.1541685241601;
        Thu, 08 Nov 2018 05:54:01 -0800 (PST)
Received: from boomer.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p6sm2740329wrx.39.2018.11.08.05.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 05:54:01 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] arm64: dts: meson-axg: correct sram shared mem unit-address
Date:   Thu,  8 Nov 2018 14:53:50 +0100
Message-Id: <20181108135352.8459-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108135352.8459-1-jbrunet@baylibre.com>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the unit-address in the node name of the SRAM shared memory

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index ff8b3406aff6..b8893675e39c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1659,12 +1659,12 @@
 			#size-cells = <1>;
 			ranges = <0 0x0 0xfffc0000 0x20000>;
 
-			cpu_scp_lpri: scp-shmem@0 {
+			cpu_scp_lpri: scp-shmem@13000 {
 				compatible = "amlogic,meson-axg-scp-shmem";
 				reg = <0x13000 0x400>;
 			};
 
-			cpu_scp_hpri: scp-shmem@200 {
+			cpu_scp_hpri: scp-shmem@13400 {
 				compatible = "amlogic,meson-axg-scp-shmem";
 				reg = <0x13400 0x400>;
 			};
-- 
2.19.1

