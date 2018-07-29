Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC23C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9697220857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5uiGvr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9697220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeG2Poo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 11:44:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39744 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeG2Pon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 11:44:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so10696150wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yJhRHkftqmDez2R9Jtt9opMpHaFukBbHgTYqvuBqeuo=;
        b=Z5uiGvr17pvrn7KzpUqit2aVQ/6HpZyaor2VU84cxKIGh41ttk9LYHdE5KvVRpxxa+
         QFRQHbKzgwq8xJ/gSSmh4tAESCTh79PjDjFZJBCbQEESH1+ht3Uwx+XS/lii5AHG+5BW
         hhWIOy8PF7nRHCfJyv6HVM+VO73pnXxDoE8ekdm4BeoxZ9BWqUOXdXEXGxOTSAokbnko
         F37xY1Zz+0+ZgZ13YJKI8o88NitGxDN31EaYqBGXikKODJpBkBBcBhIHWbAU20J4C0Ik
         dqKd41ChWI3lfAl9YiAcPfoswBfpgsnVukUEaKMs3Tlds4MDgbH1ZKE4LgNO243HcjG8
         O+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yJhRHkftqmDez2R9Jtt9opMpHaFukBbHgTYqvuBqeuo=;
        b=UWuEY+lJX6fAItymeD5Wx1wns4yU6HAfGZEupJaUess3Z31UEw9YWKo/ptblE3Pdom
         Xc0rZ+Ojd2uDdmc6hGx8ocWG+0b4ptZrmpmue3GB+e7ugajSVkoTWSZ2IqR1P84bHUZJ
         jtrO3mLlbIDYb+RNOrtUX+XpDNx5JQz+1mupnAXHDnlFqcSwh4SlQkXnNnCqVcy3GMBx
         1ZPynnQqIQo+K2j6leOwLUKakO1L8Qa5r6z02Ox415Y3p08SHo/MJDy5kM14pAniFXva
         cM02tHtXxM7wl87TQWVDtlIiyyWyn4PNbQVWxlwViQNx6RVuAsugMlYx5p2EbuamjRHM
         Ip7w==
X-Gm-Message-State: AOUpUlH05Bz6Th+34Surgsh4yOaRl20+ZI8Wr3/YzFRh1vtKLldykzCX
        oIiV/wxlK/wuTKD1IWJC3PxB9asB
X-Google-Smtp-Source: AAOMgpcNB/6WDUbg42qkbHDmi/EMG5JhSeggDBBa93rFLtflfcnwE1NK84schRhx3IQN9LlZzeQI7Q==
X-Received: by 2002:a1c:dc89:: with SMTP id t131-v6mr12216485wmg.50.1532873646703;
        Sun, 29 Jul 2018 07:14:06 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id y14-v6sm18076154wrq.45.2018.07.29.07.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 07:14:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id D53956403C9;
        Sun, 29 Jul 2018 17:14:04 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SuCipJBW0vzv; Sun, 29 Jul 2018 17:14:04 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id 59DA36408D2; Sun, 29 Jul 2018 17:14:04 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] Staging: octeon-usb: Change multiple calling of CVMX_USBCX_GRSTCTL
Date:   Sun, 29 Jul 2018 17:13:34 +0300
Message-Id: <20180729141335.32501-1-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180729124400.GB27275@kroah.com>
References: <20180729124400.GB27275@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign to variable the result of CVMX_USBCX_GRSTCTL instead of multiple
calling a macro.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
v2: It wasn't exist in this or earlier versions of patch series
v3: It seems a logical to avoid multiple calls of CVMX_USBCX_GRSTCTL that  will
also help cleaning up calls of CVMX_WAIT_FOR_FIELD32
v4: Added patch version text

 drivers/staging/octeon-usb/octeon-hcd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cff5e790b196..4615133292b5 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -598,6 +598,7 @@ static void cvmx_fifo_setup(struct octeon_hcd *usb)
 	union cvmx_usbcx_ghwcfg3 usbcx_ghwcfg3;
 	union cvmx_usbcx_gnptxfsiz npsiz;
 	union cvmx_usbcx_hptxfsiz psiz;
+	u64 address;
 
 	usbcx_ghwcfg3.u32 = cvmx_usb_read_csr32(usb,
 						CVMX_USBCX_GHWCFG3(usb->index));
@@ -629,17 +630,16 @@ static void cvmx_fifo_setup(struct octeon_hcd *usb)
 	psiz.s.ptxfstaddr = 3 * usbcx_ghwcfg3.s.dfifodepth / 4;
 	cvmx_usb_write_csr32(usb, CVMX_USBCX_HPTXFSIZ(usb->index), psiz.u32);
 
+	address = CVMX_USBCX_GRSTCTL(usb->index);
+
 	/* Flush all FIFOs */
-	USB_SET_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
-			cvmx_usbcx_grstctl, txfnum, 0x10);
-	USB_SET_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
-			cvmx_usbcx_grstctl, txfflsh, 1);
-	CVMX_WAIT_FOR_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
-			      cvmx_usbcx_grstctl, c.s.txfflsh == 0, 100);
-	USB_SET_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
-			cvmx_usbcx_grstctl, rxfflsh, 1);
-	CVMX_WAIT_FOR_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
-			      cvmx_usbcx_grstctl, c.s.rxfflsh == 0, 100);
+	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, txfnum, 0x10);
+	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, txfflsh, 1);
+	CVMX_WAIT_FOR_FIELD32(address, cvmx_usbcx_grstctl,
+			      c.s.txfflsh == 0, 100);
+	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, rxfflsh, 1);
+	CVMX_WAIT_FOR_FIELD32(address, cvmx_usbcx_grstctl,
+			      c.s.rxfflsh == 0, 100);
 }
 
 /**
-- 
2.16.4
