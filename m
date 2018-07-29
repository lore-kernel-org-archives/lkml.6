Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C04BC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D063520894
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw7k4s08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D063520894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeG2Poq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 11:44:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53013 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeG2Poq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 11:44:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so10233116wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bgNu5LgSX8fFKDvO30Ae8hHfWRzOacOvGP3ObXSNYFE=;
        b=hw7k4s08P/Bo7LST3dgzxW12SyY/tUK6lH1+TVHhmnE/B53Ehh4koQA+ptGGTpps31
         M7pVitYtEUKq3lHARttEU2ymLNzwXd+0Gnw88ktavBsILPMhf+oGf/LZd+t2Nc9Jo77H
         6+50jfl9U8KbA43YIDq1R9uvh2BiizMnVXCijfT0HIhYZqYO8sTFSehOaCufnGXwvdJA
         p4FfFvQQZVssJmw9szaaCFF2I34aJz89gTMEnDO0cP3lyBUzXmCj8YGJMPeXlF/XHK6z
         skT+VOtygaLIUoRB5Doo1rhR5ngP1jWdsCEGpu2BPov+u6EfFKB+8as1PMRWzG8KbHti
         JL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bgNu5LgSX8fFKDvO30Ae8hHfWRzOacOvGP3ObXSNYFE=;
        b=jzm4gkA80oCuQie64216+o8FgtMKik4zJdFqAY5mCGImzsrfITL7zUa4w+EYlfQWxs
         8OTW94w8p0mddPqsE2K1mwaMXxz5c6r4gKDRFRu2ImCI4lwCmAyLJYOLWJEeKLT5GzyS
         tSsertA+jwA20lJeN35Fildme+J6BzHpWatufXOCx6DSSW1AiuFq77ZpEhHprIDvE4PI
         QVDdxHYd+OiH01GBr/QZVmPsxlChlh9JhFmMletGzqLhr+oYIaB7iA7y/BYm4ZOdNQUC
         KZJrEXfmpv2v915hGbBXLYLuox8eMIO5Lz3P1psgyQmA8U9q+kmcxLMdnTC6ycU+33RK
         HZIQ==
X-Gm-Message-State: AOUpUlFAO0E0riOEI+4ONRju8Yi4FtaMM7MW2xCAL2XQQAPBRe92XipY
        eclZEpRhrNPXvTXBMcyQyto=
X-Google-Smtp-Source: AAOMgpdc4roPP1pvkYcVYs2ZBhEIcVfsA4xbHcj2G4OPoqtYWq0+qL7SgIlWhFUFylNjdl6Ex0OfOw==
X-Received: by 2002:a1c:d10c:: with SMTP id i12-v6mr7005761wmg.133.1532873648345;
        Sun, 29 Jul 2018 07:14:08 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id q77-v6sm2960362wmb.38.2018.07.29.07.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 07:14:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 709956408D2;
        Sun, 29 Jul 2018 17:14:06 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lAtOjIRfZTtN; Sun, 29 Jul 2018 17:14:05 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id EDAD36408D3; Sun, 29 Jul 2018 17:14:05 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] Staging: octeon-usb: Changes macro CVMX_WAIT_FOR_FIELD32 to function call.
Date:   Sun, 29 Jul 2018 17:13:35 +0300
Message-Id: <20180729141335.32501-2-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180729141335.32501-1-tsotsos@gmail.com>
References: <20180729141335.32501-1-tsotsos@gmail.com>
In-Reply-To: <20180727151527.GA2209@kroah.com>
References: <20180727151527.GA2209@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing CVMX_WAIT_FOR_FIELD32 macro with equivalent function.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
v2: Changed CVMX_WAIT_FOR_FIELD32 syntax to avoid checkpatch check notice and
tried to make the macro more readable.
v3: Changed CVMX_WAIT_FOR_FIELD32 macro to function according as refereed in 
commit message and suggested by Greg Kroah-Hartman
v4: Added patch version text

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
