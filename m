Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B91C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF17219ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XorT0WNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF17219ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbeHGGSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:18:14 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36821 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeHGGSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:18:14 -0400
Received: by mail-qk0-f196.google.com with SMTP id x192-v6so10552707qkb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 21:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b+C4LaNoO3ZnYCywsLPEVGpt/u0fe9hu4JYt0CTWYkY=;
        b=XorT0WNjqJvF8bzENsLc+OUdkSwawQb7q53MmUdtRgUEN+OSOznFyPG4Ql/Mi9bqzp
         hB70OgsgDsltHyIwAGLCZc+JII3uI4htNnu5oxqFkmPDcDaGrWsUvivV6qcOS+IqqiDS
         bAA762VJw0DwEIqYP5SjOKWttFsEPfpU6HdzOtCFtVgS6b6kMfu2W7Ah7DGcinVASank
         xZLKbW4QKeGQowr/yYHNbT9hk+nwyTtxZuEdAuqsec1JvQHHx4Rmi8Uq1FBbrMsW15Id
         cNGCy5pNpD8cfJTAmug0GtzHYM/4UQcEJEo2h8DvgXSiWckketgUFUs+SYRezXNWLFJZ
         4k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b+C4LaNoO3ZnYCywsLPEVGpt/u0fe9hu4JYt0CTWYkY=;
        b=RSO+ThZPdK6r0x/YxzwTqPC0T/toLZv+Xs7eSzycsN3lVXs8v8tBNnf7HwPn+/9/IR
         Cb6Xc9fAi/2RjUGI0k08TpeHIdyTd5/iLqRcPe8j510wFcLajld6ehajpFg70vy3FURy
         Z4iVK74caUA+m+tDdKB5wZJtSpfKcsxyHyz4qmGfp6KhngWIr5tR9srh8AN/DN8vpOAF
         aiVDd5FZ0JYQANWxhCYzJ8l6Y9E8KNiIBK8g9wBMvzxPlJsFREYA5Ac18+/7wb+XQkuy
         iPZ36aLjIK6c2gMyzcA+it2dWSpxmCaLOne9Q8GGofDEFRo0t7XsiNLZColAVboH7PPX
         6L7A==
X-Gm-Message-State: AOUpUlGe7kqGDLi0IUsv9brYIKmzkuZO8zLp4rn6BE5cEhZGVny2reHc
        G49W+JULpDrBh16yyYMFHuw=
X-Google-Smtp-Source: AAOMgpcGTPxqpV2lC+qZIXFVB8IDp5LGctZmbr7GwV4CFm3AYDHcySJJvDqRylvZ5JpKcH8QhraASQ==
X-Received: by 2002:a37:2c84:: with SMTP id s126-v6mr15415961qkh.311.1533614752986;
        Mon, 06 Aug 2018 21:05:52 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id t27-v6sm215081qkl.11.2018.08.06.21.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 21:05:52 -0700 (PDT)
Date:   Tue, 7 Aug 2018 01:05:47 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] staging: fbtft: Adjust some empty-line problems - Style
Message-ID: <a59c8043ff8f03d8c6345e77e9abbd8647dd32d0.1533614243.git.leobras.c@gmail.com>
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
index dc424f3a0ec5..fd483e8ecd7a 100644
--- a/drivers/staging/fbtft/fbtft_device.c
+++ b/drivers/staging/fbtft/fbtft_device.c
@@ -840,7 +840,6 @@ static struct fbtft_device_display displays[] = {
 			}
 		}
 	}, {
-
 		.name = "piscreen",
 		.spi = &(struct spi_board_info) {
 			.modalias = "fb_ili9486",
@@ -1586,7 +1585,6 @@ static void __exit fbtft_device_exit(void)
 
 	if (p_device)
 		platform_device_unregister(p_device);
-
 }
 
 arch_initcall(fbtft_device_init);
-- 
2.18.0

