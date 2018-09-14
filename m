Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00961C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B1120853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdGi0VGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B1120853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeINHqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 03:46:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41324 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbeINHqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 03:46:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so3466252plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 19:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iE+hmny/AFB3RBHaZ6K43O3+XOBARtZC94kXQw1FLkw=;
        b=vdGi0VGyknWZ78o6j4/eFGqaEgxvLktR7g17uMKChCTJCaUddk5mRKS+o+bqxnfdBM
         gDtNvKBMiulooleIlVmvUGj57Du2qHYfAnlCYBhxnaIL5rNvAWBTcARmE5koHOzZU66G
         JUEVL0GA9H5Crv0vGYI5v5CKPxOp3/n+nI/FQMMoU2WNJ8FzW+fFiERX5jwX3SiWVYhR
         8je18Qlx8P5Jq1vzOW6gmQ7ASuyAPyHUcEOP20c1Tly4ccWB4qeulaHuUszhiY9JO+C4
         5zBcSPHG8iRZe0M34UxU7/tayOtx16bYdBWA+LORot15d0Xs5YjtOhV8m8DZSolZIvRN
         qx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iE+hmny/AFB3RBHaZ6K43O3+XOBARtZC94kXQw1FLkw=;
        b=kciUPcztca3SiPcqDYbHLtZbRJN1/MmH5zKqs7hJCHPi5K+MY7zBUc1hTWl3WXktyc
         086+WsTDmQz83fBeEUW6qmPsfS8flNtucHxLaMNnANBNleiTgnyQ3omarEHVJuQ50Q1f
         hVtFYGb+fjw4i0R5nF6Z2Dd8H6bW43jIvsFegWSQkf2GqVweCeahtXv6gUtkXR7vlGuF
         JuzuUnPZIkYcxoOVRrx5NVi/VPwnGmGIusvWxeGpMhbcjUFTVahO17tlBecPJHvRA64f
         HfUJsUIUUBzRmDDXyLQTMgY59FQe8/lQo8PRIRSSWg24dphZsvUcf4AxTvAJwlQQhKcN
         dIAg==
X-Gm-Message-State: APzg51DhNYyE8FEUlBQuMlXEiI+9uoZG9WfHEdfba97mlbqtgd1P4Apu
        JXj0E6gr6OfQ+VckTQoILcP7BDU1OPU=
X-Google-Smtp-Source: ANB0VdbbLEKibKz7oKdrpwNdG8V8t63iQCOtMkx4YvgAgRgAZBOvQNpdZ/4BvHYfoCCX1EsnOaDWNw==
X-Received: by 2002:a17:902:7798:: with SMTP id o24-v6mr9767780pll.93.1536892476563;
        Thu, 13 Sep 2018 19:34:36 -0700 (PDT)
Received: from localhost.localdomain ([39.7.18.191])
        by smtp.gmail.com with ESMTPSA id a90-v6sm12764321pfg.106.2018.09.13.19.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 19:34:35 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] printk: CON_PRINTBUFFER console registration is a bit racy
Date:   Fri, 14 Sep 2018 11:34:28 +0900
Message-Id: <20180914023428.814-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CON_PRINTBUFFER console registration requires us to do several
preparation steps:
- Rollback console_seq to replay logbuf messages which were already
  seen on other consoles;
- Set exclusive_console flag so console_unlock() will ->write() logbuf
  messages only to the exclusive_console driver.

The way we do it, however, is a bit racy

	logbuf_lock_irqsave(flags);
	console_seq = syslog_seq;
	console_idx = syslog_idx;
	logbuf_unlock_irqrestore(flags);
						<< preemption enabled
						<< irqs enabled
	exclusive_console = newcon;
	console_unlock();

We rollback console_seq under logbuf_lock with IRQs disabled, but
we set exclusive_console with local IRQs enabled and logbuf unlocked.
If the system oops-es or panic-s before we set exclusive_console - and
given that we have IRQs and preemption enabled there is such a
possibility - we will re-play all logbuf messages to every registered
console, which may be a bit annoying and time consuming.

Move exclusive_console assignment under the same IRQs-disabled and
logbuf_lock protected section where we rollback console_seq.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 992bb6bb7ac2..c52a986a72b3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2705,7 +2705,6 @@ void register_console(struct console *newcon)
 		logbuf_lock_irqsave(flags);
 		console_seq = syslog_seq;
 		console_idx = syslog_idx;
-		logbuf_unlock_irqrestore(flags);
 		/*
 		 * We're about to replay the log buffer.  Only do this to the
 		 * just-registered console to avoid excessive message spam to
@@ -2713,6 +2712,7 @@ void register_console(struct console *newcon)
 		 */
 		exclusive_console = newcon;
 		exclusive_console_stop_seq = console_seq;
+		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
 	console_sysfs_notify();
-- 
2.19.0

