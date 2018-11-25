Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA818C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7664A20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeUTtzxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7664A20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeKYW11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:27:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45630 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeKYW11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:27:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so5191283pfd.12;
        Sun, 25 Nov 2018 03:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lTFIDT+YJ7amdiCQnyybMTgiRca+VkYvxun9u5Ht60Q=;
        b=YeUTtzxmg9PBVENw6mf26PD5dK2e34e0veTsSk7Q6suKrUpxGDUWUvwcG6o4oeD5i4
         bRVS2YCEFWPiU3QunUHz8HsoCmZJ3P3KOYpG2s60o3wiazb0hwig9mckd7WEsK8LPzCF
         gDH2QWFlj2dFzzOHhuNV25l+p6AjN5xSbvIO0yEZNkm2QLXHI183KvdXcwVRpnKrFMNQ
         BlrnA3Dfbs8WF7KE0Jh1vtSyc7hIrC3K63llD+nA1grH4SH2hBd31TrosJPxPQXMrA/I
         62d0hgg35xApsagja1vs49HEICF4YPji8nniQyL0sTQiUaIuoNl/4q3jBIaXboeok7ea
         v02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lTFIDT+YJ7amdiCQnyybMTgiRca+VkYvxun9u5Ht60Q=;
        b=Saf6v1eAw2EbEVfU9uM1Es11XcieeMkHCEShrjG1+J/Jb8+fX0Tlwg2UNxrqGXpBcQ
         3Cn7wBdvR2CD9q5VaZPE+ezpLf8JcrUvX9+In1RT3ZV+UvAgbBK0WsKUIy97jovSNuzP
         h1fFzVZPjJqpMc/eSb4dEqBzSx3exTx2YzQZK4Agdom0/7b+DA2XTxOpd5WAeOyy5lEI
         jQWRxktckNt+jc/+J47Roay+/kkcGIrcqOYmv4Vkh269uSA1VF9KMvwiHi4LuELz5oH4
         MPNletdn/ClKHq5aA5+i5du1rKJumZ1NlJG79RkP6A4CI3pWT+BueuUPw8gGHrLjMfDl
         RPLQ==
X-Gm-Message-State: AA+aEWYDQRB5TzmiJRjWtlf/7RD9tVrvWlCsndv3es+x8IM8lVYBoeGE
        V7WxuG+Gk4xr+FLOT4JmRVI=
X-Google-Smtp-Source: AJdET5fVrB7PhQLz8zzQpxIpq5jiveiN/ug8iKcxlUeYZBMYkDwDUVOt+sTTC+LnklgBg0FQgZglAQ==
X-Received: by 2002:a63:2d82:: with SMTP id t124mr20610112pgt.260.1543145793716;
        Sun, 25 Nov 2018 03:36:33 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id k24sm68060991pfj.13.2018.11.25.03.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:36:33 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:06:28 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 15/26] Staging: fbtft: fb_ssd1351: Switch to the gpio
 descriptor interface
Message-ID: <00e1e204b89eb507cfde8ed1c5939f8bb25a3515.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_ssd1351.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ssd1351.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index 3da091b4d297..a8980d9f7557 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
-- 
2.17.1

