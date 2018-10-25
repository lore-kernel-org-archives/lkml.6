Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A032AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6633F2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQnflRtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6633F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeJYSpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:45:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46492 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbeJYSpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:45:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so3917643pfb.13;
        Thu, 25 Oct 2018 03:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hcZ94SviZBdlcNxwC40//naoGnFsRWAgYOTZ4WTfU8A=;
        b=QQnflRtSqllzydVTZHOeSFy5Qg3d2YZ8fV8CSFtc/kS+wwO5QORA9wX6oSCvEr4lPj
         DRQtWT1Hlr+SxDEliQ8PQ62jC4SwCjYQX3KMhT7rkgDiPdQVgK40D/z0W94PCn05kjBX
         dLFvGdWkGl5TEFugiTTiuCZmeuFS34BQMrf+2l8W6gqat6AWXtBfRskX+Gfw0W1aACUO
         dvK96JxYqqYNFl6QoRzv1EWhzPkL/GsSszrPJRKBZVBmlRFicFVVCJ7gO1/An2yaURf0
         zGqgSqsA8vRHRWieck3hlaQhxro7TxSIJM2dSqU3mXWVjGzt1UaSBGG/BShG1VwHc9tR
         sXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hcZ94SviZBdlcNxwC40//naoGnFsRWAgYOTZ4WTfU8A=;
        b=QfW9xS1pANSLahE737i4jfxfB12PHGloUTggntbY7NKvUgIRMI/NbwwpnzWYgBrrRS
         ZhNVI749HcG8/JwQKBVajxBocdh2e6kfnYBDZfDJ5izOrGGi6DJAnPLm8aTbfMOOwUgI
         KERKASWA+Kka7C6WVtw+abD/vv8mHXqal/BXLQdEvA5Se4y1lJj7MUFnTaEJLTO+NTqQ
         NJCtaMygeymbLUJdsj9jFE4t3TuEamBNdlziMhpQuGPm1Gs3SzWltUkei3Tby+5jJsVL
         lnEKk378m4Y2rmu/jAGHH5BcIZhiF2fPsIw3NHiqT7WMwgo36bLKbz/bJA1jEd6Ab/rg
         BgGA==
X-Gm-Message-State: AGRZ1gL2u11qSqiudvpEKw9epl5vNiol8FF1uuELtIQnVuwSTr0MDuuA
        ocvCgBY3ZnUs6b487psGhite8VS5
X-Google-Smtp-Source: AJdET5di088Da+VHmoTXMXM+t/SXqY7fmnFucP/9fdJhuFzC/i8FdSIK/O1XqjrG3ywYXgXry8OMGA==
X-Received: by 2002:a63:a119:: with SMTP id b25-v6mr889860pgf.186.1540462379009;
        Thu, 25 Oct 2018 03:12:59 -0700 (PDT)
Received: from localhost.localdomain ([175.223.22.26])
        by smtp.gmail.com with ESMTPSA id t22-v6sm14798647pfk.141.2018.10.25.03.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 03:12:57 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv3] panic: avoid deadlocks in re-entrant console drivers
Date:   Thu, 25 Oct 2018 19:10:36 +0900
Message-Id: <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
References: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From printk()/serial console point of view panic() is special, because
it may force CPU to re-enter printk() or/and serial console driver.
Therefore, some of serial consoles drivers are re-entrant. E.g. 8250:

serial8250_console_write()
{
        if (port->sysrq)
                locked = 0;
        else if (oops_in_progress)
                locked = spin_trylock_irqsave(&port->lock, flags);
        else
                spin_lock_irqsave(&port->lock, flags);
	...
}

panic() does set oops_in_progress via bust_spinlocks(1), so in theory
we should be able to re-enter serial console driver from panic():

	CPU0
	<NMI>
	uart_console_write()
	serial8250_console_write()		// if (oops_in_progress)
						//    spin_trylock_irqsave()
	call_console_drivers()
	console_unlock()
	console_flush_on_panic()
	bust_spinlocks(1)			// oops_in_progress++
	panic()
	<NMI/>
	spin_lock_irqsave(&port->lock, flags)   // spin_lock_irqsave()
	serial8250_console_write()
	call_console_drivers()
	console_unlock()
	printk()
	...

However, this does not happen and we deadlock in serial console on
port->lock spinlock. And the problem is that console_flush_on_panic()
called after bust_spinlocks(0):

void panic(const char *fmt, ...)
{
        bust_spinlocks(1);
...
        bust_spinlocks(0);
        console_flush_on_panic();
...
}

bust_spinlocks(0) decrements oops_in_progress, so oops_in_progress
can go back to zero. Thus even re-entrant console drivers will simply
spin on port->lock spinlock. Given that port->lock may already be
locked either by a stopped CPU, or by the very same CPU we execute
panic() on (for instance, NMI panic() on printing CPU) the system
deadlocks and does not reboot.

Fix this by removing bust_spinlocks(0), so oops_in_progress is always
set in panic() now and, thus, re-entrant console drivers will trylock
the port->lock instead of spinning on it forever, when we call them
from console_flush_on_panic().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---

v2: do not do bust_spinlocks(1);bust_spinlocks(0);bust_spinlocks(1)
    thing and just copy paste from lib/bust_spinlocks what
    bust_spinlocks(0) does. (Petr)

 kernel/panic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index f6d549a29a5c..fccd41628b24 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -237,7 +237,10 @@ void panic(const char *fmt, ...)
 	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
-	bust_spinlocks(0);
+#ifdef CONFIG_VT
+	unblank_screen();
+#endif
+	console_unblank();
 
 	/*
 	 * We may have ended up stopping the CPU holding the lock (in
-- 
2.19.1

