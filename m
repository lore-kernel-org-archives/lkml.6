Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F753C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543A521566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqSt14mH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543A521566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeI0Hzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:55:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37507 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeI0Hzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:55:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id n6-v6so1099911qtl.4;
        Wed, 26 Sep 2018 18:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Ig8aYG+bq8ur+x3OT7VAaBFbnTbtP5co/zowmafEj4M=;
        b=bqSt14mH+2i9+zp4UOK7PpyLoG0psKx6j3C4hWCKigxOXBO0lHU+8nztXYaJWAwOq/
         wPQeVlT5KhXzETwX0egubL5zsDtqL7ZoAOHblp4Hp+840D0xfuAEEhhxLGyou66oJ71T
         pO0L8PQd4HXNv9uxI9Yj9nc7ZpKt7Xp7fLDRDrGecZfQCqX+KjcmvoznOLmF+qBaG7PO
         WF4/Fk6CJNuGJs6LjDojt5Eoqn6XbWTmiiVfXLac86u0+OIH993FIEstScFneL1p+2Jv
         93cBFZEkKrbUcNyqDOIrFEKZG8g8bL6n05EerYC6AL3HUQ/JMFrGWvAkiX+5sHTmArxH
         zW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Ig8aYG+bq8ur+x3OT7VAaBFbnTbtP5co/zowmafEj4M=;
        b=Xynor3n0ZJR5AYQwZ36+EoGV/9SYQ4muzdkOiviltolQL5C1IWku7rM3VIsYfDU/MF
         1p+Pvk23eStq2m3V5S1jrjzd9rJTfIUboEnyqj2JssMFfuiPsi1e2iyxuGri8Ec5Y7Xu
         Bfg863/Uos6Zba+U54Mc7hopxoTz3xOvpcFOh05fHiOI3qYKI4hTOHv6qIoGOww2KraM
         OroQbDPl6mARzIKFGJeS4ZQVxLj9s7xKee9Ujy4oVhe4aijbbyb2WIR3qfLEAaiZP5/1
         fk5feOMCYfqnC84RYxiBQFAK2X/suWR0rty5OeQhSash4TuaUgy/O9kzeRGJ1FAAlHIy
         X+Qg==
X-Gm-Message-State: ABuFfoj78lnTcXqm3D9nl5DPs3J6NTeUX+bNeIWUGvjVS3WT3FVt2nAa
        EY1OvUqHtJO31ZcxDFz9Rwo=
X-Google-Smtp-Source: ACcGV6309DusnbuhHD0Ny9IZZB55hmhLj9RQMOGISG6Fye8zX2V/LyUnTxIvzv840osoQU7cweW7Ww==
X-Received: by 2002:a0c:d2d3:: with SMTP id x19-v6mr6536821qvh.104.1538012407962;
        Wed, 26 Sep 2018 18:40:07 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id w5-v6sm454871qkw.69.2018.09.26.18.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 18:40:07 -0700 (PDT)
Date:   Wed, 26 Sep 2018 22:39:56 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 1/7] drivers: dio: Avoids building driver if CONFIG_DIO is
 disabled
Message-ID: <20180927013956.GA8956@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids building driver if 'make drivers/dio/' is called and
CONFIG_DIO is disabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/dio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dio/Makefile b/drivers/dio/Makefile
index ae92d17083f2..f5cffe232448 100644
--- a/drivers/dio/Makefile
+++ b/drivers/dio/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y := dio.o dio-driver.o dio-sysfs.o
+obj-$(CONFIG_DIO) := dio.o dio-driver.o dio-sysfs.o
\ No newline at end of file
-- 
2.19.0

