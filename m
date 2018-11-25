Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4676C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC362084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mgxc/bif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC362084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeKYWQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:16:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37359 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKYWQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:16:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id u3-v6so5208189pfm.4;
        Sun, 25 Nov 2018 03:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vw76Tev+d0mqnbRLVVripM3+SmfgYdN9yEyQ2gFNZSg=;
        b=Mgxc/bif2iMpH9x7I5xfQGAH7c8/q+rWZfMs7PWrHDNYcZRgxtXGHsOI+kiy0lU77B
         Hc/63MFFHntqI6zXnQwSeXyvdypGFqRYl2IjHVqKo1jNx6aovPkgUJSYlyTEcpCWzwMD
         4LIXKaA9gwDa2968FCzDZkwcprMijDdQmLilDrlbFEFh0yjKCD9a5qzyOcpcvFnr7B5r
         SNI/GT4X0j8PtXy1JqJulrOjJJs11GPMZVBVUz1UFMwK/2hY5PZU3xmvnzfueY7RyQvd
         b9ysypwHA1KEjyQ1GnNeusEo3/5po++GQYHWFXtkB/rjWpnVMnngZHQf+du8BI09+1U+
         e+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vw76Tev+d0mqnbRLVVripM3+SmfgYdN9yEyQ2gFNZSg=;
        b=IV4qLWW7IFuXg+2AQen7kZoPKSHW0jOJpLYKbiN8rWl1mKEeM7Dv9PYEMMZO8T96Nc
         gKaWuL36Ppd7/PfbUX3EoUdfbMakWehYC9hLAF0OYlTLOM/YiMVqyY+myn9qrLu2mi3w
         GRRPnTcDVC5hxOnO8dId4JKs+ikgAaVATpf4v5tqlC9Af8Xcjw50g2fF8heF6g8WnTJc
         jh4Knw3FCivYbvmKtRVDWweGYXimRcahjq7aXqtCRMrf7HdhV6g2XWvLrgUlI4va0a6c
         iEbNEu8817OK9WKh5N49Y0FrPFZdDTcTylKSZIr1sHoKiFIX5kodfN1AfAqPMOn7qu75
         OyPg==
X-Gm-Message-State: AGRZ1gK8cBgQOsjH4nLHEjtaPPvxrROetwvv1sBdoZZyUgbsdUsKav16
        XQD6J4+6aVtRnBsPBjQUTQ/crNzrQsJ/Nw==
X-Google-Smtp-Source: AJdET5eTVdfftlcKCDsl6eGFSekaotlMJBl3ryr4pt5VmH1HZ8Z2DnbwMRZVD5SJn5iIQFXJUooq1g==
X-Received: by 2002:a62:5793:: with SMTP id i19mr23483005pfj.49.1543145137702;
        Sun, 25 Nov 2018 03:25:37 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id g65sm208659285pfa.63.2018.11.25.03.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:25:37 -0800 (PST)
Date:   Sun, 25 Nov 2018 16:55:31 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 03/26] Staging: fbtft: fbtft-io: Switch to the gpio
 descriptor interface
Message-ID: <7f743e900391226084fc4f29a2a73e0231b6fe55.1543142440.git.nishadkamdar@gmail.com>
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

This switches the fbtft-io to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fbtft-io.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-io.c b/drivers/staging/fbtft/fbtft-io.c
index b5051d3d46a6..38cdad6203ea 100644
--- a/drivers/staging/fbtft/fbtft-io.c
+++ b/drivers/staging/fbtft/fbtft-io.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/export.h>
 #include <linux/errno.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include "fbtft.h"
 
@@ -142,30 +142,30 @@ int fbtft_write_gpio8_wr(struct fbtft_par *par, void *buf, size_t len)
 		data = *(u8 *)buf;
 
 		/* Start writing by pulling down /WR */
-		gpio_set_value(par->gpio.wr, 0);
+		gpiod_set_value(par->gpio.wr, 0);
 
 		/* Set data */
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		if (data == prev_data) {
-			gpio_set_value(par->gpio.wr, 0); /* used as delay */
+			gpiod_set_value(par->gpio.wr, 0); /* used as delay */
 		} else {
 			for (i = 0; i < 8; i++) {
 				if ((data & 1) != (prev_data & 1))
-					gpio_set_value(par->gpio.db[i],
-						       data & 1);
+					gpiod_set_value(par->gpio.db[i],
+							data & 1);
 				data >>= 1;
 				prev_data >>= 1;
 			}
 		}
 #else
 		for (i = 0; i < 8; i++) {
-			gpio_set_value(par->gpio.db[i], data & 1);
+			gpiod_set_value(par->gpio.db[i], data & 1);
 			data >>= 1;
 		}
 #endif
 
 		/* Pullup /WR */
-		gpio_set_value(par->gpio.wr, 1);
+		gpiod_set_value(par->gpio.wr, 1);
 
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		prev_data = *(u8 *)buf;
@@ -192,30 +192,30 @@ int fbtft_write_gpio16_wr(struct fbtft_par *par, void *buf, size_t len)
 		data = *(u16 *)buf;
 
 		/* Start writing by pulling down /WR */
-		gpio_set_value(par->gpio.wr, 0);
+		gpiod_set_value(par->gpio.wr, 0);
 
 		/* Set data */
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		if (data == prev_data) {
-			gpio_set_value(par->gpio.wr, 0); /* used as delay */
+			gpiod_set_value(par->gpio.wr, 0); /* used as delay */
 		} else {
 			for (i = 0; i < 16; i++) {
 				if ((data & 1) != (prev_data & 1))
-					gpio_set_value(par->gpio.db[i],
-						       data & 1);
+					gpiod_set_value(par->gpio.db[i],
+							data & 1);
 				data >>= 1;
 				prev_data >>= 1;
 			}
 		}
 #else
 		for (i = 0; i < 16; i++) {
-			gpio_set_value(par->gpio.db[i], data & 1);
+			gpiod_set_value(par->gpio.db[i], data & 1);
 			data >>= 1;
 		}
 #endif
 
 		/* Pullup /WR */
-		gpio_set_value(par->gpio.wr, 1);
+		gpiod_set_value(par->gpio.wr, 1);
 
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		prev_data = *(u16 *)buf;
-- 
2.17.1

