Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834E3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2031920861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW7bx6+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2031920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIGM6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:58:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42145 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeIGM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:58:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id l5so10912020edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=N2nxlAPwxCY787lzi2fWINFuw6kMiTtSA+BaIRlVVdE=;
        b=nW7bx6+FX6MuobpiNK93j+S9ZGNeI/hBMyS89GouGnTHZ7V6MLuc1NYVZCUbzCgLQL
         FPj8IVCweZKFQ2RKmwmJbjiJN+NFIMW2XnRhdA+cUiga/ACETl/uOTX9Sikbimst8Yag
         i6peVuJkiNNKfLHw7OXUEDBlvi67+FNDOd8kOnhfpsnJI2ldc3+r9r7PLqZduf7qICuG
         U8CkMf2iiS8nmk3h0w/dtw+s0bIqSTNBWxrMXrzkTsjTB3oX3B3UFzUO7hbx0+CFQ2w3
         SyOnu1UyAclJIbPJxe8fcDiPa6AYnDffKB3Od+l/ED3OGnuvj4T65FfgdmIT+L4F/b+C
         s8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=N2nxlAPwxCY787lzi2fWINFuw6kMiTtSA+BaIRlVVdE=;
        b=gfPaJOPDDBcvvBAVK8X+ywCVahMNzkvnmnqZn5Gm1HqqPcGWImlsKnE/IWhHiL8aAG
         6mwIocwu/t8irjmApa2xX0uazXi29aPVhQiruUC+/kd474lyhkuoc1nv2y/7R77gkkdJ
         kIYyRfABLsjfuU5HllRi7kPzemx3DeAbbeW+MlhmzqS0SFjOEucu3CTKiVxjN9YWFmg5
         yZji5KTcJq2xIGel6G6VUawMzMjsUPRVsipjAiJE1qkasg11gt71uRS5R3/84RSah6Lv
         NsJkq3nSdku0m1ziy915AUC3E4oh1fOMaXFCxjZfRJRqeLauFeCfhji7lk0zh9ieSLLD
         0ptw==
X-Gm-Message-State: APzg51BfOHGdhFemdgZO4JsIp6t8m3SRxHNBQqud5vY3cC4HWpaBZG6d
        niu2pV6j1rkmKTL+Kc0/nhY=
X-Google-Smtp-Source: ANB0VdaNZEhKJVWIjDeUcobZVRbxRIPYW/CtWOc76rGeR6HDBgbo3uMMykz5JaQaw+QRIiQFN8N0tg==
X-Received: by 2002:a50:a9a4:: with SMTP id n33-v6mr7741856edc.208.1536308294592;
        Fri, 07 Sep 2018 01:18:14 -0700 (PDT)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id w20-v6sm9301172edc.12.2018.09.07.01.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 01:18:13 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peko@dell.be.48ers.dk>)
        id 1fyBy0-0005dO-VV; Fri, 07 Sep 2018 10:18:12 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH v2] ttyprintk: make the printk log level configurable
Date:   Fri,  7 Sep 2018 10:18:10 +0200
Message-Id: <20180907081810.21615-1-peter@korsgaard.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some use cases it is handy to use a different printk log level than the
default (info) for the messages written to ttyprintk, so add a Kconfig
option similar to what we have for default console loglevel.

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
Changes since v1:
- Leave [U] prefix in printk invocation and drop space before it as
  suggested by Joe Perces.

 drivers/char/Kconfig     | 8 ++++++++
 drivers/char/ttyprintk.c | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index ce277ee0a28a..14a7f023f20b 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -66,6 +66,14 @@ config TTY_PRINTK
 
 	  If unsure, say N.
 
+config TTY_PRINTK_LEVEL
+	depends on TTY_PRINTK
+	int "ttyprintk log level (1-7)"
+	range 1 7
+	default "6"
+	help
+	  Printk log level to use for ttyprintk messages.
+
 config PRINTER
 	tristate "Parallel printer support"
 	depends on PARPORT
diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 67549ce88cc9..88808dbba486 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -37,6 +37,8 @@ static struct ttyprintk_port tpk_port;
  */
 #define TPK_STR_SIZE 508 /* should be bigger then max expected line length */
 #define TPK_MAX_ROOM 4096 /* we could assume 4K for instance */
+#define TPK_PREFIX KERN_SOH __stringify(CONFIG_TTY_PRINTK_LEVEL)
+
 static int tpk_curr;
 
 static char tpk_buffer[TPK_STR_SIZE + 4];
@@ -45,7 +47,7 @@ static void tpk_flush(void)
 {
 	if (tpk_curr > 0) {
 		tpk_buffer[tpk_curr] = '\0';
-		pr_info("[U] %s\n", tpk_buffer);
+		printk(TPK_PREFIX "[U] %s\n", tpk_buffer);
 		tpk_curr = 0;
 	}
 }
-- 
2.11.0

