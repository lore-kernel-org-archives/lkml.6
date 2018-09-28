Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FACC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F4D206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/qFR4vT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F4D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeI1QQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:16:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36204 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbeI1QQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:16:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so3981649pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYJhqrqnOxYBongsXjKG5tsCf6jK5aypglb+nXFuqkw=;
        b=F/qFR4vTTlgHtZOF3TVQkAhiezTePrj1f1bvb7XUG6I4xEji2TReQuRt6HI8vQT2sh
         0AcvkO4Jz8fGXKziqildLhVttQpIX3rKxUfg4odZOpsntjp7NMVEJwkqxsd4cyQaMrDK
         lWRn83hsBZL23BJBWHRCHG0wPLPj1b00JPcb//0MCzzJ/+SbeZBtZrJxnbNYXd+IS7i5
         s1WXwR68sdHSizkpBy1IY19wTW8RlanJ4+v9reMXiKG6SNk297h7S5YMn+rIkUbXqNUw
         mT5KQ0FTFE6giov/E0tZ+qpETnLX6qT/8Nsx/weFZqsnPZv0mPBH2dGweEizsOqnjUld
         WQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYJhqrqnOxYBongsXjKG5tsCf6jK5aypglb+nXFuqkw=;
        b=W5mzrD+ZVLfJii5Ou0ckmLX4NENlR4noGht7uNteBtLe+ScqJLQUXDzV30SKHOTn4y
         thbJzJR7/mLDFWG5pt+HT498upKd33vqSs2Rx7yMoonzg3Vhb/szXvbaorHJaz4QOKD4
         9I0lweUlvdcjht7EpVlimqof+B3V6SydTw9TWUJgBWwRXnxFdODz6PBernEXbTXS7Sio
         cNWbvyBWRa5RZKSCC7/cng13IxLf7GdyDZ8i2gC1iEkTJg7Hrlfszt3UbURSMXGIuYZF
         ZcRfAeeTcSHPKUaCzko1g8c5ndgxqMuUio/f0YUcvHqhUk2Mr3IJLVulOf9n9hjt8Qdk
         /bMA==
X-Gm-Message-State: ABuFfojpZ/rmz+X8VMYiE0QadUpPGOWl13ss3XDKbtQeqxQlG9HbWeq7
        NA2bbUxySmhjNYm1DDVPaEU=
X-Google-Smtp-Source: ACcGV61YGXqbXHJC/BJFRFVsSh0JNnN0mT4A422x9ItHwRk2FOPHNVZYXCZIJt2cKPiGe1KCiJcIVA==
X-Received: by 2002:a63:4b44:: with SMTP id k4-v6mr14258053pgl.51.1538128393616;
        Fri, 28 Sep 2018 02:53:13 -0700 (PDT)
Received: from localhost.localdomain ([110.70.14.151])
        by smtp.gmail.com with ESMTPSA id p64-v6sm8043121pfa.47.2018.09.28.02.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 02:53:11 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv2] printk: CON_PRINTBUFFER console registration is a bit racy
Date:   Fri, 28 Sep 2018 18:53:04 +0900
Message-Id: <20180928095304.9972-1-sergey.senozhatsky@gmail.com>
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

Move exclusive_console assignment to the same IRQs-disabled and
logbuf_lock-protected section where we rollback console_seq.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---

v2: added comment (Petr)

 kernel/printk/printk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 308497194bd4..24a81ba9ec77 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2742,14 +2742,18 @@ void register_console(struct console *newcon)
 		logbuf_lock_irqsave(flags);
 		console_seq = syslog_seq;
 		console_idx = syslog_idx;
-		logbuf_unlock_irqrestore(flags);
 		/*
 		 * We're about to replay the log buffer.  Only do this to the
 		 * just-registered console to avoid excessive message spam to
 		 * the already-registered consoles.
+		 *
+		 * Set exclusive_console with disabled interrupts to reduce
+		 * race window with eventual console_flush_on_panic() that
+		 * ignores console_lock.
 		 */
 		exclusive_console = newcon;
 		exclusive_console_stop_seq = console_seq;
+		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
 	console_sysfs_notify();
-- 
2.19.0

