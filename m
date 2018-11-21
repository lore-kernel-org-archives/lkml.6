Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BE8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1E720989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dfgbRhMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1E720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeKUUJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:09:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53235 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbeKUUJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so4760601wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxLn+ityF1pnRyBT0umZIgVsYgRlKl7Kj4xfH+X8IaE=;
        b=dfgbRhMBHftPoKJ7evxcwUmoQcwy9VD2tLhUWi2xB/hMbUnXlT2vtktzuKVOgmMERA
         SzFAImUSsSfx//Fn22w40hZFIrTMh5guMK2QuaYOA7AybM0qxfvAJPU3Q7cLa0Xmxqt1
         uhT064yBi9c9zipI04bkcDK+Wf/cbRnmxbwf1yOAQlqg9AYMAUOjHqxhD9Z155HTZbUE
         IrQv8Nybq/cCbuDun/QiMOl2HU7u0Bz5sTfiSSq+xtaMCGi5GkDWZFu2YgOOSuYOirn1
         M+8O50UM5Ix/E7gEHk+0Vx+vsWEhpmLet+wsOpa8SLzOHTNJhbdRNhoeXGQrIWi4Im4i
         +HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxLn+ityF1pnRyBT0umZIgVsYgRlKl7Kj4xfH+X8IaE=;
        b=FnUiMeOUaNAZWNPLFJ7L+ezbX17EtKS7S3D6hUx0GaMIpJxh+3gLC15ui/lTqe7U1C
         NrUI3WI7kR0C3c+7Pcr5CG3hrADpylysznwyu7yze85u3e6418y4ee90WNAJMqeadbvk
         I0z+tPSzK8Xv9SXe7DNqN5NQE4CTLTarvZLAHOoh4KOh1gbufd1EBgHcTQj1Ir5m8kR8
         2znPzIxK9UJE/rfAEW3BeTimuTAV4UO/jnVN0wGUbG3Q2qKCGFJjefgA2xR6C3EX4o3L
         PYIcknFMt9ZvNRcbYKyhQEoTTJ5KbWRitdAFwpNTZW/ZE8cGI0pGoOPy7/W2l3aWgaZS
         pRSg==
X-Gm-Message-State: AA+aEWbM7SLeVEBfQWPl/YIkiKGTm/ivoVbHvSUGb6wSXoMRh6rLu8B2
        3XTC/O4WG+7VIMK6cbsN8++DOg==
X-Google-Smtp-Source: AJdET5eMFjkqizdFO9Mjw9ZJscA+KawCPppievX9VzGJvBmAA2mssy0MPqxPpRk8NN01+43uIrgfsw==
X-Received: by 2002:a1c:4a:: with SMTP id 71-v6mr5066892wma.140.1542792940640;
        Wed, 21 Nov 2018 01:35:40 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:40 -0800 (PST)
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
Subject: [PATCH 09/12] ARM: davinci: dm646x: set the GPIO base to 0
Date:   Wed, 21 Nov 2018 10:35:20 +0100
Message-Id: <20181121093523.12503-10-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm646x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index d9b93e2806d2..7dc54b2a610f 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -458,6 +458,8 @@ static struct resource dm646x_gpio_resources[] = {
 };
 
 static struct davinci_gpio_platform_data dm646x_gpio_platform_data = {
+	.no_auto_base	= true,
+	.base		= 0,
 	.ngpio		= 43,
 };
 
-- 
2.19.1

