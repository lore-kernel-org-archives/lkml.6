Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A34C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028A52084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8AH1pOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028A52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeKYWTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:19:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37944 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKYWTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:19:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so4850437pgc.5;
        Sun, 25 Nov 2018 03:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yypVDYNEwuNsOFUaoUJ0BiktqZpqR8KebM36sOj/SUc=;
        b=B8AH1pOv8YvBHhOtZuHLgaFjpsxaK/rmz+ALdEuQRf/ticppLUGdlR+o3Wvg66rSbl
         G2m8qRFhDIIH3zLw/GdLW2lr5+REVC1phCM5l/di2/5j+dm0+rYHmHQJGgQDRtAoXtlG
         2WLIWSOXGDTpkqrfBADC/bifcVdqMsHjWQMiFdzBXAZLxYRSn7RX5CyKQzunskqD2Zhh
         S4q6W936Ss8tnFzK1id4ImrQhj5+TvHu7F+7xa8i4pwNDwcEQE6Uq7LAQpSVZPVhFWLg
         sqKXb8dtD4cCQY7Wtd4/gNP26FyqV91QLhhngaLwyTfq4XSllwEcUlYqm58fQm5lIlwd
         rYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yypVDYNEwuNsOFUaoUJ0BiktqZpqR8KebM36sOj/SUc=;
        b=BCJxP20EnCeqsboX3k171nVhmz3XzXp4O9XdRvirs7kTdeONtApdODVcc8E5fkzNIa
         qM2TziRVhxl6Pp8pm+SFPSO96Sg+cV1EjszHjgFC/4BLB+QRZFvx2LVrAPMsguFCftNx
         lS8uZCjp55i5YYmWtB2W3cYfO3hyhiiIxKqElG5Q5LFFkaBtlodtT/Ia1qzgsasC4Wl/
         He9tJs4AdH7LF13sf89yzYXN8BgWQ4foNOdCqVpC+YfQQL+EXWniJbi7MZyXDyMAZZj5
         mdZpwodov5W1ZDrPIMnV5HSmjsmLCid2o0v/ikHzGcVsdQGK4fu+N8Wx01GhFLdRhL9N
         bN1w==
X-Gm-Message-State: AA+aEWZnvdMmTc17AQ7FBWJ73WXLG0MWUotPnwWCyOeIgeND5RvRhNBb
        XJsAvj3ZSjWmk+sk5F9rV1s=
X-Google-Smtp-Source: AFSGD/XHHplpC6lLoiOi88CI6KJJ5ofJZMD1l/UkFDfxj1jRvBcIuJNiCCe/i1onDH/ekSDbL0N6fA==
X-Received: by 2002:a62:931a:: with SMTP id b26mr17405632pfe.65.1543145300141;
        Sun, 25 Nov 2018 03:28:20 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id s2sm49973892pfa.167.2018.11.25.03.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:28:19 -0800 (PST)
Date:   Sun, 25 Nov 2018 16:58:14 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 06/26] Staging: fbtft: fb_upd161704: Switch to the gpio
 descriptor interface
Message-ID: <87f73bf1fb0a79eac6eac5af9a376e68d152c990.1543142440.git.nishadkamdar@gmail.com>
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

This switches the fb_upd161704.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_upd161704.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index acc425fdf34e..564a38e34440 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -26,8 +26,8 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	/* Initialization sequence from Lib_UTFT */
 
-- 
2.17.1

