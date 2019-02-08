Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08929C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA0A2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Uv+caocM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfBHRft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54591 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfBHRfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so4352837wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sTea19K3binG0va6K3CDh++GjnL1PDlQZK2LSFZjZkA=;
        b=Uv+caocMdpNFgkFDcaJqdy+kjNtdbH28LW8ltHIyMpiWHChJzPTwWTPs3EDSGGYs0W
         D+uOq9GUHN1UtLEiMSu2DldQHTmMJqZtvR3y/fqJcKf3GEMM5YE7DPFQIMYGWZMzE/1w
         DegtqUrBGLNyX0WNwi3qdhx+QildyRozNmpgJCMpDZN7yRDRttEUgQmxAkzdb+heUN2f
         sh2ATwDokioA10sQ/N4iRSYQSkUWY3rcaHEGy5usDh4KgIDTx0hy1SeFU8Mw0yIFHjcz
         Z6V3VBCBbqZyWSA4hlgj/e18I/OrYDwK8i2chGeVOCzjMaxKj5/cKDwTXAdc3rVF8VXY
         8pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTea19K3binG0va6K3CDh++GjnL1PDlQZK2LSFZjZkA=;
        b=ngz0HA3vWrPNyu7XHdy1N7Mfg2NlBU7GuscYwtWVtP6JPicv7JjUTHhhA5FKDnrBbH
         scjiZL6bn+qMl11TwGpPlQUuNW+8V9zkirtcQ/h8RrJBT6OcCJWKVjP8eN0CqaCYggPK
         Bw0vYLKwujZDSMncj026TYkZlfk0ixXtPzXkRyuIgAAxhnzzXI+R0fDDd+oQpWG9EYYA
         F+jKQphCKhAsLKZ+hwILtCSp7sy1kG8YvQ+2Ro6kjNAvtBPwZqXiayMxijwR+6N4kNGl
         f2Dfn70tgPHG4VTdrInZV/zKhmLGUSzTSrzdIm05LApIJpfjSS4SvaV696qZhogKw88C
         Uc7g==
X-Gm-Message-State: AHQUAuamm3RJydrswdmkh3aNdYNYyMSiRmaZi9AkEYpwDVTq3WevJhKM
        EQFnfLqTf4nm7EbmeF0S/JAyAw==
X-Google-Smtp-Source: AHgI3IZ+vYnRfDHz0S7Iaz/A7JLuUD/0qDbQw9Rt7EpJg19BgkyaCs1UV7Z9KwDxazSgCmLpn7Vu/w==
X-Received: by 2002:a1c:c4c4:: with SMTP id u187mr7529550wmf.114.1549647343254;
        Fri, 08 Feb 2019 09:35:43 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:42 -0800 (PST)
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
Subject: [PATCH v2 31/33] ARM: davinci: cp-intc: remove redundant comments
Date:   Fri,  8 Feb 2019 18:34:56 +0100
Message-Id: <20190208173458.4801-32-brgl@bgdev.pl>
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

We don't need comments explaining what functions with obvious names do.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 2040c974689a..e32fa3b1889d 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -57,7 +57,6 @@ static void davinci_cp_intc_ack_irq(struct irq_data *d)
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_STAT_IDX_CLR);
 }
 
-/* Disable interrupt */
 static void davinci_cp_intc_mask_irq(struct irq_data *d)
 {
 	/* XXX don't know why we need to disable nIRQ here... */
@@ -66,7 +65,6 @@ static void davinci_cp_intc_mask_irq(struct irq_data *d)
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 }
 
-/* Enable interrupt */
 static void davinci_cp_intc_unmask_irq(struct irq_data *d)
 {
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET);
@@ -201,7 +199,6 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 	if (WARN_ON(irq_base < 0))
 		return irq_base;
 
-	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
 					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
-- 
2.20.1

