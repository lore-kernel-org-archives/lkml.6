Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D427C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BA52070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BebHWrUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfACPLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:11:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39071 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731451AbfACPLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:11:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id f81so30529240wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 07:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o1Rscmkgo5Aw/dFvuBDumO5U7Ea+GbZdlw4mBIcmRFs=;
        b=BebHWrUJYrV09TqDySy/CNMzu8SepgKotsI0sYvoiGaB924gKKB+E8sBEvW6FsmEXM
         SvgukRJzroS6wifqcT11XSq+rqT6IAyng+aLZNcmxXL1ZY/D5qpLFGDipJYnlfeOyrWK
         KFsETquV8t01ehjZmggMe9mXfvTjn077kkdmc9MX8kbVzhLIfcylWsqJeqwVWJZMHZc4
         bbpo4W8hEQQUxpYeKHXHy0KhjE5EkdEOclouFQgkwvX+grjyobYY53tdCuuOmzrrrGoR
         +5nfWlspWgG/Ioiffj5blMOONMLlHDfRloD4sIpjakzJKhRhiCKASOVp3suV22vEhFZc
         Zf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1Rscmkgo5Aw/dFvuBDumO5U7Ea+GbZdlw4mBIcmRFs=;
        b=ANr3Wi80tprYidT4YP905d8o7H1IKrnjyYKpTjmZweAvuFLqlVMnWnQbtDq7UyraSU
         CRYQiJvDNsq12ScjGYRegoQaxUVOxdhXE4B9wYBNXbCUUS6DfUA/o06geGOi3ggifRBj
         +8QFvTtIkNIeeS9zceVK7LXW2SJSf82qO/S/fhWnm89frmF0YRKf1+ZUmzKwvoRzsDoe
         ICfDr5UytF7yb5dSHVVijHCUWyolaJK7k/lD4Gj72sNmix+p99MkInRjlX44P/Y5mZqR
         DM4TO/8pvSR1Iz8MhK0ty8VseP5/R0gJGId0AC3TjANe3nALiVIx1/DyB0U91P/jaOcB
         vhwg==
X-Gm-Message-State: AJcUukeLN64ynTzlRTlTmyBEEQR7fBi1BdRLWwhc9PvTFiLzZE8/VzP9
        Ma37nZNYCngK27psW/2HJpjChA==
X-Google-Smtp-Source: AFSGD/VyKL1kRSsVJEg0ns79V2gz1O2GLmJIV9/g/Yv2Y4St2M7M0zHBJC4uXlv20/uVgNDHAXtLiQ==
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr36793535wmc.43.1546528279497;
        Thu, 03 Jan 2019 07:11:19 -0800 (PST)
Received: from debian-brgl.baylibre.local (astlambert-681-1-88-79.w90-86.abo.wanadoo.fr. [90.86.3.79])
        by smtp.gmail.com with ESMTPSA id n5sm45620707wrr.94.2019.01.03.07.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 07:11:18 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Andrew F . Davis" <afd@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 3/5] ARM: davinci: dm355-evm: fix label names in GPIO lookup entries
Date:   Thu,  3 Jan 2019 16:11:02 +0100
Message-Id: <20190103151104.11839-4-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm355-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index f53a461a606f..f7fa960c23e3 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -117,9 +117,9 @@ static struct platform_device davinci_nand_device = {
 static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
 	.dev_id = "i2c_davinci.1",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio.0", DM355_I2C_SDA_PIN, "sda",
+		GPIO_LOOKUP("davinci_gpio", DM355_I2C_SDA_PIN, "sda",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP("davinci_gpio.0", DM355_I2C_SCL_PIN, "scl",
+		GPIO_LOOKUP("davinci_gpio", DM355_I2C_SCL_PIN, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
-- 
2.19.1

