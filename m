Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADD1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08A920989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zhg4Cbgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08A920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeKUUJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:09:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51910 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeKUUJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so4772032wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N0vcnDyDqE+FV7vpL02RiFBkDhawBnHwoXWnuBlTRs0=;
        b=zhg4Cbgvq8IqnRhaeETGTalwqzt6p/W70hNnBzwfyQlwBP2xmen+jFXV+wmqGwty13
         YMYLx0RJ0oFkCKrmgZncluLokzUAQoVj28kEB9guCWJ/55mX/XjXjk7xSUhqCAuPsO/E
         pPIZDinZrnHfAYVu9VD/f0r//hSF6mEjcX5MZYeNsyYrN4yvlpxLGS0NiYP7n/h4yE91
         m3dQcHt1z6RYWLKCSnZj3Nihglh1lLAjjSb2UqTE6RutXBqNLOjONbUkLREoWdnIb5Md
         kCHS9bI+wzbwyqLY7fCHaJC62gMCb2aN4VmTtIU/aCbBfGo2DoQwOBjPaoqurX2+B5Ai
         7r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N0vcnDyDqE+FV7vpL02RiFBkDhawBnHwoXWnuBlTRs0=;
        b=t3+6ci7lTYgMX2bqTxgYKADQ0wc9r9VfuFv5RtYWz2ZEX91Z2O26CrYd8VHcDWFZS+
         nr+fzPJkryx0Z+l1+Vjvf3weyq2Z98KP0exiYnkpPQRqUce7og/u5hntxeH3DhflkJY2
         IBS4x6ymnMxEtpVem2H7WLunaV1KbdNDcsU6TUTKSwpP9NQxnlTV7Zi3Gk7DoLk8ikWm
         G0i0DKxfPakChUKngtIbXwoLNU7QGwrVdGjcE+HYHWEDB34hTaO1o2csNzVugAzM1RWM
         jW1J+tH7adOg1wYVOJ/zkHRcNc7TQkMw79Si7T0SNz3UKjBUnTI8vIj8EGelgCKhpGcZ
         Tyhg==
X-Gm-Message-State: AA+aEWbbmjKOfFHqmvcfItSYlzFHTUVitofVK2v8duOIqe0Dy2FUIT7a
        tLY33zIv6ljxSaXkhNBKIxDUtw==
X-Google-Smtp-Source: AFSGD/WKD05mfBXt9M2xw7hnX4BMoa01hnooYKfa5qwn/+sSOy75H7LcyVWCajTTYuyhy8offtD6Kg==
X-Received: by 2002:a1c:6382:: with SMTP id x124-v6mr5379742wmb.145.1542792930149;
        Wed, 21 Nov 2018 01:35:30 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:29 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/12] ARM: davinci: fix GPIO breakage after v4.19
Date:   Wed, 21 Nov 2018 10:35:11 +0100
Message-Id: <20181121093523.12503-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is the entire set of changes needed to fix the broken GPIO support
for DaVinci boards in legacy mode after certain changes made to the
GPIO driver in 4.19, namely: commits 587f7a694f01 ("gpio: davinci: Use
dev name for label and automatic base selection") and eb3744a2dd01
("gpio: davinci: Do not assume continuous IRQ numbering").

Bartosz Golaszewski (12):
  ARM: davinci: da8xx: define gpio interrupts as separate resources
  ARM: davinci: dm365: define gpio interrupts as separate resources
  ARM: davinci: dm646x: define gpio interrupts as separate resources
  ARM: davinci: dm355: define gpio interrupts as separate resources
  ARM: davinci: dm644x: define gpio interrupts as separate resources
  gpio: davinci: restore a way to manually specify the GPIO base
  ARM: davinci: da850: set the GPIO base to 0
  ARM: davinci: dm365: set the GPIO base to 0
  ARM: davinci: dm646x: set the GPIO base to 0
  ARM: davinci: dm355: set the GPIO base to 0
  ARM: davinci: da830: set the GPIO base to 0
  ARM: davinci: dm644x: set the GPIO base to 0

 arch/arm/mach-davinci/da830.c              |  4 ++-
 arch/arm/mach-davinci/da850.c              |  4 ++-
 arch/arm/mach-davinci/devices-da8xx.c      | 40 ++++++++++++++++++++++
 arch/arm/mach-davinci/dm355.c              | 32 +++++++++++++++++
 arch/arm/mach-davinci/dm365.c              | 37 ++++++++++++++++++++
 arch/arm/mach-davinci/dm644x.c             | 22 ++++++++++++
 arch/arm/mach-davinci/dm646x.c             | 12 +++++++
 drivers/gpio/gpio-davinci.c                |  2 +-
 include/linux/platform_data/gpio-davinci.h |  2 ++
 9 files changed, 152 insertions(+), 3 deletions(-)

-- 
2.19.1

