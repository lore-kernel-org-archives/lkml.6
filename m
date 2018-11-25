Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8C3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A200720867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdadmErl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A200720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbeKYWVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:21:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38064 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKYWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:21:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so4851840pgc.5;
        Sun, 25 Nov 2018 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pVvKmfOIVjYe+j60IQblG+ZKp4+HkaMZYtsYJ8xIvg8=;
        b=vdadmErlwqgo6s0XZE8gk7MijPx7ADiHHEBHHG1WgVaSVBJvzoktqVd1/DcSi3dOt6
         qv2d2Sv5n+JF95nGLpjBchysIuU/WedWFuiiQ8r1cBiycfebpUKCWVkCdol3ZO7ZlVzi
         HBbz6jliSbhQsgtO+4/jWPDKd/OSe4uzLtzSoKB/jv/ZE32P97yxllL3oPXLz46nFUlE
         aevmXCqnbhwdr3LSNnv+3ahwPr+EOVLZh8RieNN8UNDmHwdL9W67zo0LwNun4ZTRqJ3M
         8BO+8AOaZaQ6agbs/L3KaqkH+t+j3YWwNr5o2RfrDXIiV7DMpeQ70D2uSH4a8A/C9AE6
         KhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pVvKmfOIVjYe+j60IQblG+ZKp4+HkaMZYtsYJ8xIvg8=;
        b=lGIJfXz4Bl+KMxH6cgiCq4RsgaGdV3BWdvlN8RQfOQgHNHQT3RyUudfwH65XSTm58E
         BuKTCxFbciNkQ5q+73IdIwpn98mDGiDZl8+M5QfwmsxtW6alpWMd1M3LklF5UCLXuccg
         hkwtujmeqJdRycxdPpoTB3yPRauwpNOSkMbOWA/py/wRY3UzJ6Euhx9DxsVHrcahBAgs
         835eRKSGRgIQiflcLABO/j2nmdj9xJDSD/gXVuH+exfq+TXhl+pWZTPXKf1PhWbD7Lqn
         HJU3rXdPwKOWQvGpmrRaskWUgU5wktTQv18Lj/klJo5aur8cye5gVowE9G0lh3NxVUSl
         Gcpw==
X-Gm-Message-State: AA+aEWalSEOsDdoNWomeqf6VIvBHzNmHhlp9TGd0ic9gxhRqCWgoaZ4x
        DyPT423mGHtXdrjwWLPn/aA=
X-Google-Smtp-Source: AFSGD/Xyxm0fCg+FQnoAOpWNIv4KHcJDumzikYyHEY2GO2mZIfazoUk88WV8UQtzM0UeWwNAFuEH4A==
X-Received: by 2002:a63:d949:: with SMTP id e9mr20862433pgj.24.1543145442279;
        Sun, 25 Nov 2018 03:30:42 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id m9sm55199349pgd.32.2018.11.25.03.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:30:41 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:00:37 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 09/26] Staging: fbtft: fb_s6d1211: Switch to the gpio
 descriptor interface
Message-ID: <c224f79b36ea42c31a1faa28493c61fdea48025e.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_s6d1211.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_s6d1121.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_s6d1121.c b/drivers/staging/fbtft/fb_s6d1121.c
index aa716f33420a..b3d0701880fe 100644
--- a/drivers/staging/fbtft/fb_s6d1121.c
+++ b/drivers/staging/fbtft/fb_s6d1121.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -29,8 +29,8 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	/* Initialization sequence from Lib_UTFT */
 
-- 
2.17.1

