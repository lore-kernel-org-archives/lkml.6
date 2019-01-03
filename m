Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0FDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D390020815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Ltx6QoPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbfACPLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:11:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44155 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731468AbfACPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:11:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so33864644wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 07:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9YQ2TzxTUSfp2DIUx4vV2/rZOoYPnNHF0DkPFTWj6gs=;
        b=Ltx6QoPU8u/ClrcHN8/KYiqxZk7gJ6gSAVVoZtKSfUJ5PPR8x5pJ0bswRjV6iXKD/O
         elTmtLVJLACcjZwaQjInwyvb+lb0jTm3j1CFd8LQC4gShxVaqWgCr3wtQ30Co/skrR+Y
         e9EREm1CmhUtWgGLXItXdYtn83TYXxm0pO6p1+JyoWl2mrx+Ff+SS1Y+qccZ+6T70g2B
         lZLzmex1GsBrZdmESBHRSl9P+WNV94uzeMrc/2DTuriapZJEwoTI/Yql48TFjGfU3hTq
         2jZ0HSim1Vmgwd1ZNykpn6WrW1rxaYUXyOM47KE4Z2erJoXVaaPH6us8xESBFCkIYTDY
         XtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YQ2TzxTUSfp2DIUx4vV2/rZOoYPnNHF0DkPFTWj6gs=;
        b=dKjvUb4Rd0YSixw4c1NOL1NhG+HNpAL9xrBjN/93WkXxZqbN0ycE/AL3/0Ayz7JRzi
         8gW88ToWB0/X0vnR+/F+u9GHdiA6ynu5Vlw29yaJwdk14p5K8uizqhT6fbVZcrpF/fci
         G8vUXvjazPzwfYKcKYZ/bFtX9AT+O+497pdLovZqVfTBbmjEMfvPZVzdppT+cSirFsEL
         Q7kdvmn5KiJ4wE3COe1jckCnDwEdiPqsSVRwmprEQ25iUT8URdFYU3tBNlfxkR/0N8gW
         Fv6M/0nuuPlJUACoIftr+ZcEQEB4bpR/pDnC9KLQ4wy3eIIKaMTOS3MIrPTvcj8aEsLB
         ZyYg==
X-Gm-Message-State: AJcUukfVAhU9/mBrCrydxf2qp/A9l6hYCW8p3+RKO6jMd47Z6JWoU93W
        mJNiC+m3c+vvIhNVeGQYz6kasw==
X-Google-Smtp-Source: ALg8bN6lsWuJBPaMucgfyH1x9LfnTyfJbLdWwp8Hpy1I171Vf/C8ksE+M2IyGZjj4GmTbmG8k3cXUQ==
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr42352116wrj.107.1546528280732;
        Thu, 03 Jan 2019 07:11:20 -0800 (PST)
Received: from debian-brgl.baylibre.local (astlambert-681-1-88-79.w90-86.abo.wanadoo.fr. [90.86.3.79])
        by smtp.gmail.com with ESMTPSA id n5sm45620707wrr.94.2019.01.03.07.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 07:11:20 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Andrew F . Davis" <afd@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 4/5] ARM: davinci: dm644x-evm: fix label names in GPIO lookup entries
Date:   Thu,  3 Jan 2019 16:11:03 +0100
Message-Id: <20190103151104.11839-5-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm644x-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index e1428115067f..b80c4ee76217 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -660,9 +660,9 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
 	.dev_id = "i2c_davinci.1",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio.0", DM644X_I2C_SDA_PIN, "sda",
+		GPIO_LOOKUP("davinci_gpio", DM644X_I2C_SDA_PIN, "sda",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP("davinci_gpio.0", DM644X_I2C_SCL_PIN, "scl",
+		GPIO_LOOKUP("davinci_gpio", DM644X_I2C_SCL_PIN, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
-- 
2.19.1

