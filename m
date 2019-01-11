Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7C4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7062620665
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ltbdWbyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbfAKRW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:22:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34848 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388837AbfAKRWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:22:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so16039808wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZCWTPLj1wbSsS1IA9/4GHyR1fEd02J/mQnVEGIGX0jg=;
        b=ltbdWbyDi0jBWv2fbbnv1XubGMt4cHhglnamBW9t0GJo1n1uv6QcU3yKXXjRILz478
         xndStFoLPYdJWGYWDzDnw33Ro+p/6OErGCtePhwLvb4PkESMpluH2f5Whrg/I/X/Q28L
         5a8d2/UjTc7qe3ec/kPkwnBWHklnZgKLm7nNCT16ZkXZEdOsSrIrhXHzdcZV9PHFeSms
         gB8bKxPJkRldTxu6LKo0rnDH7RZFrEF8kEKQm1n62ggdjeDMizcMVYNb+D5jTw6OLREi
         LwMe4sqEqQ/ylf36pIosNZP5A+rFBq6gkPimybEzRnArKVwQSRFBX03mgCkpimb0Moin
         yWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCWTPLj1wbSsS1IA9/4GHyR1fEd02J/mQnVEGIGX0jg=;
        b=kLwqO/9XsXehS5wj+auxtjf5bKk/l1Gze5O/6E3J93IXRpLSo66/Xp1d/HC8Syu3FU
         DsuiZr3dAHyuJUgKRInFIUYRayAvgE59mG0xKtogzZmvWWhVNmAfWUVaHtMQulwBZ8LS
         Hrhgj704PtB/7JD0+WSIQab9MdFemFlMG5rDx+GNRDdb0fmWthC8eVsKqE5qhocbjWJs
         JCLlWRmos7z1CysM1g/ctVsa75J619f5BheEFFgIfUNgzKXdxYibO4syo2A3NKn0jeNh
         wR7L6o6SYdyjPHRg/Kr8qIuglfwDkooAwMWTZL8lptGxrblKuGoflfflaDHsissaNb3l
         pYkg==
X-Gm-Message-State: AJcUukfbByusLm4tIL9la7xtHWIBTl8f4pqgHKRuxAwuKCaIMau5TFfp
        /ooxW6B0luvKiht50up9/nn/ig==
X-Google-Smtp-Source: ALg8bN4CbRi2RRXk862TNhcRJmqfRrGD5w/qHOZK8fNsp+aOcWTFAbyHJd6NmsUQGtkQLZJqaZv/8g==
X-Received: by 2002:adf:8b83:: with SMTP id o3mr14965839wra.81.1547227320100;
        Fri, 11 Jan 2019 09:22:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:21:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 08/17] ARM: davinci: dm644x: WARN() if clk_get() fails
Date:   Fri, 11 Jan 2019 18:21:25 +0100
Message-Id: <20190111172134.30147-9-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm644x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 38f92b7d413e..85d69ac1bd70 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -681,6 +681,7 @@ void __init dm644x_init_time(void)
 	dm644x_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
 	davinci_timer_init(clk);
 }
-- 
2.19.1

