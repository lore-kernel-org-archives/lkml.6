Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B57CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5BA2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AXEDg7Kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfBKM0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:26:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52490 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfBKM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so17485112wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVbb/kmDGnz2R06A9Y+sRzR+uJXik+IbWekFAYRY3NY=;
        b=AXEDg7KklUenWcoBF2Tt9JIwcxAg0z5HlJa0TWbNeQNwbacsdqkwMeXuuyqsCOc7Ms
         IMPLR+O3M1KC/1RqnWOSCspIfZeNAXxmm5Rn6HmWUybW9Pretx6s1cJgfp0cTotrZQPD
         LCFoVwW52YTdE28yKm/wZmu+ogrYs0RlqYtR737s4i0Vg+DjnfjU+Xqf2iSYzYFiwci8
         SENRBCAilwDZnPHWJxaFPJgJg9r495z9T89oxc8scpgP7vEiVEquLXUu00rBNbv9k2eM
         6zYLgCT4BuqtUofPvva7KxVeWC/H9GPzhgwcN1V7BvMwzcx7nnppoF4jAWbseXbv4pEw
         V33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVbb/kmDGnz2R06A9Y+sRzR+uJXik+IbWekFAYRY3NY=;
        b=oc+YTTSpqCtzxrUawzc8NRxGzRZ8G1KwGPdRAE6SdULJVeAM7Nrlaq2wA4HhxDIFP4
         nb92wwQQZVsEKcAYDj/udBQF2UrclvyXzxqAP0/PjJE2EY/DFLXyt8U8SBBLFu0Kjl7o
         V0QAqrfLteMDspFaJP6cGfjBALFjknVijiXJoeQoUknwmMAMXsr3CfCYwo3Su81JBWiN
         4zvWhzrNMt2na9ALVjcaBC8OotMq8f034Z35QKd1FafT/FhrgtyoX5co0t0q+LdRKgBi
         THB1POV6LVseezEHPcMPf1RZS6YhGHRHdLExXlFN+m+HJhkHRTzKC+odMLGdAyPT8gom
         AnfA==
X-Gm-Message-State: AHQUAuaiMdVeDKogdSwFOTHoDVXO9bt/NjlTiS3fFMfXznwH9r0jg+LQ
        4kT7ofN70nbcoKJoyxY386HOnw==
X-Google-Smtp-Source: AHgI3Ib/DPvgBo2reENCghlhxMh3WiDOjeD7oK6R0Li2KY+cahwbev0DMRk1xiQehHjSAv5CAD6R3g==
X-Received: by 2002:a1c:7dd6:: with SMTP id y205mr8674098wmc.121.1549887984740;
        Mon, 11 Feb 2019 04:26:24 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:24 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 09/33] ARM: davinci: aintc: drop GPL license boilerplate
Date:   Mon, 11 Feb 2019 13:25:42 +0100
Message-Id: <20190211122606.8662-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
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
index 88c30759d1c5..1301adc569e2 100644
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

