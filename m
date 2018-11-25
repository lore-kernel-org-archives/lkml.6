Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26FBC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04FB20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOJCjV8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04FB20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeKYWc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:32:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35352 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKYWc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:32:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so2235242plo.2;
        Sun, 25 Nov 2018 03:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gh2wc/jSHR8MY8+y/Ct1rHZJwBTxuebRuLrawMukGBw=;
        b=sOJCjV8s6jDOI1mP9ands7Y3YX0k/8tCeWb0TdIJQJRw+WAa5XM499ddRSE3OQ2kwP
         Ap/SPvkWg9q099SvA/fzzRT7pOfPThiIYIIL5JcVU+Td0ablFJ1QjLbQvVbrcI7w4jqO
         LFnYaO2nd6uk0aSKHwsvG4y4l+dV0X2EJasWg1FCPlUUP/yYuFjzVpL4wgEaX0Z9Euxj
         HbYeypJ9WySU9WxY7LGU5Ys8dcJR0qSOwTUYpBjT2Mnafx6OXZCmj6v7Ff52+fjYBhuJ
         +BQp7eBNoNcn0c8TRG3TVwHdxRc72I8mb7S4ZFE+2zs3vIvmwxfguSR2TCUEiLMhIMLD
         kfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gh2wc/jSHR8MY8+y/Ct1rHZJwBTxuebRuLrawMukGBw=;
        b=eGxs015MvJdeABvgVGt8y0t7WMs1SPFh7a+D9vtfKZe90siwZjbg7VJt1hnQcDiekO
         8rBTT4xDDHzrX9Zca9pbP7a4/jm3r3/ckhXq3qVHcp5QkRiFRxr6uUEoafgiWWUtwPL3
         csBCsti5pu25QIm/1vlG626tdCb7jRCcAzSEs9ioa2ZJwDsyA/3/gugr65Gen0Eu4Lyi
         yoA5ZhSdvoiK4tznLu4wxPOHlu+BeGqWoMq1vLDjZ7yM+7SPN4p4kgcrKN2z0Le8fKmT
         0UHlrOsTFNZzPM1y5DCB2BucN08KZHI/O1Vrq3+O0USeQd2c3fVKRQG3m8doHOCtkrgD
         vgfw==
X-Gm-Message-State: AA+aEWbRjBBSFQqTJiQM/Evr3wYJpeJAo4XBt9bCEhYXP8cJJTj++L1U
        xRbEkj3XOz/qHcoIAuH5KJI=
X-Google-Smtp-Source: AFSGD/UvKMtUZUHrkDC8Fm1ps6v6HT4w8HQUzx6+MRHoMPjzB7zBlFe9HJ9WdVDC8HxKsH711yWQRA==
X-Received: by 2002:a17:902:b406:: with SMTP id x6mr16684558plr.329.1543146092801;
        Sun, 25 Nov 2018 03:41:32 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id w185sm24343630pfb.135.2018.11.25.03.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:41:32 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:11:26 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 22/26] Staging: fbtft: fb_pcd8544: Switch to the gpio
 descriptor interface
Message-ID: <1711118a6354b75d09872e9c15c40c254129654a.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_pcd8544.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_pcd8544.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_pcd8544.c b/drivers/staging/fbtft/fb_pcd8544.c
index 32172f8f79f0..ad49973ad594 100644
--- a/drivers/staging/fbtft/fb_pcd8544.c
+++ b/drivers/staging/fbtft/fb_pcd8544.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -119,7 +119,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 	}
 
 	/* Write data */
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 	ret = par->fbtftops.write(par, par->txbuf.buf, 6 * 84);
 	if (ret < 0)
 		dev_err(par->info->device, "write failed and returned: %d\n",
-- 
2.17.1

