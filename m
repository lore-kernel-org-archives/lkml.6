Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329ECC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B272229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lAGM5Fmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501916AbfBNOx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:53:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38901 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501898AbfBNOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so6384851wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okUwTyEeH6/l1M7Q6lKQuzEi41SPX2N++dZHkl6IdSI=;
        b=lAGM5FmkFOzhuGm8hihDzDp24yLDTJRuRFhRnXooQn59nuqRkQdRXYjYS+8XDL3gTC
         zY3aEFFjnt3WX1j6Bo0B+ego9QaF5Lj/7K09jV2Tv/pHhH7u3SdFwIajiN+z+BdmD+iA
         HoF8FMrHBtZq4nrY6lLEr5jb1M5feRLTLEz9xk1qhWnUk95tpFTz1w+Ym2Eey2EyarEE
         CrhVAihTS6OK+qqN1pN3NnVxD+Adg0e5/NOUbeHxwZfuGYgwx1Q77YsMiYxo8ZiLiByR
         8Rd9G5MXFu8rXb6aG6wdBJdb7hoNwNR5GB7ql7xBvy6CV/JtRnwaWGfDbm4mWxxTuthY
         yqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okUwTyEeH6/l1M7Q6lKQuzEi41SPX2N++dZHkl6IdSI=;
        b=d5Oy+rKcmc3HpgVLIpClWPnYTv4HiXXJoM1Yz0x96nG+G0Tf40LdAIYHLdCPXI7d1a
         2KGaX/CXIpawCXMIm4wFWgxaMuRvA4HvBCEn1Jqxajz3GmEJUwKl808GqDpkskOHYGDI
         ac3q2eoS9glZtUtnL33Qyj+/EH51v35/sHO/RCLmbHSpAeo1w05gJmQZns8OLpS+NeoS
         aqBNC0f2JQyrMopcY52FUKYIhOqBsAMr1MdQYTRTd2JyoscY6BCh9frVIIPS0czN6LNr
         xfm+F1voU5vgDfTMkcsmzciXVG8+LVwjGIVY8e4Nm+/IdUdBGjcNtS4X6LB99et3Z8jy
         jBvA==
X-Gm-Message-State: AHQUAuYH0pkNdfnW72I+sQeJsxr2ctQlAzdzWbSGM3uZ1By6/TwErAyf
        XEKsGwim19zUJpSPhKQ1+hNXsw==
X-Google-Smtp-Source: AHgI3IYYMOKkHOZIFummh/UeZ68UyO57CsV/dlHGSXu0ERJ78EgGMLfWVhz3rlQDlK9MCkIowwD7ig==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr2953977wmf.105.1550156002069;
        Thu, 14 Feb 2019 06:53:22 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:21 -0800 (PST)
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
Subject: [PATCH v4 33/37] ARM: davinci: cp-intc: use readl/writel_relaxed()
Date:   Thu, 14 Feb 2019 15:52:27 +0100
Message-Id: <20190214145231.8750-34-brgl@bgdev.pl>
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

Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()
and writel_relaxed() respectively. It's safe to do as there's no
endianness conversion being done in the code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 1bf11fa8be76..f88b7f0978aa 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -45,13 +45,13 @@ static struct irq_domain *davinci_cp_intc_irq_domain;
 
 static inline unsigned int davinci_cp_intc_read(unsigned int offset)
 {
-	return __raw_readl(davinci_cp_intc_base + offset);
+	return readl_relaxed(davinci_cp_intc_base + offset);
 }
 
 static inline void davinci_cp_intc_write(unsigned long value,
 					 unsigned int offset)
 {
-	__raw_writel(value, davinci_cp_intc_base + offset);
+	writel_relaxed(value, davinci_cp_intc_base + offset);
 }
 
 static void davinci_cp_intc_ack_irq(struct irq_data *d)
-- 
2.20.1

