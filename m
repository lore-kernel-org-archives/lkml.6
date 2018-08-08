Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117C6C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B087721521
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyEFYqtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B087721521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeHHCqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:46:20 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46180 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeHHCqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:46:19 -0400
Received: by mail-qk0-f196.google.com with SMTP id 191-v6so321623qki.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xX/nu252jiBWdXsloTf+yps4BVgjXb0mUJ/H2EP9P0s=;
        b=MyEFYqtNwNDGKQkBLFxwIHtB9ppaqL4DN5h7KgMec0Fb6c6pRd5D/oOa84eOkBy0Jd
         GgCXTv7s/sJlgMZPlNWkZWr7OHt9ae1v+i9oCkA0IynBQ45abJCuJloyW/vjdFR4Soa5
         eipEZaFDn8N6+8FGtn1mjaY4R5D4f8c57T9YQXtORYs9jJlLdSTMxKsZbhzqx6lJU0j+
         PtrOMFB17we24gUKdJssqyE2zKH0Ij4660hIUhu3T4VDkFOB6NBQowhV1bawWa6PFwMx
         Cr9OSBM/4WnZQWXPHhetjZKOojjQbZCMnFn/o87K/bPdODN5ptdg/zNeDywbv4rHNXcV
         VHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xX/nu252jiBWdXsloTf+yps4BVgjXb0mUJ/H2EP9P0s=;
        b=MrIkVfGJ5+BxgUpddQNaAyRjgP0m+ms8ZH2IWMm5smUnbK2Jw/1imHtz0XZfHpUapl
         wv/S1B5z3zyK76iNYMecrgTGXUMxcX22QuBFnAPVyF1iePTet9aCwX52lFNgsTmOJVO5
         fEj/6bhSs6k5VOUu0r0ZDb0M3/stzfEtpKHBBXbv/mlyk5d86qnJf/VDILuRPxqYG4ma
         vC0Sxes04TyC3M1viP8s93S9+MvmgAa6wj20M16aKGGXf01XrpA92tanG9adv4R2UDoI
         EGmDvzEq/qdkd0yg2+2fa78b8I2kwLK/QtPbvfvWxkCdAUsQwLpw4qTJ/9BKu5/vroo8
         GkEQ==
X-Gm-Message-State: AOUpUlEaJm6i2vfgwDijmlt6cCW/ejtRM0MG+shQJ0Np24FbsMpVDnIM
        OhiEMblKIzmTejr865ty0zk=
X-Google-Smtp-Source: AA+uWPynahbmPV+wEYj3wzRFJTvYOxOvNzGdRrIGTMEjKwVRvc4nHu709Ll6uQfueGbtD1QD9KqcVw==
X-Received: by 2002:a37:2e06:: with SMTP id u6-v6mr575625qkh.89.1533688162363;
        Tue, 07 Aug 2018 17:29:22 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id r13-v6sm1720748qke.21.2018.08.07.17.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:29:21 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:29:18 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/15] staging: fbtft: Erases some repetitive usage of
 function name - Style
Message-ID: <fb9ac797f1fd3cd8a830b3320c0ad93477cb7b1d.1533686201.git.leobras.c@gmail.com>
References: <cover.1533686201.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533686201.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes this functions to avoid using "blank" on debug twice. Improves log readability.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fb_sh1106.c  | 2 +-
 drivers/staging/fbtft/fb_ssd1306.c | 2 +-
 drivers/staging/fbtft/fb_ssd1325.c | 2 +-
 drivers/staging/fbtft/fb_ssd1331.c | 2 +-
 drivers/staging/fbtft/fb_ssd1351.c | 2 +-
 drivers/staging/fbtft/fb_uc1611.c  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/fb_sh1106.c b/drivers/staging/fbtft/fb_sh1106.c
index 3fc18c0a6f11..00096f8d249a 100644
--- a/drivers/staging/fbtft/fb_sh1106.c
+++ b/drivers/staging/fbtft/fb_sh1106.c
@@ -89,7 +89,7 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "%s(blank=%s)\n",
+	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
 		      __func__, on ? "true" : "false");
 
 	write_reg(par, on ? 0xAE : 0xAF);
diff --git a/drivers/staging/fbtft/fb_ssd1306.c b/drivers/staging/fbtft/fb_ssd1306.c
index f5e0ec1c01dc..57139740297e 100644
--- a/drivers/staging/fbtft/fb_ssd1306.c
+++ b/drivers/staging/fbtft/fb_ssd1306.c
@@ -148,7 +148,7 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "%s(blank=%s)\n",
+	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
 		      __func__, on ? "true" : "false");
 
 	if (on)
diff --git a/drivers/staging/fbtft/fb_ssd1325.c b/drivers/staging/fbtft/fb_ssd1325.c
index 1a469b3c92d4..f974f7fc4d79 100644
--- a/drivers/staging/fbtft/fb_ssd1325.c
+++ b/drivers/staging/fbtft/fb_ssd1325.c
@@ -88,7 +88,7 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "%s(blank=%s)\n",
+	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
 		      __func__, on ? "true" : "false");
 
 	if (on)
diff --git a/drivers/staging/fbtft/fb_ssd1331.c b/drivers/staging/fbtft/fb_ssd1331.c
index e2b3ba82d01f..44c3c95c1e9b 100644
--- a/drivers/staging/fbtft/fb_ssd1331.c
+++ b/drivers/staging/fbtft/fb_ssd1331.c
@@ -169,7 +169,7 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "%s(blank=%s)\n",
+	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
 		      __func__, on ? "true" : "false");
 	if (on)
 		write_reg(par, 0xAE);
diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index ba78a7758fb7..3da091b4d297 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -163,7 +163,7 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "%s(blank=%s)\n",
+	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
 		__func__, on ? "true" : "false");
 	if (on)
 		write_reg(par, 0xAE);
diff --git a/drivers/staging/fbtft/fb_uc1611.c b/drivers/staging/fbtft/fb_uc1611.c
index 4d65567eefe2..dfaf8bc70f73 100644
--- a/drivers/staging/fbtft/fb_uc1611.c
+++ b/drivers/staging/fbtft/fb_uc1611.c
@@ -129,7 +129,7 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "%s(blank=%s)\n",
+	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
 		      __func__, on ? "true" : "false");
 
 	if (on)
-- 
2.18.0

