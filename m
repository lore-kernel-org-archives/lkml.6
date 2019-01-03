Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2358BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF53320815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="L+sKfSVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfACPLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:11:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38514 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfACPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:11:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so30720988wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 07:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWJWZZulgERjeASm5OPhNm8DDTWU4vIOyd+OG5AXAec=;
        b=L+sKfSVoSFpnR2cCgGPWnhqAIvti6WS54mBOHrTm6N22eM/XWKvnmszR28T5tMhgmD
         i/BzdyANsf8hldO3/FlO9l/ItkyMXOFsYTldmeordPlCMlexNlZKOP9gaGW4nnYH7jGP
         z7b1Sp26yhjG+C1DG2NxGsGlO6ajXuewy8EfYVi2V2u0CVXupESTQMCclFAqxWyL9B1m
         Hf3pyqSuf/zDW6cMZgiJtAJ/Ynj9Ixe7jRCxIzTK0tPKRzDD5HQJ98h3CKKZwHKwlnaJ
         bV7ULddFW1aWAdT5zZveRIG/4qHPJNeXtp90+3cEELToejm0vZ5UoqU2pCaZro92i9eM
         AWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWJWZZulgERjeASm5OPhNm8DDTWU4vIOyd+OG5AXAec=;
        b=jGE7v97PcgGtTW2fVlArruZ7bZlYhVibUtE0HXsu1z6qwyt+HYIJUJPr0NvDO4y/C6
         0STg4bvmwbAVLNwOicfEPwMANLflhnqGFVk0vlZKHptN4+iquHOCEvncr/FUVtoOvuaa
         NE9Q8J9MGaOzmliUJfx8SELTfponkzhAn+8EPUbpyK73FFvVQ9zxHrFijIbSsH5Qcv0C
         DTgHG3agphSYE9UqtS6XIha/OYw3jazqsiNPAsxTf/91epSP0naY6WK6nYNETtSio3Qc
         lcWqfO/AReFAAFSEQ2VauKsWejLw2MHvNzw5cYM+f+oTSGvnf/IJsEXijmZnx4Qy/JZw
         Uwgg==
X-Gm-Message-State: AA+aEWZ0DAGoCzRE+A4TxiPS/Z4qolRuyP7JDfroffttqD2/tnqAVi8W
        ojVaNcqDF1Uy55hUAhM9HWF2sA==
X-Google-Smtp-Source: ALg8bN6PCUvz/cxT6+XRAoazQ4VYiP/T5jYo4SZ3HPxrIpV5+BxkbEed1Vjf1Xd0mzn52R8Lovx2wg==
X-Received: by 2002:a1c:a895:: with SMTP id r143mr36694420wme.95.1546528278238;
        Thu, 03 Jan 2019 07:11:18 -0800 (PST)
Received: from debian-brgl.baylibre.local (astlambert-681-1-88-79.w90-86.abo.wanadoo.fr. [90.86.3.79])
        by smtp.gmail.com with ESMTPSA id n5sm45620707wrr.94.2019.01.03.07.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 07:11:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Andrew F . Davis" <afd@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/5] ARM: davinci: da850-evm: fix label names in GPIO lookup entries
Date:   Thu,  3 Jan 2019 16:11:01 +0100
Message-Id: <20190103151104.11839-3-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-da850-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 6a29baf0a289..44bca048dfd0 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -805,9 +805,9 @@ static struct gpiod_lookup_table mmc_gpios_table = {
 	.dev_id = "da830-mmc.0",
 	.table = {
 		/* gpio chip 2 contains gpio range 64-95 */
-		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_CD_PIN, "cd",
+		GPIO_LOOKUP("davinci_gpio", DA850_MMCSD_CD_PIN, "cd",
 			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_WP_PIN, "wp",
+		GPIO_LOOKUP("davinci_gpio", DA850_MMCSD_WP_PIN, "wp",
 			    GPIO_ACTIVE_HIGH),
 	},
 };
-- 
2.19.1

