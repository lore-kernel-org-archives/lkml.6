Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBCBC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D050A20875
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQktK3zM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D050A20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeG2XzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:55:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44886 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbeG2XzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:55:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so10703414wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9IMjNOqZ59KEl3T6bB6oFS4zcfIm37gFNIXZmEfYJug=;
        b=NQktK3zMDt1JpdkdUsFzqWwVbm+e4103RJPaXBnREVIKut1RBl46Uk+NWHH1LbFcJP
         yzeq+wbP/1P64ZoykNLil+Xund3h0CfB745QSKKug8M5p/ziIHW6Dh5XPXWbFVh6Kr1F
         /QQykgOafvIodjpPcJHw7h9nnA1mpO0VQy8MVDuyvu0kTbZGJYtbhNN7j1mxjOK+8JwD
         2Eg5syxUVIwvJYDnJDsk1cBoZfX9lmOcGbOhdtslGJrQfR44hoTYNmhh3soZcdXn23bT
         fhT1hqQ9Jwuq37pmKIm8u9FozPOY5kFo8G2og9B95hXHMR0TGq5HoVaeBjhc4n+1yP8R
         zbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9IMjNOqZ59KEl3T6bB6oFS4zcfIm37gFNIXZmEfYJug=;
        b=ds5uh/NHe+WHOF4A0mqa4BBpkAGV4cynPdtorCb3mVvnkit3QOtQVwTetYJPL6Z7yT
         9F3v3LWXJHyNJLrMwRTrgfjPpNoKg8CrtmcoGtmkIcqFF5PC77AXVzNlXoz8p8IvPgv9
         UGysNOh+wLVU85cLvUnCluaQWZlEKZZjxKQRP0CBWdjt2kQjYrSl4G6bPzeNmCF0F57o
         WHI6dIIC1xFEXb04LKxs5KbL0PNEyAVmsWNN0NTEBc5VQYo4/QgO/ISZaN9DEGiRYdhz
         NaTeg+N12zYVsOdp1wWlFrGhmIVeH3/4vL6U3moCOJt8okfxhESEGB9yw/CkwziBNLGR
         gy6w==
X-Gm-Message-State: AOUpUlHI08zyCdqCOTjStKo+IrTpYPm7NXSm+Dv/+esWpIteJjdX2WDr
        lTDfh9Dy+JN1zNLzZcBYmILkjFhn
X-Google-Smtp-Source: AAOMgpdQL0qJyZbntPpUtCaiHvvUSkTjF0+StYBbR3Q/yyHiejvw/OrZbCQhLpvcwbLz19nXXixJTw==
X-Received: by 2002:a5d:44c6:: with SMTP id z6-v6mr14766270wrr.236.1532902979849;
        Sun, 29 Jul 2018 15:22:59 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id u4-v6sm17193488wrt.31.2018.07.29.15.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 15:22:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id DE67D6407C0;
        Mon, 30 Jul 2018 01:22:57 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FwigCbc3Sak1; Mon, 30 Jul 2018 01:22:56 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id 6972F6408DF; Mon, 30 Jul 2018 01:22:56 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] Staging: octeon-usb: Changes macro CVMX_WAIT_FOR_FIELD32 to function call
Date:   Mon, 30 Jul 2018 01:22:48 +0300
Message-Id: <20180729222248.27180-1-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180729140522.32173-2-tsotsos@gmail.com>
References: <20180729140522.32173-2-tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing CVMX_WAIT_FOR_FIELD32 macro with equivalent function, and used
simpler approach for new function's parameters.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
v3: Changed CVMX_WAIT_FOR_FIELD32 macro to function according as refereed in
commit message and suggested by Greg Kroah-Hartman
v4: Added patch version text
v5: Fix parameters issue and simplify new function.

 drivers/staging/octeon-usb/octeon-hcd.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index edf87d1b3609..c9fbff93bed4 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -574,18 +574,15 @@ static inline int cvmx_usb_get_data_pid(struct cvmx_usb_pipe *pipe)
  * Loop through register until txfflsh or rxfflsh become zero.
  *
  * @usb:           USB block
- * @address:       64bit address to read
- * @timeout_usec:  Timeout
  * @fflsh_type:    Indicates fflsh type, 0 for txfflsh, 1 for rxfflsh
  *
  */
-static int cvmx_wait_for_field32(struct octeon_hcd *usb, u64 address,
-				 u64 timeout_usec, int fflsh_type)
+static int cvmx_wait_tx_rx(struct octeon_hcd *usb, int fflsh_type)
 {
 	int result;
-	u64 done = cvmx_get_cycle() + timeout_usec *
+	u64 address = CVMX_USBCX_GRSTCTL(usb->index);
+	u64 done = cvmx_get_cycle() + 100 *
 		   (u64)octeon_get_clock_rate / 1000000;
-
 	union cvmx_usbcx_grstctl c;
 
 	while (1) {
@@ -648,9 +645,9 @@ static void cvmx_fifo_setup(struct octeon_hcd *usb)
 	/* Flush all FIFOs */
 	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, txfnum, 0x10);
 	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, txfflsh, 1);
-	cvmx_wait_for_field32(usb, address, 0, 100);
+	cvmx_wait_tx_rx(usb, 0);
 	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, rxfflsh, 1);
-	cvmx_wait_for_field32(usb, address, 1, 100);
+	cvmx_wait_tx_rx(usb, 1);
 }
 
 /**
-- 
2.16.4
