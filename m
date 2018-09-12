Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7E7C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2825320866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHGXxlmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2825320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeILMwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:52:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39793 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeILMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:52:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id i190-v6so612715pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eWAlVSAFCQUwpmiLccOtR4xIKkAjmuUgFQSEA3rtxOw=;
        b=mHGXxlmzy5MMzFkqgDpslUc7xaD1BNzHZi52t7ES0LmyO3mVFlt4/gdIp7CSSJ0axR
         95JfIWMS4RuKzM5r2Xluhcu9e4SpGYJB0Mzg+VxeAA71J5S571GecaPOGVd0Sfmhwxi7
         Lq2hZ2fcQtDwcafcDX+1Mr4dKE1Xj88ExsHsYf9OvV241deEPPIHibJAwvXLuokZx1mO
         +ZyGuGIW4VH9WJZHuliYs8g9cTDGtfWaAmzDna7Q/6U1YqQXxsfLqF1wyblOZQ222g3O
         waTho1IJm29OhG3cLGNA1JcBs1ulvrJoH6MH/wcs5NHaAW2RaPE+k/4YA6BuefQ+j4E6
         7L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eWAlVSAFCQUwpmiLccOtR4xIKkAjmuUgFQSEA3rtxOw=;
        b=DB7OpT+W97O8NKE15Tzur16oLkF+psmFJ7KQ1FPJUwyn9dwhi4dTL9iY2+SMokSPBl
         WjQhXKr1Gtv7njmLMfbS0RRrjhfjk7DDTZ2bhQLZzS5Ak6RHT7gppVBYFLwAS8j5H1gu
         z2Wwpy1FPmiNg5vuqnq5TogvgUXdZZI+Y7ZYV1vGqLuWW/xdSR1C+ug/A9ZJ+q8UXG0J
         MSM0TjGnfD/pp5S/4sG/oDJLYEz1RR9lV8xmVquKpUHCqSsMf3HB/DfjocIUC7PTR5uW
         qgvAy+bNKdR7lHJ1hK3GcUu2B7/PurWFSdfyQxJ5DB5o/gAUNKyljOXpm+iMc2WLFbwv
         mX0Q==
X-Gm-Message-State: APzg51AzYuNW4Bcu1kPJlW4vuSXb5Xq8sZNlmrlzWfhxBTcgQ+ImVxF3
        IImF2o+VBrvqaMFYbMcT0rE=
X-Google-Smtp-Source: ANB0VdakYDcLvqvz1Gr3MtxwpWV2Qn/WQm7PGeqecDmIJwUgFvr601D9XEfzHa4KeUZtl6W6eMFnUA==
X-Received: by 2002:a63:4386:: with SMTP id q128-v6mr679165pga.353.1536738575062;
        Wed, 12 Sep 2018 00:49:35 -0700 (PDT)
Received: from localhost ([175.223.23.50])
        by smtp.gmail.com with ESMTPSA id l3-v6sm565422pff.8.2018.09.12.00.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 00:49:33 -0700 (PDT)
Date:   Wed, 12 Sep 2018 16:49:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <20180912074930.GA470@jagdpanzerIV>
References: <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
 <20180905053609.GA19936@jagdpanzerIV>
 <20180905083326.GC19936@jagdpanzerIV>
 <20180905110207.rxy3upplgkjbk5oi@pathway.suse.cz>
 <20180906072940.GA382@jagdpanzerIV>
 <20180906142825.u2fiqt62jmapr5ud@pathway.suse.cz>
 <20180907042132.GC2394@jagdpanzerIV>
 <20180910145747.emvfzv4mzlk5dfqk@pathway.suse.cz>
 <20180911023039.GA4065@jagdpanzerIV>
 <20180911084722.22fqbewiebzsdofm@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911084722.22fqbewiebzsdofm@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/11/18 10:47), Petr Mladek wrote:
> > Oh, that was intentional. I consider repeated messages to be less
> > problematic than the missing ones.
> 
> It makes some sense. But it might be problematic with slow consoles.

Right. And this is why I brought up Jan's patch.
And I agree that we better discuss that approach in a separate thread.

> > > Most problems should probably be solved when we store console_seq
> > > before setting exclusive_console. Then we could clear
> > > exclusive_console when reaching the stored sequence number.
> > > 
> > > Can this be that simple? ;-)
> > 
> > This can work, yes.
> 
> I'll try to cook up a patch later this week.

Hmm, wouldn't the same "it might be problematic with slow consoles"
argument apply to this solution as well? If we flush_on_panic(), and
have a slow exclusive_console then flushing logbuf to that slow
exclusive_console can take quite some time, before we even begin to
flush oops messages.

So maybe we can do the following:

- store console_seq when we register exclusive console
- in flush_on_panic, if we have exclusive console set
    - clear exclusive console
    - rollback console_seq to the value it had before we set exclusive console

So we will not re-flush all logbuf messages, but only the new ones and
should get to oops messages sooner.

IOW, something like this?

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 53c94cbce0af..4ef199572df7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -424,6 +424,7 @@ static u32 log_next_idx;
 /* the next printk record to write to the console */
 static u64 console_seq;
 static u32 console_idx;
+static u64 rollback_console_seq;
 
 /* the next printk record to read after the last 'clear' command */
 static u64 clear_seq;
@@ -2592,6 +2593,10 @@ void console_flush_on_panic(void)
 	 */
 	console_trylock();
 	console_may_schedule = 0;
+	if (exclusive_console) {
+		exclusive_console = NULL;
+		console_seq = rollback_console_seq;
+	}
 	console_unlock();
 }
 
@@ -2793,6 +2798,7 @@ void register_console(struct console *newcon)
 		 * for us.
 		 */
 		logbuf_lock_irqsave(flags);
+		rollback_console_seq = console_seq;
 		console_seq = syslog_seq;
 		console_idx = syslog_idx;
 		logbuf_unlock_irqrestore(flags);

---

	-ss
