Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7E4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298D320818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dltVY8Rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfBLKjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38872 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfBLKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so2442234wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KqCZkQam34X7Bd200BUIwd7m0iyaXsOBKajs3xqc3eI=;
        b=dltVY8Rg9Jt6pvWMqt4mQnCPaY35Oj1OYdIytpSfageeZyQdjxWEmzC06SRbAD13oq
         MwRlr/zdYfEL32h57Ni6Gn1Awqhih/IZHeFUenxtdZ9lOhue+rAnMSx2CBHTe1QsIBoo
         r83Cp/nifNT5AtfHbKVC0ipsTZp6ycsDtdZAOhH8AXXuyeudX6W3JI/NW1sHAPw+tsqq
         R52zODkbXnUJtyGzY5NgJLvmqWtBK+AuPCPxeUmKdLv3vEccM7uNADI7Sc7ZW9KlMdfk
         F6ZcCBRu9l//0c9505kXf4a7PETbtT4y0QfMxJaLz4QmeEpeS3axILCck/jlSEer/hbG
         YAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqCZkQam34X7Bd200BUIwd7m0iyaXsOBKajs3xqc3eI=;
        b=YCI/GqhWm+6Lk8QxSjvDM9q0Un+qyT6dVyPhvTKBbCG3MN9sAtphkmFvY9FDFwP4TO
         Dv0oPnku++MhvHVp01KHSGtuGPiIay5kH2EEtTG9GZqWNlqPN9emTpSbC7LafYLeoWWm
         XBzZqYksmtXmOOffMfV8Q01oxCKqWsH3GQF5qH4v3XS70P8+mgGrHMtZ8GZ82eBYfgfg
         6DUO8XRPTrCdihhDNM2vcp18+WbxEnBHoDIgEqYd87tINA43StVrfvhXbxrA///rxMpS
         ckygW9gU9TNHWO4bs/a/yb/jwyw4EwxUurp9uXayQq+xaKNKFORpnL0yML2vbf2NEHPV
         WIvA==
X-Gm-Message-State: AHQUAubPd+dtr2sXDoT5KqtT8d6nqN6slVBhooJNvbT1vxR2aDob/9nO
        cxTgaWBfgE0qWdsYhqMyvt6ifA==
X-Google-Smtp-Source: AHgI3IayhylVm8s5vzLnSD2obQATi986qVmsxzmPPX8fbDSSNN9weyF77qA/hPaXkwgx4e13YDKSYg==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr2302570wma.32.1549967948526;
        Tue, 12 Feb 2019 02:39:08 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:07 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 10/37] ARM: davinci: aintc: drop GPL license boilerplate
Date:   Tue, 12 Feb 2019 11:38:08 +0100
Message-Id: <20190212103835.7768-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
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

