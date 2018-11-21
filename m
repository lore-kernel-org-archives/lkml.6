Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA6CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D5F20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="g9iFWn2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D5F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbeKUUJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:09:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35268 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbeKUUJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so5003898wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RdsjIEfrCRlwOjYmuBRa5tB1xw6cWRBIx0raXNtfpFE=;
        b=g9iFWn2S5pq7eBt4g40m3N53VIfmw3U9oka+7dbLz4sfrtMdPyVzSxFXTM1IpJ8uKv
         0XYqpT2jikhULX+2PoZG6RjmISkzethdrjATyYON7z01dh9ehJ2g/+/UuDMOCHVSnM8P
         p+Eb2GE+TFeON/fYyfp/cLzRfgFXHlkHfdg0gq/XAxxtAX+IYvhKN2jnrn26tAAz4eYs
         qdp0D6uz8jphnmdpP48P2jh6A5jdFlt2UJ+47e3Us2HehPE6GWahBSNIZlGclXP6N2xR
         t/59B8NWApo4+gK2bv1ylYwTwF7eNg6JxT62LThu/8T+OILLpKhVTeEwp6zjjzU480ax
         YaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RdsjIEfrCRlwOjYmuBRa5tB1xw6cWRBIx0raXNtfpFE=;
        b=q1ORcBMK3muVeUytNYDWugEUcY9HEKFKVb9cTkZPEQS0uuxH/RFfGu4YVWdQ48xGAu
         uy8nqmZ6Jj3wdPVxP323celRKHRudJMDhIqCqiQnokQK6145glmbCHWHdeSVp8ESdLQ8
         MljUE7NApZ5voIYmyecgXrCjhjZH59yefGv5lQ/0zms/wxeq/nUor+O2P6lOKBn11fy2
         FCvO1DzRy1TpBw8tQuCHdrLXeP6xUsUPqCqcqdYA9d50d5L8Ae42WGE0ezHhaFBkuedc
         7I5oZwME8uVOg1ml83+mPIETHDwaRSmoc68vLgSCqr/3LzQpcuLX+eblCPX5LNwmLxv/
         du3w==
X-Gm-Message-State: AGRZ1gJWowBAdK9mZkfWNQF4Ka5V9nyvtr+y2HZcfexM575BOUQJc9Oa
        TKidV7RPJYt4RgX4qE9IP9bIVg==
X-Google-Smtp-Source: AJdET5eggH4F1XtkO2tVIJtJXbgMfK97TgZh/UxY53TOO0SRd/QOqWU82zd5OhCvhmkgHrFB5DUHQQ==
X-Received: by 2002:a1c:34c8:: with SMTP id b191mr4808912wma.34.1542792941874;
        Wed, 21 Nov 2018 01:35:41 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:41 -0800 (PST)
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
Subject: [PATCH 10/12] ARM: davinci: dm355: set the GPIO base to 0
Date:   Wed, 21 Nov 2018 10:35:21 +0100
Message-Id: <20181121093523.12503-11-brgl@bgdev.pl>
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
automatic base selection") broke the GPIO support on DaVinci boards
in legacy mode by allowing gpiolib to set the GPIO base automatically.

DaVinci board files use the legacy GPIO API with hard-coded GPIO line
numbers. Use the new fields in struct davinci_gpio_platform_data to
manually set the GPIO base to 0.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm355.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 2b0f5d97ab7c..4c6e0bef4509 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -584,6 +584,8 @@ static struct resource dm355_gpio_resources[] = {
 };
 
 static struct davinci_gpio_platform_data dm355_gpio_platform_data = {
+	.no_auto_base	= true,
+	.base		= 0,
 	.ngpio		= 104,
 };
 
-- 
2.19.1

