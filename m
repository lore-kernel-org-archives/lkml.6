Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C48FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B823820857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDxTgpxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B823820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbeGZRAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:00:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53129 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbeGZRAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:00:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so2417492wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DHPSRW0sf4DJlg4JkK+EnUCg+YfXWzUOE1zsfrYiRcc=;
        b=jDxTgpxMexI81y2tndrtt1qGZseFeKWk4zwM4P8Np7o+Zt5jC9piAr/3q4AD79f6bw
         h4pq+Rytlyong22YsehVwtORLFqhEeEwrGuAQDOMijbXMQvu9BgDVl4Pnw3WIhhtjmis
         BjBsCMCEdZb8o4iiizh6vQCnk+V3+8CE104AI/UHeWwuXyadMSJY66fxvfjFBs3oJ3Z+
         LsCsl2fxadytxgKqG2m6x5SApfI2BlVwFme6tUdEa0pFMXQJIBKBBrbNtrEHHLzf9UvM
         DjCBSGcdev879fvYJmyi1yeV3tTOSwjJyBOw74UwMUxPhS0LcgxYLpQ6iCcjM2emSQNu
         SGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DHPSRW0sf4DJlg4JkK+EnUCg+YfXWzUOE1zsfrYiRcc=;
        b=DkmZQnfsJ8QhNrVTXLMXp01a1bkYqwPMJpqbAJFOuGvVVDYSNy0JCtk7KnEGfBMrOQ
         FFKxHVhXMgoUbv9ibYyt1cwAWf3jOPWusbn4Kzqi1v5SEU8n/5hB11S1SsVxesSG3rka
         Gh5NZcp88DQ3Tj4xMuK9hF6brJ7j2hk+viOtuVD5WW4AO+Y5ujTXecxrhVXhd9TkU3j1
         phK60W0CTGqoDsajk8q0Zx0xNsNJUbOry1oQTgrZuhI73XL3kfcdolS7M9iKeC75T3xQ
         0DcotzvhteZIFaomlosVqIHfaOsZZr2wbyZYYZbw7ttlmTzZmRoDrMLbZtJ39F6/nqu/
         80mg==
X-Gm-Message-State: AOUpUlF4j25Gdlx2xZ+809cIzIoamu3xI8bsNI3iQrdUBDDkfXpnsx6c
        JEEJ+l/rXKCXpJoUjsPPY2c=
X-Google-Smtp-Source: AAOMgpfDRzSYI6dDEd1oGqhylP2d/GTcaURoQTpBiYBTwBdHEfxsFab8FreeStW6Vmia0A8NR/jdsw==
X-Received: by 2002:a1c:910f:: with SMTP id t15-v6mr2021254wmd.51.1532619761980;
        Thu, 26 Jul 2018 08:42:41 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1415742wmg.45.2018.07.26.08.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 08:42:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 353446407E7;
        Thu, 26 Jul 2018 18:42:40 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P06ptUVH8Qow; Thu, 26 Jul 2018 18:42:39 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id C2F586408C6; Thu, 26 Jul 2018 18:42:39 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] Staging: octeon-usb: Change coding style of CVMX_WAIT_FOR_FIELD32 marco.
Date:   Thu, 26 Jul 2018 18:41:52 +0300
Message-Id:
 <37553f45bfb34de4b0af476286b1b782ea834963.1532610629.git.tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1532610629.git.tsotsos@gmail.com>
References: <cover.1532610629.git.tsotsos@gmail.com>
In-Reply-To: <cover.1532610629.git.tsotsos@gmail.com>
References: <cover.1532610629.git.tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180726154152.OR2D9zR5snEiqdk5nN6QEte68y0XNUzK6S5IXWopEwA@z>

Fixing coding style for CVMX_WAIT_FOR_FIELD32 was confusing. Also
encapsulates into parentheses timeout_usec.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 44 +++++++++++++++++----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cff5e790b196..c8e0ebf1434f 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -378,27 +378,29 @@ struct octeon_hcd {
 };
 
 /* This macro spins on a register waiting for it to reach a condition. */
-#define CVMX_WAIT_FOR_FIELD32(address, _union, cond, timeout_usec)	    \
-	({int result;							    \
-	do {								    \
-		u64 done = cvmx_get_cycle() + (u64)timeout_usec *	    \
-			   octeon_get_clock_rate() / 1000000;		    \
-		union _union c;						    \
-									    \
-		while (1) {						    \
-			c.u32 = cvmx_usb_read_csr32(usb, address);	    \
-									    \
-			if (cond) {					    \
-				result = 0;				    \
-				break;					    \
-			} else if (cvmx_get_cycle() > done) {		    \
-				result = -1;				    \
-				break;					    \
-			} else						    \
-				__delay(100);				    \
-		}							    \
-	} while (0);							    \
-	result; })
+#define CVMX_WAIT_FOR_FIELD32(address, _union, cond, timeout_usec)	\
+({									\
+	int result;							\
+	do {								\
+		u64 done = cvmx_get_cycle() + (u64)(timeout_usec) *	\
+			   octeon_get_clock_rate() / 1000000;		\
+		union _union c;						\
+									\
+		while (1) {						\
+			c.u32 = cvmx_usb_read_csr32(usb, address);	\
+									\
+			if (cond) {					\
+				result = 0;				\
+				break;					\
+			} else if (cvmx_get_cycle() > done) {		\
+				result = -1;				\
+				break;					\
+			} else						\
+				__delay(100);				\
+		}							\
+	} while (0);							\
+	result;								\
+})
 
 /*
  * This macro logically sets a single field in a CSR. It does the sequence
-- 
2.16.4
