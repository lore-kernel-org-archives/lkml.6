Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3745EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E955720867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBJLOHpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E955720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeKYWaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:30:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33579 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeKYWaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:30:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so4860534pgu.0;
        Sun, 25 Nov 2018 03:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qxUID7k7Y8CQCpEWwZjJonHxQp7oQcbmFgsGyzgEYWU=;
        b=lBJLOHpz51eLi1aCa9wPdmYe7q/2Tn8WnW9+YNsGEtImvXy/YObIpPyFn8n4auWoYD
         adS65M7oNcGBRH5TeQOId+vzaI5Gck3EIJZMRjzpFOU7W4BSmc8K0S7F1c461REeloeF
         W0Kqev0av75nvQxcZzS57w6B8j/mvz1GCpLKq8eDSggFSOcVjhDny1xa0uJZE6ICA/Rj
         Gltxrk+aUZaatS9cF/9Iw4FGeZBSDF6MIyLu50uNFsrMcxZkD4h7NNM9+a6PEnALLNFh
         RssfvG1pmtQdHQrYr2xJt7WO8wHx73XW028RLcdmSeSNEkH3Vmc3jkdN6HqN6iULHsQu
         ZBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qxUID7k7Y8CQCpEWwZjJonHxQp7oQcbmFgsGyzgEYWU=;
        b=HDIYae+zzjfwDGmnmzeUkNwokZvXpKWNyKtQccA7SqpL8TXuXJ66QodSFmLRRCeLhC
         6bfEVYdYf/KsyXv8/J55TCDIvfF8XGSiGqSvOinLXET75IscrT+fgBc3/Ja/dM6g3C8t
         B9xQR5zs8nLO9HooUg/41z9k3qEd6JeJa1sUPsYvS0nT0q5T2Syi0ccB7+osV2UNsInK
         QFNwqXiBq7N+rpfrork4EpAmJdfvAHwoMnTgHOm0TFNBk9pguBS0jGFD7iV5dy14nlHq
         /nNTEdNBaYhvERl8eZEliInVGfGDOvg8DVzW0xzY/kgDJzXOswHDJP0YW9tBpJ1cpsZl
         GzpA==
X-Gm-Message-State: AGRZ1gJ0ceYDZWRafqlwaJ6n38tP8CugeTzp29GuewnASzisrmj/vQdL
        +I1dR4TX/OXLwNN7ONjXtSs=
X-Google-Smtp-Source: AJdET5f/kGAVOW0h1BxZoK982S9vKYsArNAHWt0WxKUaRUYszLC1LH359HVfeYovirgpNaSz6nDK5g==
X-Received: by 2002:a62:c302:: with SMTP id v2mr23505757pfg.155.1543145947819;
        Sun, 25 Nov 2018 03:39:07 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id g70sm10629087pfg.98.2018.11.25.03.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:39:07 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:09:01 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 19/26] Staging: fbtft: fb_ssd1331: Switch to the gpio
 descriptor interface
Message-ID: <5727415d372ab17866b1f207db17030051331ef7.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_ssd1331.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ssd1331.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1331.c b/drivers/staging/fbtft/fb_ssd1331.c
index 0b614c84822e..9f54fe28d511 100644
--- a/drivers/staging/fbtft/fb_ssd1331.c
+++ b/drivers/staging/fbtft/fb_ssd1331.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -80,8 +80,8 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	va_start(args, len);
 
 	*buf = (u8)va_arg(args, unsigned int);
-	if (par->gpio.dc != -1)
-		gpio_set_value(par->gpio.dc, 0);
+	if (!par->gpio.dc)
+		gpiod_set_value(par->gpio.dc, 0);
 	ret = par->fbtftops.write(par, par->buf, sizeof(u8));
 	if (ret < 0) {
 		va_end(args);
@@ -103,8 +103,8 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 			return;
 		}
 	}
-	if (par->gpio.dc != -1)
-		gpio_set_value(par->gpio.dc, 1);
+	if (!par->gpio.dc)
+		gpiod_set_value(par->gpio.dc, 1);
 	va_end(args);
 }
 
-- 
2.17.1

