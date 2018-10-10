Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E320C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50DD2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN7PZquk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50DD2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJKCMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:12:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37049 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJKCMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:12:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id c22-v6so5907922edc.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 11:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=N2nxlAPwxCY787lzi2fWINFuw6kMiTtSA+BaIRlVVdE=;
        b=MN7PZqukqNTvxHUMortt05cwxkZm9AKwieQjBjZGS7Crms5Gvi+BCZZCMgHinAv9XE
         Jq1Qni/QFnOhwY8LS68nc8QzQ1ZkFHvCG3dy1bAuQkm8pWyydx9LQWBJT5/gJzuoVMdy
         a95be9Pz6hX9Jp2y0Pba0RpHj0RcYBJag5lu7unit2jlp9/isaAkmv6pTAfcPgPrx9Pt
         LUF1mexehbUpEGZItT8ussDihMek4nV4FN4ETJnnbM/mf4I0uhWXM/yhu3F6gWiTMjJL
         ERV9oQE353QxwPDYyB7tZCCpg7yRu0nzpSNJ9QR45e6KqS2bOyShn4IXruxfrDUmbdhc
         fmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=N2nxlAPwxCY787lzi2fWINFuw6kMiTtSA+BaIRlVVdE=;
        b=Grx022fcYjDsB+LRBTPXXHH4831OY8l8+fWSbMk0IXFaJKbebMqE07NbM/tbPqSAQu
         eJI9NLeuCJUVT4p+QQC4LdVZJa7ZFrf+NtxKNSAxI7cUt3lj62VrAZ5tRhACuNZg4ZId
         9XGjkfVrE1UYLLCfEe9kLQMqSKvIbwWoxod7OsekS9zUQSlPDx3Na8yOEoklrx7FVj/C
         RohnseUtNrmPRvTsb4+xCjRLghDNPJYp1XL9ZnWeYj4NvvWZzL2brJ/Q9m0YVjUg33Hk
         HIULe+W2tzcvDudZlTp2rbzTYWxOUwubaLDDTc+6h39+dsa+xlbb4rGJjvqiEGMhAn0V
         Linw==
X-Gm-Message-State: ABuFfohUN8jT/cnRhPbw4efbFNJV8q9N4Iu0Dn7Q2zehSp+lKxjKAvlD
        x9AkYI5bLhemrtg8d7dVveM=
X-Google-Smtp-Source: ACcGV63DOzYVV62Ed4JEul873kcLw6GAI0NLbyf6FOJU9ypagJ/T3dttidyQxNLCs3yCGxyHcSx4rg==
X-Received: by 2002:a17:906:f186:: with SMTP id gs6-v6mr34697868ejb.212.1539197365853;
        Wed, 10 Oct 2018 11:49:25 -0700 (PDT)
Received: from dell.be.48ers.dk (d51a5bc31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id w10-v6sm2619332ejn.65.2018.10.10.11.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 11:49:24 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peko@dell.be.48ers.dk>)
        id 1gAJXq-0007O1-P1; Wed, 10 Oct 2018 20:49:18 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Peter Korsgaard <peter@korsgaard.com>
Subject: [RESEND PATCH v2] ttyprintk: make the printk log level configurable
Date:   Wed, 10 Oct 2018 20:49:10 +0200
Message-Id: <20181010184910.28353-1-peter@korsgaard.com>
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

