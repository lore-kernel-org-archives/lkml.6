Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1301C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A06620865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihTMQzht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A06620865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbeKYWan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:30:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41481 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeKYWan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:30:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so12519371plm.8;
        Sun, 25 Nov 2018 03:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+pv8tzgPNpJdv5oYEQcNenqbg8M3Qth8oGrTAJrgcc=;
        b=ihTMQzhtmKVOWt8+xAIneJLMlGTmWZZGPydNYw9CNFNxUXoWQ0aUD+7cfuJuhYX8H0
         ftt3x6pCl1lqY/DE1pH3XUzzdlkKIkjmAdQQzAG2jQR9BT2XfGVTM/5vYRmr2pmBzvK6
         70Rf5kU+ZEN1eQ3/FQPJGN47tH2M0tBdMJA9+cM0hCl9MzG1iA9haqAh7CH7+xamLwty
         SRooL/4NCsXLiHGd1o6QZMM9YJo9wKZrt9YsWCKWutge65+FDaFXHE/wihU8pZOZLrOd
         3gfUkMFV0dGrihxOsAc9Iep2ZkC6mdh96HEei/FywzbIsrYs6jfEN9X2rfYL4PdCVhH0
         W9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+pv8tzgPNpJdv5oYEQcNenqbg8M3Qth8oGrTAJrgcc=;
        b=FWYUzMoB5NZV+uDMzcHYRK9Q2iZlhBTjAuGyyoW+gfLkUF7Eroa0tYH22lwvmzPVYG
         NlC7PagSBIOQPYV6RzzCLOA0R9R6Sh/T9Ch9sK8dsR2dZmFfUHeSl5+l/rWUcwYWBqoE
         M4gCEayQtioPJOoTZxfPq20ZyjMpBypqFlCidNVscKp5DyxsjEe5ADMTf7IUVcT3Rbre
         MpxZAktLCx2LyW8SI20O5GqTnw8RHbE1Pce9BNGgtVkzfy8LgpSngeZ3LEudi9iodXAR
         XSkfya8CXOZybgGkmXgarQlra6hlXNH96Wwzk1Qh05KdJVZHtRi7edUlD5CMVMW3AGJL
         KGLg==
X-Gm-Message-State: AA+aEWZEvEEl8SYjqeUp7VppL7MxU21PE7JZnoYmLTYXSf1E5rLBRRlG
        3pAuyj64iy6Ndf1108fzHOo=
X-Google-Smtp-Source: AFSGD/Wmcl3S1P3YteVP8ZYwUrSqQXxSd2WzGTmBcVW6dujx64E3DXivujdK/3D1wcFrgs7GqO2hOg==
X-Received: by 2002:a17:902:6848:: with SMTP id f8mr22676712pln.300.1543145989552;
        Sun, 25 Nov 2018 03:39:49 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id e123sm60598760pgc.58.2018.11.25.03.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:39:49 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:09:44 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 20/26] Staging: fbtft: fb_ili9163: Switch to the gpio
 descriptor interface
Message-ID: <1eb3d0f4ef62a3e709c9057d1d0e367cc56c43e0.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_ili9163.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ili9163.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ili9163.c b/drivers/staging/fbtft/fb_ili9163.c
index 86e140244aab..d609a2b67db9 100644
--- a/drivers/staging/fbtft/fb_ili9163.c
+++ b/drivers/staging/fbtft/fb_ili9163.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <video/mipi_display.h>
 
@@ -77,8 +77,8 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	write_reg(par, MIPI_DCS_SOFT_RESET); /* software reset */
 	mdelay(500);
-- 
2.17.1

