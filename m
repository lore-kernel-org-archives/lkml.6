Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE925C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961492054F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZYxur8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961492054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJPMxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:53:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47054 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJPMxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:53:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so10804316pfb.13;
        Mon, 15 Oct 2018 22:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVYIhdVZHvxmKxxgkD3u2siYzRTuYmE4tH8lCk6uizQ=;
        b=AZYxur8NlKBRC+78JRic+IQTjMVEgY8nLbBjZ/9E8L2dXG0QxUqQqFenqx4N9ix7FC
         MoakkNynaJLOP7nuAqOacr8Fad8Nxc1WZ8i4mwZ+G+nw5kzD34Kq8d9MI1qZzK51kbTb
         juoPLKSMJt6n/ggNFg/7jjBA7WZCe75REghgy2tqpdWYkM+W7lgpt2t3MQB2+QPQi8S5
         YJ5KCnRV6wNyEY9ATJ9K94cwMCt0cXmaMtuDCAUU5eT0afi9iQzeoofA0xA6tn8GJoUQ
         Pk07qWv5HKvWAURt/GHYLPPC2G9tWwmfcwqGmJdXmI1FFoGjb530sJ29gzmWFEKJIhmo
         XKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVYIhdVZHvxmKxxgkD3u2siYzRTuYmE4tH8lCk6uizQ=;
        b=dEtyNRtBfLKSziH85fFLxRN5Elv8eliaVyB8KwtL8UxbSW+FoMAuAQam2DyMGq1RP7
         +C9tX/5+Y7Wvh1BtTVC0ZpiyUVmNfBP/JHSCNVZ3x0+y2Va2rgrZqm/hVnVgqww679Nc
         8QsjbaRO72EHjgniABnzi2z70IhMDRpXl7F8FK9mJJIZDJ4wxhg7vbc/go3yEBiSw+Sa
         BtHRODanUZXjF7JRAner4D1Rd8kI8YbHkmbPfJHuOpy0fjzgNfU5dPRxvB61cWJ6FOCi
         OsrB07JuEu4QwLJSGQnwMnVg3mu/jtM0GpBhQT0+Rf3OrGhKL9rto4uSpSZEzLp1OeCA
         NuOA==
X-Gm-Message-State: ABuFfohpw9G3160SFgMO8Hr8aHa9f+P+SGL1FynAZncTODEl+jNoAUkb
        FDbQDNgn5uu5VfdSjmsJTjAuWSbh
X-Google-Smtp-Source: ACcGV60uIMhKKl1tSS62AYOgxBoLLPf/68wVzYUMPpBFAaeN7m7Bl6k2N4PJx3u2FRc2eX2msVbH8w==
X-Received: by 2002:a62:6643:: with SMTP id a64-v6mr20434947pfc.202.1539666288531;
        Mon, 15 Oct 2018 22:04:48 -0700 (PDT)
Received: from localhost.localdomain ([175.223.10.117])
        by smtp.gmail.com with ESMTPSA id e131-v6sm19353225pfc.52.2018.10.15.22.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 22:04:47 -0700 (PDT)
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
Subject: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console drivers
Date:   Tue, 16 Oct 2018 14:04:25 +0900
Message-Id: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
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

Fix this by setting oops_in_progress before console_flush_on_panic(),
so re-entrant console drivers will trylock the port->lock instead of
spinning on it forever.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/panic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index f6d549a29a5c..a0e60ccf3031 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -237,7 +237,13 @@ void panic(const char *fmt, ...)
 	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
+	/*
+	 * Decrement oops_in_progress and let bust_spinlocks() to
+	 * unblank_screen(), console_unblank() and wake_up_klogd()
+	 */
 	bust_spinlocks(0);
+	/* Set oops_in_progress, so we can reenter serial console driver */
+	bust_spinlocks(1);
 
 	/*
 	 * We may have ended up stopping the CPU holding the lock (in
-- 
2.19.1

