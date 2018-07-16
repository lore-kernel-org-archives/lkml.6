Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE0FECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DB72086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="csgJV/gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DB72086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbeGPVI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:08:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37139 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbeGPVIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:08:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so33193536wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O2pUjS4HBNO42FMv9IZ/gInmgO8sn3kKOK2ddG2zFxU=;
        b=csgJV/gT5DnpCiKckw2UUboVv3Eo8GZg7Ug3DrYfTQd7jiiYQPexuS8sf3XOBKajTT
         F1eZcvFcZEbacaZFj1FxKMk0rM9NttIr1Zx2DbVMc+9lneT5GjXWJX+WUt/fzSG7+5zW
         mnBt0v1ZtBLQ32w1LLv6JliHObW95KuDoBdr6Sq1zyh9ZK196a9wm+yqaY2GzBlpiv0u
         xT28pl6eDixHa4OC/oR86KYE4WoJ+XljO21VN/Te3M3Et9bm2q4XuuLjrd1eiFMkSvBf
         TNCFRCSHaFi6VePWukQO4Z4Tijvz+DRomQQH9FMsLe3GBVWc2KButagkoeYAIxVmdMmU
         vWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O2pUjS4HBNO42FMv9IZ/gInmgO8sn3kKOK2ddG2zFxU=;
        b=MXLfMiHAQLvSOXJKKbwv43fwg4ehRmM7oNW2pGBPlIWosBPRm7bEx/R7EK1BcVg9Ww
         8T3tnJ1ukXZgKGTGGWbHMHxUu3kWJCGuGuua628cVQ0ogxXq8NTxxn7mkUINOoK7zZiC
         xAv4QUJCo9cPFBRlMWjGpI/ETJ5MESavpHGe9tjICpRRDdxgBQq3PwfUckyiiKwjqY4F
         PR/J7MfaACvaIZkJmf03RaPNxcQ4LAS2JZzwAlovBl4kUIJEtfBs7LtyU7pk+YMwsCJU
         ff+M0tnHEN7AA0JuTjrIuVfDHnbZZcyxhpMFuB6lGcZanmfrd8tHyIKPqGOyYcfxsBOw
         usTw==
X-Gm-Message-State: AOUpUlESImz9rLGr+wGHniYKf/qjPsHEFfelc98GlTpeYs3bNBNl0Rrf
        U/10Wa0bNu4cgyJgWm2MO6fKrA==
X-Google-Smtp-Source: AAOMgpd6SZtqydo0TUrjmyDUHfbXbFc7UH92/TVVCcMzVEIeozKKQ3SSXkX+KCuqba4qu8ODbIN0ZA==
X-Received: by 2002:adf:a0f3:: with SMTP id n48-v6mr13791521wrn.23.1531773549607;
        Mon, 16 Jul 2018 13:39:09 -0700 (PDT)
Received: from bender.home (LFbn-MAR-1-570-38.w90-118.abo.wanadoo.fr. [90.118.15.38])
        by smtp.gmail.com with ESMTPSA id j43-v6sm53533686wrj.1.2018.07.16.13.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 13:39:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tony@atomide.com, daniel.lezcano@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com, drivshin@awxrd.com
Subject: [RFC PATCH 3/4] ARM: dts: dm816x: Add all fck timer clocks
Date:   Mon, 16 Jul 2018 22:39:01 +0200
Message-Id: <1531773542-15736-4-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing fck clock to all timer nodes of the DM816X dtsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 1edc2b4..0cc7f17 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -352,6 +352,8 @@
 			reg = <0x48042000 0x2000>;
 			interrupts = <69>;
 			ti,hwmods = "timer3";
+			clocks = <&timer3_fck>;
+			clock-names = "fck";
 		};
 
 		timer4: timer@48044000 {
@@ -359,6 +361,8 @@
 			reg = <0x48044000 0x2000>;
 			interrupts = <92>;
 			ti,hwmods = "timer4";
+			clocks = <&timer4_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -367,6 +371,8 @@
 			reg = <0x48046000 0x2000>;
 			interrupts = <93>;
 			ti,hwmods = "timer5";
+			clocks = <&timer5_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -375,6 +381,8 @@
 			reg = <0x48048000 0x2000>;
 			interrupts = <94>;
 			ti,hwmods = "timer6";
+			clocks = <&timer6_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -383,6 +391,8 @@
 			reg = <0x4804a000 0x2000>;
 			interrupts = <95>;
 			ti,hwmods = "timer7";
+			clocks = <&timer7_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
-- 
2.7.4

