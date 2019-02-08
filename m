Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6E5C4151A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408A7217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lFbxxyY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfBHRgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:36:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35605 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfBHRfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so4335660wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6mmX1T1Rw0VrOeRhK3Cni5+zNNC71FKpECFu89Vdzs=;
        b=lFbxxyY3IxcUzFTBJLzsfVJHq8XWJa9p5gP2ToZJ8Ixw5H9OkMWk/36SScf0lAKSU9
         tSCiMlWCBkiFDEUGSaYdSCeFcmduT2HgRl1fLO6QSAEgI8jijHfXF6TWlCwqKKm2yPUx
         kXsSd7j+UxTLYk59MrbixZL68E220LLu6gyJAVlny9LdLIhPnyLcsfFvbMA43RFut5JL
         PI+C8PT3vqL8ro5vX1kXdE5psHfcC/hIS5+stS9Egky2Cj+TnoziMiIFIcaimUv30IU8
         6St8xbZY7h0iscYwhEkls2aP/7Ak/GZycpg+PqVn+xKYVPCFi4U4lRwo8PSp+l4SDRDG
         wuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6mmX1T1Rw0VrOeRhK3Cni5+zNNC71FKpECFu89Vdzs=;
        b=GSLXjZHZ1OIzTkeIVN7pqXB7qrmyciPoqGCBaGTyNR6Gh2tHG9y/UokuZUK2XJ6m9F
         sv3J87Z+uY/sLB/2W8hbWN82KCSva72T1PW8Peo/Ev4udnCOWCJsDTGZZyIjmi7hPqES
         cCRyPyiuZuRm+o7JKA1YQblwIUQVQEYQwSzofAS4VfDRsUcRL+yjWdwo4Mt2AYO7TZqy
         6iTN/axwY1kVVUYft+8x8VXlyKlt8/76iRHVotiHbwY+LtNxiqp4YrxBDgon/iFLHCxM
         YxeTC663zgEfGA1+s7i2LVVJq5CpwlvHn2iP3eamxkzsp55OnjMf3kahF4ZTGHc64A5o
         OX4w==
X-Gm-Message-State: AHQUAuYCDymzdEND/OnLgPnWxbZEFfR5IpoHIe41NMNmFeFrkuepTSkk
        vZydI0yNe3zswd5bghxBmL5CKQ==
X-Google-Smtp-Source: AHgI3IYGRu8V/S6RdIIYnDp1H5CZLu2k9RGp0lVcLanMUYYwQ3Uv6vJud5VqOIjcsIzKC00L0FAyVg==
X-Received: by 2002:a1c:f71a:: with SMTP id v26mr11681787wmh.131.1549647340841;
        Fri, 08 Feb 2019 09:35:40 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:40 -0800 (PST)
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
Subject: [PATCH v2 29/33] ARM: davinci: cp-intc: use readl/writel_relaxed()
Date:   Fri,  8 Feb 2019 18:34:54 +0100
Message-Id: <20190208173458.4801-30-brgl@bgdev.pl>
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

Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()
and writel_relaxed() respectively. It's safe to do as there's no
endianness conversion being done in the code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index c1efb9390655..4bbf0eba1920 100644
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

