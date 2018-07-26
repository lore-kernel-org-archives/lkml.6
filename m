Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D58BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0042083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrnN1Ev7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0042083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbeGZOrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:47:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34027 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbeGZOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:47:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so1739941wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 06:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/ckAjEk4IalBCR92uNU6B9/d6ldGAozsXpiokoTQ9Kw=;
        b=hrnN1Ev7sFcKvGM5js5mM9N05wAhQ0QXz+Lp29E4OuNJYtC95zng8VtMyd3266mQUP
         h+vjanSRsLrCdvBHiANRpQX0gGXhvuTFjLDyUeuFFcxXhVWIomuhfwZuUuY+6nAFzOqa
         bCFjt1LF0qc6CehwXr/VUY7m+P7nSaoQuNRQ3IPlVQRxnYzQte5kiQQT4pDIHmis1rYo
         zUC+PPQu3RW3P1WY2yiVV+/eSL9JwG2eXCGTyN2ATZqHXsqSsYYOZxcsoQvPxr4ItG2Q
         liAZ5jw62gukzhji3Eo9EUUshWx80HuPS2FGeAsFt7Q+8yRhGB0L7VBSrjr+ZovR5SmI
         J5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/ckAjEk4IalBCR92uNU6B9/d6ldGAozsXpiokoTQ9Kw=;
        b=sveQJ+KgVjOlY1EieUEmeU0LhC+Nwbs82uj0TVfT0KflfnNX7F243WQ5kLZNlYtsP9
         OzKum9Ai68oFZMhy4H8wRYbt0eW3E6dnl8GKN/URi3RJWSpBSkxiPjVEYUxCdGscZQH4
         NCnPdQnupHj8UyKVYLAHhxHE3//3/oej80vxZUP11PqFkuINx7UK2jU2yc6LElqobcBk
         0mpPMnLc6rkM+LiW8sL0ScDXs8Zx7W/03CPkQWZUafx/N/XNd0FzwrxFhs/1zB71g69n
         EfYd1juOSm3Up/WtegjDabiQtDtZ3K0rMe4GiFA5GORKvPUcObSNXLjZYmbhserp2nS1
         9ung==
X-Gm-Message-State: AOUpUlG5Wg+CFE7SHEIJdkBGWlhCxNqDL8J03MCSRYw8Y7VTgmPuYy4x
        I3sk2uXSuzpLkxbAviRd5zBQPs+U/kU=
X-Google-Smtp-Source: AAOMgpex7Dl4ArHYNKr28IVI5lQWj9LEA2+ynysQb5coBQQwn4N09ixykU8c0Fl6EupBWpieJ2zcyw==
X-Received: by 2002:adf:94e2:: with SMTP id 89-v6mr1596812wrr.48.1532611823661;
        Thu, 26 Jul 2018 06:30:23 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id r5-v6sm1131342wmc.39.2018.07.26.06.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 06:30:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 2A4296408C4;
        Thu, 26 Jul 2018 16:30:21 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lM9L_mjyEtJP; Thu, 26 Jul 2018 16:30:20 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id EB18F6408C8; Thu, 26 Jul 2018 16:30:18 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Staging: octeon-usb: Breaks down cvmx_usb_poll_channel().
Date:   Thu, 26 Jul 2018 16:30:09 +0300
Message-Id: <4465097e58f6dbc0e19b9e945ac0b8eee5d98726.1532610629.git.tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1532610629.git.tsotsos@gmail.com>
References: <cover.1532610629.git.tsotsos@gmail.com>
In-Reply-To: <cover.1532610629.git.tsotsos@gmail.com>
References: <cover.1532610629.git.tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make this function more clear a new function created that controls
channels halt on no DMA mode.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 83 +++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index c8e0ebf1434f..f9f429d385ce 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -2585,6 +2585,52 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
 	}
 }
 
