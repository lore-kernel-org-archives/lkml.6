Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCC9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EB320867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogiDF1kM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EB320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeKYWdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:33:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34732 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKYWdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:33:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so5220812pfg.1;
        Sun, 25 Nov 2018 03:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+572idReg0X74MOoL7Y1Sdw4yAedED2G+PJTcyR+meM=;
        b=ogiDF1kMVinvyb1Jn8E6TAmDjtqvgYUrFVPoJQhGAnwdcAGfNxOnHfDL/8S+FbElHo
         sGsBuGCOwUvoenrhqJTmbP+0ASh3ZGB+GS1l/AqqMdIXVOuXNSDmTLtl9ayT+LZUQoM1
         Z11mr7rK4GUoo/Gf3j4ake9dm38EzwlQyPI9XpvUuMdMWQH75KAfi2yrNwg9n2LIbvXo
         YeWF5BCJT+fn3sIJ3CaGnP0xdGpVYGRtdI5HcpvrZgXSLnngHEUSLM9uDlE9wx9kavH4
         M7P7Hn1Ru0XAsr+bOleLI8vt2AxEF9v7OgBpyW50xdEhyJxJjpzd/Apcc7ZIswovjk6a
         /5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+572idReg0X74MOoL7Y1Sdw4yAedED2G+PJTcyR+meM=;
        b=m1NbJwVfpOHLrrrBltigcECop0n4om2Uh0hOIlDwwYQsY9cgJg1QqvbFecRwk2fgFE
         yhOK4vNElMD8qXyvKfxmz4o8rwxIVJR1TqMzhjPXsjYVt+ntVuam9hWMwUBPf5FPyd3m
         VGTAdOpmIj0pmTVhXQ5pVD9E9bBAk5QxETjKaiKsObY6qAsgvM2iIdjgObJ+S4/EI01U
         D3cq0uJr2QURxfUamRu9RnmqkxwNhFDvAepatsSB8N21JKXTzAfp8HNJkhBlWpAVFf6v
         WPiFgavBrdEqUsSUwCb2R8h2u4084bWr+wKjR0nbnvfWGZjShNgae1A9TtDfJU4cEJi1
         y23A==
X-Gm-Message-State: AA+aEWYDvSJFUVQkbbvoGSXUtaAel6K6xlE7xyFtB2O/aoWfGf5rJAM/
        Fgdn/lTrBK1eosOFSjzVWpz6/KbshNYoig==
X-Google-Smtp-Source: AFSGD/UFakaEaXly/hk32srXj/fAxpAsOybqEckPlSGve51H3v/Y7Vno7P4B/tcHzErU1QJV1thfkA==
X-Received: by 2002:a62:3ac1:: with SMTP id v62mr19289542pfj.87.1543146135232;
        Sun, 25 Nov 2018 03:42:15 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id i189-v6sm91012543pfc.16.2018.11.25.03.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:42:14 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:12:09 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 23/26] Staging: fbtft: fb_ssd1305: Switch to the gpio
 descriptor interface
Message-ID: <1abc12c3f5290b1eca9b8d737dda0ebe146e340b.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_ssd1305.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ssd1305.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1305.c b/drivers/staging/fbtft/fb_ssd1305.c
index 3515888d94c9..020fe48fed0b 100644
--- a/drivers/staging/fbtft/fb_ssd1305.c
+++ b/drivers/staging/fbtft/fb_ssd1305.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -168,7 +168,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 	}
 
 	/* Write data */
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 	ret = par->fbtftops.write(par, par->txbuf.buf,
 				  par->info->var.xres * par->info->var.yres /
 				  8);
-- 
2.17.1

