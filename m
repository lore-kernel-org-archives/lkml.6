Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E7DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E320620844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/t9q3fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E320620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbeGYCA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:00:58 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:55728 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388420AbeGYCA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:00:58 -0400
Received: by mail-vk0-f74.google.com with SMTP id j80-v6so2242745vke.22
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 17:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=44jEWQQm/T28mqKlZG7Ef2B9v8tnrCRDO/QbziHOkyU=;
        b=q/t9q3fl42QlVHVu57sUSd19zYH4fdWN4pBnLBMQX28Erop+5DBGWptd2brPQvPPcs
         9OKBdJjAGA1cvdgtruB1Y75Olup203NE+GU3PoBYKSQU2wAv0mXXDib77jbowqe31jZi
         x3XtdLapKL1G9wKrA8iGYOnoA8p3nh/gYdH2e5cKj8J9Gaj+4IKzJHNScIS6840qqRG2
         9/JAM2S9qurfnvV3eFdFdRlyKxrrq0v1mZEo0rM2pKIvOgoaL6MznJzs9VAQvrmgG/d3
         bO2DaCWnklaZQj0oSj47Gi6lsfjQYQBQSOMeukrYGJrMl1yjsk6d2VMNVxPETKJVfmn6
         6mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=44jEWQQm/T28mqKlZG7Ef2B9v8tnrCRDO/QbziHOkyU=;
        b=J97UxsLsVuF4HLmozIP2auS/ce7QIPT9GO4aCYACz4xq5xPednqwREVepgE1NPstWs
         TgsIscB4idPEsNCMXTviBY/2peOxdPJl/JN2YuISMgZN4WNqRhwhi0wv7fTEL8mrmxAp
         tbyM3mN4+Pk6wmrXdCnoL6zyw0znOOmGq1iMJMrpr7FceFJakcSys6XglJcEQIMzVygc
         0ducgF202/+DKReW/OC1YJ8RriWfMQbb7CCzvThx3M0l+tB0HE+rcexaAwY0qQlpKr7Y
         XOjnls5I191nPfXvj3eJvC3Hz7Hz2Zv72O/r61TxoRVglooXQrQpz3qA2fili5S+C4hN
         Ujbw==
X-Gm-Message-State: AOUpUlH5MXR9o7gWxwdz30bROw167eZU4Lb4Jv15W608O7Ga6bn2rcF2
        ZWy1NrBX9Jma3eAH9BZ5MjevI2Ts
X-Google-Smtp-Source: AAOMgpcVPxMYUHQBGIOTpJFA4Y/X7RZi4xYzCZXzspp2aevWISOgUfsQDe2f4uMDcCtumSF4Ej3ngs9G
MIME-Version: 1.0
X-Received: by 2002:a1f:b42:: with SMTP id 63-v6mr9735544vkl.24.1532479912445;
 Tue, 24 Jul 2018 17:51:52 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:51:33 -0700
In-Reply-To: <20180725005133.107823-1-rkir@google.com>
Message-Id: <20180725005133.107823-3-rkir@google.com>
References: <20180725005133.107823-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH v2 3/3] tty: Replace goldfish_tty_line_count with a #define
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

The driver never mutates this variable - no benefits of
keeping it mutable.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v2:
 - Replaced "const u32" with "#define".

 drivers/tty/goldfish.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 173383f2a4c1..eb88db4f243c 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -49,10 +49,11 @@ struct goldfish_tty {
 
 static DEFINE_MUTEX(goldfish_tty_lock);
 static struct tty_driver *goldfish_tty_driver;
-static u32 goldfish_tty_line_count = 8;
 static u32 goldfish_tty_current_line_count;
 static struct goldfish_tty *goldfish_ttys;
 
+#define GOLDFISH_TTY_LINE_COUNT 8
+
 static void do_rw_io(struct goldfish_tty *qtty,
 		     unsigned long address,
 		     unsigned int count,
@@ -225,7 +226,7 @@ static struct tty_driver *goldfish_tty_console_device(struct console *c,
 
 static int goldfish_tty_console_setup(struct console *co, char *options)
 {
-	if ((unsigned int)co->index >= goldfish_tty_line_count)
+	if ((unsigned int)co->index >= GOLDFISH_TTY_LINE_COUNT)
 		return -ENODEV;
 	if (!goldfish_ttys[co->index].base)
 		return -ENODEV;
@@ -251,14 +252,14 @@ static int goldfish_tty_create_driver(void)
 	int ret;
 	struct tty_driver *tty;
 
-	goldfish_ttys = kcalloc(goldfish_tty_line_count,
+	goldfish_ttys = kcalloc(GOLDFISH_TTY_LINE_COUNT,
 				sizeof(*goldfish_ttys),
 				GFP_KERNEL);
 	if (goldfish_ttys == NULL) {
 		ret = -ENOMEM;
 		goto err_alloc_goldfish_ttys_failed;
 	}
-	tty = alloc_tty_driver(goldfish_tty_line_count);
+	tty = alloc_tty_driver(GOLDFISH_TTY_LINE_COUNT);
 	if (tty == NULL) {
 		ret = -ENOMEM;
 		goto err_alloc_tty_driver_failed;
@@ -333,7 +334,7 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 	else
 		line = pdev->id;
 
-	if (line >= goldfish_tty_line_count) {
+	if (line >= GOLDFISH_TTY_LINE_COUNT) {
 		pr_err("goldfish_tty: Reached maximum tty number of %d.\n",
 		       goldfish_tty_current_line_count);
 		ret = -ENOMEM;
-- 
2.18.0.233.g985f88cf7e-goog

