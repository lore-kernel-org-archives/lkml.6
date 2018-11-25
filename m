Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42276C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE06E20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssn4twpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE06E20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeKYW2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:28:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39826 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeKYW2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:28:45 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so4850764pgl.6;
        Sun, 25 Nov 2018 03:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qCi7oDyTc58B0rVilB+8XFSOvbyYBw9Cm4Az3esZHqc=;
        b=Ssn4twpdv27HsAjCF4CyrPIjS3wPV88q3//C1j8duhRC5Pki3vvpM9UMP9B1n1zJfz
         SDYTO66SEHBE5Myr6sehrTL6HDstPELNH+9Wc7EXKoDgaJtvVRSXcu85og8Rd2oy9JMX
         n4iDG7SiISsi33brRDc2WcW23WrcGX6lQsPEbX0V2JyYQehmnDwqwT0gXUsbCedjcaRX
         BKypX+asEEEjfS9dMWVDmD06n3VU3JGYhPky1XXYHIc8SPhTvTE1itxj4aESSCGxKOlj
         V8Gtbp/WLxZsvR7ymPwwOKvqXKMh8nRMYAXCAc/Xtxr4RCbm2f99epYPom8pQpXHai+U
         Vkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qCi7oDyTc58B0rVilB+8XFSOvbyYBw9Cm4Az3esZHqc=;
        b=dvPb+MooFWxFaqwjLaM4r0PpQHJaGZA/JpOSb3XA9u6zzpGXWkSpQ7e7IFgFBSN2hb
         NIuVsZmxRxhUsZQLWCAZeYrPZAF2jvpU2F4zQIpma34dMRNFpWXL6BtDgsp7xz2ufTzU
         sf9ZOimQdCS8WQebZfmii+NEswQT/HzANxoxtHLfQzYUns2gqaIwjLzFiy/LVj0sgdLm
         nO6qqPh3c8Ohq3Geb7jxon21YMxk0Ezl+dOqqNNfod2BkNMXCck5hU+ct67uhK99soys
         Un0Fy4HDTZrvXCGJRp4NO03rfBbqEkc8Z0ucsEJvSXxG0c9cgeBAmAbhbqkw/rXZhR29
         x4ZA==
X-Gm-Message-State: AGRZ1gI/uSyWu3dhpilf1AHDYxc3vUdQ9R8lipudEKuKqeQ1xXj2z3f3
        2egmwFCySJQ8JJKWMxUzJ66T67xYWrLVmg==
X-Google-Smtp-Source: AJdET5emgc3v7+dHAcuiMoBw6XJ+rep9hmpClD5NcY5tXn64ke7Fgw+vEiujc1o5cGttxvC4TD6r7A==
X-Received: by 2002:a62:2781:: with SMTP id n123mr23705936pfn.138.1543145871517;
        Sun, 25 Nov 2018 03:37:51 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id p15-v6sm100361867pfj.72.2018.11.25.03.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:37:51 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:07:45 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 17/26] Staging: fbtft: fb_ssd1306: Switch to the gpio
 descriptor interface
Message-ID: <e1eff99fabe75d10908fe03cc646edb3ad0f6c45.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_ssd1306.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ssd1306.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1306.c b/drivers/staging/fbtft/fb_ssd1306.c
index 50172ddd94ae..d7c5e2e0eee9 100644
--- a/drivers/staging/fbtft/fb_ssd1306.c
+++ b/drivers/staging/fbtft/fb_ssd1306.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -190,7 +190,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 	}
 
 	/* Write data */
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 	ret = par->fbtftops.write(par, par->txbuf.buf, xres * yres / 8);
 	if (ret < 0)
 		dev_err(par->info->device, "write failed and returned: %d\n",
-- 
2.17.1

