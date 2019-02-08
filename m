Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BA0C282D7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E104F217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="y4N1WMiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfBHRgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:36:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50521 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfBHRfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id z5so4366510wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DCvcInryiKJ5GrPJy1j5iG1WoHmXy8a7aJkXnmpsZFc=;
        b=y4N1WMiLVk4c5d1EH/eZBPxa1swvSZh6hsrRHejgMW/Ko4MWV0Kdm7JVpTJlp2McBz
         yY2zewtIRFF/IPHNLMs1HtFG9cQsPQ2jV77ncrQOmfuGr1pQ+gpt8g8nHXHd8uUDnCkq
         0LaBNxr1ySH4nOPtF/KADGhob5HRqItJFbLfmG3gk4+bsytvaWwV2WcHeHL7qqwTAjLm
         RecOGFo9KtVvp3qg7gnmWAMDpNdsBS2R1N7k10FZwuB4FACzpWeaW7dKibjnO3erxEzo
         7FVGY7qbbppf0b5sw0hKg1v2w3cvg2KAFuqBbXehZ6S/YQlG5sKFhr94EUy2+xSI3LWR
         Fbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DCvcInryiKJ5GrPJy1j5iG1WoHmXy8a7aJkXnmpsZFc=;
        b=MuYe9ytIGYQ/fzfOLj53M2rULdhO56bM3yYZ+x0l7wiZsLqyOkSARJuLl9rBdUlCfT
         Z/ZuvNUAHSNXRIRO0PTZLrOzI2qV2VeEVnfJRPcPoHbsNnjD9Zm6TtF3k7yrMfJAGBMR
         3qmIWmyp9UiLs7SLvSCmyzFEXki1hulYUmlcg9tDZVcVbyM8YESRBqem3Xsu54YmOsbD
         7WwoX24DMPbZUDRE/R51RPNumVxJUD3gXekW8WfVYa8HGEl0qFSAA4e+mjv/99ijOFZX
         wqLyelzo7HJo5PxtXL9qB5r0z+rP/DsrzB8j7xeBbVzDUHMI2wTCZTbe2jAk/suiYzje
         3zyQ==
X-Gm-Message-State: AHQUAub+LWZR9vo4cpAI8oyvJwAlQGJNOo5uUvVeuXdSJKSLFMDtC2W7
        bWABiefppahhC1KexE5BptzPeTixUlg=
X-Google-Smtp-Source: AHgI3IYsyQq0D/k2rzm+qjhpLW0sohd3DtivCeCHVbXGyN2yLySwVSdqTwIwvhSLHCJD7F9Dm/0w6w==
X-Received: by 2002:a5d:6244:: with SMTP id m4mr16924387wrv.314.1549647342125;
        Fri, 08 Feb 2019 09:35:42 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:41 -0800 (PST)
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
Subject: [PATCH v2 30/33] ARM: davinci: cp-intc: drop GPL license boilerplate
Date:   Fri,  8 Feb 2019 18:34:55 +0100
Message-Id: <20190208173458.4801-31-brgl@bgdev.pl>
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

Replace the GPLv2 license boilerplate with an SPDX identifier and add
myself as a second author.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 4bbf0eba1920..2040c974689a 100644
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
+// SPDX-License-Identifier: GPL-2.0-only
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

