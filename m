Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F13C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F622229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fo7WDiek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439532AbfBNOzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:55:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37831 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439505AbfBNOw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:52:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so6327751wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KqCZkQam34X7Bd200BUIwd7m0iyaXsOBKajs3xqc3eI=;
        b=fo7WDiekD7IpoHzdaa0atbQ/BSibpvghz63JMbYbaE6BdRtzwBaBFYCIRdJ8PcBDar
         OuqfQB3Q4zCkJXWLjJHfdciJ4rtO5INFK+BJWSMG11UBJmCdv18mpPtrff70GrbmQjZT
         uzaIJHIUPNef5+YF9Es+4daF3zzM5qV8DiWO6T8S0XFoAKM1mJEBrhQW4AqFhzPVXxUc
         WpYVgBDEl3s6dO+fYBfEwzEJbD4NGjE7PvDB9vm1oypjRE0kupcg94XyN8wiDs7esBDa
         TC5wdIcgPQcziqEYRs5pMOfi3uTZPcsQdSn5oBYimSgFcVP3Q8rPxOfS3l2Hx8Y4cP3Q
         Obgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqCZkQam34X7Bd200BUIwd7m0iyaXsOBKajs3xqc3eI=;
        b=qMJCO/jVJ05Gso9GF8adUzPDtzsdxBr0HNF76TaBcSCqbqsunakaMMtVPz/0MaUO+s
         EnobzJDkJhTulfh6uOQF0VafgZpM+/MT9HqguQoVXC5NcUsrTwINiMa1EvrQJSumMpbU
         0DmKm1ALn9H75ihFQp2Wv+yNb3Ut1vqnJi+TvYs4BDjJuUQpEvjngE8yuwi15kyO1xGW
         BUer3a2jfSWTJP9xPwLORE024yHTLUGpEXVrX00R9bQbmYivcAb5AKHwC2/nA2zW8fYj
         bKKS6S1BxZXoNDnGTQXTUzB0KwbKHpqHEhA7heakSREImvL+TKRw/ApIqJmyKhTHWvV0
         r7EQ==
X-Gm-Message-State: AHQUAua7NTeOHoxDaHk2nfaIGyQzIcGHC9q8fbK1zbk8ncIZK4SHLFzO
        VvutTxPNJCNVe4rwLI5jrLU3IQ==
X-Google-Smtp-Source: AHgI3IYESV50SAOR0AHkCFB8svKvmHkqSd9N+lmUd2L3OrHls9MpA/SDQjrgo6rLPXZtFq1j4+gr1w==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr2930963wmh.86.1550155974782;
        Thu, 14 Feb 2019 06:52:54 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:52:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 10/37] ARM: davinci: aintc: drop GPL license boilerplate
Date:   Thu, 14 Feb 2019 15:52:04 +0100
Message-Id: <20190214145231.8750-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Replace the GPLv2 or later license boilerplate with an SPDX identifier.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 5bfbd9c70a2e..eadbb9d75415 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -1,23 +1,9 @@
-/*
- * Interrupt handler for DaVinci boards.
- *
- * Copyright (C) 2006 Texas Instruments.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Copyright (C) 2006, 2019 Texas Instruments.
+//
+// Interrupt handler for DaVinci boards.
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-- 
2.20.1

