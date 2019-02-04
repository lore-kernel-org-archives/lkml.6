Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D95C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666B72080A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="F1jCRjN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfBDRSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:18:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50537 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbfBDRSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:18:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id z5so714175wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cL06X0SvDGMjwFcjqHY6E+rz25qUhZDQqZhRx5iU7ME=;
        b=F1jCRjN8h8/nMYlj12bcajal+uotZrxHk42c9h4CQV3w8N7Jmhl4MBsR4mruIs8czv
         hhjG621Ul6NTAC3hqPzsV2JybtBfP7R9xaaRmKLv55C23v49ZEpqlSAgSudEdjW5+PhA
         ib8aofUBRsnb2QV4q7BGjpALJTTAYhMg2IuF9DRN1V4tN7bz4h6ktGxyQErwVqqFUrjA
         BP2S1QZbDfW6EsWZ0lhXx9E5orB7txQMiFTjx96NBKRhz/eJsKD+OnXQrR7wRVYadXHT
         j90ZyaPDWP/L9ByaF+9J3Ocdnk9szuX+zJloQ92zJwTltvEqIl8t+z12UxSYgNT5DssM
         p+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cL06X0SvDGMjwFcjqHY6E+rz25qUhZDQqZhRx5iU7ME=;
        b=OhislCHK5V3QhGbXa/yYcszm6ii0h2/S+81e3UiOa/JVu/2zbojdQlPmdazTLOBQ6L
         W4U4g/ED+Rzuqc9bxmMwmAwrFU3Ylx530drxYClX+QaGO3FRal7LdVP0Lf+kwsGQtJlV
         9isDivlZy2qBmfpV+AvYnoU85YlKls/vE7woGBkLmZM9Ol1r3UY4V/h93LFrTZhFOJQj
         Bwrf7Z+rbeuaw5YfU0EFvb0u9qjJxXroF5SYn23DYpcYwM7NglhNkzC09dlto+f0IAjB
         ufDdX8NHfU3gDqnt4LRbPLOQRN7xfiIFy4267pFXo14Dw497FGnHWkffQ+aHmBlxWfuK
         4iEQ==
X-Gm-Message-State: AHQUAuZfduI9iQE6COfenimi2CT46Ux6p7V2rsyu2Idgb5mTKlWN0UxG
        IB4fUG+qD00PEmp86bDO5gkqfw==
X-Google-Smtp-Source: AHgI3Ia+a096I3KabgzhorfVAQJI3FLct3YvppdB9aSJOuW9Y77GT0Q4bikWwc/27RSP0jRxc99ElQ==
X-Received: by 2002:a1c:570d:: with SMTP id l13mr307866wmb.139.1549300695211;
        Mon, 04 Feb 2019 09:18:15 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
        by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:18:14 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 07/12] ARM: davinci: move timer definitions to davinci.h
Date:   Mon,  4 Feb 2019 18:17:52 +0100
Message-Id: <20190204171757.32073-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Boards from the dm* family rely on register offset definitions from
arch/arm/mach-davinci/include/mach/time.h. We'll be removing this file
soon, so move the required defines to davinci.h where the rest of such
constants live.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/davinci.h           | 3 +++
 arch/arm/mach-davinci/include/mach/time.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index db4c95ef4d5c..dfd1b1ab7b59 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -60,6 +60,9 @@ void davinci_map_sysmod(void);
 #define DAVINCI_GPIO_BASE 0x01C67000
 int davinci_gpio_register(struct resource *res, int size, void *pdata);
 
+#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
+#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
+
 /* DM355 base addresses */
 #define DM355_ASYNC_EMIF_CONTROL_BASE	0x01e10000
 #define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
diff --git a/arch/arm/mach-davinci/include/mach/time.h b/arch/arm/mach-davinci/include/mach/time.h
index 1c971d8d8ba8..ba913736990f 100644
--- a/arch/arm/mach-davinci/include/mach/time.h
+++ b/arch/arm/mach-davinci/include/mach/time.h
@@ -11,9 +11,7 @@
 #ifndef __ARCH_ARM_MACH_DAVINCI_TIME_H
 #define __ARCH_ARM_MACH_DAVINCI_TIME_H
 
-#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
 #define DAVINCI_TIMER1_BASE		(IO_PHYS + 0x21800)
-#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
 
 enum {
 	T0_BOT,
-- 
2.20.1

