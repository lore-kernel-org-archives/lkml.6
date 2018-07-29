Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9B9FF05E1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D744720893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiDz2o9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D744720893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeG2NLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:11:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32925 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeG2NLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:11:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so9674230wrp.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/zGWAdUrLWMAGHUtdiQhvL6RJgET92M5/TQg0/U+EuE=;
        b=ZiDz2o9fsfCqsA7qXJgnCM4tFlZ7R5RvDFKAJBh3dn+iEIIAcoMoOIkxpJBJ1hVEI+
         F1F670H3KRcsOiYpdPt4ikvPh4i51M4Jbz2JzC6dUSed8ltPZk1in5kFU2esuuCj9/OS
         n+sQ0oaSYZkvuXF1RAZapAs0gXSfBFb+dj45NGeKtREgCBxlwxA03yZR+rYe0IaxBeHj
         9QHCzhiF6h1Ej/8WybBk8LXYs/DwDE+4Fn4tWc5Q5wIvVj240N1YrjQnnLzPfKU5e7B1
         TUUijfytfY00wy4olAbohRknzaU7sxGddcTQAUIEqtuhaogt8NFEOjJU8apfRMU1ss0O
         kfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/zGWAdUrLWMAGHUtdiQhvL6RJgET92M5/TQg0/U+EuE=;
        b=mRDbkdGVm0ybWibMuwu6lDnqQkJzV7DFot+jpVhAQX70RBfq9qEO0YPAGZ6t4K0xMa
         3qKL3d3T0TikKi419ofkWMTZ8d65Hv/Rbymx+yBN+i4K3hBmGaTynwQA+LGokpr5j4x5
         /fiBNt2yDEr7mPB04Pd8A2A8za5E4OIzqasMeiVHuX8LcPKRMqBKuv7ecVj+DAbddhOy
         8+fRVY6c8S3jTRsX08p/c860U8WwdOy20pO+ZLt5C6eg1cAyPrhluqYhrMI9ajuuiZA6
         7KiIRTc7cRSIZrSWhMZzAI38i1wA5QHfSYlSIiEnYK5u1IUHaiz3qWApxIDbg4mh7eRy
         dMTQ==
X-Gm-Message-State: AOUpUlGAEV+r0mHyUkvUmKbEGnLzyALuRxbMKgsPTH5OC2oIlcJmnstR
        ptaXGk0PxIMpbeq5iXdcpW0=
X-Google-Smtp-Source: AAOMgpdlqPtNATWp8B/wm1HOE69QS4bAkY4JAiVoIZX9T6+wpSeotaihIvdciA/km9Wop8aS4A5Nhw==
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr7594425wri.221.1532864452842;
        Sun, 29 Jul 2018 04:40:52 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id z3-v6sm11742513wru.27.2018.07.29.04.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 04:40:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 76E476408D2;
        Sun, 29 Jul 2018 14:40:50 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0fSyIzIZ-Sil; Sun, 29 Jul 2018 14:40:50 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id 093B56408D3; Sun, 29 Jul 2018 14:40:50 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] Staging: octeon-usb: Changes macro CVMX_WAIT_FOR_FIELD32 to function call.
Date:   Sun, 29 Jul 2018 14:40:35 +0300
Message-Id: <0e52fbfefc34fe064201da9ad93e12e50e1e816c.1532864087.git.tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1532864087.git.tsotsos@gmail.com>
References: <cover.1532864087.git.tsotsos@gmail.com>
In-Reply-To: <cover.1532864087.git.tsotsos@gmail.com>
References: <20180727151527.GA2209@kroah.com> <cover.1532864087.git.tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing CVMX_WAIT_FOR_FIELD32 macro with equivalent function.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 65 +++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index 4615133292b5..8a7bdf1a9fe6 100644
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
@@ -593,6 +570,42 @@ static inline int cvmx_usb_get_data_pid(struct cvmx_usb_pipe *pipe)
 	return 0; /* Data0 */
 }
 
+/**
+ * Loop through register until txfflsh or rxfflsh become zero.
+ *
+ * @usb:           USB block
+ * @address:       64bit address to read
+ * @timeout_usec:  Timeout
+ * @fflsh_type:    Indicates fflsh type, 0 for txfflsh, 1 for rxfflsh
+ *
+ */
+static int cvmx_wait_for_field32(struct octeon_hcd *usb, u64 address,
+				 u64 timeout_usec, int fflsh_type)
+{
+	int result;
+	u64 done = cvmx_get_cycle() + timeout_usec *
+		   (u64)octeon_get_clock_rate / 1000000;
+
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
@@ -635,11 +648,9 @@ static void cvmx_fifo_setup(struct octeon_hcd *usb)
 	/* Flush all FIFOs */
 	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, txfnum, 0x10);
 	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, txfflsh, 1);
-	CVMX_WAIT_FOR_FIELD32(address, cvmx_usbcx_grstctl,
-			      c.s.txfflsh == 0, 100);
+	cvmx_wait_for_field32(usb, address, 0, 100);
 	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, rxfflsh, 1);
-	CVMX_WAIT_FOR_FIELD32(address, cvmx_usbcx_grstctl,
-			      c.s.rxfflsh == 0, 100);
+	cvmx_wait_for_field32(usb, address, 1, 100);
 }
 
 /**
-- 
2.16.4

