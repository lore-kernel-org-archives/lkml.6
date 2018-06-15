Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EF905C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAD9208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYIaCA10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAD9208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756143AbeFOJkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:40:45 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40074 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755727AbeFOJkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:40:40 -0400
Received: by mail-pl0-f66.google.com with SMTP id t12-v6so5078289plo.7;
        Fri, 15 Jun 2018 02:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+GkQsQRiTvn4MOH0WKfhkdbbtuW1dkHa9yp36/C6uAw=;
        b=NYIaCA10yWkNBZb0XfL/5JeyTMw6VKWlKzzJo6h6EFNOO1tgAJcTrgxCJ8LQTCF8Tw
         9KkTDqQ0680zMEag0aSU82Z3WAX82uoM4G57ax6cT1mgxYxJ+9x/fpLJeW+ooUCTSSxn
         56eyS3iRzHs1lR+Q9mx1cpwsqgnrfvHxxDTk87IxLzp6Y41LXZwfc6cLQRvs7Ic/EYfy
         EavRsS1+cb0ePzMGnDXnNWVQGJAVlm9uOh4wNnyVzIdsfBr56cuGra7jj3TCuvOS6IXp
         LR6y5lfyGWg45C1QxapP48Q6c1FlxGI+NKlb9n4/sBpMBG44tIj2TUOlaIXpXyr0BQPj
         fkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+GkQsQRiTvn4MOH0WKfhkdbbtuW1dkHa9yp36/C6uAw=;
        b=SaxSEI9LSfl6M9fk92c3WMNgNmjf59l1Fu9itpo9xeAm6+zZHEhEEfPbSt/X2rAjsR
         Aqb/wsAowRlMrugOwJ592gw2DudDrMmxROR3M6vO+XuZ5H70cpahOAmXzNcflUBBEl/L
         o+bUK0AD3vRKt7DfPNLVYzWYkAzbmfXbU106b9CuCTz7BCmoazDLcdasNl5JFYx9G0al
         Jd2KES3UU9lHRbK3BJHRnoM37Huz3BHl4rx3o+ZJg8BwxaLImbuk9Urhg7+u94veeuOX
         KibQHciNanyRf4S//4ACr3WdeIkwJfRlGorkPyUY5frj19ablHT/Yg9z+mXz1i0X9Taj
         XUGw==
X-Gm-Message-State: APt69E0JOyGEcfSZgwwIxFGDx4UlAPf0fMc1jFp+MIDbY0YhGx9PzPK+
        HfP2hTqSN0UFRm+AGg+ZAIwQwH/g
X-Google-Smtp-Source: ADUXVKLY/FfJyekDkYyks2xJnvs5tPlmx5Wc7WkNJBXZVZ657IKNPZO24uJvYgvDERTTe6JIIdCBng==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3-v6mr1132500plb.211.1529055639577;
        Fri, 15 Jun 2018 02:40:39 -0700 (PDT)
Received: from localhost.localdomain ([175.223.48.179])
        by smtp.gmail.com with ESMTPSA id p1-v6sm11628551pfh.58.2018.06.15.02.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 02:40:38 -0700 (PDT)
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
Subject: [RFC][PATCH 3/6] tty/pty: switch to tty_port helpers
Date:   Fri, 15 Jun 2018 18:39:16 +0900
Message-Id: <20180615093919.559-4-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not directly lock/unlock tty_port->lock, but use tty_port_lock
helper macros.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/tty/pty.c                |  4 ++--
 drivers/tty/serial/serial_core.c |  8 +++----
 drivers/tty/tty_port.c           | 38 ++++++++++++++++----------------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index b0e2c4847a5d..dddeecc2289e 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -116,13 +116,13 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 		return 0;
 
 	if (c > 0) {
-		spin_lock_irqsave(&to->port->lock, flags);
+		tty_port_lock_irqsave(&to->port->lock, flags);
 		/* Stuff the data into the input queue of the other end */
 		c = tty_insert_flip_string(to->port, buf, c);
 		/* And shovel */
 		if (c)
 			tty_flip_buffer_push(to->port);
-		spin_unlock_irqrestore(&to->port->lock, flags);
+		tty_port_unlock_irqrestore(&to->port->lock, flags);
 	}
 	return c;
 }
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9c14a453f73c..48b3377d7f77 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1480,9 +1480,9 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 
 		state = drv->state + tty->index;
 		port = &state->port;
