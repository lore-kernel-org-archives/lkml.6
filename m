Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1554BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87FC2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jD/4E8Dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfBHRfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51895 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfBHRfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so4377600wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5xoYgZeFd4jbYH06UIuAag4pMtuSlF7B4aVziE0WwaQ=;
        b=jD/4E8DdS2MTQvD0NBcKMnWK2cKwqopPRaKfl+aaNLGRhW7PWtdF2k1Z1UQdWaBdcL
         yGPJIo0MXD4BFBKDGSaI7YmYrG9t1a/dVcf1C9Q72VmPAl2syn9C8sN8jJST6Ns5AVdz
         tbi/gIiyWgU73u2KVyf41OU+MPK459C0fyZFxQ2qXFKAcps0zFlpcbkWA8Pc2oD/HVsE
         qB8FFdyV31z4mOeZzkoFU932QrlCLJvhe3NsOx67jklQPzgzoucVGgEyoB5tV5K45+eB
         2Aqw86m91Fvn9Kz6CvR3YIjdddRFMbLdlQyTdEh4q/7wYjMm3qhU0T/vr881qdyXi5wN
         x40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xoYgZeFd4jbYH06UIuAag4pMtuSlF7B4aVziE0WwaQ=;
        b=YRmLxS0nvupHpCtSLgDZNxoZ2NdG9JHF6XPjHmmqL2wIREs3lOFAxyp4vxVCX8Fko+
         n4hMhTVTGP11ob8sE7c+l3E+QB18DHm8Y67U81i1FQnpkuyA9qFEFWXQ6/IlOjI4XngU
         vEIgQadUUA0k+AWryhbhb4T95eZrEluvMLdA3gZZkyZCRUcX9t0dwXebXv6IBSgSnIQz
         +yP2WmY2zPQfJV93Mqk9+asuwT3l4X4I7/MeNA19cjxvUIY5QT5BCVXj4whwO/X+aSDk
         5I4RJPUAlSehVL05RG47bXa/h204xJshutrxOIDoKcoWh9vo0DyQhF1jL3TZntiO9xzB
         2qMw==
X-Gm-Message-State: AHQUAuZkbdttt0li733HfpuC5B0X06jcRy4TnLAHNTGGZqzE3cEvIRAS
        bPXIYaIQsE+aAjD33QEbziZSOw==
X-Google-Smtp-Source: AHgI3Ib4uwqzIycD76Vwm/WlgnnMKFLp1gyu030lqPxI4JxPluFuqGuye8gSeDMn5wJkdBjI8YI8AQ==
X-Received: by 2002:a1c:5fd7:: with SMTP id t206mr13143576wmb.145.1549647321932;
        Fri, 08 Feb 2019 09:35:21 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:21 -0800 (PST)
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
Subject: [PATCH v2 13/33] ARM: davinci: aintc: use readl/writel_relaxed()
Date:   Fri,  8 Feb 2019 18:34:38 +0100
Message-Id: <20190208173458.4801-14-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 148c23728bdb..6a7205a844e1 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -36,12 +36,12 @@ static struct irq_domain *davinci_aintc_irq_domain;
 
 static inline void davinci_aintc_writel(unsigned long value, int offset)
 {
-	__raw_writel(value, davinci_aintc_base + offset);
+	writel_relaxed(value, davinci_aintc_base + offset);
 }
 
 static inline unsigned long davinci_aintc_readl(int offset)
 {
-	return __raw_readl(davinci_aintc_base + offset);
+	return readl_relaxed(davinci_aintc_base + offset);
 }
 
 static __init void
-- 
2.20.1

