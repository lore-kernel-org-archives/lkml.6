Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D486AECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883872086B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfHi0R0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883872086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeGUO2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:28:19 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46046 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeGUO2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:18 -0400
Received: by mail-pl0-f68.google.com with SMTP id 94-v6so6353948ple.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TsEDtgoo8iE7eCWyLIce3yfAFKobSawsm55rUUXe/2M=;
        b=qfHi0R0XRu01ed1bic804JJok1Zaj69o9UzFciVf7mNmZveUoi8mSjbTN5jZwjXUAr
         owgbAD0x0uc7GKdGAd/Ag+SMgRrp4pwfNttNdT9YPFnfGRJ9bPDmSS04nToWsJ4ZlQeq
         K+qmxjjMak3aZDmthNvEhwsvZ9dISwRjfKYMG5mVN2/jx/GGdn9uUoRq4BoCBS4AHeYt
         PB4pYYpOVfVjC9L0XX8UAeufuoRdZSm63Ncz3vdTPRsq+gOq7aSpbUuGtlWjDbs7N39w
         x/duGv0lb5MFbIrq7mCaaG6eGKRe34SNn5u6kS65yJ/aFabjnH5iB/XNQDfqtOoDAr6d
         NsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TsEDtgoo8iE7eCWyLIce3yfAFKobSawsm55rUUXe/2M=;
        b=BinF8PmzRzuklORW8KXli1PtZUZ78VSgjjjCidTuX4LDJO1I4ry7lZPBepnpNegsIH
         RuAljzFj9shi/K8QVRfjXy7Zq0X+g8vRnrbECjuICOawV6Tp8TKQqDNsrxGYF/vBG73n
         Pv5N5KQ4RRVQ8/xGjlowbXWavxucTHUAwvugt6pD1nWYfwAbcw1qBMyn74EBsYYyYkFK
         Kv98lZlELnCXnMZrfQACyoSUmJ3Eh3snQC6vcM3YkJNrxs5gGgwBYoXJHd9psBMLlLWr
         S7/YuWEWUP+TbcrYdjs7FsGroRec1i93EbAOFcBoW6zNPSjvQUBpGa1ADu1j6b/Omw9u
         BZKQ==
X-Gm-Message-State: AOUpUlFMaRGcPYJuxxaPXgCSwhKpgyCYlORY0QJZZrvW0ZGFZ6e+1xfM
        kkkUGtByrrCGAqNQlHxKHw4=
X-Google-Smtp-Source: AAOMgpczEIDttWmRUnOuRMhhbynY/NVKBfr3DYfXZMZn+By07uJkXzaVLN4Brk7onjhBZfgOoM3u8Q==
X-Received: by 2002:a17:902:243:: with SMTP id 61-v6mr5791138plc.301.1532180130628;
        Sat, 21 Jul 2018 06:35:30 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:29 -0700 (PDT)
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
Date:   Sat, 21 Jul 2018 06:35:04 -0700
Message-Id: <20180721133507.95599-12-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721133507.95599-1-toddpoynor@gmail.com>
References: <20180721133507.95599-1-toddpoynor@gmail.com>
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

