Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4628AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF20208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocIfxGNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF20208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756115AbeFOJkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:40:36 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38508 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755727AbeFOJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:40:32 -0400
Received: by mail-pg0-f65.google.com with SMTP id c9-v6so4197646pgf.5;
        Fri, 15 Jun 2018 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5apb6k5nSC0HUfE/+7Wt3NSt9FbkZt1amlbcSiyy6A=;
        b=ocIfxGNU2wb6L+jU8/9EvSVKj9kmc043k02o4AORKIXdse4hINx0Cdwi96qMHJwjP6
         VOV5nwNLeABticJWeKFKlAl+m3IgqkbtbAC9++0MTQHzRnHpPQ5UPa4EzL+bAdevOa24
         gHtVg6msq3ElfclzwGZ3KzXoEGbi1xNfOeYYnSw5s1MmW3oKLhozgyVTj2DLmHhkOQqB
         pn72HmDh8h5FlUTlicjc3AmE3WihDVWJdcSIVeD99BPqUu0vpy0tx5rzVNo66mMzFXQ6
         A+REGSeFuJcIYIFIhG3UxdVgxBk1DcFvLoF/APDrMXRvEAoXXxvJbi++ruQaEx39iMub
         CrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5apb6k5nSC0HUfE/+7Wt3NSt9FbkZt1amlbcSiyy6A=;
        b=PR9P0IvVpafTYEDCLLwAVWZBTsddUi+V8C2ZCRyeGQ3Wg7l3XN1joSOJEpm717BruS
         zM8RCz5me61JpFZH91ek5pcsEK6DAzWwZ37Yh1MrbETu7WgN82trUZYaFReQDjfZrv+j
         qXsssL+H3h7MBD+B+M02Y7PcDnmvdyf5XjaowlC+ltG5mr8q/n5fcLbopPJwGN1zJ/PY
         pFfECGGwZpL0S8UVGujz7CaQ4/CTa+jFc2hBSXqfbBbmvDNgauGSlwwUhCfB2zXnuWgg
         RO3pmw8x+MiwKmGLHlWOQUkWpbWpVDiNjKahAjtlai3c4KkEh+VAyEL2uYg2ZnI71YFb
         VTxQ==
X-Gm-Message-State: APt69E3I0hffzxVCMS2W5zIvlUuaKwJZncm1EtUsvbMh0C53K2P8ZeBw
        W/nNOwcIKL4SdzjSEFMTsVA=
X-Google-Smtp-Source: ADUXVKLwTyH7ZnT52KKCv7BB5C4XwMBAD4nOEe2vXUt3jjzuhcZWSR/t4+7cadYVGY0bz1SK7vtCcw==
X-Received: by 2002:a63:27c6:: with SMTP id n189-v6mr918816pgn.164.1529055632225;
        Fri, 15 Jun 2018 02:40:32 -0700 (PDT)
Received: from localhost.localdomain ([175.223.48.179])
        by smtp.gmail.com with ESMTPSA id p1-v6sm11628551pfh.58.2018.06.15.02.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 02:40:31 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 2/6] tty: add tty_port locking helpers
Date:   Fri, 15 Jun 2018 18:39:15 +0900
Message-Id: <20180615093919.559-3-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TTY port spin_lock is one of the locks that can cause a
printk-recursion deadlock, thus we need to lock it from
printk_safe context. E.g.

ioctl()
 tty_ioctl()
  spin_lock(&tty_port->lock)
   printk()
    call_console_drivers()
     foo_console_write()
      spin_lock(&uart_port->lock)
       tty_wakeup()
        spin_lock(&tty_port->lock)    << deadlock

This patch adds tty_port->lock helper macros which take care
of printk_safe context and redirect potentially unsafe printk()
calls to per-CPU buffers, which we flush later from safe a
context. The helper macros will turn the above mentioned deadlock
scenario into:

ioctl()
 tty_ioctl()
  printk_safe_enter()
   spin_lock(&tty_port->lock)
    printk()
     printk_safe_log_store()
      irq_work_queue()
   spin_unlock(&tty_port->lock)
  printk_safe_exit()

 IRQ
  printk_safe_flush_buffer()
   vprintk_deferred()

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/tty.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index c56e3978b00f..828f91ab680b 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -252,6 +252,30 @@ struct tty_port {
 	void 			*client_data;
 };
 
+#define tty_port_lock_irq(lock)				\
+	do {						\
+		printk_safe_enter_irq();		\
+		spin_lock(lock);			\
+	} while (0)
+
+#define tty_port_unlock_irq(lock)			\
+	do {						\
+		spin_unlock(lock);			\
+		printk_safe_exit_irq();			\
+	} while (0)
+
+#define tty_port_lock_irqsave(lock, flags)		\
+	do {						\
+		printk_safe_enter_irqsave(flags);	\
+		spin_lock(lock);			\
+	} while (0)
+
+#define tty_port_unlock_irqrestore(lock, flags)		\
+	do {						\
+		spin_unlock(lock);			\
+		printk_safe_exit_irqrestore(flags);	\
+	} while (0)
+
 /* tty_port::iflags bits -- use atomic bit ops */
 #define TTY_PORT_INITIALIZED	0	/* device is initialized */
 #define TTY_PORT_SUSPENDED	1	/* device is suspended */
-- 
2.17.1

