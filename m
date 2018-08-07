Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BE1C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9A6219E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCFuCBLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9A6219E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbeHGGT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:19:57 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38184 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeHGGT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:19:57 -0400
Received: by mail-qt0-f196.google.com with SMTP id w26-v6so3807553qto.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wdJeQVMkzWFFAnw3PSsAicxRn7TB63V545Uo1Z/IRHk=;
        b=lCFuCBLT+hXBqML7EDegSc3B1EFlglmtv3LEo5q36sJNXQOp9gB9K/aD4bSVDyh7nb
         7v+KzwPUocrTT8R0t0AJDg/23ITCDCxmn1Rj+Ew9nqgdyCfhUzQuoX9VL6D6w0cxpmmi
         oVmy+BJpFcUuIzo+yAHI7Z233o4njg+kXf9XRBRRNITtQvprkA16NDFmsEWRBqsBw0q1
         BKalDeS7dHUqo1I/t9FeQjf0Ft6nEwjldelv13MiQfZr11r7RddwFhROlPaUvA0Bt6YM
         25qLCa9bc/MyyzEKN+B77rDP6uDnW1qbGEXdmwdGCnbpsgG0aEtwqPo1j+M/uOet4hNZ
         zKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wdJeQVMkzWFFAnw3PSsAicxRn7TB63V545Uo1Z/IRHk=;
        b=Mc8M/mZXp4sRrK7m/tfWWKiyogrqt2aVbSrEvbhWOlY4Em0E/7DCHHK96nfBlemlVj
         KG1Pr0fqhG58iZ6243PEJt2a7IqTstInM3vUdyBDiqiBbLM7aYtZ6uOPzSqtSRRhBo9P
         rNBO+FRZXVz+bTzPDEDEu05+x5wM2rx4FpSf8VVuwx/rBldr9VEG63zV2OyW7kwNbTTw
         LpuQ3IN79xcq9IoxkSZteAtqADxTFOjUh3c6FLbpCaZTz5afJyiYAYMQAOz3pyMTpLXZ
         2Pnf3pM0YyfKA28XfELIy0lzDC3UuRHngQ7IwDul3UGP6ED/ayJEqpeeFH4PCzcRWcpm
         kpKg==
X-Gm-Message-State: AOUpUlHVUZXY6KhqVRsKkbC6Y5xDDuTnEMrScVfleuSBqllqqJmyXnwm
        WcI80CNQZ5T+XePX3Hk+0E0=
X-Google-Smtp-Source: AAOMgpfMfaYGwfiE9W6JWcLdgbo2EvhZfIsZ/rUra3RQ0Rcmw3tj7D+4d734k79lPoc2dAvuxPkoug==
X-Received: by 2002:a0c:ada8:: with SMTP id w37-v6mr15332630qvc.107.1533614854942;
        Mon, 06 Aug 2018 21:07:34 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id c93-v6sm209594qkh.90.2018.08.06.21.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 21:07:34 -0700 (PDT)
Date:   Tue, 7 Aug 2018 01:07:29 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] staging: fbtft: Replaces (1 << n) for macro BIT(n) -
 Style
Message-ID: <580ed6c870697966cda930995f998c3a4ac62450.1533614243.git.leobras.c@gmail.com>
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
 drivers/staging/fbtft/fbtft.h | 56 +++++++++++++++++------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 3f3dcd96f9a7..41ac00239aa3 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -377,39 +377,39 @@ module_exit(fbtft_driver_module_exit)
 			 DEBUG_LEVEL_5)
 #define DEBUG_LEVEL_7	0xFFFFFFFF
 
-#define DEBUG_DRIVER_INIT_FUNCTIONS (1<<3)
-#define DEBUG_TIME_FIRST_UPDATE     (1<<4)
-#define DEBUG_TIME_EACH_UPDATE      (1<<5)
-#define DEBUG_DEFERRED_IO           (1<<6)
-#define DEBUG_FBTFT_INIT_FUNCTIONS  (1<<7)
+#define DEBUG_DRIVER_INIT_FUNCTIONS	BIT(3)
+#define DEBUG_TIME_FIRST_UPDATE	BIT(4)
+#define DEBUG_TIME_EACH_UPDATE		BIT(5)
+#define DEBUG_DEFERRED_IO		BIT(6)
+#define DEBUG_FBTFT_INIT_FUNCTIONS	BIT(7)
 
 /* fbops */
-#define DEBUG_FB_READ               (1<<8)
-#define DEBUG_FB_WRITE              (1<<9)
-#define DEBUG_FB_FILLRECT           (1<<10)
-#define DEBUG_FB_COPYAREA           (1<<11)
-#define DEBUG_FB_IMAGEBLIT          (1<<12)
-#define DEBUG_FB_SETCOLREG          (1<<13)
-#define DEBUG_FB_BLANK              (1<<14)
+#define DEBUG_FB_READ			BIT(8)
+#define DEBUG_FB_WRITE			BIT(9)
+#define DEBUG_FB_FILLRECT		BIT(10)
+#define DEBUG_FB_COPYAREA		BIT(11)
+#define DEBUG_FB_IMAGEBLIT		BIT(12)
+#define DEBUG_FB_SETCOLREG		BIT(13)
+#define DEBUG_FB_BLANK			BIT(14)
 
-#define DEBUG_SYSFS                 (1<<16)
+#define DEBUG_SYSFS			BIT(16)
 
 /* fbtftops */
-#define DEBUG_BACKLIGHT             (1<<17)
-#define DEBUG_READ                  (1<<18)
-#define DEBUG_WRITE                 (1<<19)
-#define DEBUG_WRITE_VMEM            (1<<20)
-#define DEBUG_WRITE_REGISTER        (1<<21)
-#define DEBUG_SET_ADDR_WIN          (1<<22)
-#define DEBUG_RESET                 (1<<23)
-#define DEBUG_MKDIRTY               (1<<24)
-#define DEBUG_UPDATE_DISPLAY        (1<<25)
-#define DEBUG_INIT_DISPLAY          (1<<26)
-#define DEBUG_BLANK                 (1<<27)
-#define DEBUG_REQUEST_GPIOS         (1<<28)
-#define DEBUG_FREE_GPIOS            (1<<29)
-#define DEBUG_REQUEST_GPIOS_MATCH   (1<<30)
-#define DEBUG_VERIFY_GPIOS          (1<<31)
+#define DEBUG_BACKLIGHT		BIT(17)
+#define DEBUG_READ			BIT(18)
+#define DEBUG_WRITE			BIT(19)
+#define DEBUG_WRITE_VMEM		BIT(20)
+#define DEBUG_WRITE_REGISTER		BIT(21)
+#define DEBUG_SET_ADDR_WIN		BIT(22)
+#define DEBUG_RESET			BIT(23)
+#define DEBUG_MKDIRTY			BIT(24)
+#define DEBUG_UPDATE_DISPLAY		BIT(25)
+#define DEBUG_INIT_DISPLAY		BIT(26)
+#define DEBUG_BLANK			BIT(27)
+#define DEBUG_REQUEST_GPIOS		BIT(28)
+#define DEBUG_FREE_GPIOS		BIT(29)
+#define DEBUG_REQUEST_GPIOS_MATCH	BIT(30)
+#define DEBUG_VERIFY_GPIOS		BIT(31)
 
 #define fbtft_init_dbg(dev, format, arg...)                  \
 do {                                                         \
-- 
2.18.0

