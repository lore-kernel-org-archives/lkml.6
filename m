Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923DCC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A70020989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lFLzIG/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A70020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbeK3EBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:01:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44836 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbeK3EBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:01:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so2604388wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRZsXfVX9KBSlXVwQ78mHqYkQJoNSqDjXJ+icKBQYMg=;
        b=lFLzIG/UAwDukMZJ6lcx1pApLjGL45NvKXfJEL+qr6AnUMaVKNqJj73S0drx2VZgYM
         BAEhp6KAVU18elkPWc3ulBOCmYDLh1/W7GZVtj8DNrFPpJxDqNZGY9s75cBz5kleIUWE
         CiSg06sscFiGuPzVNlIH1Y56DotnSzPxEcMrksR4Pm927KenY+PWAAugHDCETaGsfTE3
         /L3ebf7w4Y4T9/elFazC15ZkuPzgclKoVIssfThBaQxjURsb9C6uFuJq6MqUaAz89Ffa
         UC9vJJO9OcEDDYTILsXx8yaF/9lqgmgaKKQ6MzOjwT2fcg1bnUyES+xTt8VeSqC582Xb
         132Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRZsXfVX9KBSlXVwQ78mHqYkQJoNSqDjXJ+icKBQYMg=;
        b=TIMgamwRQ/HiHocnSq+/MTz3Pb7Qr2AnGgiZSkMS2CHwvfthvwkZAAMRsa/qS72Qbj
         CB/fQhKg4O3Pux/2D3AckuAYbS+q4iMXmiCYY2RMcGz6mYnC8dgtgVk6F3WkhDK+u0lb
         O+x2a1tGuo7/7aHWu8utlQV75+gpDK8H17B3RT8gQ2XDiOcYyS2IS4yL9y7MICHR11AL
         r/wI6fWwIS01DkA6n/jHFNZGRdNAbhYAxAmCJZJRt19EMwUSY25W+eI7nfU8h9e+QWaj
         UcRapHKRXASQECwARuAIMp0qvc4+zxR/N+uzj7idLN00TU74IpQCYW6/ugl1J4vm68uL
         kRMA==
X-Gm-Message-State: AA+aEWYhktKJp6uRDzYqP8zd6e/Zt6VOW8d4G6HAG2wb1ygoeICGMQNh
        6e85akL7y2EPHRTt61fxPYHsBg==
X-Google-Smtp-Source: AFSGD/VWWBNnolANuHU1TkCcJKgMN+NieajRhNqJBYqopmOA3JcgJlUQXLOlkZ84csmE21jagMaf8Q==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr2022047wrr.74.1543510501467;
        Thu, 29 Nov 2018 08:55:01 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h131sm4203676wmd.17.2018.11.29.08.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:55:00 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-axg: remove alternate xtal
Date:   Thu, 29 Nov 2018 17:54:51 +0100
Message-Id: <20181129165451.21446-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is actually no alternate xtal on any of the axg board I have
seen so far. The 32k is actually generated internally, deriving from
the 24MHz main xtal.

Amlogic SoC also have the option to provide the 32k reference externally,
through one of the AO pads, but no platform is using this ATM.

Fixes: 5e395e146667 ("ARM64: dts: meson-axg: add an 32K alt aoclk")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index f2e9fbfff4ea..63adf54b00c5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -53,13 +53,6 @@
 		status = "disabled";
 	};
 
-	ao_alt_xtal: ao_alt_xtal-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <32000000>;
-		clock-output-names = "ao_alt_xtal";
-		#clock-cells = <0>;
-	};
-
 	arm-pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.19.1

