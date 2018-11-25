Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8BBC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9714620867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PunL8fme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9714620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeKYWPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:15:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39800 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKYWPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:15:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so6222487pld.6;
        Sun, 25 Nov 2018 03:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ruZlVQBdSmUF/Z0DwV9S/yoSoYQ4BIFvk5eGKjRr8so=;
        b=PunL8fmeUy02K39t0aw/07dmPxPcHqWd+x5VXlWx18ldnveuboCJoayoXFxTkOMoEe
         yMcTO0MyiteJWdT2FS1liV84gerddPUnaMP4E2FoLEYXFLVU1NDQ0bTc7LH8sWIKGXXT
         WHNAk7bjzaHQtsLpFyqhtXGG1ixaS5a4zLnxoU0MHR3Xn8aC5gRqBL9+d3vW707RIxUq
         W/JT2iV2rPVPKrLyYWki59prh3bbqSFOO4oAM8BHW9VeKzVy39qJkvhfgKVOVuL2z+Yl
         S5zpmDxSALiyX9nhZ7WFZbZTcOo3u7uR/yaeU8NK2N9m6w+1B3kmhH36vsQx3ylWEXtA
         nBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ruZlVQBdSmUF/Z0DwV9S/yoSoYQ4BIFvk5eGKjRr8so=;
        b=jSY/1kdF3+VO+23uRn6uMf5Yx5Qc37SYWRyeqpYtsYL9MMmRNBopwHKyEqEM3SXIHK
         H87+h+Qu1AxNhkJM68c/5zMz4lLr1vVLKdsSJCOUd24Zm/o8mmlmLVWMAM54al57K2AM
         um+OweBdBJ5dEZQXKJs8FblwTtOhVRBZtYOlFANq713smMHw2ZbOtdB2H8HMt0LbZ+Cu
         m+AXOP9miMqhZB3bkuU8HyTQEWUboz6SkK275v8qfv/2EXrF15+S8rk5EAf7NJX81mDK
         sEqvETbDc7mIkQF+DnmdZCq5gsVbA079dWkEsR5DRyE+EKHCOGCj86F3vbQTrWXpn9X2
         Fqag==
X-Gm-Message-State: AA+aEWaKbhUyH3rhf7Azq7SqEuL9soJn1Qbl2zdNmtamLgDXF9+DsAv0
        JNxb/fZDK7HVFn2v7u/3X4r0K6z2pXHXvg==
X-Google-Smtp-Source: AFSGD/XxJS7hZ7twVxrfhvgBVwME9yIB4Hr8TivJlwWbYmbVwoFiHk9uY4hMo5hE4A/8OUFIJm6xeA==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr23633464plb.335.1543145069756;
        Sun, 25 Nov 2018 03:24:29 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id y184sm61041688pgd.71.2018.11.25.03.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:24:29 -0800 (PST)
Date:   Sun, 25 Nov 2018 16:54:23 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 02/26] Staging: fbtft: fbtft-bus: Switch to the gpio
 descriptor interface
Message-ID: <dbf64d73ba8d86609ec0aae1876ab7aaf54c6c1c.1543142440.git.nishadkamdar@gmail.com>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the fbtft-bus to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 8ce1ff9b6c2a..2ea814d0dca5 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/export.h>
 #include <linux/errno.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include "fbtft.h"
 
@@ -135,8 +135,8 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 	remain = len / 2;
 	vmem16 = (u16 *)(par->info->screen_buffer + offset);
 
-	if (par->gpio.dc != -1)
-		gpio_set_value(par->gpio.dc, 1);
+	if (!par->gpio.dc)
+		gpiod_set_value(par->gpio.dc, 1);
 
 	/* non buffered write */
 	if (!par->txbuf.buf)
-- 
2.17.1

