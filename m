Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77366C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B21B2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LDQuT2pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbfAaNkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43642 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbfAaNkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so3298463wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2Xh/bADBzCrm3hKxGT4g5SPR6uE8yywQw4yqUJgRK0=;
        b=LDQuT2ptEwh9NF1JFEiGkKxl7h2tRCIljF+tOMhMiKr2Fb16f/N1+bb0JNGMVFX70T
         hrMgSazv1p25WG6lo9thtuBjBPYV2/n6ixKUiL5Dgvwh0rT6orexRJOmNel3dh+BzpD7
         jurEFlxuK7vKUAZihSUt/l9oN5WQWHc9boQC1b5pkI2fxD2dUQZHbGyv15NHB5oHCuNi
         a1GrJPmy3SMd1dSOvu+IAspEk8wRU1J08XyLbaJluKhwWCAQr00M4MhvhTIRL6IbJPev
         3+2kTrgRsXxvdWQ5xof/gpQ07DFY2aLMRlxzNfmY8vuWONTJqfioHQkonY0+kMA3E0le
         Y9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2Xh/bADBzCrm3hKxGT4g5SPR6uE8yywQw4yqUJgRK0=;
        b=V2ozXRFRuGJMWzT+MDNWtGbqtR8kVld+kkZuCdF5sQH3sK/fQnHflXwUVRcQH2V5uQ
         Nf35sHZd0f6Hl0FbpDHfw/GKcNLpo9uk2wao2XBNn/5SnsQY3pmMSXHhJnl+5ZkCHpiN
         B8v53KRLe0YVVWNeAR8oMIl4jLQRd4Vqzi3Ooy79hhp3vxvBIjNX1+fJQaENL7xWF950
         rPRmTs+E2XHt8t42wEm9skJohAygqL2ohOIuXeuLQpYNGWeYOXRG27p1iTpAMvDzTUoX
         fzqjPTiEG/5yYHyHJUyTDAV/gmq9hNA5g9tfIqCjJAjLmfstkb9GVqOFZAeP0S6f8gQA
         Tkzw==
X-Gm-Message-State: AJcUukevAUvQE6PXIF+unkCmGK4/NQd2LjLYsvURichkzLRgq+5rrNOF
        dq77Eb/qLwVow+UqV+lkHfL7CQ==
X-Google-Smtp-Source: ALg8bN5h64yQsKQBbQ0yLFAe7JMo8Th/nncaNStYFuEj0CyTQd40wFF+daLlnxbSRiE94SMeJfoR+A==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr35274858wrw.123.1548942015818;
        Thu, 31 Jan 2019 05:40:15 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 29/35] ARM: davinci: cp-intc: drop GPL license boilerplate
Date:   Thu, 31 Jan 2019 14:39:22 +0100
Message-Id: <20190131133928.17985-30-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Replace the GPLv2 license boilerplate with an SPDX identifier.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 812e49fcaa8b..780b3f57aa59 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -1,13 +1,11 @@
-/*
- * TI Common Platform Interrupt Controller (cp_intc) driver
- *
- * Author: Steve Chen <schen@mvista.com>
- * Copyright (C) 2008-2009, MontaVista Software, Inc. <source@mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Author: Steve Chen <schen@mvista.com>
+// Copyright (C) 2008-2009, MontaVista Software, Inc. <source@mvista.com>
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+// Copyright (C) 2019, Texas Instruments
+//
+// TI Common Platform Interrupt Controller (cp_intc) driver
 
 #include <linux/export.h>
 #include <linux/init.h>
-- 
2.20.1

