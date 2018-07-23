Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E864ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D705420852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEk5oa2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D705420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388237AbeGWQBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:01:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35014 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388060AbeGWQBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:01:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7-v6so146154pff.2;
        Mon, 23 Jul 2018 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+dAUKql/BRjNumc7Al5mWoqSRpfYn7jQynfwgOe3RJk=;
        b=DEk5oa2ZGMfQ191Xmlc0/dM8etxci1tod2RjsX2Wtky8kDosRepYrkxFcEz3JEyRzL
         GNe9Xh9fOEG23Utq65LZrC047SrNx1D54gHGAN6jfPT1vJFDpRLrW/RK5+YjP6DNlEw7
         0fXHoO8RJ/xyV7xkNqDxjVHDEwWqS/zyYtH7gTCgXmiXlO+0Z0E/QlR1iPb5ZKjUsjLY
         neVro+unXjiBXziph6wq65wenTcbWq5P8RdxRRGFAILunzcR6gCgK8ptgs3EZKI5DFtt
         9cFxlfDhzYkfFIo6fj9S4T7y/JbBHvjGYbgYh6wWhy+vCkxBbJVXrUPjvYmXbNKBw1Po
         wCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+dAUKql/BRjNumc7Al5mWoqSRpfYn7jQynfwgOe3RJk=;
        b=YJbnbvcfD6GIUohPU8vRWyOCow3FVrF/UCvJyBNpmu7s73pT9Dy5iqurwmjFL5N0Ht
         d/T+v6mKkYYWt9PM5nIC2aV8selV5HE0nkw01DYYRki0/nQzlADPuLaguWJynnh3nTgR
         EibxDHTg7isTDfSCackdgVZmknfn0C7xMNVL52Jfvhv6/cRI+NrTcxAkzUNh27facR98
         qATUkurrKPbSZ7RBbIkr/j7SXOYyT8D9igm26Qd+E5nkYOrfZLZ6jcThGU/z+zpmxRpH
         S7N2G6Qo2HDFXLnuhw0GfbKiYY7xkuBz5jg8Qc+Q8u/nNOji4+YiRokLyHtWDos3Gvt3
         ctEg==
X-Gm-Message-State: AOUpUlGiP5eCihwxyfx93IZH069iJsVEhaj9r2VZONQ0pV+boQhkLO6H
        4v25u6FZicukoC7vOwjCdZo98GPa
X-Google-Smtp-Source: AAOMgpeHKaSjeA4gbRxh3Usukhi/xIVUlJrgg+v9cS4Xlsi7QBsBsxG9WoKihh84Q3wfBinrUnLidQ==
X-Received: by 2002:a65:665a:: with SMTP id z26-v6mr12306987pgv.193.1532357982943;
        Mon, 23 Jul 2018 07:59:42 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:808a:8cbe:ddb0:64b])
        by smtp.gmail.com with ESMTPSA id h190-v6sm1851315pgc.50.2018.07.23.07.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 07:59:42 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-media@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH -next v2] regmap: sccb: fix typo and sort headers alphabetically
Date:   Mon, 23 Jul 2018 23:59:29 +0900
Message-Id: <1532357969-10612-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos 's/wit/with/' in the comments and sort headers alphabetically
in order to avoid duplicate includes in future.

Fixes: bcf7eac3d97f ("regmap: add SCCB support")
Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Brown <broonie@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- Replace Wolfram's address for Reported-by tag
- Add Reviewed-by tag

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

