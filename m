Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF85ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72040208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuQxwc0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72040208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbeGNGRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:17:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44624 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeGNGQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id j3-v6so23746197pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jp5XQFGvm4Q5/9SrLOd8buaptegLsgF6Xx6T3djvq14=;
        b=XuQxwc0JlLbS7RmirsR4bQ5xjDyUQ5nroe7tzKI7zZ7MpfTvUErWC4fZSvx9zNc0fO
         VbRPkrU1GxIbZqXCY5rU6ao/Hn00nDbwnvQa9+s/vGmZh3wJwBRa3SINRj3AcnLIZtg5
         j2GtSzIYXhVC4ZBNOBSM4NS5n9Aj75ElMXC8SxEv65Q8Ap1P78CZHgZazfWJtUtSoaVU
         znjLj9eMHfTLZQnO0/Mo10SI6GmQ/3KfOtAL9l99xF5Gd993kY7jCiUybVTJSdMqEk2t
         jxS8MNHvIW9N4ToJEmV4sHZchKN+Aozus8RFSpORxQ0Pui22i6yPs8zaBb/RzKOt8tms
         3hUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jp5XQFGvm4Q5/9SrLOd8buaptegLsgF6Xx6T3djvq14=;
        b=FTwTL3Hm3zJesVPuKK6OEXsk31Eb0lfPwTRWMZ+PXPB7OAD1+XQtQARNzBzm2hcU+L
         +tFW0QCCipUv7dx/B4JFaqeZzbv1DbutKkqQWI+0LMcWtKrmcNH7vcZaMuGFcK1EyP4X
         qIE8ALGf94Wn53uIZ5vaoLEbm9L6l6Y9PfuK51kPy6KlQsUz8giBOMHXhge+SEqQBmQg
         w4BaXdDMSRGLxUTD2LOMKd6WyDPPh+94Ar2xvB6rGE4/QlmRA7ZZgRy3mBFg+W7qL24I
         Bjxinlq5Ty0ciKiHE7X/cMTPK/yrsfoftD3e+jhcw/qI/feOjsjB/G+C6u+71FRcHd+j
         ju5w==
X-Gm-Message-State: AOUpUlHx8/86nbABRNE6rc6aCNvJFSZzfZMhk5JARWV0NKb/addqQgpI
        ak3TBf/h0HzN/KpqY7xNMNM=
X-Google-Smtp-Source: AAOMgpf6zHWOGvhqktsgrNav0VHgUEhaMn5BCp/1le6E/PLLuH1bud6LF2ZvA4J8fjiP8bWdV95qGw==
X-Received: by 2002:a65:654d:: with SMTP id a13-v6mr8569818pgw.132.1531547932141;
        Fri, 13 Jul 2018 22:58:52 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:51 -0700 (PDT)
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
Subject: [PATCH 08/18] staging: gasket: gasket_wait_with_reschedule fixups
Date:   Fri, 13 Jul 2018 22:58:06 -0700
Message-Id: <20180714055816.223754-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Return -ETIMEDOUT on timeouts.

Don't need 64-bit sized retry count.

Use msleep().

Return immediately when condition hit.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c |  8 ++++----
 drivers/staging/gasket/gasket_core.c | 11 ++++++-----
 drivers/staging/gasket/gasket_core.h |  2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index f2d082c06c98..b1318482ba65 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -502,7 +502,7 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 		gasket_log_error(gasket_dev,
 				 "DMAs did not quiesce within timeout (%d ms)",
 				 APEX_RESET_RETRY * APEX_RESET_DELAY);
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 
 	/*  - Enable GCB reset (0x1 to rg_rst_gcb) */
@@ -525,7 +525,7 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 			gasket_dev,
 			"RAM did not shut down within timeout (%d ms)",
 			APEX_RESET_RETRY * APEX_RESET_DELAY);
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 
 	return 0;
@@ -576,7 +576,7 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 			gasket_dev,
 			"RAM did not enable within timeout (%d ms)",
 			APEX_RESET_RETRY * APEX_RESET_DELAY);
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 
 	/*    - Wait for Reset complete. */
@@ -588,7 +588,7 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 			gasket_dev,
 			"GCB did not leave reset within timeout (%d ms)",
 			APEX_RESET_RETRY * APEX_RESET_DELAY);
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 
 	if (!allow_hw_clock_gating) {
diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 155c69446f0b..6316e6c800ba 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -21,6 +21,7 @@
 #include "gasket_page_table.h"
 #include "gasket_sysfs.h"
 
+#include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/of.h>
@@ -2135,16 +2136,16 @@ EXPORT_SYMBOL(gasket_wait_sync);
  **/
 int gasket_wait_with_reschedule(
 	struct gasket_dev *gasket_dev, int bar, u64 offset, u64 mask, u64 val,
-	u64 max_retries, u64 delay_ms)
+	uint max_retries, u64 delay_ms)
 {
-	u64 retries = 0;
+	uint retries = 0;
 	u64 tmp;
 
 	while (retries < max_retries) {
 		tmp = gasket_dev_read_64(gasket_dev, bar, offset);
 		if ((tmp & mask) == val)
-			break;
-		schedule_timeout(msecs_to_jiffies(delay_ms));
+			return 0;
+		msleep(delay_ms);
 		retries++;
 	}
 	if (retries == max_retries) {
@@ -2152,7 +2153,7 @@ int gasket_wait_with_reschedule(
 			gasket_dev,
 			"gasket_wait_with_reschedule timeout: reg %llx timeout (%llu ms)",
 			offset, max_retries * delay_ms);
-		return -EINVAL;
+		return -ETIMEDOUT;
 	}
 	return 0;
 }
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 77d08c1265ca..16bee478dce6 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -714,6 +714,6 @@ int gasket_wait_sync(
 /* Helper function, Asynchronous waits on a given set of bits. */
 int gasket_wait_with_reschedule(
 	struct gasket_dev *gasket_dev, int bar, u64 offset, u64 mask, u64 val,
-	u64 max_retries, u64 delay_ms);
+	uint max_retries, u64 delay_ms);
 
 #endif /* __GASKET_CORE_H__ */
-- 
2.18.0.203.gfac676dfb9-goog

