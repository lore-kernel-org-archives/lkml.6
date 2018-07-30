Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6163B13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECC320873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq3BcCEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECC320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeG3PV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:21:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39536 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeG3PV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:21:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id a11-v6so7299332pgw.6;
        Mon, 30 Jul 2018 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cpeRy15Wk6bv+h52Ji00CmuhkRmAG9Bs8LCMfFc87Pk=;
        b=Aq3BcCELBFVHB10lws86HcTMWBdMFwUx2uvsnNa8A2apAaWWtQR7BdEsh7TwAOtlfD
         i84SSIm1Qc/KIUGZ9b8XhRaCVcEbZIukQxVxW7XSri5hon2jR9oTLRsql+i4ntXMStb2
         AyEh0+lSo9OonBAltFe1yvS4S92STA+U7ci9mWowKbVTc9cpL8L0FS43OVnNJs6HbtnJ
         ZAWvMdDZiwcsrPzxBY3JlPXRuCUGMZV6OmY0a0obSJ4vgiUKPDRaXx0UZpyduRBZxXYE
         rF+4fNZcDwNyKduNmwAetkhFh8/5XUkmleJI7iNbiip1ozMnF3g59E/UGbHs3Ejq39XZ
         fDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cpeRy15Wk6bv+h52Ji00CmuhkRmAG9Bs8LCMfFc87Pk=;
        b=blK3j0/vRgU5trNdJIk7h4IGqrTtQmOyevKSOF4Tf6Sa5oZOwYEOOXfwbBefA5+qg5
         HDr46/bLkM4TrO0WZ4rsJcaYPuhHu36ryLEe90AW0hxCti0y323HrFdt3hDE2yr20PBs
         DJ5iMQ3nAD10t7oPsYBnGhr4e8ZI5xCzyCSaI4Ae79or2xhj+TFtZWvYi9ohkNHSpo0V
         9zXRhGZNWAYyNuIyNSQKthqXmY0An5nNNGLYVALVdBgMOSk9qXNk72dmEVErMgeR8nkg
         3JuIBxg967jIr19jB4RfiedWVr7O3qk0I/zBPRn4mHKDzFz1DA87CB2KvtWsuFwGkSdQ
         ouOQ==
X-Gm-Message-State: AOUpUlEXGTFORJv3dB5OVewUsV51B4ai6kYwSZ5FwUpWtdjn1xUEAaz+
        ueW1FhwyI0gjwiy61YBWNvU=
X-Google-Smtp-Source: AAOMgpeiSODPpwbTJglI9UMopQ4p2cTWArKBnkWLTXWFN8rkXwk6tH6iYQA4vFIc07XadILxqb7PCA==
X-Received: by 2002:a63:2404:: with SMTP id k4-v6mr16282632pgk.191.1532958382697;
        Mon, 30 Jul 2018 06:46:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4550:ab75:cee3:d6c1])
        by smtp.gmail.com with ESMTPSA id k123-v6sm25456998pga.21.2018.07.30.06.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 06:46:22 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] power: reset: gpio-poweroff: Replace mdelay() with msleep() in gpio_poweroff_do_poweroff()
Date:   Mon, 30 Jul 2018 21:46:14 +0800
Message-Id: <20180730134614.9016-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio_poweroff_do_poweroff() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/power/reset/gpio-poweroff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index 6273ad3b411d..bbe55cfa87d0 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -33,16 +33,16 @@ static void gpio_poweroff_do_poweroff(void)
 
 	/* drive it active, also inactive->active edge */
 	gpiod_direction_output(reset_gpio, 1);
-	mdelay(100);
+	msleep(100);
 	/* drive inactive, also active->inactive edge */
 	gpiod_set_value(reset_gpio, 0);
-	mdelay(100);
+	msleep(100);
 
 	/* drive it active, also inactive->active edge */
 	gpiod_set_value(reset_gpio, 1);
 
 	/* give it some time */
-	mdelay(timeout);
+	msleep(timeout);
 
 	WARN_ON(1);
 }
-- 
2.17.0

