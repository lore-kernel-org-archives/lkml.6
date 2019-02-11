Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D619C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7BF2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="v+foSweA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfBKM0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:26:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45956 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfBKM0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id q15so4440934wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krZKYWoU8pidQJSuC93zX28N7u3H16YP6+0fJKp65YA=;
        b=v+foSweAwlvLRYK067ZEY421O7c6yQsEQ2J3Zc6Guw8DCLrNAlsM/cL1gjLlP5QlKy
         nfEBCwyUMiuslK5XPkwn9nIH3bisP6+hVvu9p3Q812crvhpCneAkVDr5JFupnXxpwSAh
         iWMnD0akRTrSPeWeB0delCZ/+/M6b3bRERwX+wJZHl7f/ogkSX0YPgAtBCFsfnUeKNUG
         u2Hoolx6LL0CuhrA36b0VVIfLwBQu5Xivv0ZdjENk5u5LHzw6XAGLiPYjwrsqtDZLKOF
         ye9V42Mbpxa4qK5s/dhEfHrO28cmKk1CGhBDHEwitsaxgH4NoSJ9mD1y6b83jGS98M98
         2I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krZKYWoU8pidQJSuC93zX28N7u3H16YP6+0fJKp65YA=;
        b=YFQTv8+P0Dx8e+95JQqYmPPX2FAL9EqC4tcbSwEBNSuanvgdhoS7mp7fZJfGhBHoRk
         0PDPoDvVZIL4AONFtm2Fdkwkdy9elTdFMl8mLDKsltM+LP2ODqwxZV/WZiGPhUApVCM4
         SMzMB0xlXoDkLIS6Dc4R5H5G0yXA3sYPYylFknmfPCu+1XZaQLzO/78SaXGTv3E7U0Vq
         eYA8TPTPMHgNdhOMCwEngDOZPFAgv87VTHxm3y+VB4r88sQPl1cml7vg7SNVu/uqrFzR
         FOdWKEIDriS/ufUU2KauJhokiVSLfN31KtLsSEopVwUhDBSqKxih67vIXX8/G9/hUY/t
         gzMA==
X-Gm-Message-State: AHQUAuYSswqzFGilU6tZey+erj/vlc5KgEBT/0uEig55oHfyDofyB5Ru
        0CBhUA6t/nQg2Fs4u0t/qns7pA==
X-Google-Smtp-Source: AHgI3IaAQHSdGcRUIgcdYvZNxlXj6H4KgRs1wEYKfsoBZw6wR8VkvZCUMVhkm1hGJ/OCUOvAlE9fHg==
X-Received: by 2002:adf:dbc4:: with SMTP id e4mr29296689wrj.320.1549887995641;
        Mon, 11 Feb 2019 04:26:35 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 18/33] ARM: davinci: aintc: remove unnecessary includes
Date:   Mon, 11 Feb 2019 13:25:51 +0100
Message-Id: <20190211122606.8662-19-brgl@bgdev.pl>
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

These includes are no longer required. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/irq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 0f469c59acfb..0768edfc3b66 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -12,10 +12,6 @@
 #include <linux/io.h>
 #include <linux/irqdomain.h>
 
-#include <mach/hardware.h>
-#include <mach/cputype.h>
-#include <mach/common.h>
-#include <asm/mach/irq.h>
 #include <asm/exception.h>
 
 #define DAVINCI_AINTC_FIQ_REG0		0x00
-- 
2.20.1

