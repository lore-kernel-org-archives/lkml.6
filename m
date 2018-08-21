Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D5EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FDD21837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV2s1dCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FDD21837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeHUUts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:49:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32876 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeHUUts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:49:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id h9-v6so3715373edr.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=V7JcX9TJkFRIeYghVVBHAuxKIL9Ien7WkapaghyRol8=;
        b=EV2s1dCY8uxfwzItB+GtPndUPuX6eSWlQBl3OkZGP/ZDRfYqJiQNmM/3VBv9xF6/CE
         T2lTY++pfySV3cPcPWjwm+wAXNf9BPxM64O2oxLpqfLN9SeoD9FRTp2tTxO8Uk8R+FvH
         TryF3Mc7oEGYEaM+c3qV/UQ14kHTX+dcchsrDgk52UWNAnig3/QpPxykIfBwvXkCcBeI
         aHxv4RimZoOG8vUzLc7FkUho12GaB80BIItYhgxVzLPNvZ6DAa/TnBfHN6984k5KrNYB
         aY7lCp5H5hQx46Z4CPbkxra9k8lLPYftAVJGKESnvz7Jm4WrF3OY2ZrfQIWJwdy5QHNl
         SMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=V7JcX9TJkFRIeYghVVBHAuxKIL9Ien7WkapaghyRol8=;
        b=rNnTBTh1mtN2XmYMSFti+XMGUC6dR+JsRp3D7XxCGi6RAye/5jUcw61hFelr/cAt9+
         1VTKLCnCtz+Vx7tgnzprm05RQx49AnoCWXRZaQzRZTX/YFcLfGTXhBoEXxWnNVZCPyOw
         pMECMukusSHHU7u3zahBZQPmDhYqrVafyifQxB3hcpBx/4TAaYDTbloo2ZX2xF0RXTZe
         pYEyIu2KQUC7XQeUOAjmDv9hN2EuN7YOAhUhoCSSjPAfzV4wRzfbfiK+zoI/sApRRld7
         Wnq+xAVPzjlCl13LaSKNPcHluV9Kp4TX2YC9UbgE+gwKCF0+EAvM04Q4Y4NBE1KG4R6n
         ljDQ==
X-Gm-Message-State: AOUpUlELveFe03HKykTsBdYvGbrM3JWGuVJ4VJqWezJAB+okvXxKWjH8
        K+3sUxVh3Wc09j8TcHXcTHU=
X-Google-Smtp-Source: AA+uWPxiiMeH2vyz+Q0oTjzeV0N5mrlilEvNh+4UMwMPaWa/NLM4+LEf+PRlEfX7t34OeVY/j6cCqw==
X-Received: by 2002:a50:dd4b:: with SMTP id u11-v6mr63586699edk.298.1534872523522;
        Tue, 21 Aug 2018 10:28:43 -0700 (PDT)
Received: from dell.be.48ers.dk (d51a5bc31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id w1-v6sm9599668eda.63.2018.08.21.10.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 10:28:42 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peko@dell.be.48ers.dk>)
        id 1fsASP-00087E-Gf; Tue, 21 Aug 2018 19:28:41 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH] ttyprintk: make the printk log level configurable
Date:   Tue, 21 Aug 2018 19:28:22 +0200
Message-Id: <20180821172822.30975-1-peter@korsgaard.com>
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
index 67549ce88cc9..22fbd483b5dc 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -37,6 +37,8 @@ static struct ttyprintk_port tpk_port;
  */
 #define TPK_STR_SIZE 508 /* should be bigger then max expected line length */
 #define TPK_MAX_ROOM 4096 /* we could assume 4K for instance */
+#define TPK_PREFIX KERN_SOH __stringify(CONFIG_TTY_PRINTK_LEVEL) " [U]"
+
 static int tpk_curr;
 
 static char tpk_buffer[TPK_STR_SIZE + 4];
@@ -45,7 +47,7 @@ static void tpk_flush(void)
 {
 	if (tpk_curr > 0) {
 		tpk_buffer[tpk_curr] = '\0';
-		pr_info("[U] %s\n", tpk_buffer);
+		printk(TPK_PREFIX " %s\n", tpk_buffer);
 		tpk_curr = 0;
 	}
 }
-- 
2.11.0

