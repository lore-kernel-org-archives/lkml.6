Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA01C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD4C21829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLWn8yQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD4C21829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeHMTIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:08:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47031 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMTIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:08:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so14771477wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nAuuGfEBqUzGmffhMdinMiP0Bbawez3wjdM3P55HzJ4=;
        b=qLWn8yQQpQHDhlTrwDiT63XTpFGoHP3P80dXof5vykQDOCgp7lq2VolWRDDzCnA/1+
         kB0E1TMqHs2lPHn+L0joY4b900PzTmPyVA7Dx3LrrvL8CsP7aM96iz73uJciAso8tDrw
         aafeaaaL8H/XdK/rsF7bAmHuWtg+7kwJCzsTi0qYhGIEI7g6Sq4xtTh7ucKB1HKpmWIG
         XEI5yh3mMLZgmwep29SayhYrovtmb3otjc19l1m3yB8UjK4WQ669xquX+m3m9Y43yEtO
         zlOtREBFUpg2oI9jg6m4QjffmVIsPeUfdvj89ZjqYo+0VpnNfbx3lY6+dkuShPhDWfuF
         K38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nAuuGfEBqUzGmffhMdinMiP0Bbawez3wjdM3P55HzJ4=;
        b=cgyhWX5SaxH7S85OPBqnMptqOEru638sdTr9+IJKA0joDUBzYqiWBUu0LWPmH4B4Dj
         QPBzJroTLSgZqmx2RBiNu/ApOsczhc8jGV3TKQ9rXV816390KxiHoKhMzOmkqafspjoO
         cnvhDYOhPYWSw4GZ09NCE8faEZQXgY6uqFLSv3YNBGQQyODsMBmS3yP5rVVRkTjJuiYx
         siCqzArrjGfsXtoDLefwR/O4qeAkqbQj8XHThXjYTKn5rQIeKsCAChCo3m5M7pQdaNsp
         G30nyvpYsRUVlJLVkLU6gGifecFcBfDiTLSf4jvm6ixrQX6yrhYgHrOV7+l7HQd1lcgf
         dOeg==
X-Gm-Message-State: AOUpUlGFinTfe4lhsjRo2/ysltfHfppH8mpavsayEVtirNJtAA0X1MX/
        NO9xG+Q5faovnze0sgoQ9ug=
X-Google-Smtp-Source: AA+uWPzt7S4pUQihopRcSxGthOxzdjQ4KvQXjdhf5EV2E5JT0hE5WCNOQL4DgPXeXgIbBng99fL00Q==
X-Received: by 2002:adf:8296:: with SMTP id 22-v6mr10689101wrc.252.1534177539595;
        Mon, 13 Aug 2018 09:25:39 -0700 (PDT)
Received: from we.local.lc (athedsl-4536824.home.otenet.gr. [94.70.6.0])
        by smtp.gmail.com with ESMTPSA id t198-v6sm17622264wmd.16.2018.08.13.09.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:25:38 -0700 (PDT)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: octeon-usb: Replaces CVMX_WAIT_FOR_FIELD32 macro with a function
Date:   Mon, 13 Aug 2018 19:25:29 +0300
Message-Id: <20180813162529.8969-1-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaces CVMX_WAIT_FOR_FIELD32 macro with equivalent function.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 56 +++++++++++++++++----------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cff5e790b196..f188e19c6fc1 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -377,29 +377,6 @@ struct octeon_hcd {
 	struct cvmx_usb_tx_fifo nonperiodic;
 };
 
-/* This macro spins on a register waiting for it to reach a condition. */
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
-
 /*
  * This macro logically sets a single field in a CSR. It does the sequence
  * read, modify, and write
@@ -593,6 +570,33 @@ static inline int cvmx_usb_get_data_pid(struct cvmx_usb_pipe *pipe)
 	return 0; /* Data0 */
 }
 
+/* Loops through register until txfflsh or rxfflsh become zero.*/
+static int cvmx_wait_tx_rx(struct octeon_hcd *usb, int fflsh_type)
+{
+	int result;
+	u64 address = CVMX_USBCX_GRSTCTL(usb->index);
+	u64 done = cvmx_get_cycle() + 100 *
+		   (u64)octeon_get_clock_rate / 1000000;
+	union cvmx_usbcx_grstctl c;
+
+	while (1) {
+		c.u32 = cvmx_usb_read_csr32(usb, address);
+		if (fflsh_type == 0 && c.s.txfflsh == 0) {
+			result = 0;
+			break;
+		} else if (fflsh_type == 1 && c.s.rxfflsh == 0) {
+			result = 0;
+			break;
+		} else if (cvmx_get_cycle() > done) {
+			result = -1;
+			break;
+		}
+
+		__delay(100);
+	}
+	return result;
+}
+
 static void cvmx_fifo_setup(struct octeon_hcd *usb)
 {
 	union cvmx_usbcx_ghwcfg3 usbcx_ghwcfg3;
@@ -634,12 +638,10 @@ static void cvmx_fifo_setup(struct octeon_hcd *usb)
 			cvmx_usbcx_grstctl, txfnum, 0x10);
 	USB_SET_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
 			cvmx_usbcx_grstctl, txfflsh, 1);
-	CVMX_WAIT_FOR_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
-			      cvmx_usbcx_grstctl, c.s.txfflsh == 0, 100);
+	cvmx_wait_tx_rx(usb, 0);
 	USB_SET_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
 			cvmx_usbcx_grstctl, rxfflsh, 1);
-	CVMX_WAIT_FOR_FIELD32(CVMX_USBCX_GRSTCTL(usb->index),
-			      cvmx_usbcx_grstctl, c.s.rxfflsh == 0, 100);
+	cvmx_wait_tx_rx(usb, 1);
 }
 
 /**
-- 
2.16.4

