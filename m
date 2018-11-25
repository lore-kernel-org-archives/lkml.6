Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CBEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA9420867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpzF7dDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA9420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbeKYWR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:17:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43734 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKYWR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:17:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so4832400pgk.10;
        Sun, 25 Nov 2018 03:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rMElMpMisVAE3FqpXFSDvSfqW4QN19vtNlPQias8rSA=;
        b=bpzF7dDoz+l0R4q/CyYwGwulHKax0HDuX/GDPElSXW3AbtvIcO1+X/mETz5a3DCKyt
         2xan3fDOkkT3OphcPiE+AjxW+lMWtOmYdV+ljXuzSmmfczw8kSWiuZi/3zAGWIOYIC2K
         or1VEAL4A7s8hwaUkIpi1y/1/UQSmFN7cB0L8SxlNV7pxrGfG3BaKIbvE3wbVmaf8rHM
         LkcS2dUlZSkyfCg9EYyGhq3ioqabg9Y5DXIwsSi/IG4+eOjgmTb4ZLTJahObSmShFENR
         0XOFvQ9eOLBg4K8BfUaK/dkD7l3hRdNwWD6YfNOEKdgiPD6xjB3ACY8KazEXyFTGJaDv
         3soQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rMElMpMisVAE3FqpXFSDvSfqW4QN19vtNlPQias8rSA=;
        b=Ax254f4ILpICqF+QP+pzZYTKcz79+SIGH5X771Xb3Rdhuy8UBuzRPPWVxr96nZJyT0
         RaszNdeCKKpTHOMJh7PaEOpeQ8Fo+CqgGDsjvPJmTFHirRgEUMQovqDv5rw22Fqs/oXT
         ibLzfjBzivz4KHcPerM1cmutT7x/sI5rZLR0kLFu9U9JElBacBuU38bng+SyXDIt+5YM
         UYBV2QSikdtBEg3qbH5iLC7CpSrHsuob5o/vlqrDyzv2aO448nMq53+XoZtBawzbVgAw
         0YcJCNedYpzs+hRzG7FMknKgaMV4RW+HEQNP2FoeYjPzAZ5ZCuk9uymu0+YPBZxG0KnZ
         nO1Q==
X-Gm-Message-State: AA+aEWajd/XgPZOP69iLQ7SR/EOl8wkbfq+fMTGka2xXlnL10kLExmfP
        Y7cnjDX0yMQT6EfvyWx52o2AyBH8Usf9Tw==
X-Google-Smtp-Source: AFSGD/WzpNc3P94ieUVyR0IbBqYIIDHTk3ngrCxhFEduUnFG3AVo9vH4KHk34Il0Mr+YM+XRKeFYNQ==
X-Received: by 2002:a62:6385:: with SMTP id x127mr4415223pfb.15.1543145195593;
        Sun, 25 Nov 2018 03:26:35 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id k14sm78747321pgs.52.2018.11.25.03.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:26:35 -0800 (PST)
Date:   Sun, 25 Nov 2018 16:56:29 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 04/26] Staging: fbtft: flexfb: Switch to the gpio descriptor
 interface
Message-ID: <0bc27a5c4f06e50f9cc2d568c6ce5f983dc84925.1543142440.git.nishadkamdar@gmail.com>
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

This switches the flexfb.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/flexfb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/flexfb.c
index 2af474469e7d..c5fa59105a43 100644
--- a/drivers/staging/fbtft/flexfb.c
+++ b/drivers/staging/fbtft/flexfb.c
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/vmalloc.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -521,7 +521,7 @@ static int flexfb_verify_gpios_dc(struct fbtft_par *par)
 {
 	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
 
-	if (par->gpio.dc < 0) {
+	if (!par->gpio.dc) {
 		dev_err(par->info->device,
 			"Missing info about 'dc' gpio. Aborting.\n");
 		return -EINVAL;
@@ -537,22 +537,22 @@ static int flexfb_verify_gpios_db(struct fbtft_par *par)
 
 	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
 
-	if (par->gpio.dc < 0) {
+	if (!par->gpio.dc) {
 		dev_err(par->info->device, "Missing info about 'dc' gpio. Aborting.\n");
 		return -EINVAL;
 	}
-	if (par->gpio.wr < 0) {
+	if (!par->gpio.wr) {
 		dev_err(par->info->device, "Missing info about 'wr' gpio. Aborting.\n");
 		return -EINVAL;
 	}
-	if (latched && (par->gpio.latch < 0)) {
+	if (latched && !par->gpio.latch) {
 		dev_err(par->info->device, "Missing info about 'latch' gpio. Aborting.\n");
 		return -EINVAL;
 	}
 	if (latched)
 		num_db = buswidth / 2;
 	for (i = 0; i < num_db; i++) {
-		if (par->gpio.db[i] < 0) {
+		if (!par->gpio.db[i]) {
 			dev_err(par->info->device,
 				"Missing info about 'db%02d' gpio. Aborting.\n",
 				i);
-- 
2.17.1

