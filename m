Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D52EC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C4822399
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlMDVvXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C4822399
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeHJBBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:01:12 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41043 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeHJBBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:01:12 -0400
Received: by mail-qt0-f193.google.com with SMTP id e19-v6so8377670qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xxpkXVXmR5G14mwi0WFDB9MNSkoTXKtJR8LDdUksBI0=;
        b=KlMDVvXSw3UNuj2JXyeaUqpyLzHJsZIbGrgsgXziieKGHlz9l/KvjsXfoh82v8Dajb
         qMlpwgkMuZPGBlSQaxsbfv/5q76XI3TWVlt6iR5RlP/3/KTq3goHWLVymRWJcnXW5IxD
         kPREF4YNTTrCxsbYNSIkTrYDEhFD6+jxgauKiYFZpJHEljULu90RP9He3Jr1tWcq2rhC
         wLYhrlQulzSFsk6t4KHtnB0IwK3uJ2QECd29hD84wKONfEZ8bWbjFeSSNYuquq5KNvv3
         s1mZbkbaUtTAvUQ9emN5icnAmUGwIOR2k8mhBrysgDOCuY475YSvksDKsitvujyxH2I1
         8dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xxpkXVXmR5G14mwi0WFDB9MNSkoTXKtJR8LDdUksBI0=;
        b=LshgY1v3CfsJBNk4yOKrcooXTn9zB32hPeWM+LuV4FVEsGft9Jiak0akD4MRqHHNS4
         YAyZimNg7elWF26ru6KBVjjY2RuFAJNBJOgB52fd4LFa6fhA7jAnq51RRHeKMI4p1/5v
         uM0mIaBTFVUzkR2AM7NacDlqFTJdBce4NpbahACnhcul+kUT/8q06uMLcs1Teui9bE75
         vUl5VwW/KiMVluQdgRDLVN6ObzsgzdCamVlOFSHwFmOt0sJZz2Vv6hPl5beyKL9YusHc
         QWaB7M/aSaFvQdK20S/0uptyxK87VzRnTGvIOpJSFJZ32dX16AiyTmeNjLNelfqdmi65
         rZ0Q==
X-Gm-Message-State: AOUpUlEfc3MnhSMoGYNJhYJUCqMyUrbpi5+lozqEvPjswmnq3DsH5AD0
        BfXKryFJiAsyTXvrmU6SmWE=
X-Google-Smtp-Source: AA+uWPyLKMNLDuz7EyINjF0uz22HGrwgcFNntFHdK+1+lHm4BN+FDckTXsc4Y6zDMDBMtB2OLH65qw==
X-Received: by 2002:ac8:2bea:: with SMTP id n39-v6mr4121010qtn.292.1533854055356;
        Thu, 09 Aug 2018 15:34:15 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id j86-v6sm7084768qkh.60.2018.08.09.15.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 15:34:14 -0700 (PDT)
Date:   Thu, 9 Aug 2018 19:34:09 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] staging: fbtft: Replaces (1 << n) for macro BIT(n) -
 Style
Message-ID: <3e0e483abb894faa5b55c3704ebfaef59e551a1d.1533853354.git.leobras.c@gmail.com>
References: <cover.1533853354.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533853354.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of default macro BIT(n) instead of (1 << n). Helps readability.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 56 +++++++++++++++++------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 958835da433c..efdad47ccd26 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -355,39 +355,39 @@ module_exit(fbtft_driver_module_exit);
 #define DEBUG_LEVEL_6	(DEBUG_LEVEL_4 | DEBUG_LEVEL_5)
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

