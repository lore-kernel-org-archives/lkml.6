Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F4BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C169D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHhPoSEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C169D20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeGQVj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46906 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731334AbeGQVjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so1081324pfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JHpAaAcqc44ClJzMQ42YALBYUZKV3DbZInBuPaeJSz0=;
        b=BHhPoSEvR3TxGX5wJxobGobWG/yksS9RaL9HNDvitxdLWIZaXNDISLlAiY3Qfro4Ps
         fISpgmezV1kCbUOscizft41U1O/GErRdyaw01N7nmhYcYw1p9zGYPxE8difffBcx7b+m
         R7T36wH8gdoXQ1eiHcDS1onTkGddduuSliZL0AIlfh0qp89pjQd/5HGiVocVRxvYHakV
         6ES5w5DiO6CxaiwLvqfc3jwN58RE+44xtDhNUcDAyjyM48jS8Z1a0JcFfJFI2z2qHbkz
         730MGToT+POQC8VHz1nLb8+R2ivVvapIWyQRHnXUtSCOGr5RVJ2fJpyHEi+pltzifNcw
         AeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JHpAaAcqc44ClJzMQ42YALBYUZKV3DbZInBuPaeJSz0=;
        b=ZOFIhjtonenCkS1nvq0gFDO9eRCz4bxPJRqpqgvgP+I5FoPTBL4BnUXfd46gK/Ni3x
         92N/nHH0+r0nFsPsc/chf3UUPPNlfJpvLBy5a34mDXCwYVcWWdpcwIVOi/9cE/POn3SB
         gqiMfttGt/byez6EBFq+rHNggPx8rivD+qIENNMEgVE9nJjyKSwrkwXyLosj9Czt8I5K
         MCwmdd2U8YDN5lEoi2+hOGqiE9lZf763Mdd92FzvJaG/AbCg5IqhXqkKqxpW8N9DDfKz
         H4hDD8xGetu9O3EAoQg0XqmNv0QFUTp+6gNdwaWV61kPWIX8tfnhkPDr3tpN7nWDPBl0
         QTeQ==
X-Gm-Message-State: AOUpUlFbFBX8Nm+171Sv5qwQVqeJ2VFLbes29VVXsrEF5BHpkoz4pEkE
        2mkTBZC70rge6pcy+k4A+zRdFg68
X-Google-Smtp-Source: AAOMgpdVgptDwEXRVIYYrdkvY53vFK4hi4hz5Z40QRtkqD1DWEAUbtSecc3yiLnIPi9aTyHk3kWriA==
X-Received: by 2002:a63:c20:: with SMTP id b32-v6mr3011680pgl.400.1531861498183;
        Tue, 17 Jul 2018 14:04:58 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:57 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 11/32] staging: gasket: gasket_wait_with_reschedule use msleep
Date:   Tue, 17 Jul 2018 13:56:51 -0700
Message-Id: <20180717205712.29495-12-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Replace schedule_timeout() call with msleep() for simplicity.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 803566229bfcb..442543573f6e9 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -14,6 +14,7 @@
 #include "gasket_page_table.h"
 #include "gasket_sysfs.h"
 
+#include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/of.h>
@@ -2097,7 +2098,7 @@ int gasket_wait_with_reschedule(
 		tmp = gasket_dev_read_64(gasket_dev, bar, offset);
 		if ((tmp & mask) == val)
 			break;
-		schedule_timeout(msecs_to_jiffies(delay_ms));
+		msleep(delay_ms);
 		retries++;
 	}
 	if (retries == max_retries) {
-- 
2.18.0.203.gfac676dfb9-goog

