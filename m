Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8DEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD9920865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpFM1jDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD9920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeKYW0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:26:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33148 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeKYW0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:26:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so12519208plo.0;
        Sun, 25 Nov 2018 03:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nnEBSqM1uS9ARDBY0EwxFQ6CGN9MXEOWQkraZRswdf4=;
        b=hpFM1jDLq2gtTgBBhJW2p5UNFCK6JeMbH7mzm2BIVYuwQl+saK0MT4+ceAdgsEDyRp
         MLLnH7zFcGx5tA+bYte5uUm4Ur6ZPeWyD0tDvo9C0XQ0SpOrmx00w5KX3VPjJk9r2YVk
         Fncp6CCtp8ZApptMKxfrSfsR03ghUxnPboOrI/mtOnJjUMq4pSwYa/HegVxCYMT67Dli
         tApEYqzmYTayIHUTSIlL+NmxwlGw9YYcopRVFSa48i5MV95VQ3EkGQivMKnI/ii3jwEL
         /eG49v/kmNrw6sn/Q9co4gLcA8H9mET0zWzk+VBWJ2G9FHBjGE5rGs3Wi3Y5F50Pk+W4
         FqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnEBSqM1uS9ARDBY0EwxFQ6CGN9MXEOWQkraZRswdf4=;
        b=K6/QhiyGvq2IYOmZpbzL3GXAEalNbJR75HOX7pZjXLyNrKfBbwT84dHWiNKjS2X9w1
         tEDe5ZNB0/K2Feh8UyjMk0nGqxns4A5R+Ig6k/EzrYL+w+QFTuBb3ZCKTibvFsZHqwGr
         lcfQePB+MCq4hOVQjqYH3NHfa4aGwxsBiFxXbxtQ166A7xb4YPoRVTlKunZcFrQvkzob
         WsFpFYuQXWtaXEFivWqTqCl46h/fUyG1uw/tt7QCXzB/+baYu6QhMNNtryeBe5NN32Ic
         dvttZDqHdQ6NTbDWn7SyLxx83tOujcHB3Th1gqGZxl7BzxNd8dsn7FuEyQaFHf+gUjrH
         rjtA==
X-Gm-Message-State: AA+aEWbWqOJCO33DJWn7BssMnJV1M12i1cfR0gwGyXpaMBdgLbXGv1Np
        T8Hirz+aYx0axOGvWSmjrRA=
X-Google-Smtp-Source: AFSGD/Vc1zhQr8RychFBk7yKVRYl25ZpAjj7rHyTCQ75xIaM623T987WZT5r4bfYZKeWptQa8dAT0w==
X-Received: by 2002:a17:902:bd92:: with SMTP id q18mr23266921pls.167.1543145756041;
        Sun, 25 Nov 2018 03:35:56 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id i1sm42623474pgb.46.2018.11.25.03.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:35:55 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:05:49 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 14/26] Staging: fbtft: fb_ssd1289: Switch to the gpio
 descriptor interface
Message-ID: <e9235e29c72adcd9b24fdfa64f9953af4344d575.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_ssd1289.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ssd1289.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1289.c b/drivers/staging/fbtft/fb_ssd1289.c
index c9b18b3ba4ab..bbf75f795234 100644
--- a/drivers/staging/fbtft/fb_ssd1289.c
+++ b/drivers/staging/fbtft/fb_ssd1289.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include "fbtft.h"
 
@@ -28,8 +28,8 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	write_reg(par, 0x00, 0x0001);
 	write_reg(par, 0x03, 0xA8A4);
-- 
2.17.1

