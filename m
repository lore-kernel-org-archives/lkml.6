Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B07C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986DB2151B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6jcvCTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986DB2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeHHCqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:46:12 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39341 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHHCqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:46:11 -0400
Received: by mail-qk0-f195.google.com with SMTP id b5-v6so349859qkg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k0xsE+r9tC3fPiSlSdgfkfxvvRBoB0ReDZ3MRXr/beI=;
        b=q6jcvCTmlNiacx8aze/n7vx3qi1DcxbuX4GWVoZbCBnnCrOVTA1xu89M8reiAAfgru
         TjcAXCtV87EG1hoUMUsw7pGkDWa1OqUuX67rg1UwsSufFQ5bhzstElV0mGPqg8SWIlaI
         dANEWQWbzGJkuBTiENS5pM9KYnltUuEmZDNCKJlO1PkaLgxdRIdwF1bARjaPBzcHcycG
         vsWVPvNxH7BQZKKiR6LVulxZwODPZasOfavQome1IB7Z7QL1SyI7cOpSzx9BEz33rTQZ
         2wnKhVg+7qX5QVhczy0dqXErPMq9zplq2Vmba7uS5sp06n9sM0+g3wlHGuo9kmqANBJn
         j+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k0xsE+r9tC3fPiSlSdgfkfxvvRBoB0ReDZ3MRXr/beI=;
        b=RUPHsO8gkDokiC2c0AnnZ60E3i1KmOE/t21A3WLXfLxngTb2yhPQr+Mf4x3OouF5dA
         9/IkdN68FUr1BXvyi0XfVZTAYOhhzT8D7sN/bGG8SexvVG5LYkjj3tHzZYqhV5O/nFjL
         dCLPo4Nk+e7HOVC805xSGiPl1iLkOIJHgRq4DWS8zChalAoIpYMSnLAxC+7/9uMB42Af
         LcTFvBvvjXQ72zIMcnkyXba7C9gevuZgwd6ZvcwfzJJ7PYf83Br0w5ZyKwWPjym5EmxB
         gRMXRZNYU6oij4qXo6U4mHy2KFDXeHMOJNF8T81toCIQbcIHXehe6UX8A4D2I6VnQWDf
         9iLA==
X-Gm-Message-State: AOUpUlF6R1AHktfefUc0sCcXl2IpOWA5lkiJk18W4XlZpKlVnVMtQLUf
        Q9pxaZg0AJ2Pcnrkk5teC+M=
X-Google-Smtp-Source: AA+uWPwRBGT9C8oz0ZwW2wbjnFMdBxOe5jTGoYq/qKq7HqK8RFM/SXBtHiDXqVMBSr4pTyV+QkAJTA==
X-Received: by 2002:a37:a758:: with SMTP id q85-v6mr548177qke.321.1533688154337;
        Tue, 07 Aug 2018 17:29:14 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id p13-v6sm1782123qki.12.2018.08.07.17.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:29:13 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:29:10 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/15] staging: fbtft: Adjust some empty-line problems -
 Style
Message-ID: <90d7ea3be6836413fb8ea8753a00fa2df712b683.1533686201.git.leobras.c@gmail.com>
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

Erases some blank lines.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fb_s6d02a1.c   | 1 -
 drivers/staging/fbtft/fb_s6d1121.c   | 1 +
 drivers/staging/fbtft/fb_ssd1289.c   | 1 +
 drivers/staging/fbtft/fbtft_device.c | 2 --
 4 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_s6d02a1.c b/drivers/staging/fbtft/fb_s6d02a1.c
index 55513a395567..d3d6871d8c47 100644
--- a/drivers/staging/fbtft/fb_s6d02a1.c
+++ b/drivers/staging/fbtft/fb_s6d02a1.c
@@ -16,7 +16,6 @@
 #define DRVNAME "fb_s6d02a1"
 
 static const s16 default_init_sequence[] = {
-
 	-1, 0xf0, 0x5a, 0x5a,
 
 	-1, 0xfc, 0x5a, 0x5a,
diff --git a/drivers/staging/fbtft/fb_s6d1121.c b/drivers/staging/fbtft/fb_s6d1121.c
index c3e434d647b8..aa716f33420a 100644
--- a/drivers/staging/fbtft/fb_s6d1121.c
+++ b/drivers/staging/fbtft/fb_s6d1121.c
@@ -154,6 +154,7 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 
 	return 0;
 }
+
 #undef CURVE
 
 static struct fbtft_display display = {
diff --git a/drivers/staging/fbtft/fb_ssd1289.c b/drivers/staging/fbtft/fb_ssd1289.c
index 67b3f8548241..c9b18b3ba4ab 100644
--- a/drivers/staging/fbtft/fb_ssd1289.c
+++ b/drivers/staging/fbtft/fb_ssd1289.c
@@ -153,6 +153,7 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 
 	return 0;
 }
+
 #undef CURVE
 
 static struct fbtft_display display = {
diff --git a/drivers/staging/fbtft/fbtft_device.c b/drivers/staging/fbtft/fbtft_device.c
index 4110bba52e64..50e97da993e7 100644
--- a/drivers/staging/fbtft/fbtft_device.c
+++ b/drivers/staging/fbtft/fbtft_device.c
@@ -837,7 +837,6 @@ static struct fbtft_device_display displays[] = {
 			}
 		}
 	}, {
-
 		.name = "piscreen",
 		.spi = &(struct spi_board_info) {
 			.modalias = "fb_ili9486",
@@ -1580,7 +1579,6 @@ static void __exit fbtft_device_exit(void)
 
 	if (p_device)
 		platform_device_unregister(p_device);
-
 }
 
 arch_initcall(fbtft_device_init);
-- 
2.18.0

