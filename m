Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3DFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E4120867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOajoqL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E4120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeKYWWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:22:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37587 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKYWWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:22:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id 80so4850431pge.4;
        Sun, 25 Nov 2018 03:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lNjTLrgM0lAefUW1IzI7RLF3mGgrVo2mb1RHBLDea+0=;
        b=qOajoqL+zLkJ0lKvjFVMHvuHMGI/3srjwQAtOWGXrBo8oIDw3lLuiBsABFuCtZmyI/
         S+VMhKiM7yhm2AmpkM8n04YIIjumETRcukpT9JUr+07OjIktkKnwKWYpsQ12+xnqJGoC
         EERSfQpYZstYwp3tEj8nRHRGKtd2NMMt42bmM0Cea9YMIhhm3onhq9aiUqk3/n1KbRfV
         kryYOaxJuhRlie0imubRixMdWIQGwj1AnYOew88yp0cf69A4x5C26fKDrpgJ6jnqe9+4
         pdwTrliOMRHaM3d0hCK3yHvX1CC3BhyKmANKm2qJiaxRM0dQctJ3XgMBXkwbQ09iwwg/
         Tp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lNjTLrgM0lAefUW1IzI7RLF3mGgrVo2mb1RHBLDea+0=;
        b=ARftm28ezwODSuwUEZM8CpN6I2g+R7bg0QzvMZ3KaaR3fMWedMQHbfTEWP+dW+jNYL
         8P8z1s4mM6ouDvipZGbaOIDVOAKVPusRo2Etw34E/uZAkckZAYgvZDK9VD9WxZCMF3Lg
         8Y7D6rGpDGeuDZm6nQHTB8GRlyU7ShaxJhIn2lejlieCldO/LiqGxqUSQ7tiMugIrpOi
         Tu1wj50LdVMh2lQ5immhURuegwF0JoQEU5Qtmi/WW59TlYsy98RV9AVqLNfAa9n5Eu01
         T3krv2eieMuo4vOPn7AI8MhI65/da+5kAIqtMgul9Ic8c4UA1Pt6myN55cqBoQTXrG6b
         y7gQ==
X-Gm-Message-State: AA+aEWaSvoWX36wXW1KAbiu4u8ZLIBpDsvlJfmCpLBjzsRMVSvpgPFM+
        /6Fa24gDCLM1jSDZOXmzx9GU/FO9WlPmnQ==
X-Google-Smtp-Source: AFSGD/Xp+XyxiJzg6gNWdymm7s6s5aNwEofA4Zyk+MC7JT493leuPMTTWy7pews0buFcAgq6L9rHpg==
X-Received: by 2002:a63:d513:: with SMTP id c19mr20785838pgg.287.1543145489532;
        Sun, 25 Nov 2018 03:31:29 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id l5sm16051420pgp.82.2018.11.25.03.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:31:29 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:01:24 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 10/26] Staging: fbtft: fb_ili9320: Switch to the gpio
 descriptor interface
Message-ID: <c788c14dfb7ba423708669c9764615ebb16f35df.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_ili9320.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ili9320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index 740c0acbecd8..ea6e001288ce 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
-- 
2.17.1

