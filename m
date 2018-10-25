Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05925C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30AF2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuOX4Mj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30AF2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeJYU25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:28:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33429 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJYU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:28:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id z2-v6so3894625pgp.0;
        Thu, 25 Oct 2018 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dEIn9cVr+pI3NMEMOoE9IlqFedtG8otNOw5EOATkuVY=;
        b=DuOX4Mj59xGwZDR9paIdGkJg9PSuxvFS0wBFXbq3E0QR+e12rZO7D26UYKVnn3q9JV
         NhLoA24p6Og6pbhlx/a89nmU/vTI/OpSHbcDQjth32keXe1X/9oAwZ2e1DOc7Q8uU9Pr
         VOHSCJ5ofQRXRB1ijVTsHoqDTLfRrCJERgur/fQhLhyjnqaQUlox/qjdBvI1JhCMjrF0
         fsyXieM/wGokuJ50dLW8A7fYrvpxUgUnOdb4zuLqIhYXW/UjuktwQDQizIzpQZfOqYJs
         0WdEx476iVPIyrsIgyM9Icl4eQeF8dWj6/Uw126i4Xh5ZpFL/Ut4vGD79v1XRiYtDpQh
         5Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dEIn9cVr+pI3NMEMOoE9IlqFedtG8otNOw5EOATkuVY=;
        b=a5biJydIv50LWHau+tgLY0hOmDS0ZaubseHdi5Y5i6n625TTaqOt9g9LKzxwfPtLj9
         ItASYmM5ERgSfQ1Ees8sTjC4vWDNCqiDR5ZiltAEJEHvu8TD9/QEB417ZfDgeT9eBPff
         oEEOFpkOzD59v6bc/QDq/5rPE8sB0HqfXiCws38ow80MnvHkkokbEnU0cH+C+PzpOfCz
         56ST7du+75PlEgL65VPSgG1TeOQRQmOP5gKbWqgHyX1P3XT9WZNnDUkrsxFqvZcZYSGP
         GRv2nUgJBydcvESSaaa36Dq2p5GUwY2byg+toQL75ie+RbdiA3aZ5a1jGLwhki19S+As
         YpBg==
X-Gm-Message-State: AGRZ1gLMX3rG+Lp75w5UEdkOe72acUFwP1229mdqUfv3pz4XQFZuAOJh
        5fypY/MjNDXkH4oiROLg/Xo=
X-Google-Smtp-Source: AJdET5cHlgb4MHiHCwwEHcjlNdDDTIsMckyCl50OPIECS6ZmhOR26tcXx5aOLW96LIu1adRFudUd9g==
X-Received: by 2002:a62:b87:: with SMTP id 7-v6mr1256241pfl.67.1540468588317;
        Thu, 25 Oct 2018 04:56:28 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id z14-v6sm10384978pfi.4.2018.10.25.04.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 04:56:27 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 25 Oct 2018 20:56:15 +0900
To:     kbuild test robot <lkp@intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
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
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv3] panic: avoid deadlocks in re-entrant console drivers
Message-ID: <20181025115615.GA1018@tigerII.localdomain>
References: <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
 <201810251848.0wSJMnS0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810251848.0wSJMnS0%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/25/18 18:51), kbuild test robot wrote:
> 
> [auto build test ERROR on linux-sof-driver/master]
> [also build test ERROR on v4.19 next-20181019]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 

My bad, sorry!

+#include <linux/vt_kern.h>

This should fix it.

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH] panic: avoid deadlocks in re-entrant console drivers

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
 kernel/panic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index f6d549a29a5c..272ac1c34e4b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -29,6 +29,7 @@
 #include <linux/ratelimit.h>
 #include <linux/debugfs.h>
 #include <asm/sections.h>
+#include <linux/vt_kern.h>
 
 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
@@ -237,7 +238,10 @@ void panic(const char *fmt, ...)
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

