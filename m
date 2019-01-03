Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A57CC43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDB82070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JTyFMNoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbfACPLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:11:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37714 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbfACPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:11:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so33844401wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 07:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKwFZaBRHlpAL4NyBpL6IVUugaHSo3atuqW4V0FtM2c=;
        b=JTyFMNohkRlhdNgkXpADXeirbaPnQ729Jz0hDZ/7YCNMvsABHAYzTtAd2g5wWkjRqT
         /w9xMWbUpUqm/ANQgvMzDHeMuavasT34FIyT14K9Q1aOF2VjuvnrIVf9CQbuF17hnVog
         bwG3ZdYN82yFoDsDzXASuTkEm9tQrRpnklq9iKQsjjCy8uKqc/piiJ1g6GpN/n95m0EB
         Z8C8fMNWMR1wlaSXo3ipHwdiPlSGxFJiyUO89ODEopAGs0QenoLpnWhgXc+euGYmhMps
         9lgnvFv6J9poBsH1pmUnz3PhkPx3Z0zHYTH/XLbzhLW6TmFh6oZaWIU5O2feNIX1zC2+
         wA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKwFZaBRHlpAL4NyBpL6IVUugaHSo3atuqW4V0FtM2c=;
        b=FwETEE8konC04MGN4pAaPVj3GU9Ql5VKyRVSo9OEMeNaFwk4Nzstj8cFcHS0gYfyB0
         LRxwnBcn0Zo6LHRkM7oQShTPoM2B5pqXg4kZNhajCSmTWE/gav/5Lp1FaduBofptITgg
         T83jO8tLiN3ZfRwAxovx6lZF6HKKAAonIEp3x1/Tv4K72MpoLKBwwfl/KamulJzue/w4
         ADA5ZbuYFIjGEzqhU+blOE1w8nn62PfO7eJa10JFhyXai+hlstwkjc5yamV9ntAzy2HU
         GpyFK6kXdOeefflt69notYnznT++Bccn3UYj3/DHQsnGMh953H8p+Kl7n63FBA53hwFw
         z9lw==
X-Gm-Message-State: AJcUukd46oeVW2eQEIanjq8zIEFkv5/pxEHHsofFGkzeV8Ro0CiUCc95
        TKa4EPwe5nhqPQAT9Uolgpiq9Q==
X-Google-Smtp-Source: ALg8bN4M1S0x3YPo2ENcFhdQ5C7fw+iK8m8C3oprqYtVIG+y4ru2b2rIvveCLlkQRb3Kky0/rx7J0Q==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr43619386wrm.239.1546528276956;
        Thu, 03 Jan 2019 07:11:16 -0800 (PST)
Received: from debian-brgl.baylibre.local (astlambert-681-1-88-79.w90-86.abo.wanadoo.fr. [90.86.3.79])
        by smtp.gmail.com with ESMTPSA id n5sm45620707wrr.94.2019.01.03.07.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 07:11:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Andrew F . Davis" <afd@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/5] ARM: davinci: da830-evm: fix label names in GPIO lookup entries
Date:   Thu,  3 Jan 2019 16:11:00 +0100
Message-Id: <20190103151104.11839-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103151104.11839-1-brgl@bgdev.pl>
References: <20190103151104.11839-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") the gpiochip label no longer has an ID
suffix. Update the GPIO lookup entries.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index e52ec1619b70..c4da635ee4ce 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -208,9 +208,9 @@ static struct gpiod_lookup_table mmc_gpios_table = {
 	.dev_id = "da830-mmc.0",
 	.table = {
 		/* gpio chip 1 contains gpio range 32-63 */
-		GPIO_LOOKUP("davinci_gpio.0", DA830_MMCSD_CD_PIN, "cd",
+		GPIO_LOOKUP("davinci_gpio", DA830_MMCSD_CD_PIN, "cd",
 			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("davinci_gpio.0", DA830_MMCSD_WP_PIN, "wp",
+		GPIO_LOOKUP("davinci_gpio", DA830_MMCSD_WP_PIN, "wp",
 			    GPIO_ACTIVE_LOW),
 	},
 };
-- 
2.19.1

