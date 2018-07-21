Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E2EECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EDC20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBdSE/x0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EDC20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeGUNue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:34 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36779 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbeGUNud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:33 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so6330806plb.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TsEDtgoo8iE7eCWyLIce3yfAFKobSawsm55rUUXe/2M=;
        b=ZBdSE/x0ROh5tLxldawX6gSr6xqwZqoVgYDK/nmw1akJzJtiKNk+mu3mYO5oS0mjD+
         Vw5bMdHNilE9mE4MozKuxDfYZ8AVlbdqyLRAQKo6y2Lx450wPrHAMiydZJRnpZWj/xug
         a04vB90beQIVC2VvjtD3jJ7Qq/oimabmeN2d4SwjRapcVEURiPN3GwXsrVJxUBBlp79f
         goU9kpir4JguIqMhR2CDQD1CkLKErvasxqj3eEO6h2Nqn+hH5HyKgbfHFVoEq/8qVYVt
         HNtswXRq4E/ol3pymBiC+N1mME0HCIjHW7t4sK8BD4sTtPyu9TCQ+N6M2Mt19w8TBBXX
         aKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TsEDtgoo8iE7eCWyLIce3yfAFKobSawsm55rUUXe/2M=;
        b=jp0Edt3bytbtrDXS1nQc6wgVlE5COxvlnvKdM2j8Q7nD+riFGEndxoY9PK9KyGrg4j
         eRgmsRy9A14rFgY85ictJ6+zKAd/CIrAe7TF0iFqXDiZB/gSmsSXgi8bjZKu2JB7VHVS
         xlGZz9eytA/j3/SvPiCELjhjsf4TRcJ+wBT9r6GD0ritV9ggDxjVFMuLbzOttK1QLo0u
         duA0gCQ4WWKbUvZGhZLK9yT9pFmpWTdqdswIPssliga5xczQpnURQgYAp5MSs1n2OI8L
         yHbMVgLgaU2RebrgonJ3UVN1xkslJWLLvI0VdtUvGF+QPRki8I8r2I5auCErp/OqCold
         MR7g==
X-Gm-Message-State: AOUpUlGAcKHfowZDrvCjl6rj4exybJIBeDDS9X8POrA2qAlrFGFT7vQk
        9xKXNl08Bu65cdM+NVnzsnI=
X-Google-Smtp-Source: AAOMgpeM20gY6ANzun+1v33wacBQXxWd1EHvvTc9/b5OlAWn7wI+6NiEbYQl8T9WSiIPZGsHXCQS8g==
X-Received: by 2002:a17:902:e28b:: with SMTP id cf11-v6mr5837821plb.86.1532177873494;
        Sat, 21 Jul 2018 05:57:53 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:52 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 11/14] staging: gasket: ioctl common: convert various logs to debug level
Date:   Sat, 21 Jul 2018 05:57:01 -0700
Message-Id: <20180721125713.88501-23-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Debugging information is improperly logged at non-debug log level in a
number of places, and some logs regarding error conditions may be
generated too frequently, such that these could cause performance
problems and/or obscure other logs.  Convert these to debug log level.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c  | 2 +-
 drivers/staging/gasket/gasket_ioctl.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 1d04fd0990e45..732218773c3c6 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1801,7 +1801,7 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
 		if (driver_desc->ioctl_handler_cb)
 			return driver_desc->ioctl_handler_cb(filp, cmd, argp);
 
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev, "Received unknown ioctl 0x%x", cmd);
 		return -EINVAL;
 	}
diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 8cf094b90cdb0..63e139ab7ff89 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -73,7 +73,7 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 		}
 	} else if (!gasket_ioctl_check_permissions(filp, cmd)) {
 		trace_gasket_ioctl_exit(-EPERM);
-		gasket_log_error(gasket_dev, "ioctl cmd=%x noperm.", cmd);
+		gasket_log_debug(gasket_dev, "ioctl cmd=%x noperm.", cmd);
 		return -EPERM;
 	}
 
@@ -132,7 +132,7 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 		 * the arg.
 		 */
 		trace_gasket_ioctl_integer_data(arg);
-		gasket_log_warn(
+		gasket_log_debug(
 			gasket_dev,
 			"Unknown ioctl cmd=0x%x not caught by "
 			"gasket_is_supported_ioctl",
@@ -329,7 +329,7 @@ static int gasket_partition_page_table(
 		gasket_dev->page_table[ibuf.page_table_index]);
 
 	if (ibuf.size > max_page_table_size) {
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev,
 			"Partition request 0x%llx too large, max is 0x%x.",
 			ibuf.size, max_page_table_size);
-- 
2.18.0.233.g985f88cf7e-goog

