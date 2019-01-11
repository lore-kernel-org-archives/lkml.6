Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC3EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B08D20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hffmTclC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfAKRWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:22:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35173 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388749AbfAKRV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:21:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so3141157wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5eYRdbvgDdHfOnobAkn0se7ULIb/ZfwVvRXf2x91rcw=;
        b=hffmTclC/x8u+Wt1kuG5Wxtfm6YyV5cO0iMi6wL530U8HsPEkq2jYoL7b3WqwuOtNk
         pJF5S8qKGlpdEiHaJ6/glLMHv8dolGRBCLqxQJ3yVqNv/Ex5EoizPFGgj5hQW+1Yw6bq
         1GOhkPHEfRACFJPJW6ygjfLI4qbsk8oq2GEZAPaWsl3cf052aQmnKrumxiuYvhERp7da
         GlYrESykyYFVlln/BA59FG4HQ9QLn6gC/D7ys4XosCrFf/9ssPJrd3QnjiRL79QOCP0e
         hs0S7kStYDI9SNs9BQC96nLGd3yR163GIsUaDGoJlmEIq8crLDiBKuEnZ62PmuCHqTNC
         l4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5eYRdbvgDdHfOnobAkn0se7ULIb/ZfwVvRXf2x91rcw=;
        b=KDOZzi38XpZQz8FgpdU13v7hp2xK4c213ZyLNF/JUWXYCGZkIB67a6LJevbLditMwf
         DbLozeYtHVIyiaKwaUm7K5BU2/PGEf5bzVU++7eVfTojDWtMkfY1BDokEnUn623uiiS1
         1tTKetnbFxiB8/eSoLRMTW93RjjghvWuHwPPMDvsVV0OoA7x9Pm62K7nmVTXnnxy/mQz
         kP0fMJ941X7dLTthIcqR5Q6Zc3iBGBl6J5iKvd1TjjA7uBTYWuC2avDQedWs4IxJQoZ6
         NHdFkuKKk82/DWlFLYjb7AROKPRj9PARaGpvcbBR4UfaS+XW/nxzz0IhsOLCsp6vl4Vq
         q6XQ==
X-Gm-Message-State: AJcUukeGdC66yDNFSX19D1tfWAOjc735A7lZ6CzduAnzCZWKNkVDz94y
        zRqLmoWyDBhfF2iXesPbVVoy+g==
X-Google-Smtp-Source: ALg8bN6/vlQROYcPFMxZim6E1/hYDMGefiK5Z6JM9KdqjaHc9jDYPjMkBD3PcbjuASZry8S9lXjO1g==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr3257815wma.114.1547227316209;
        Fri, 11 Jan 2019 09:21:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:21:55 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/17] ARM: davinci: da830: WARN() if clk_get() fails
Date:   Fri, 11 Jan 2019 18:21:22 +0100
Message-Id: <20190111172134.30147-6-brgl@bgdev.pl>
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

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 2cc9fe4c3a91..ceb0417f10f6 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -834,6 +834,7 @@ void __init da830_init_time(void)
 	da830_pll_init(NULL, pll, NULL);
 
 	clk = clk_get(NULL, "timer0");
+	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
 	davinci_timer_init(clk);
 }
-- 
2.19.1

