Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D774C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FEE2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="e/66MXAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbfAKRV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:21:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41210 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732472AbfAKRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:21:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so15981559wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5wxOOtRPEpRp3NqPU5OWIWIo8d5meG2Q4lKl/MEhWw=;
        b=e/66MXALy0oMKyfIZxENV25RBdYLzmeemileG5eHJQ0Zxt6IKjyFNlw3rXW1wK8Mfd
         1YfMnZCl0lFm6Ihq1xIjSJv4r/YUb3sMrEEzapaIdkj948u1paqffsRNbAEz283z4zOy
         9aureX7GhHrONT0IOycm8jSwTtsXOptc6IsmI5qP6/PClxhQZQ75q2xb8FurIY3WOj7y
         aAizECrqwqWyG8+JC3bBaVVKnrfYvoMRKIfX2tuZxU2sgDbPeXkBrBfwpzMEo1lm6ZXU
         8MDAAwksDVH/vUAAa/khNm3Ya99SuyVow7iO4aDez2yXS/ccZg8zozY/k5Q/O3LkVThO
         6VJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5wxOOtRPEpRp3NqPU5OWIWIo8d5meG2Q4lKl/MEhWw=;
        b=SKVWNDY5zfU7CD7yNxU1cT3aBxoWJnI/M+G1sNuWLgLFOpVtNn4lNzwanlAlgi4+AK
         cz/N1I+5XHW7i6QZT2xtFUHZWk79vaXKfwvOCJfHuFtCdSN4Pb+hO4SVj8JlzoNJ6X/q
         kyL1y1mtkhtrRM6Ue70vaC+GQYQls4KMbCLA0lkojXRdJPYSAT4n5KAVtGXF/j0KFbvN
         f9FyGUvkt4JyATUnI3KHYntHay/3qAszCOR79/NPxjTk2RZtBPCRVOIacpjHHNIZ/MQ7
         RRYAPp3zGb2TkcLNiQC5MHV1BPKSDkymYuu6zAnva2RcS5Ich/redUAkr4fVQHZztdNf
         0WJQ==
X-Gm-Message-State: AJcUukf14VSBmulfKcm79R50oGrAFf4SrrsDEXyvQ4T+yHCaXtjs7hMd
        HGQ35U2zn9P1V4ah2MqwJGDimQ==
X-Google-Smtp-Source: ALg8bN6JrlHaHd9Kb9BKNe9ETCtms1Agm9rsGJqbpV4tR6ep3omWM3gClOtHRI3AhBHB/q/nB+jMrg==
X-Received: by 2002:adf:f052:: with SMTP id t18mr15116950wro.112.1547227311159;
        Fri, 11 Jan 2019 09:21:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:21:50 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 01/17] ARM: dts: da850: fix interrupt numbers for clocksource
Date:   Fri, 11 Jan 2019 18:21:18 +0100
Message-Id: <20190111172134.30147-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The timer interrupts specified in commit 3652e2741f42 ("ARM: dts:
da850: Add clocks") are wrong but since the current timer code
hard-codes them, the bug was never spotted.

This patch must go into stable since, once we introduce a proper
clocksource driver, devices with buggy device tree will stop booting.

Fixes: 3652e2741f42 ("ARM: dts: da850: Add clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 47aa53ba6b92..559659b399d0 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -476,7 +476,7 @@
 		clocksource: timer@20000 {
 			compatible = "ti,da830-timer";
 			reg = <0x20000 0x1000>;
-			interrupts = <12>, <13>;
+			interrupts = <21>, <22>;
 			interrupt-names = "tint12", "tint34";
 			clocks = <&pll0_auxclk>;
 		};
-- 
2.19.1

