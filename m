Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F04C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3642084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZ0Zs/XV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3642084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeKYWXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:23:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34309 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKYWXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:23:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so5216030pfg.1;
        Sun, 25 Nov 2018 03:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJ/EI6CfXpOfArtQ5hWXpp1pZvvMvidMZmAU722ZAnQ=;
        b=sZ0Zs/XVDivzvZOGAvV3INb48BdFSvb7TeMBMrru5v3ex6sYa/pZ7eRxJSmwyVTgGB
         Cly03qvNosTb8ShJPdr0BkxPLgRhZp0b+JBbK/x2zcgVCflrwuMbZ7WvXQ5xftl8FT5B
         sPIeVbFSDav9zE9Oa6wKMtfYT1e+KXagNFNUNMxM7QxYBXcyyl9csnjGysH0wHtzh/RD
         iUjCuZtEO5PzLSnwXRG9XvS//yYaFcx3c6kcCxtlaOAOQv096WUXbFz2SC+yPs2o1P9W
         mkqzsrvppl3K4FoZ4uFWFtNZ4Bi/7Yf59EtjPgISNmfy16Dzo617YecapEH1ooNi9C6K
         jQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJ/EI6CfXpOfArtQ5hWXpp1pZvvMvidMZmAU722ZAnQ=;
        b=oePFea5axPlGOPEWcyajugPqOLY5Lt9Am5AUGAZwHg2iAYOdA8fI/WDEkxn8LEyDoq
         j9kEpTSdJ0wJgISsJGXAuck207/Q4kKXgrzjstd/R3cnJEK6D4YX2PTTV/er1cn2RimL
         6x2Y+82/teBSE/b08+bkOBjtbyyBZj/k9pPV0JbV6qrgzuSZewVq47xwG5pvuV8ueWB0
         jShvERgV3iy6ioQrUb+Mj+c3PBIsC1D79int9fB5oJbkOCi7+4/PMI4+iMZRPQJCGWxr
         OjFqzq2+iSNphwYz/GV7e3FuY2jsyISnzX9VCxmPz68TK2R5MN/lgNLh6gIEM4FpiuHK
         7MHQ==
X-Gm-Message-State: AA+aEWZj2/BTvAJ9RHdSZHwbABLov0NGwDuc0zc9A2W+KBu2gM3NEZNE
        x0dRmyMFKQIxQRO0MKDK920=
X-Google-Smtp-Source: AFSGD/XTOsAOPdBCeBGzyXF1EFRL5VJMyAQ9ETNOtgGxnmRId18vX8NDZzQCADqzMcTm7RNkErLvkg==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr21025300pgl.127.1543145561322;
        Sun, 25 Nov 2018 03:32:41 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id g15sm175262796pfj.131.2018.11.25.03.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:32:40 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:02:35 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 11/26] Staging: fbtft: fb_ili9340: Switch to the gpio
 descriptor interface
Message-ID: <5968b020512499e503ed380225f94b2019284366.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_ili9340.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ili9340.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ili9340.c b/drivers/staging/fbtft/fb_ili9340.c
index 430f21e50f4d..415183c7054a 100644
--- a/drivers/staging/fbtft/fb_ili9340.c
+++ b/drivers/staging/fbtft/fb_ili9340.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <video/mipi_display.h>
 
-- 
2.17.1

