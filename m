Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3D6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5080E2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sbN5jXOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5080E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeKTXDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:03:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53269 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKTXDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:03:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id g131so1950696wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkFurtpj3xocO7TudwoJGLKdATuAg38vT4LiX+grVRo=;
        b=sbN5jXOw90a5RMQmXD1wlQjkfV7fDchaPHJ4TlixKmSe0RqDyoUbRikUSefoiOg6Eg
         ziraAdSZsZHUGGfsXcA1D7AD6VBIzxcOP15GmwuD7FA7j+WYisSkE5/sMgJaNVGd1jOw
         u392ZTLkfnnTIyv0h2zKNZkayZ6vK4ozBnbfJqWzZ+4FlmQq9bz+FDhyhMoMoQ+2f71f
         OCiDQHa1A/4tn+qLGNgiHNnflHQ0ifHKr3FSRvg9TXaFrj9XCKcK9c3nMlkmJAFLxyfj
         3TjhgVfWmd4r1ERSrOQ/xRU7nX9lyoi0GnzH37Jl04+pq3FXVYqaoMaYZkS8g1zAwD16
         WbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkFurtpj3xocO7TudwoJGLKdATuAg38vT4LiX+grVRo=;
        b=K2j8Ity7wufecQMuUvgqemD1AHC7W5xia2v85i4n3wdtLBHCa3w+AUBgvVoQCOY5zY
         FRmp7o26T9n7Tn2iO2Eq6ki6Aj50SI6hddexTLSDmFgnTV4WKXZUaoua9ZL4O8ZhhTi7
         5qYbN/OtM+6Z4267oopQOHjXz3N6bt9EPezzpuFCXXPgrNHxcf4l+IhZVSJEs3osUF2y
         +HbDVfFeCJ8cY2WMtIbrY7p1EfxDysTNEuLyAIAqLDpINEJ1i5voTm+dINt2Ci8bcdlx
         gi390t7H6FZ0QegYwZ+kSvRED0pT00PlZsgSS9IoXVkdJwf30gsiV62Sf7jgB3Jjv7Zc
         INDw==
X-Gm-Message-State: AA+aEWagGk6+fg0As+tC2JWnU4bAisjFMVVQMzJgTbXnuv3B9eIefFqg
        FYWC2E62kp3vXJE7Xgs2NJ2Ceg==
X-Google-Smtp-Source: AJdET5fklahH5KrzwDFDwqg/BXtNCrneFl4Er0R8kvmNMkvD8mIfjDB0oAWtDScYZO3hil3Eu3qxFA==
X-Received: by 2002:a1c:a05:: with SMTP id 5mr1932679wmk.49.1542717269555;
        Tue, 20 Nov 2018 04:34:29 -0800 (PST)
Received: from debian-brgl.home (lfbn-mar-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id v189-v6sm33482685wmd.40.2018.11.20.04.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 04:34:28 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/5] ARM: davinci: dm646x: set the GPIO base to 0
Date:   Tue, 20 Nov 2018 13:31:22 +0100
Message-Id: <20181120123125.24938-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120123125.24938-1-brgl@bgdev.pl>
References: <20181120123125.24938-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") broke the GPIO support on DaVinci boards
in legacy mode by allowing gpiolib to set the GPIO base automatically.

DaVinci board files use the legacy GPIO API with hard-coded GPIO line
numbers. Use the new fields in struct davinci_gpio_platform_data to
manually set the GPIO base to 0.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm646x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 6bd2ed069d0d..158f5908a0f0 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -448,6 +448,8 @@ static struct resource dm646x_gpio_resources[] = {
 };
 
 static struct davinci_gpio_platform_data dm646x_gpio_platform_data = {
+	.no_auto_base	= true,
+	.base		= 0,
 	.ngpio		= 43,
 };
 
-- 
2.19.1

