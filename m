Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AFAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1742229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Rvul6yt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501977AbfBNOyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:54:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46158 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439561AbfBNOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so6753697wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aM1xrGIBo2FFuSsmFTHMz/H1xNta7gzJkLnZYdQJhl0=;
        b=Rvul6yt72Uwr3bRtEJcC6I1BHBHLO17zBhrTDZp+43ywZo0tX7Nc1nfQaV1nQfdMg9
         KAqsCKeRnHEk33COzaf+0D3Oyn+V5g6J+4tKCe3/EZaqVfUWINfzl64oqlqrF4FW/C0V
         qer9hhgHSjxeAoMmS1Cj0HHYaQt73qlwQVo5OV9pDV++fYAVvxDrFsgYWOgMe1LztAKX
         u2Lp9BWwY8O7llkhdOY6DUMADHclTrCF2I7jdLPTAFKRKG9L88TX8GW+x6+Ef4XjjO8G
         2j6rwfOQ/uixpmalXr20n2FaTk6ugI2Qq4zPtCiH3uGPwYXc7VHcLPt7pR+p0baDy0mu
         dpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aM1xrGIBo2FFuSsmFTHMz/H1xNta7gzJkLnZYdQJhl0=;
        b=EwNis4+6fiTrs+xy2LMCyHHmxA505XOF0Eqi6gw8qo7p3yR6qujz048qJVDDuGjx1U
         gvIKNoKDFPT7e+dQT86E+Yy0E+G2Av//6dJS106dCF4sgSMpy4CK+c+c8an+jlL6qE22
         Is8S/jPEkmSd61QcSCPJmzBrWzZLXOPA+7m0DJLqZeGl05u6vxP28aDlgJ43MG/o34eC
         n0o+Y2lhUcDJ/ifRKi+Ql09BLxF9kc1i/loZW7MZM9EW6l9dSrlDtAnfQhDPE23sP8H1
         yXd+vISklZBehGhX2M3qVYzmEEu+xOfsxeDmavWDM0yv1uqOBtVt4974oGlG/uJAP5+u
         JciQ==
X-Gm-Message-State: AHQUAuaQt6P2uoZ78dEAjvkaazwAYmoW2ihTA0NLnROIJFZ+Lob9UbQ3
        3VWO6BRZLHYqbrm3Xlg3xkqizw==
X-Google-Smtp-Source: AHgI3IYrmPhX6LitBswpX2LropaG4cWp7UbgyexCuEbIsp79u6SnchGmw2yORC9r4/JJ/EwEmejPcw==
X-Received: by 2002:a5d:5506:: with SMTP id b6mr3015045wrv.33.1550155988226;
        Thu, 14 Feb 2019 06:53:08 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:07 -0800 (PST)
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
Subject: [PATCH v4 21/37] ARM: davinci: aintc: remove unnecessary includes
Date:   Thu, 14 Feb 2019 15:52:15 +0100
Message-Id: <20190214145231.8750-22-brgl@bgdev.pl>
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

These includes are no longer required. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/irq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 92b6e653d8cb..810ccc4fe476 100644
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

