Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E0EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C52A20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugpVsEnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C52A20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeKYW2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:28:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33622 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeKYW2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:28:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so4511336pfb.0;
        Sun, 25 Nov 2018 03:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6D7IR6TlRx2eRF8FI6Y8TfnnyTdNduDtNJBidXF2B8I=;
        b=ugpVsEnbyWA5yIdQHFMzXNbRz5tiTGo7PGYb7lr4fNFThPVhmZw/K9w7ORdSdzLVQm
         7AdFJbUiQ7zejbHmRWfQCXo4xh2E4JylrnTkK1pt/FKdHcHybynFx5CSVN4F5fd+UB/k
         Q14lCwP4haoH0d915DWzvlh1o1NKiBs/QIxvt8fTiSkhGXWEYoPKeQ4Uzuo80/zWk3sT
         DM3VfNhSo8xuWX202f53KZOS2xO6jxt2Go/P2cIwqkti3UFMxLdEZVXlZwvghAiu0ZRZ
         uVyPdsW5vH5IBSRo/UNe6SG+2zsghVS+nt8PbCj78WTie4Rwq9RhhRTeETp1NIb7/1eK
         +qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6D7IR6TlRx2eRF8FI6Y8TfnnyTdNduDtNJBidXF2B8I=;
        b=Nm/5fqiIqW1pVnuH/jt9NRnvOYB3XN6La2eZDPCUR6FzDg3hwYsmoD1rp8D2UHGsUT
         QEcUdMyjOOgqkoHnw5gph6a3mL2VBCa2jTNr8J/xSIUtY+m/hOzVQRV45zhhszmsr3rf
         f5IbBnTuXtxFxcL3hvG2I7oKu+purS430SFT6LkR2LpZidKg2OeUEofXPsYj4dRiv6qM
         pl3+QCgQZ3T5XOMJ8SBNP+O4QKU5eZdCVyDSA85HS+S6Uu5sqvRrklLVc4Dz8VUZSBlr
         uNuu//oWGPqEtoUye354XFUD+zDHh8dWEDyKHF96gkGn1YABeofoS9zSu0Ae2E1l2Mgv
         2diw==
X-Gm-Message-State: AA+aEWZRhDmvAnTgIHCQYsKhEYHdpkuhbg22drrfSN04cBeqlbUXfS4x
        Rh0akkwVSAgtGASmR07DMgU=
X-Google-Smtp-Source: AFSGD/UAc+raqzdgNl8L24sxnguAts7suDYQs/AyLZGp4afPAH7z0/kEs6HlcTwioNtsl4lopeJFPw==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr19424260pgd.49.1543145833923;
        Sun, 25 Nov 2018 03:37:13 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id l16sm57473850pfg.161.2018.11.25.03.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:37:13 -0800 (PST)
Date:   Sun, 25 Nov 2018 17:07:07 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 16/26] Staging: fbtft: fb_uc1701: Switch to the gpio
 descriptor interface
Message-ID: <9aa3e142296156dd54a199774b3e35fe7762712b.1543142441.git.nishadkamdar@gmail.com>
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

This switches the fb_uc1701.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_uc1701.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_uc1701.c b/drivers/staging/fbtft/fb_uc1701.c
index 0a3531d6eb39..e4ccc73868a7 100644
--- a/drivers/staging/fbtft/fb_uc1701.c
+++ b/drivers/staging/fbtft/fb_uc1701.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -136,9 +136,9 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 		write_reg(par, LCD_PAGE_ADDRESS | (u8)y);
 		write_reg(par, 0x00);
 		write_reg(par, LCD_COL_ADDRESS);
-		gpio_set_value(par->gpio.dc, 1);
+		gpiod_set_value(par->gpio.dc, 1);
 		ret = par->fbtftops.write(par, par->txbuf.buf, WIDTH);
-		gpio_set_value(par->gpio.dc, 0);
+		gpiod_set_value(par->gpio.dc, 0);
 	}
 
 	if (ret < 0)
-- 
2.17.1