-		spin_lock_irq(&port->lock);
+		tty_port_lock_irq(&port->lock);
 		--port->count;
-		spin_unlock_irq(&port->lock);
+		tty_port_unlock_irq(&port->lock);
 		return;
 	}
 
@@ -1603,9 +1603,9 @@ static void uart_hangup(struct tty_struct *tty)
 	if (tty_port_active(port)) {
 		uart_flush_buffer(tty);
 		uart_shutdown(tty, state);
-		spin_lock_irqsave(&port->lock, flags);
+		tty_port_lock_irqsave(&port->lock, flags);
 		port->count = 0;
-		spin_unlock_irqrestore(&port->lock, flags);
+		tty_port_unlock_irqrestore(&port->lock, flags);
 		tty_port_set_active(port, 0);
 		tty_port_tty_set(port, NULL);
 		if (uport && !uart_console(uport))
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 25d736880013..4237d282f89f 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -285,9 +285,9 @@ struct tty_struct *tty_port_tty_get(struct tty_port *port)
 	unsigned long flags;
 	struct tty_struct *tty;
 
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 	tty = tty_kref_get(port->tty);
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 	return tty;
 }
 EXPORT_SYMBOL(tty_port_tty_get);
@@ -305,10 +305,10 @@ void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 	tty_kref_put(port->tty);
 	port->tty = tty_kref_get(tty);
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 }
 EXPORT_SYMBOL(tty_port_tty_set);
 
@@ -349,13 +349,13 @@ void tty_port_hangup(struct tty_port *port)
 	struct tty_struct *tty;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 	port->count = 0;
 	tty = port->tty;
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 	port->tty = NULL;
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 	tty_port_set_active(port, 0);
 	tty_port_shutdown(port, tty);
 	tty_kref_put(tty);
@@ -496,10 +496,10 @@ int tty_port_block_til_ready(struct tty_port *port,
 	retval = 0;
 
 	/* The port lock protects the port counts */
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 	port->count--;
 	port->blocked_open++;
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 
 	while (1) {
 		/* Indicate we are open */
@@ -536,11 +536,11 @@ int tty_port_block_til_ready(struct tty_port *port,
 
 	/* Update counts. A parallel hangup will have set count to zero and
 	   we must not mess that up further */
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 	if (!tty_hung_up_p(filp))
 		port->count++;
 	port->blocked_open--;
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 	if (retval == 0)
 		tty_port_set_active(port, 1);
 	return retval;
@@ -570,7 +570,7 @@ int tty_port_close_start(struct tty_port *port,
 	if (tty_hung_up_p(filp))
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 	if (tty->count == 1 && port->count != 1) {
 		tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
 			 port->count);
@@ -583,10 +583,10 @@ int tty_port_close_start(struct tty_port *port,
 	}
 
 	if (port->count) {
-		spin_unlock_irqrestore(&port->lock, flags);
+		tty_port_unlock_irqrestore(&port->lock, flags);
 		return 0;
 	}
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 
 	tty->closing = 1;
 
@@ -615,16 +615,16 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 	tty_ldisc_flush(tty);
 	tty->closing = 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	tty_port_lock_irqsave(&port->lock, flags);
 
 	if (port->blocked_open) {
-		spin_unlock_irqrestore(&port->lock, flags);
+		tty_port_unlock_irqrestore(&port->lock, flags);
 		if (port->close_delay)
 			msleep_interruptible(jiffies_to_msecs(port->close_delay));
-		spin_lock_irqsave(&port->lock, flags);
+		tty_port_lock_irqsave(&port->lock, flags);
 		wake_up_interruptible(&port->open_wait);
 	}
-	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_unlock_irqrestore(&port->lock, flags);
 	tty_port_set_active(port, 0);
 }
 EXPORT_SYMBOL(tty_port_close_end);
@@ -675,9 +675,9 @@ EXPORT_SYMBOL_GPL(tty_port_install);
 int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 							struct file *filp)
 {
-	spin_lock_irq(&port->lock);
+	tty_port_lock_irq(&port->lock);
 	++port->count;
-	spin_unlock_irq(&port->lock);
+	tty_port_unlock_irq(&port->lock);
 	tty_port_tty_set(port, tty);
 
 	/*
-- 
2.17.1

