Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62DDC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737FB20891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vd+a0QgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737FB20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeG0E1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:27:54 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33672 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbeG0E1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:27:53 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so1684268plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5ipPKmNqurUEYnSz1c9i8Emr1lo7ISjakwd28pOJ/0=;
        b=vd+a0QgXMmdBqSA4Zb8E68el1RUhJM+tT5SeG99wXhZUipLYRPxrtDFF73d944H6F3
         bcXsiHEXw9v5gX51V+BsxHDvj4+ik3Mv75OEoSd2HxaQdAOTeiEEHdr558w+T47ecHos
         oqAwc3GTkV1A0RLTs/ulztJi+SYyua7xPwnM40VQ4edd7Hhh7vWREFa3jyIGHJTn1Wwt
         Ooaed3yu7YamLXKyC1L0KKyHUTMFTmuYs4EQ5ae+kKJehMM6kv/UL0cwO9El6kYV0tJu
         OjFs1O14ncsNfpOw1JmexVtgaG2gm9xmlnZ/1I4Nb6TrRlHlPhFEt/MgVJ/61TeRtp3K
         SjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5ipPKmNqurUEYnSz1c9i8Emr1lo7ISjakwd28pOJ/0=;
        b=aFgXsxTP3yvBaAJZiM7gxxuVI8Dr80BueL7UnWnRjBkLFc6lVmOnFtTzTpom4oGNGg
         OclKgJVvJ+dd5Bf3Yyp7spW52VcALTsQ2JuxjkDeoQKWGbvCUElWq4skxybvAY98Rfgp
         0Y5A4eWnFa+WaP1agnhPMV+cU+/GTK4GGIQ/svmXNCoMGY+SiI50budU8JpVZYy4NnvO
         AQbUOOaXQKRcTEu+d+560q3rnsuuITaNy3ubu5mAxK6Moz/YqDVZF3i361TzmP5asVag
         fH4OhAymdDKanvVVNb9Lyd9vfnM5BoWzGLisAkuXtouuztZohTyWw8zl3H+eVrSmZs+n
         G1Xg==
X-Gm-Message-State: AOUpUlGCkBBLUgjSPfN4BspB7mmfCcQfJcAuJYFwbPssU9RnoEUlx7x4
        PhFC7+ZRabZKRuDUDN5FbRw=
X-Google-Smtp-Source: AAOMgpf5JX0CX5u9gZLc7i5n9wgAuOuABgeQPeYLI1q1nInM5N38C1sQIVzUh06ThMZJ19Lnh4IqXA==
X-Received: by 2002:a17:902:9a4b:: with SMTP id x11-v6mr4263414plv.342.1532660890695;
        Thu, 26 Jul 2018 20:08:10 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e126-v6sm6418544pfg.31.2018.07.26.20.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:08:09 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 08/10] staging: gasket: remove gasket logging header
Date:   Thu, 26 Jul 2018 20:07:35 -0700
Message-Id: <20180727030737.231268-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180727030737.231268-1-toddpoynor@gmail.com>
References: <20180727030737.231268-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Gasket logging functions no longer used.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_logging.h | 64 -------------------------
 1 file changed, 64 deletions(-)
 delete mode 100644 drivers/staging/gasket/gasket_logging.h

diff --git a/drivers/staging/gasket/gasket_logging.h b/drivers/staging/gasket/gasket_logging.h
deleted file mode 100644
index 54bbe516b0716..0000000000000
--- a/drivers/staging/gasket/gasket_logging.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Common logging utilities for the Gasket driver framework.
- *
- * Copyright (C) 2018 Google, Inc.
- */
-
-#include <linux/pci.h>
-#include <linux/printk.h>
-
-#ifndef _GASKET_LOGGING_H_
-#define _GASKET_LOGGING_H_
-
-/* Base macro; other logging can/should be built on top of this. */
-#define gasket_dev_log(level, device, pci_dev, format, arg...)                 \
-	if (false) {                                                           \
-		if (pci_dev) {                                                 \
-			dev_##level(&(pci_dev)->dev, "%s: " format "\n",       \
-				__func__, ##arg);                              \
-		} else {                                                       \
-			gasket_nodev_log(level, format, ##arg);                \
-		}                                                              \
-	}
-
-/* "No-device" logging macros. */
-#define gasket_nodev_log(level, format, arg...)                                \
-	if (false) pr_##level("gasket: %s: " format "\n", __func__, ##arg)
-
-#define gasket_nodev_debug(format, arg...)                                     \
-	if (false) gasket_nodev_log(debug, format, ##arg)
-
-#define gasket_nodev_info(format, arg...)                                      \
-	if (false) gasket_nodev_log(info, format, ##arg)
-
-#define gasket_nodev_warn(format, arg...)                                      \
-	if (false) gasket_nodev_log(warn, format, ##arg)
-
-#define gasket_nodev_error(format, arg...)                                     \
-	if (false) gasket_nodev_log(err, format, ##arg)
-
-/* gasket_dev logging macros */
-#define gasket_log_info(gasket_dev, format, arg...)                            \
-	if (false) gasket_dev_log(info, (gasket_dev)->dev_info.device,         \
-		(gasket_dev)->pci_dev, format, ##arg)
-
-#define gasket_log_warn(gasket_dev, format, arg...)                            \
-	if (false) gasket_dev_log(warn, (gasket_dev)->dev_info.device,         \
-		(gasket_dev)->pci_dev, format, ##arg)
-
-#define gasket_log_error(gasket_dev, format, arg...)                           \
-	if (false) gasket_dev_log(err, (gasket_dev)->dev_info.device,          \
-		(gasket_dev)->pci_dev, format, ##arg)
-
-#define gasket_log_debug(gasket_dev, format, arg...)                           \
-	if (false){                                                            \
-		if ((gasket_dev)->pci_dev) {                                   \
-			dev_dbg(&((gasket_dev)->pci_dev)->dev, "%s: " format   \
-			"\n", __func__, ##arg);                                \
-		} else {                                                       \
-			gasket_nodev_log(debug, format, ##arg);                \
-		}                                                              \
-	}
-
-#endif
-- 
2.18.0.345.g5c9ce644c3-goog

