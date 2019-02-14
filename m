Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE7BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DB32229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Q+8OvKcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407377AbfBNOxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:53:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42935 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501902AbfBNOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so6770567wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9OS2j5P+OKbS15xo80RfyEYHigP9NlBVGu1ltrl0zE=;
        b=Q+8OvKcYMz28eCikUsRT1SEzESuFixDZIfGn2mWPLwiePWiXY2Z+DV8xY3knuo2lA1
         ze+MmpYyyBstJXXRa4nJ/pOd2O38Je13IS2fYhCny/msqIQXriVxc53C5SsQRmOzjJIH
         ePYJu4qzem3qk3GPG0ZlqESpwQtnjy8pufCajzE+lB4mYPnam6xLvQn3PhnVikSkpq2h
         3b4Mi0M3B1zyrvtJ2XgyfCMXQO7O0k734shnRyXnlKJ2LOE5TfF262UhDtm9/AAHnZ1/
         4DZPATMr0BxxNhmI8Oy/qiFDVD/kqZ02OymPzrHsiv72FRecGQ19wW8F6efjawhJZM4Y
         MJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9OS2j5P+OKbS15xo80RfyEYHigP9NlBVGu1ltrl0zE=;
        b=KXKIqH1ZmGa/RE9Aur7cqj7yARyZm7q5RO3hCBTkJqqUWu1/WzcRNVcGcegeArJdUe
         WOUgJPHCvg39+Zrcvr0rPIfMucFxUkmh62X62LjbBia+el5fyeBCpIiw7BDytA9t0LOO
         HvKlwZmz5iXSKnWOe6xYmPilyL6dtdex/EdDpKko0Y9wOO08rP0pRAgyjqird0ial2Y+
         DcHZas2i73CcEjN7mnna+U/c1qmKzkxlztwoSWny4ke5st8GqwbcDNtss5TV2TOFbkKn
         +rPT28+nqtBsMNTOdeesGi48gU7655+GJznN9U5BMkQegP/w/O/Pbo20D0S58eF0CjWO
         vmdA==
X-Gm-Message-State: AHQUAubdXosDLSthNP0RUbsY7LGpF3lHJ9KBNR6EouHLlKUwKfug+hwG
        MbevEfkBG4yZu59LjtY6AwWK/g==
X-Google-Smtp-Source: AHgI3IYUNJ6gjMu13DLiX/0O8K+lGwumOsQ6vq6uhsteUkOicKJHagr5JWdJnaG6j5EokVVTE/ahhw==
X-Received: by 2002:adf:f40d:: with SMTP id g13mr3168099wro.18.1550156003257;
        Thu, 14 Feb 2019 06:53:23 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:22 -0800 (PST)
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
Subject: [PATCH v4 34/37] ARM: davinci: cp-intc: drop GPL license boilerplate
Date:   Thu, 14 Feb 2019 15:52:28 +0100
Message-Id: <20190214145231.8750-35-brgl@bgdev.pl>
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

Replace the GPLv2 license boilerplate with an SPDX identifier and add
myself as a second author.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index f88b7f0978aa..eeb3351016f0 100644
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

