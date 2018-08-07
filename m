Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A48CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301C6219E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8oKDhz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301C6219E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbeHGGUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:20:08 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44371 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeHGGUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:20:07 -0400
Received: by mail-qt0-f195.google.com with SMTP id b15-v6so16392570qtp.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 21:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jqV9ZYshPEnmGEkhjm4wmPtcfDutx+I5nWinyIJ4m8Q=;
        b=X8oKDhz3ejdQqj0omyOGMj2m1DbI15EoACIRZvQ7DRFySq1d9EboLAQPocXxPcRg2n
         CSsqIfouDNCFnN+U9Ry03ZaOuM2VgdSUjge0Q6MlfJSRHKV4yDd/U0HOWyv6Obde9Tts
         MRncMyOU/+G/b3KvMtG9zAgQBYP7HDNHQddyMi/wo5x64GBNNAD+ngCsYtKZ6Gov8x3l
         iycyUwlZzPaOPxqBKs5XLHr+I2ZiCrLDkw7jxcgLaTxn0cwmlAgHaV/aqmuJw8Lnljdk
         c486Ew0jrFES3vF0PIsXm7IQ9HM+ajkORKmqBHKIo9HEF6NhBbGmENkPC1k2sh0Lql8+
         WinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jqV9ZYshPEnmGEkhjm4wmPtcfDutx+I5nWinyIJ4m8Q=;
        b=X3ofHQTXATRg/G/1KF6LrsAFb0xGhfyPhjWpg2cu6kecaK6rryILblQtp4BfZiuhFc
         ABxLCzoRxeUL8DWWq46RCd8+KGFZzJZQk6jqCuzp09VeRPZWo7FrzuYjze/OoWP3rc6r
         QxhBkAFQPVl8RgTOhWovakJqM1P22WRE+z9lNHlWOutU1GRJSsNDbanZohWk5S9UG/aI
         /Luvomm8No3FaGWz5pyhKQs274BKkj14J/HDO+RpPFVyiZGCr1VH2vQuxokwNOuLn3C8
         D+aPXNb1E9tjd8X24+TGqELbkq/gNl8SujAHMbfTNlLDQ1ZqVzgh3S1zFf18tvAJ1OlI
         UjqA==
X-Gm-Message-State: AOUpUlHFiTYb/7treU6TW/gdL9MvsuNNvRQXnKqXl94DoR1OLlWpjG6r
        mWPIuFz+iSTW9Cmzm6K2aEozJpgR
X-Google-Smtp-Source: AAOMgpeS2aeftffh+OYCSIOZqvb25zUEPDXMEfchQz7gqmZBI1U4N/cAZhDiNe4T2fhIeCyf+m8k/Q==
X-Received: by 2002:a0c:d0e3:: with SMTP id b32-v6mr15073987qvh.236.1533614865891;
        Mon, 06 Aug 2018 21:07:45 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id u25-v6sm149783qkk.7.2018.08.06.21.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 21:07:45 -0700 (PDT)
Date:   Tue, 7 Aug 2018 01:07:41 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] staging: fbtft: Includes parenthesis around macro
 parameters and avoids multiple usage of macro parameter - Style
Message-ID: <3cac26238f63cac9123ad767341daead9aec7717.1533614243.git.leobras.c@gmail.com>
References: <cover.1533614243.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533614243.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 41ac00239aa3..eb2bdc4870be 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -411,17 +411,21 @@ module_exit(fbtft_driver_module_exit)
 #define DEBUG_REQUEST_GPIOS_MATCH	BIT(30)
 #define DEBUG_VERIFY_GPIOS		BIT(31)
 
-#define fbtft_init_dbg(dev, format, arg...)                  \
-do {                                                         \
-	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
-		dev_info(dev, format, ##arg);                \
+#define fbtft_init_dbg(dev, format, arg...)				\
+do {									\
+	typeof(dev) _dev = (dev);					\
+	struct fbtft_platform_data *pddev = (void *)_dev->platform_data;\
+	if (unlikely(pddev &&				\
+	    (pddev->display.debug &					\
+	     DEBUG_DRIVER_INIT_FUNCTIONS)))				\
+		dev_info(_dev, (format), ##arg);			\
 } while (0)
 
 #define fbtft_par_dbg(level, par, format, arg...)            \
 do {                                                         \
-	if (unlikely(par->debug & level))                    \
-		dev_info(par->info->device, format, ##arg);  \
+	typeof(par) _par = (par);				     \
+	if (unlikely(_par->debug & (level)))                    \
+		dev_info(_par->info->device, format, ##arg);  \
 } while (0)
 
 #define fbtft_par_dbg_hex(level, par, dev, type, buf, num, format, arg...) \
-- 
2.18.0

