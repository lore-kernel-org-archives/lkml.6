Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F99C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C6320671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8AnEY09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C6320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeG0E1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:27:50 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42206 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeG0E1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:27:49 -0400
Received: by mail-pl0-f65.google.com with SMTP id z7-v6so1677220plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkGsDv4LtF9CNAP/+5LtCNxwWUzmfMPOmiGQrcOXvOs=;
        b=M8AnEY09vU9E2ynAFRTl4o26A8zQYz7sX1jbctJdYq0QjjhpiW+6uTP68sI04Zxduw
         f2yW++3MqMZMusjjwYlBkdzuOWgz1WVhvy32tFoHwIW5HeE7r0YTy34vGZAAyF92hHKg
         /d8D5HAxJh05Jluvi2mjHnIXZCL/F6pk8g5/CvFVljsrIsbOxXnbjW7chAlDcQhJpHm5
         FcM/uLjbcWZjGV9FL6hKqkL0oV4IopyBt42YP793QwHlhYssC9lto5KOlvmrXo9OjcDn
         qAUTRiFZDvYBvno2P20NS6+mbfqDSy5FVYcI53WKqsqnua+KpwYbTHqFh/YzvzEFOw1h
         208w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkGsDv4LtF9CNAP/+5LtCNxwWUzmfMPOmiGQrcOXvOs=;
        b=srGw/qCIbzcdrtJzvqEW3wAO1A9GfGGU01cdyEbF+xRLI6noqAoAu3sOYejEq3hDd4
         D2uyX6iFeYMfmLZRZiCsPSVxS14fQOngGgV9QE8/LG2zvgyPaBjrsukHHZz7iMWI0gU2
         G2Nevh7wKsL2ZhVzSdCkdWjMoYWvkztVxpAPiZLmztM6GB8j4EFIgfG4SS7YTe5IgXLp
         yR2omtk9iP4aL3PBCLpQZcv5z0L0EAfxrwVU1USCvJpCKYppgiRLLK0RcJW0aSPHA5vu
         fGxAWlN9VNd4TDSVqjIdClwiASDJYCi7wpf2639QXa3R53TM1VLjnSVUEH5tMsbNCjX/
         0vjg==
X-Gm-Message-State: AOUpUlElu70IBXt2yaHdEqVA/pfQLA65LEtgkeH+K5W+j8ifVW0E/EIL
        MPHKIjxGiHddyosQrlQW7G4=
X-Google-Smtp-Source: AAOMgpcWFUG10Rkj2xh7UhYJQdME70wlLYQsEcVnIgZlYiE0JO0gcxcl8nFEHDmYw3pFYPnFVSWFvA==
X-Received: by 2002:a17:902:7b83:: with SMTP id w3-v6mr4305284pll.192.1532660886638;
        Thu, 26 Jul 2018 20:08:06 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e126-v6sm6418544pfg.31.2018.07.26.20.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:08:05 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 04/10] staging: gasket: ioctl: convert to standard logging
Date:   Thu, 26 Jul 2018 20:07:31 -0700
Message-Id: <20180727030737.231268-5-toddpoynor@gmail.com>
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

Replace gasket logging calls with standard logging calls.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 63e139ab7ff89..78a132a60cc4f 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -5,9 +5,9 @@
 #include "gasket_constants.h"
 #include "gasket_core.h"
 #include "gasket_interrupt.h"
-#include "gasket_logging.h"
 #include "gasket_page_table.h"
 #include <linux/compiler.h>
+#include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
 
@@ -73,7 +73,7 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 		}
 	} else if (!gasket_ioctl_check_permissions(filp, cmd)) {
 		trace_gasket_ioctl_exit(-EPERM);
-		gasket_log_debug(gasket_dev, "ioctl cmd=%x noperm.", cmd);
+		dev_dbg(gasket_dev->dev, "ioctl cmd=%x noperm\n", cmd);
 		return -EPERM;
 	}
 
@@ -132,10 +132,9 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 		 * the arg.
 		 */
 		trace_gasket_ioctl_integer_data(arg);
-		gasket_log_debug(
-			gasket_dev,
+		dev_dbg(gasket_dev->dev,
 			"Unknown ioctl cmd=0x%x not caught by "
-			"gasket_is_supported_ioctl",
+			"gasket_is_supported_ioctl\n",
 			cmd);
 		retval = -EINVAL;
 		break;
@@ -186,12 +185,9 @@ static bool gasket_ioctl_check_permissions(struct file *filp, uint cmd)
 	struct gasket_dev *gasket_dev = (struct gasket_dev *)filp->private_data;
 
 	alive = (gasket_dev->status == GASKET_STATUS_ALIVE);
-	if (!alive) {
-		gasket_nodev_error(
-			"%s alive %d status %d.",
-			__func__,
-			alive, gasket_dev->status);
-	}
+	if (!alive)
+		dev_dbg(gasket_dev->dev, "%s alive %d status %d\n",
+			__func__, alive, gasket_dev->status);
 
 	read = !!(filp->f_mode & FMODE_READ);
 	write = !!(filp->f_mode & FMODE_WRITE);
@@ -329,9 +325,8 @@ static int gasket_partition_page_table(
 		gasket_dev->page_table[ibuf.page_table_index]);
 
 	if (ibuf.size > max_page_table_size) {
-		gasket_log_debug(
-			gasket_dev,
-			"Partition request 0x%llx too large, max is 0x%x.",
+		dev_dbg(gasket_dev->dev,
+			"Partition request 0x%llx too large, max is 0x%x\n",
 			ibuf.size, max_page_table_size);
 		return -EINVAL;
 	}
-- 
2.18.0.345.g5c9ce644c3-goog

