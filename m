Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A89C46463
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFAD21711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONnoD6xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFAD21711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbeHCDn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:43:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45994 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732317AbeHCDn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:43:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so2050561pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 18:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FF8jm+Qw8OGjZYdChPEDgjvmkEJH75SO79YM5WIT/w=;
        b=ONnoD6xqXC7JLA9XTQNyvIMjyjY7VK5EyGwH7qW/mgWWVGjaYNpT6Zu8glXt3A6Hzw
         TelrS3LZvB7f4fZV9gfkxEp7n7zMZP6ga6IoM2NMqjD7yZgPz5dJ2xJDNeMUIYiuo7lT
         7lhK4hsE8i5gvccKc48P+r2S2L82mgwtgYzurOLy1R+I3b3oWBTaMPghZFDoZAdy5w+x
         v+dw5tJCre5rOPhnOCLlSuMYHH+i/7T331UCuQqr8iZIlp2wXus0ABt40yQurfEtM/jv
         M/GHopgeSnmC+OQ2wmBnd2z1yxczlztTbJCI7//RTcDYgIRSrdn/e6KJj7FkRGSQL2eW
         0+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FF8jm+Qw8OGjZYdChPEDgjvmkEJH75SO79YM5WIT/w=;
        b=jWiAvrxltRAvUq/nKAuFeqlm4mewwkDc42mKIvx/iHTH134fAsINTw7yOTIuHvB8Ya
         aAGcFjeY26PnoliK0j/LojpSaeUwB4faZRuOzCSWi4PIzWTWWRVZRPcx2mChljkbCPba
         LNRTsC4jLjD4QnE9tKA29VRqyDzqpZCF+FXZ5T3LZfowCOkmsZphXh29Ozkyq2uLreJI
         OfeYVDK3qAqlvb6CovrR6DkpbT9PLqFSAiRVnYjV5EoeoWz4E63v3SKAKqq2V7QaqQwQ
         qVNenc0ARXzGpeBFUQbbvQN8hPzd9rFVTDWOY2e7OAEnFJEsQ46RWZ0pPuntaFU6HdNM
         2ZLQ==
X-Gm-Message-State: AOUpUlE0n55QHrYI55CGfJXAG7JENBPWISEhgD4cPaQeImni3H0nnMd1
        wRRIHPCMYXY28H069wQiH0c=
X-Google-Smtp-Source: AAOMgpeKnuBJaRIN7RFbQDHC8xOqKk0G6c/ggCCqzokv7PGSjdUijS+L8tn8ylixV27M6JennF+ppw==
X-Received: by 2002:a63:be05:: with SMTP id l5-v6mr1694813pgf.330.1533261006469;
        Thu, 02 Aug 2018 18:50:06 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m81-v6sm7348315pfa.188.2018.08.02.18.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 18:50:05 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 3/4] staging: gasket: core: add subsystem and device info to logs
Date:   Thu,  2 Aug 2018 18:49:51 -0700
Message-Id: <20180803014952.104582-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180803014952.104582-1-toddpoynor@gmail.com>
References: <20180803014952.104582-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Identify gasket as the subsystem printing various messages.
Add the driver name to appropriate messages to indicate which driver
has a problem.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 91db71c238804..93a4d9f08eaab 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -6,6 +6,9 @@
  *
  * Copyright (C) 2018 Google, Inc.
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "gasket_core.h"
 
 #include "gasket_interrupt.h"
@@ -208,7 +211,7 @@ static int gasket_alloc_dev(struct gasket_internal_desc *internal_desc,
 
 	gasket_dev = *pdev = kzalloc(sizeof(*gasket_dev), GFP_KERNEL);
 	if (!gasket_dev) {
-		pr_err("no memory for device\n");
+		pr_err("no memory for device %s\n", kobj_name);
 		return -ENOMEM;
 	}
 	internal_desc->devs[dev_idx] = gasket_dev;
@@ -1760,7 +1763,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	mutex_unlock(&g_mutex);
 
 	if (desc_idx == -1) {
-		pr_err("Too many Gasket drivers loaded: %d\n",
+		pr_err("too many drivers loaded, max %d\n",
 		       GASKET_FRAMEWORK_DESC_MAX);
 		return -EBUSY;
 	}
@@ -1790,7 +1793,8 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	ret = __pci_register_driver(&internal->pci, driver_desc->module,
 				    driver_desc->name);
 	if (ret) {
-		pr_err("cannot register pci driver [ret=%d]\n", ret);
+		pr_err("cannot register %s pci driver [ret=%d]\n",
+		       driver_desc->name, ret);
 		goto fail1;
 	}
 
@@ -1798,7 +1802,8 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 					   driver_desc->minor), GASKET_DEV_MAX,
 				     driver_desc->name);
 	if (ret) {
-		pr_err("cannot register char driver [ret=%d]\n", ret);
+		pr_err("cannot register %s char driver [ret=%d]\n",
+		       driver_desc->name, ret);
 		goto fail2;
 	}
 
-- 
2.18.0.597.ga71716f1ad-goog

