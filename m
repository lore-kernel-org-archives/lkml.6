Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0E0C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B822220880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md4YNuuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B822220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbeGXXsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:48:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34633 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388495AbeGXXsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:48:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so13371913wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1UnPdvQpdk1Rsid3I0cSCjatzFu+2xx59j/ZbzmYYRw=;
        b=Md4YNuuAbrJUAanZ2agBJdHJt6wp485TSrnahN24mAuXFTg+RXJHUchLxPblHwHgkl
         HUe1fnvvjZzZKyrkrwrN4CiWS8+l3Ex9uWPNiq4HNjDCv+A8b8EM1sMVhZ1xbE+xMQib
         c/WQzh5r/A7NdB77OxUghFwU7tp/rPm5jkoMV8+59XKVWWE8Rhegf/sudjz/oTADhgxU
         s/ZJmEer/HzruEfTvclKM0LVpJUCQYwFpZOS/M4pE3rtSiKMwK/JsAE4IzEiX2DPNeBi
         K8hRsndTcGp7yZOTxXvD4rfvLAMY8XDyXs3tjwz0bwfjYaG1UYXWHM50ue8ygIA1zee7
         jJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1UnPdvQpdk1Rsid3I0cSCjatzFu+2xx59j/ZbzmYYRw=;
        b=l2LtPDFUNSeh8A82y80UFHj2m91PSdox+HuU5Yy6kes8A24FIxY/YJ0TqFh4O33Yw6
         5oLbOKyMyOMjCm1IMhazfRCuf7Pp3siCFnt+Ezvam++uvf31AnmT8enoeQbWwpxv6rnt
         D33+s6vDxQQ9h7h+l8AiKJ/z18n0RzavEUTFnLYOIwd4r9nYh4ohqZfFlge47Vijj0EI
         ygv3x6B1eIR424Dr3oYDPi/4iozvaw0+onxSi7vdQdypAA/DDEIn8zAj09TrK+AjMDak
         eeq3hqocPrSnMuO/p+E96vqQyYaAHTj+U/Tcdeb1Cpixk/B/d6R0OCt4OKPzuZCOSJIj
         0JMg==
X-Gm-Message-State: AOUpUlGSZDNkDJkLWvGQT+JFx/JJrPzYChpEAc+WRaHISgDUA7H2+R/H
        b3hxjii+81BFeTybYNCMKQc=
X-Google-Smtp-Source: AAOMgpfhDN04aXOw2B3C6zDb1TCcadSlcMommYMcV3p7hh94Od8gh6lA4vIRZmTuMhPKqPZBMrVgRw==
X-Received: by 2002:a1c:68f:: with SMTP id 137-v6mr3159350wmg.82.1532471963011;
        Tue, 24 Jul 2018 15:39:23 -0700 (PDT)
Received: from we.local (athedsl-4407117.home.otenet.gr. [79.130.175.61])
        by smtp.gmail.com with ESMTPSA id y14-v6sm24823891wrq.45.2018.07.24.15.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:39:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 42EAA640816;
        Wed, 25 Jul 2018 01:39:21 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UF8pqt0p9_Qx; Wed, 25 Jul 2018 01:39:20 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id CBAE0640824; Wed, 25 Jul 2018 01:39:20 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Staging: octeon-usb: Change coding style for CVMX_WAIT_FOR_FIELD32 marco.
Date:   Wed, 25 Jul 2018 01:38:52 +0300
Message-Id: <20180724223853.10198-4-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180724223853.10198-1-tsotsos@gmail.com>
References: <20180724223853.10198-1-tsotsos@gmail.com>
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

