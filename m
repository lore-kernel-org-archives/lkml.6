Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B68C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF24F216E4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh6gofkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF24F216E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeHHCrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:47:05 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41317 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHHCrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:47:05 -0400
Received: by mail-qt0-f196.google.com with SMTP id e19-v6so556415qtp.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=liXe7yn1dS00Nnn/opyJHTJ6sbfSvRLm2aH7YKI+VI0=;
        b=gh6gofkwkMaifLcrTWx1W9LGrg0HDuz3VRCBBmtMUpWZkdqszLAZ3VFOMBVrq+W35Z
         pU6V+MLWgE95YjCIWiL8pF3ck2rvG2UwI3uo71+1YiY5C1rCrgXLBz4a9ehNQlJBIdPQ
         59LKtlwM+pJu9YtxfYCO/+Oq2HKIXmLQKm2YS4YsN/M9wYcctjhK6X5Iqwr/WZFmLmv0
         Na/dhTDu1VyS+pCbcjhFUzx2xgTo0alJ0ZRz8C2rdixmwGWblsckmyjLWIZ4Y4KroY7A
         AUvojfX9epbJE4h2C/db7n3G9WSjGhRLvkCswVCtOYqgB9+GHzIE7LNTUfnl8uPT8dob
         Zreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=liXe7yn1dS00Nnn/opyJHTJ6sbfSvRLm2aH7YKI+VI0=;
        b=o/2UBkXYHjgQD3vrEjkNKCSfSHCy1QwIRDm3eJ4GGnbKMs0dA7tJ68zX6sRc7xOngH
         +ls92nLaRM+RKmgRMPO/RvHB2zMJGPNkrJwMDD3GKd05c0+qSSKHATgeQARF8aGt8Itg
         U7v8YJPyaQzde+O4u7AY73OrV8PxGNcPhby8A+qa6caPpx+lI9Gv92m1BqFMtZrxsCCT
         kOEd7GsrbmgwzpY9j1scXkYyk2IfIZMHUrBt1nS9G2XAT0WfsTPvp8PeZmqtZAIirny8
         b9+Ob9+SHk3RSK2aX5VITYH6pCVdQQi5KaXxeFBq7hKDFAFUdwpv4V/I5/FFXgIvxOYM
         Tr4A==
X-Gm-Message-State: AOUpUlEXkbGwhGnDW5UV7/MonwQVNOp6gHvZZMLUQPWpfABSlNuDHd31
        RzkA1YQ7feit7JdVIproB8s=
X-Google-Smtp-Source: AA+uWPyM+4KDFWtloJLRIutsHCY/3MZNcpqDjQvGlD8hAmcmt/RcgW4Q/jx7tsplOeGFASHp5C7clQ==
X-Received: by 2002:a0c:ab43:: with SMTP id i3-v6mr589142qvb.87.1533688207360;
        Tue, 07 Aug 2018 17:30:07 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id a187-v6sm1815951qkd.47.2018.08.07.17.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:30:06 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:30:03 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/15] staging: fbtft: Replaces (1 << n) for macro BIT(n)
 - Style
Message-ID: <fc54038cb95429917556b4c54b89f12339fae618.1533686201.git.leobras.c@gmail.com>
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

Uses default macro BIT(n) instead (1 << n)

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 56 +++++++++++++++++------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index f771271d497a..2b2988d2f73e 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -373,39 +373,39 @@ module_exit(fbtft_driver_module_exit)
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

