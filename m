Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD4CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EBE20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDbTlJ8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EBE20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeKYWfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:35:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41594 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKYWff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:35:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so5208490pfi.8;
        Sun, 25 Nov 2018 03:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5TeqWar3dO0fdR0lC/BCMiMXBG6bf5C4CJMHDM3xWMM=;
        b=ZDbTlJ8bbAkpAlECZewFM7pRmLgTQcQTymxXx0gbWHoO05hhGKdlsejWFHwXIFm91F
         JKt5SwMUuwRAJD2kDhm9GRFg4meFh1IhJE5lONUKbAGKtdawRCr2kvLEGzxQ3PYBF9cC
         hkWuLL54U7DBj81pZjCyU5xeOWVXnVAgblOUWG8BquV0k+isOJikr6dZa0CwuhAc98iL
         9nV7WgzdH85fG6jSgJGCKel+ub54j6cz/O7A2mYJ2Q51b5D3IsRVNBh6Y+ZEwV8Wa8eY
         FES9H/Tt54Ebxv4en5A7feujyzRK+dYX7IIJJnNf/iXtsSe+9BgE470vXcx7ylFMzRQa
         9Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5TeqWar3dO0fdR0lC/BCMiMXBG6bf5C4CJMHDM3xWMM=;
        b=bIKVGK3h91+rtyASBJvwJFd3c6fOGvufOCrwBX8z5Mnadm5/RMOo+qOG0w+8sTBvCY
         DkYZVy18BrtMSpKt5wg9Px+pDDqetAfwt6vsorVqldpl5pgTDxM28ZghKw+KItaKOiUh
         OdJd7zCpsNpx+M2AxFFs52+bvMCTJR8BJsdbm1rzFdlBYe2FMhVGekmjRHUTnpS4Whh/
         96FqxU/gPCGKNN15zfJopWhhn9LWGoHOVAoz0+BqgZrIWwEaNJEABrl7Q5UTHNi1L6ou
         Muo2+ZMB1c6hynnKNXDX6XPbIp9KN/RRdQ5CXycgye/JolcHAxmZXx6ok1BkVmnDpPNQ
         MKLw==
X-Gm-Message-State: AA+aEWZYZB7a5+NomXfexYD/N3tD88+MwcFan0+BVVv7pfB0pXt5LVUJ
        ns2jvGAk9xHebxDhOUJTRmEj9oH/Bvjazg==
X-Google-Smtp-Source: AFSGD/WP9N9YX2heUkvJpwExprI/Qk9Ry51ZATGpuRBKS4Tryy5FjycW/dKxFWM66z3XVomElQx5QA==
X-Received: by 2002:a63:d655:: with SMTP id d21mr20708128pgj.280.1543146280981;
        Sun, 25 Nov 2018 03:44:40 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id v14sm84405700pgf.3.2018.11.25.03.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:44:40 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:14:34 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 26/26] Staging: fbtft: fb_ra8875: Switch to the gpio
 descriptor interface
Message-ID: <d9b510e30805d4d5aea8544a552a9c1c49d9de41.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_ra8875.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 5d3b76ca74d8..70b37fc7fb66 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include "fbtft.h"
 
 #define DRVNAME "fb_ra8875"
@@ -39,7 +39,7 @@ static int write_spi(struct fbtft_par *par, void *buf, size_t len)
 
 static int init_display(struct fbtft_par *par)
 {
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 
 	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
 		      "%s()\n", __func__);
-- 
2.17.1

