Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C411C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343D82086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0zhyZrs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343D82086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbeKGUQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:16:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33571 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeKGUPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:15:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id u9-v6so6508947wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TtiQgLxeB3Vvn/F2D6s5fJLLQl7t/5akjyB6egj8ywA=;
        b=0zhyZrs1I3b3f94v43giJ2+xKNtpj+u2i222TmZvKBZx4aozIM+K/TtJpf4qQp1923
         ue+riMpQtEfF/we1Jbyyujh7eic8rEfHuH8/tO23R11rl2+4gEmTCuf0IrzIh6u2M6FX
         QhRrSWdrE/NN8K3dqGYniVltQGAuxSwTsA41Q8b9VxHdW8a7PJOmCuP+mvE7dZHLIHI1
         qQ+8dEEVxHT9SwaJJesig8VAQJTcnWtI1ps2t/wqOZ9P/JriHWYFdHu76btBvHTPTYRk
         iDKtJRdQOzXwqYLbaqsSMcIT0tT0dUHe5tmcyc4HKokqBswfdCMB4ZqJEev7WKOXQLlN
         hFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TtiQgLxeB3Vvn/F2D6s5fJLLQl7t/5akjyB6egj8ywA=;
        b=OtJZ1XBAvXzCv3wC1MN+IXQnJXDPv5PSWCrVf6BL9Bj24hStKpJOARjlG28iNV/9uK
         dffKtYKXCpf1bCXf8PqvgQ7Q/xBOvzFX84agQaohoeeUiRDkpw9IHOQGWzyUeKXzBQCO
         FZnnSwZ2oXzADLOwaLvMYk8vp7/4DgFsXnvwXkYUrooC8QxI3nKTwJ0ZiqzABmUmVlvN
         cIwy9gpxJw+sSF+4ptN+ehmd9t7vk28C7eKxATjSVjtsa2zRdjqGc6YRRZmJ/un09yhz
         nfa3U58oxZOjWobhmdIOQlVBScMvQwkFJ7rpiZVPzDUr2VCkPNhlYSgf5+wFh22/W8Cz
         9+Pg==
X-Gm-Message-State: AGRZ1gLwCko0Y0+cjmhzZzlBLl/BYiyiqEliF6pNqkQdy/AQMKitRqCU
        kgesb7L0DfGnbGIgw4asWnox+g==
X-Google-Smtp-Source: AJdET5eWHJ7knPhvjHNh3UKLjisXjHbWEAIrvKWOLYMndyy0oF+BEyD9Luy9btlXwSU3dpxlwRhjsw==
X-Received: by 2002:a5d:4012:: with SMTP id n18-v6mr1321656wrp.185.1541587555294;
        Wed, 07 Nov 2018 02:45:55 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h125-v6sm314484wmf.48.2018.11.07.02.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 02:45:54 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: meson-gxbb-odroidc2: fix GPIO lines names
Date:   Wed,  7 Nov 2018 11:45:49 +0100
Message-Id: <1541587550-17842-4-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
References: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio line names were set in the pinctrl node instead of the gpio node,
at the time it was merged, it worked, but was obviously wrong.
This patch moves the properties to the gpio nodes.

Fixes: b03c7d6438bb ("ARM64: dts: meson-gxbb-odroidc2: Add GPIO lines names")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 54954b3..00f7be6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -187,7 +187,7 @@
 	pinctrl-names = "default";
 };
 
-&pinctrl_aobus {
+&gpio_ao {
 	gpio-line-names = "UART TX", "UART RX", "VCCK En", "TF 3V3/1V8 En",
 			  "USB HUB nRESET", "USB OTG Power En",
 			  "J7 Header Pin2", "IR In", "J7 Header Pin4",
@@ -197,7 +197,7 @@
 			  "";
 };
 
-&pinctrl_periphs {
+&gpio {
 	gpio-line-names = /* Bank GPIOZ */
 			  "Eth MDIO", "Eth MDC", "Eth RGMII RX Clk",
 			  "Eth RX DV", "Eth RX D0", "Eth RX D1", "Eth RX D2",
-- 
2.7.4