+/**
+ * Handles channels halt in non DMA mode
+ * @usbc_hcchar: Host Channel-n Characteristics Register (HCCHAR)
+ * @usbc_hcint:  Host Channel-n Interrupt Register
+ * @usb:         USB device
+ * @channel:     Channel to poll
+ *
+ * In non DMA mode the channels don't halt themselves. We need
+ * to manually disable channels that are left running
+ *
+ * Returns: -1 on halt
+ */
+static int cvmx_usb_dma_halt(union cvmx_usbcx_hccharx usbc_hcchar,
+			     union cvmx_usbcx_hcintx usbc_hcint,
+			     struct octeon_hcd *usb,
+			     int channel)
+{
+	struct usb_hcd *hcd = octeon_to_hcd(usb);
+	struct device *dev = hcd->self.controller;
+
+	if (usbc_hcchar.s.chena) {
+		union cvmx_usbcx_hcintmskx hcintmsk;
+		/* Disable all interrupts except CHHLTD */
+		hcintmsk.u32 = 0;
+		hcintmsk.s.chhltdmsk = 1;
+		cvmx_usb_write_csr32(usb,
+				     CVMX_USBCX_HCINTMSKX(channel, usb->index),
+				     hcintmsk.u32);
+		usbc_hcchar.s.chdis = 1;
+		cvmx_usb_write_csr32(usb,
+				     CVMX_USBCX_HCCHARX(channel, usb->index),
+				     usbc_hcchar.u32);
+		return -1;
+	} else if (usbc_hcint.s.xfercompl) {
+		/*
+		 * Successful IN/OUT with transfer complete.
+		 * Channel halt isn't needed.
+		 */
+	} else {
+		dev_err(dev, "USB%d: Channel %d interrupt without halt\n",
+			usb->index, channel);
+		return -1;
+	}
+
+	return 0;
+}
 /**
  * Poll a channel for status
  *
@@ -2595,8 +2641,6 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
  */
 static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 {
-	struct usb_hcd *hcd = octeon_to_hcd(usb);
-	struct device *dev = hcd->self.controller;
 	union cvmx_usbcx_hcintx usbc_hcint;
 	union cvmx_usbcx_hctsizx usbc_hctsiz;
 	union cvmx_usbcx_hccharx usbc_hcchar;
@@ -2627,35 +2671,16 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 					     usbc_hcchar.u32);
 			return 0;
 		}
-
-		/*
-		 * In non DMA mode the channels don't halt themselves. We need
-		 * to manually disable channels that are left running
-		 */
+		/* In case of non DMA mode handle halt */
 		if (!usbc_hcint.s.chhltd) {
-			if (usbc_hcchar.s.chena) {
-				union cvmx_usbcx_hcintmskx hcintmsk;
-				/* Disable all interrupts except CHHLTD */
-				hcintmsk.u32 = 0;
-				hcintmsk.s.chhltdmsk = 1;
-				cvmx_usb_write_csr32(usb,
-						     CVMX_USBCX_HCINTMSKX(channel, usb->index),
-						     hcintmsk.u32);
-				usbc_hcchar.s.chdis = 1;
-				cvmx_usb_write_csr32(usb,
-						     CVMX_USBCX_HCCHARX(channel, usb->index),
-						     usbc_hcchar.u32);
-				return 0;
-			} else if (usbc_hcint.s.xfercompl) {
-				/*
-				 * Successful IN/OUT with transfer complete.
-				 * Channel halt isn't needed.
-				 */
-			} else {
-				dev_err(dev, "USB%d: Channel %d interrupt without halt\n",
-					usb->index, channel);
+			int dma_halt_status = 0;
+
+			dma_halt_status = cvmx_usb_dma_halt(usbc_hcchar,
+							    usbc_hcint,
+							    usb, channel);
+
+			if (dma_halt_status < 0)
 				return 0;
-			}
 		}
 	} else {
 		/*
-- 
2.16.4

