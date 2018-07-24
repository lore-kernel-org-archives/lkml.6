Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249C5C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB0E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V89ehpUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB0E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbeGXXbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:31:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40635 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388543AbeGXXbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:31:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so3211927wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1UnPdvQpdk1Rsid3I0cSCjatzFu+2xx59j/ZbzmYYRw=;
        b=V89ehpUXoHegh7NQdHH2maW4GD5QmYgMv1Q+aG72F9sk/4E/rd+xA6nrmZG5GLrRN5
         AGQesqcULUgQbKKE7D7dAGRHWO6o2UbXWdZIfYGBdngnnXRdT1ytXcZyIUI1luKq5o8J
         HRrNsYKCqcPXZtCB0bsWAuF9ZlnH9YjXzyfVvnSe5cmGxvw2s1NlIeYQwq3kGlsmw6ft
         FgT2R3ve8Y4ixyZZP8wqlrODko/dgB1roJFJ/iIYNuAZSpdDCZb1meqDzhcN3mnCbyZD
         QW+9dREJt95/nO1OG9HkmZHMB2Wj79+B6A+PoL5DrjX01qbdDxndJv38aLM1EPbAp6Za
         LAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1UnPdvQpdk1Rsid3I0cSCjatzFu+2xx59j/ZbzmYYRw=;
        b=RKaVoVS7NlQ8oUXaLfVQ2Pj/8+VwBJ/hftuBu2rXtMSPADT7/Ts/nziFi/a0XI+BTo
         7pcvFSJuAL5+JztEF8smv06lxq9YBz3jcPZ11ojoNrIBPqMAjMcY8ImXHs1ArjgJYlhI
         6Fx0IhPmAyS4EWwW1X9ht4l+OcnkkrSshDYl6DTBF01vw7d0gPGqqUK2X9rygP2Vka76
         Y/Ifn+m3ky5L/n7jTT1DmQci0Uq97O+qXcRUQSdUiP5SzZ2ldCBdsxg6BJTsZRR5hQJr
         xkZa8xu4A2iZeEtYl3Ih0bGmmObg4HdqKIjFWWw9WEecbjl/fE3aEhsIi9D0tTVeUYTE
         T+AQ==
X-Gm-Message-State: AOUpUlFc5rtx2KnCgA/O4ohRhbfEOHI/szkdZuMtODlBjPy1HprjXGtm
        4U1G3Pi+lhbzB687Hbq1yRo=
X-Google-Smtp-Source: AAOMgpdkzBVhYaV8g4nweSy3Z5H91yNHHeaU0k5Pi3CY+rTvsQ2sfIo4prnKKStjcxbEO705pqNyEQ==
X-Received: by 2002:a1c:ee5d:: with SMTP id m90-v6mr3059050wmh.107.1532470945099;
        Tue, 24 Jul 2018 15:22:25 -0700 (PDT)
Received: from we.local (athedsl-4407117.home.otenet.gr. [79.130.175.61])
        by smtp.gmail.com with ESMTPSA id w9-v6sm19871534wrk.28.2018.07.24.15.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:22:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 9F1D06408C0;
        Wed, 25 Jul 2018 01:22:22 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pP04Jm6Wa8Qx; Wed, 25 Jul 2018 01:22:22 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id 61AC86408C1; Wed, 25 Jul 2018 01:22:21 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Staging: octeon-usb: Change coding style for CVMX_WAIT_FOR_FIELD32 marco.
Date:   Wed, 25 Jul 2018 01:22:10 +0300
Message-Id: <20180724222212.8742-4-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180724222212.8742-1-tsotsos@gmail.com>
References: <20180724222212.8742-1-tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes coding style and encapsulate into parentheses timeout_usec.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 44 +++++++++++++++++----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index 0d3ec12788fc..84986252720d 100644
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

