Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489DFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B5A2064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pj5kHzis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B5A2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeIEKEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:04:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34897 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeIEKEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:04:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2-v6so1777134plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 22:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SGfJmxSnzjX4CwVezg9MN5HPq9y3O3EZ/iwj2y65l4I=;
        b=pj5kHzissK+ExtvnJTbORtpQ2xQN6lgHl8jAxTXsp9lRFTxfUjNJE6wYyH3Vl/Avoz
         vw/Nf/8VnNRMMfYP0WKV3aDhpq6ym1plZaTUViStNMPCZNKFaqUlvyrtWnqWmQpw5wQ0
         9THn1MmgrTm/QI41e/My6l8r0+qatJ9QRQZfLwQ/6gVnyRWybG+Ur/+16okuHhzX6N88
         nd6utt9CnOudKOUSUv3kGCWle0/KjV4DH6s/ewYtlSLlBfoe0eaPmo+VEdERfMZ4yReI
         +bsQbk5qBO9NT3cADfGIQaSljkjPSl3PJC1G+RRffFQh6ai9I/PF40UCtLOv0K3IRCVb
         niKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SGfJmxSnzjX4CwVezg9MN5HPq9y3O3EZ/iwj2y65l4I=;
        b=HbPqfYcZo2FER/IKfgFR4pR1wp5lG+nUdGF61Cu/ryh62ba0lNqlL54L6qTuwGnVTh
         ZX3WsFw1o/1mL6WGaPWa6BAS4/zHrOggHk7QqSHH+m6ZBRAfaA0GJtwMPCojZ+gwHS5x
         xY6lHfncH6o8wvdSGahnhqLmN2wzpbMnTo7yflS+/m3AWz3I9wnNnQWVkNMvbOvzqzoo
         7w2Sb6D8Zke6Q8zZ7kVIUrKVbf9bJySS2ZozgW6UEoD/RwA9OLTBmelOYG6uPgSBQwjc
         Of51ziwE1D2Z4vZobG6oLg6jEP8sPwu8tjvoQVVg/pJEc0sSk8+lL6vr/Dmp4Gd9kh3s
         RBWw==
X-Gm-Message-State: APzg51BYsgJW3zbFl77wobN/iK+F9GDbeEzNOLoP//isqxPdxxpHkVEh
        PS4c+IqUl4z7JJ/I8bfsYZE=
X-Google-Smtp-Source: ANB0VdYG9GjdWotIDeHrz4Bq/04lX1LYtSMJdOsEz3rGraR8XoLrB1/ObbWv2MtN2FIRniISucxDrg==
X-Received: by 2002:a17:902:7d83:: with SMTP id a3-v6mr37137143plm.0.1536125774483;
        Tue, 04 Sep 2018 22:36:14 -0700 (PDT)
Received: from localhost ([175.223.19.100])
        by smtp.gmail.com with ESMTPSA id i7-v6sm837271pgs.17.2018.09.04.22.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 22:36:13 -0700 (PDT)
Date:   Wed, 5 Sep 2018 14:36:09 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <20180905053609.GA19936@jagdpanzerIV>
References: <20180904180154.845-1-hdegoede@redhat.com>
 <20180905023522.GA1444@jagdpanzerIV>
 <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/05/18 06:53), Hans de Goede wrote:
> > 
> > Do you use earlycon?
> 
> No, I'm seeing this with the regular/normal console stuff.

OK, thanks for the report!
So I think that your case is CON_PRINTBUFFER related as well. We have
a number of logbuf messages before we parse quiet and console_loglevel.
Those messages pass the suppress_message() test. Then when we finally
register a CON_PRINTBUFFER console we update console_loglevel and flush
all logbuf messages, but console_loglevel does not matter anymore.

> > > This commit fixes this by setting a new LOG_CHK_LEVEL on early boot
> > > messages and doing the loglevel check for these while flushing as before.
> > > 
> > 
> > Hmm, OK, chances are we need to re-think 375899cddcbb. It might be
> > the case that we sort of broke CON_PRINTBUFFER handling.
> > 
> > 	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH
> > 	register CON_PRINTBUFFER console
> > 		-> no debug output
> > 
> > So I think that when console_unlock() re-flushes already seen logbuf
> > messages to a newly registered exclusive [CON_PRINTBUFFER] console we
> > probably need to look at the current console_loglevel in console_unlock()
> > loop.
> 
> So if it breaks quiet and the above use-case maybe we should revert
> 375899cddcbb for now?

Maybe all we need to do is to re-introduce suppress_message() check to
console_unlock() when we have exclusive console set (IOW, when we re-flush
logbuf messages to a CON_PRINTBUFFER console).

Just a demonstration of the idea. It does not look very good, tho.
I'd rather have just one suppress_message_printing() in printk code.

// This is not a proposed patch, hence the 80-cols violation.

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c036f128cdc3..231ac18423e1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2416,7 +2416,7 @@ void console_unlock(void)
 			break;
 
 		msg = log_from_idx(console_idx);
-		if (msg->flags & LOG_NOCONS) {
+		if (msg->flags & LOG_NOCONS || (exclusive_console && suppress_message_printing(msg->level))) {
 			/*
 			 * Skip record if !ignore_loglevel, and
 			 * record has level above the console loglevel.

---

We are still early in 4.19 -rcs, let's wait a bit and hear from Steven
and Petr, they have bright ideas oftentimes.

	-ss
