Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA41C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836EA20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="V3XilHnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836EA20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbeKUUJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:09:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53326 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbeKUUJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so1544665wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7d3gKs/3PvV8H7d9+aIBGmoqH8Qt+ozbWCJM2/z5B8=;
        b=V3XilHnEpfkxXKAmbQVk8CoixuIwu4UWCWLHeW4SnZtL+K4bsA9hN9EqhOu3+QRrl2
         sPtFcgujmxQMNS5TUcxgk0QefBpHVb1rj/fOY8nnnQGZ7UsuZLoF0LnDr/aE5Qz8G1h+
         SiJ0S6d5KtXtcmy6GGkH/aeqOqVtzCYktoOC4+VjhU6GyfpMdeTCQRXGA7GT4UuYZaVM
         BGeVJeDLxtpnFFvsePGZ7Idp7ViUH8CtX+y72FSGRsj8fiQhVqBiMCCzdXUsCEPHyh03
         l3FzJYS4+QjAWUT8rHOhsk7kE+K3OyR/JePdm8/0dVSFtQ/QgjgG8i+5Ya2k7oqkvfor
         pphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7d3gKs/3PvV8H7d9+aIBGmoqH8Qt+ozbWCJM2/z5B8=;
        b=Tnhgb5FfcLi1eSPOtniCX/YxDmEdY7/7j3DqXDthz9JXp/ZHQ0HsE+q2C29QrvQP1k
         ERLYYgx//mLvT8jBZdtHFH0mZ7Kac3gm9Kd3AVOuakbOf5OA723vBRAkbYjwdtr2dtfT
         TqHxH9us6VIR9ZlFIkxHP5wZzJpNFaGIwcn51BLhB3N41IP1h2dZj5QWzqozehC/z+4e
         OFBzV0q9ANWHtEpffoy+eVwlKqsMP/AJ062PDlX4V1t2ZZjaamAHIyulIZ2GcIx2I7vb
         ArEJz6z0dnNWpfXpENpSCvVzyRjHy+MpqTIKDKmhPo3+cY5Y+mB0J8uHe5wsglpe5PxK
         eIcA==
X-Gm-Message-State: AGRZ1gLrqVPvdXNACXhq/TzsH+RbBNgonN3ArPG5UtHik7l5WdvGnqqG
        mOL6yIM9AWwnxZB4SlhgoPaUPQ==
X-Google-Smtp-Source: AFSGD/VX08JNI5ikbq1tXDAaLlSVnFItRfKDCgaREx0gR5ni4t6qJB3WUEapAGhELtKtPKiBZZo21A==
X-Received: by 2002:a1c:128c:: with SMTP id 134-v6mr5436123wms.72.1542792938299;
        Wed, 21 Nov 2018 01:35:38 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:37 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 07/12] ARM: davinci: da850: set the GPIO base to 0
Date:   Wed, 21 Nov 2018 10:35:18 +0100
Message-Id: <20181121093523.12503-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121093523.12503-1-brgl@bgdev.pl>
References: <20181121093523.12503-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") broke the network support in legacy boot
mode for da850-evm since we can no longer request the MDIO clock GPIO.

We now have the option to specify the GPIO base manually for davinci,
so add the relevant fields to platform data.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 4528bbf0c861..e7b78df2bfef 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -719,7 +719,9 @@ int __init da850_register_vpif_capture(struct vpif_capture_config
 }
 
 static struct davinci_gpio_platform_data da850_gpio_platform_data = {
-	.ngpio = 144,
+	.no_auto_base	= true,
+	.base		= 0,
+	.ngpio		= 144,
 };
 
 int __init da850_register_gpio(void)
-- 
2.19.1

