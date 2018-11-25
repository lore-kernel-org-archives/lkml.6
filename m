Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63927C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C7B20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND2Fyfq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C7B20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeKYWex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:34:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44768 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKYWex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:34:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so5200566pfh.11;
        Sun, 25 Nov 2018 03:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nlfXRSuXszRS2eePMp322iYr7wPmU7nfVAqJI0y364E=;
        b=ND2Fyfq2KaaqPZKiFpoPFCFzPk+omLnRiS+wJz+Xd3NtL5fH2Alxdc7+1V5uis6ceS
         h9aTurbeYb+kPPedfopcK4bz6bNfmQ3mwTlxWdGtomxmNtG4LgtqC5h+bp7Vd7BTfpyC
         A30I7Ie30sDhNU58WDd6AFlDH5/bn8mGyN5lqdhisE0h0+xF5eZ5jQ6s6/o9U+dohv0J
         zA3hdnEYuHn2GPZxt1kJcSVL+mfwCDx2XTcsxehjw9vN6tlWOjaxvnKMpjk+17KPTtB1
         ZG+UYYaVBvdDNwMXBNUyrl1H8b78r0oMIeykbjl8kMDrYoYk3siaYDB2uT99SOC/1lvp
         yucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nlfXRSuXszRS2eePMp322iYr7wPmU7nfVAqJI0y364E=;
        b=B1JwTH4TCMLdLmB5upwMoE8nKoJDRBEyPFOqHuzSNsYO+bX4d5MDAUdbZuXMQ6NJjl
         tjk64NBew/YYo/1/RVSbfSrdvu7Z5zS9xAq/8PuG4hN7HKF8OW4LonXiSkPgskpRWCXZ
         muU+b8pZkb1AjlCg6x7yrw/Umo/zROxE4N20mlEYE39rAmklgCKqFC8z5u3vtFbpLlCK
         Im3xGROQNJdoS8t0RZQt4cT/EUR5WE90oWgsK3k59fygUDwpLMLcql+jPQxkNZwZ2zHi
         lqLlKdWewFp0xZoq8rylqHd3jZKrJKsXUYYgC+QK7Rj1TbeY5TrBtwBf1nzx8Ym/DX78
         BMRA==
X-Gm-Message-State: AA+aEWZHMyCRi3dKiFjgShElO/n5eNiGVvtsXxMaTS6TyhTE0n6/6TOD
        BCkxVMsH8iudZrSVvKEFqT0=
X-Google-Smtp-Source: AFSGD/WjztrDzI9gtOnpAPd/U/+hvklD+ohXNhIiOoIFV43MYQ2NI0Z4Fx3Ns49ATntG+hJwmLHELg==
X-Received: by 2002:a63:5e43:: with SMTP id s64mr20805546pgb.101.1543146238813;
        Sun, 25 Nov 2018 03:43:58 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id g3sm2050276pfe.37.2018.11.25.03.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:43:58 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:13:52 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 25/26] Staging: fbtft: fb_watterott: Switch to the gpio
 descriptor interface
Message-ID: <eadbfca17c916cf29d6bd62d316e9c1797f2b70f.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_watterott.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_watterott.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
index e77178157f1b..0a5206d28da4 100644
--- a/drivers/staging/fbtft/fb_watterott.c
+++ b/drivers/staging/fbtft/fb_watterott.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -213,7 +213,7 @@ static int set_var(struct fbtft_par *par)
 
 static int verify_gpios(struct fbtft_par *par)
 {
-	if (par->gpio.reset < 0) {
+	if (!par->gpio.reset) {
 		dev_err(par->info->device, "Missing 'reset' gpio. Aborting.\n");
 		return -EINVAL;
 	}
-- 
2.17.1

