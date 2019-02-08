Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197DDC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74842146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Xd4FqMO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfBHRiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:38:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54185 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfBHRfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so4359995wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVbb/kmDGnz2R06A9Y+sRzR+uJXik+IbWekFAYRY3NY=;
        b=Xd4FqMO9I6790JqPr79qSiqhSgCtZHQ1J58BNZs0T74nySxs2q+HXWouHipBL2wWKZ
         2YzZj0CD9aaoze2laS5JYLbbBCzfvokXAXHjlp454uKIgGCP4N77BWyP+ADjpro/VpEA
         F2nbwFdX76a4FDyzV9xO1GXEtX51noqw+Eck0sp4RTajjDExJiZ+CguPtidHATXrwsrR
         VLP3ujtFLNHGfhT2r6NTDJaqSpma6l5MOFP/jHOU9oCbpxZu0O2M9wYRUGhKpEMuOkWm
         o2j0tCkYmW6JKvBbEqsY08bE30J1FR+50rugCUJECd2H2sbB61C/4k3ODgntqPrcKsnK
         tzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVbb/kmDGnz2R06A9Y+sRzR+uJXik+IbWekFAYRY3NY=;
        b=DR1MW5nLxXDVIDbd3y9K+/iOiZ1qxV4aDtbsCcWYF7M3k7KRdVEclcG1hWImAnaTOO
         6nu3/onetCjq+FhoHGgh3WDeh1QrqQQHuuRqmKRQgQZnQfTS3P/j0E9gXFpf26Rs98xz
         n2k74n9wx1bMirGz/AYFcBMIO3OU64HDCVfEO9jKigoCezqXaxGFfd5xXCOwZpRXeu6I
         +zgpju2pUKKO+2vv8brBcOAm7VE3PaYjbmFE4d2vk4QxH57inD43GV55uq6e60d+nESN
         8YR2YKbCPasTnN21+HiCCGmk7Qd8sT2bF8ulW5t1Gi7ngR+MgMVjx8yZJ9yuoDoFIgR1
         K5ew==
X-Gm-Message-State: AHQUAuZ9OV9hx4UlUdYSXCtT/ut6lWE0HncWII6g/tsuBBiEm28NdtYP
        Q42if27ErORsajj/ITvd/zs+IA==
X-Google-Smtp-Source: AHgI3IaI0pnsdQtq6MqG/GmPvD6gDbPnXpMBFVIAGhp/O8zIeiMvo7WGh6h+OvsMvrtJ9on0JuoT2w==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr16665956wrp.80.1549647317160;
        Fri, 08 Feb 2019 09:35:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 09/33] ARM: davinci: aintc: drop GPL license boilerplate
Date:   Fri,  8 Feb 2019 18:34:34 +0100
Message-Id: <20190208173458.4801-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
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

