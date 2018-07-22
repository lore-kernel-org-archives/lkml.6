Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D95C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE6E205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pau+IQ8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE6E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbeGVQnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:43:06 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44838 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbeGVQnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:43:06 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so7166963pls.11;
        Sun, 22 Jul 2018 08:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S5cLGCI+XVTxRuLGUkFvRH8uP0UZ9nGbqM34dOpZyLQ=;
        b=Pau+IQ8CHi+yjccLQpNvniHfR4ZZqEVK4Z0fWE1E127gtJOGH3ko/JpeYVnNQ/zEZK
         GG9APMJdXWMVXKSOYYB9S7ukJl2QarPqCGNSGw1pnK3CE668oYaoiWtoXoAPuuU98IYL
         J1iQqGQ2ICC7VA3YdrwJY9DuB98alkR4iZATxluEVntD4q7IdOVLLCNsKoeLi6qm7So4
         8NbJz83Fa9ajY7WoQG4BLg3ErGzU49jmkvcc2VOnGfxUWaNrU6XitNp07w1xguCfbz6S
         Wkhx+Bl8zPZuNBxwm5QarvNmFSwIz+X8NS6B81nBw6jMWgOx0vsFbJoKfhyBVVA2Gy+v
         1FQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S5cLGCI+XVTxRuLGUkFvRH8uP0UZ9nGbqM34dOpZyLQ=;
        b=rrSzrcp6zuNs4AvSowuhMwiiOsgyVoE6euZaxEnW4BerJIdoQf4fRXgtyaWp5BTCbn
         qqLZAY+Bueh/Jd+CpnwhLdjpGm4dWZulf76n+EoJ1CdSbpmUWiIr6+WtJgkwK/gBZg1M
         D+Mzck8laItA5KLeGsoRbOG8rMik05JHXuoGFWdUcmA4r5JSH8lrhsfZn+qxZqRouMLJ
         pnbi1TG621cG7IQgEHBtr8gWsQ5raJHrcDpwY2vnfJaq6KExuQWcXrZQS/kewj0fC66x
         tUz7ICerlymCMEti4dXCLv6/ZAkpYH/aPna+IndF/lG6HbpITDInOaTI+y5gMoTNzs2u
         myKw==
X-Gm-Message-State: AOUpUlFQ3nKRWZFmxHo9ZdLcnEZayyBcKNvo4oG5UXIrGB51gk2Yed4W
        6LXykSBwaICcRhrk88rvTOUnhEIz
X-Google-Smtp-Source: AAOMgpcKp0RlGalS8zffIn/4iSBna1fca5t6Bc0HptMmAAllCGvsmdFPHqdCbyLReiHhNEsW1H7QTw==
X-Received: by 2002:a17:902:820a:: with SMTP id x10-v6mr9576168pln.261.1532274361059;
        Sun, 22 Jul 2018 08:46:01 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:35c0:e530:abfe:4337])
        by smtp.gmail.com with ESMTPSA id k64-v6sm9217493pgd.47.2018.07.22.08.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 08:46:00 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-media@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH -next] regmap: sccb: fix typo and sort headers alphabetically
Date:   Mon, 23 Jul 2018 00:45:46 +0900
Message-Id: <1532274346-16952-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos 's/wit/with/' in the comments and sort headers alphabetically
in order to avoid duplicate includes in future.

Fixes: bcf7eac3d97f ("regmap: add SCCB support")
Reported-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/base/regmap/regmap-sccb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-sccb.c b/drivers/base/regmap/regmap-sccb.c
index b6eb876..597042e2 100644
--- a/drivers/base/regmap/regmap-sccb.c
+++ b/drivers/base/regmap/regmap-sccb.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 // Register map access API - SCCB support
 
-#include <linux/regmap.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 
 #include "internal.h"
 
@@ -29,7 +29,7 @@ static bool sccb_is_available(struct i2c_adapter *adap)
 
 /**
  * regmap_sccb_read - Read data from SCCB slave device
- * @context: Device that will be interacted wit
+ * @context: Device that will be interacted with
  * @reg: Register to be read from
  * @val: Pointer to store read value
  *
@@ -65,7 +65,7 @@ static int regmap_sccb_read(void *context, unsigned int reg, unsigned int *val)
 
 /**
  * regmap_sccb_write - Write data to SCCB slave device
- * @context: Device that will be interacted wit
+ * @context: Device that will be interacted with
  * @reg: Register to write to
  * @val: Value to be written
  *
-- 
2.7.4

