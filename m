Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15160C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AAC20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4v57R9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AAC20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeKYW0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:26:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43130 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeKYW0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:26:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so4837415pgk.10;
        Sun, 25 Nov 2018 03:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PJodRdvSzkZ9Z2SXB+EE3wodES1ao6gn968M8LM2ZEk=;
        b=B4v57R9FD8s6ODUAMAyQ/3xzBN41Var/9NqPrHlTKM5Kw0hb6UXveJX7rkTOqMUMVC
         UGKX15KS7cEfQPoImnZauXNDLFPgYUc99xLNpwlwbheKsLvBrT/AANeUtq+2Wgg61dUT
         DVHn7XO7QPMcihULmRGnFpvlc+Eap9fourIDrXr0g6c8EpRlpy57EhyDB62WvRecWfOw
         x+ghdSMQQhg+tF2gN7NmMYz5CTDMYzfAxJpn1IZ5DVdjq/plbpKUupYOwWaqRjr0DtJM
         PDxzrbm4xc9Xy5XJBRtnMoTuUO2nfB5HuNxx4ONj/BRrU7ui7WTtXdit2YqIH734C1dE
         kWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PJodRdvSzkZ9Z2SXB+EE3wodES1ao6gn968M8LM2ZEk=;
        b=nFVxwPP2ryMys2MtNBsgh/0MvRFGYzaxnQqA1maQUTqP6MWY/e0f9K4tqhwWzq1XzK
         HJ2tgqkCIQmGQ7sTvRyWgiD9GXtW2lp6NUZDckMz36Xl1gNLS7yRaZOigTKyxFAX52Jr
         RbRkbpUmwez4YewRiawRetR09LQ1lNDpYWwcs+RdSXiR+oS3jVWcQr6Ased5pIb7Iue9
         +VO6AwkyN5F+qNZMywOp49k1bccX0Wb0VZ5y4gzUFyvFc0NPgQ8vhM1egTLBWqcNUf5c
         xBXoQ8rGD2Qly/jRxiFeeKXDc9+IjZgYDpptS+6qJ0U+Z2EUxnFexDQSexirbsKWG2jJ
         zVcA==
X-Gm-Message-State: AA+aEWZiWQb8WWuER5ewzIXfUfD8Ztn0TsTLY/2KfZIm7fliAt4iOtqH
        b6ilNU9rHQcXOo/Ax02QsrU=
X-Google-Smtp-Source: AFSGD/WCCxUKw2jkTOVomDVEZLn7C6caHH2GcffrAOo3/+lzsFf7P+rd3xjXoiQ6WbwdRVUx9yBtKA==
X-Received: by 2002:a63:6782:: with SMTP id b124mr20956174pgc.151.1543145720064;
        Sun, 25 Nov 2018 03:35:20 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id z8sm93352847pgz.53.2018.11.25.03.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:35:19 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:05:14 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 13/26] Staging: fbtft: fb_ili9325: Switch to the gpio
 descriptor interface
Message-ID: <8508af894651d71df497be698d4e08697ec86fc6.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_ili9325.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ili9325.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ili9325.c b/drivers/staging/fbtft/fb_ili9325.c
index 2cf75f2e03e2..b090e7ab6fdd 100644
--- a/drivers/staging/fbtft/fb_ili9325.c
+++ b/drivers/staging/fbtft/fb_ili9325.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -85,8 +85,8 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	bt &= 0x07;
 	vc &= 0x07;
-- 
2.17.1

