Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B593C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44E120837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4rdl8mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44E120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbeLGO1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:27:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34693 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeLGO1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:27:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so4026051wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 06:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O9uuRd5pfY509NuMLIC/5QxRbASqWsAR5l3rSXHqJbY=;
        b=Z4rdl8mWVLNtxLR51fhFUjPDUfmzuQk0MjL1hrWhfsfkI7jYAjmzdbV1c3jf0hTJIY
         NzH6BmGg87qESE3gm2WE5noKdgsJOfIN+9UZprLe2YS8dlEkMPV2GopS10oiy9bfSWfH
         ENhDSKWg+fesXwwfacGKpn1BuFtGPbfx1fm1m2lyCq/F9pAK0npQnrLoWW6HMct/Z6hQ
         2it9n4VgkERRGKmSkKqa2jCDyYipgDQf/y8+rvXRmz33Ms3XUbAw6lzmdhgALCUZmkOy
         DwRY005Wipz6kJj0USv5ECAibtjKvqRPvPDxFQ0k7fsmh91WsMl8opCp2ocQu20rbMFQ
         yLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O9uuRd5pfY509NuMLIC/5QxRbASqWsAR5l3rSXHqJbY=;
        b=hpOaIt+TTdWlbbisFuTOKzJ6ctM3PlfIIGwS57X8BhzoXtiaGgZwCI3p5zeFq7J4Uk
         aFCtMa2Uq/2spA5Sx/MbtLfC95SotxQYL/WiMhzzcSQ97yGzCSNKqDXwtWo1l/iQgGU8
         C/jzxxtac0FEYBjimr6LgboycuJkwkRkBIJLwg2tkdH4/S+5/QbLu16zpzZCMl0W3o6d
         yv/cGSp7pOdUHbJiWadWyLvWXbVARBy0jSof5vR7nP5Z9YppmTOCoeSztIJoS8x7qNjO
         VQpV6gGGaNael35j85FnceEhoEsHdRiUvQD9O392K7EnXorwnhI3OsUoM0fqIASo6PRg
         fbNw==
X-Gm-Message-State: AA+aEWbcWXawg7XNMdt6O6rJyt8l2ykorvCAg9o1NAV7+my8l+whlAjC
        0sIOGpARv8Ub6C6r+hdYMtQ=
X-Google-Smtp-Source: AFSGD/VPV4HzALi0gLu974MaoWU6F0hpqQMKlovBOvhp7/qiPMkRBW97v8i9N95YKOrJlRSROc6CBA==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr2111067wrj.58.1544192860975;
        Fri, 07 Dec 2018 06:27:40 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id 60sm7172523wrb.81.2018.12.07.06.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 06:27:40 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/5] char: lp: detach the device when parallel port is removed
Date:   Fri,  7 Dec 2018 14:27:31 +0000
Message-Id: <20181207142734.27370-2-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207142734.27370-1-sudipm.mukherjee@gmail.com>
References: <20181207142734.27370-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the parallel port is usb based and the lp attaches to it, we do
get /dev/lp0, but when we remove the usb device and the parallel port
is gone, we are still left with /dev/lp0.
Unregister the device properly in the detach routine based on the port
number it has connected to.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/char/lp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 7e207ff0f2fe..e21ed4007d0f 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -976,6 +976,8 @@ static void lp_attach(struct parport *port)
 
 static void lp_detach(struct parport *port)
 {
+	int n;
+
 	/* Write this some day. */
 #ifdef CONFIG_LP_CONSOLE
 	if (console_registered == port) {
@@ -983,6 +985,14 @@ static void lp_detach(struct parport *port)
 		console_registered = NULL;
 	}
 #endif /* CONFIG_LP_CONSOLE */
+
+	for (n = 0; n < LP_NO; n++) {
+		if (port_num[n] == port->number) {
+			port_num[n] = -1;
+			device_destroy(lp_class, MKDEV(LP_MAJOR, n));
+			parport_unregister_device(lp_table[n].dev);
+		}
+	}
 }
 
 static struct parport_driver lp_driver = {
@@ -1082,8 +1092,6 @@ static int __init lp_init_module(void)
 
 static void lp_cleanup_module(void)
 {
-	unsigned int offset;
-
 	parport_unregister_driver(&lp_driver);
 
 #ifdef CONFIG_LP_CONSOLE
@@ -1091,13 +1099,6 @@ static void lp_cleanup_module(void)
 #endif
 
 	unregister_chrdev(LP_MAJOR, "lp");
-	for (offset = 0; offset < LP_NO; offset++) {
-		if (lp_table[offset].dev == NULL)
-			continue;
-		port_num[offset] = -1;
-		parport_unregister_device(lp_table[offset].dev);
-		device_destroy(lp_class, MKDEV(LP_MAJOR, offset));
-	}
 	class_destroy(lp_class);
 }
 
-- 
2.11.0

