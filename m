Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78464C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4832089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgttLsKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4832089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeKHWGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:06:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35111 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeKHWGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:06:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id v9-v6so6947771pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z4HL5vdFKj3lvyRmDgUkcTz3TYnCqHWA1a6A7dgpydU=;
        b=EgttLsKR4bJVP11jIHNimK4XPh5bRT8YNTs+Q/WU1mltjS0jeb6109pyEYy2zZ52gG
         j4OT0xinsPFKeXectKpPPwDKJhIcCgsrnr8TKc3PDePkcauW+6gHkYGbW6yrdQOkSk3W
         yXk3KbP4v9KpszQz1nYdaOBrcDtrszFitXEAdqAVac3tFkQSWZSDl2IsVc5xqNXO/BlH
         vwPqJZfNzRc4XmqJmU/7j8DGTbf6Gz6fdEfF4ZvfxxMAkoBgwV8sSXkSzSom6FzOVQB4
         fxt44PhxFF9cMTg+8trmiiIvkEIZ6HGHaZbdM13acVSA9EVnk61Q+Giaq2C4z8+uf+Yr
         r6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z4HL5vdFKj3lvyRmDgUkcTz3TYnCqHWA1a6A7dgpydU=;
        b=VnRUDpryq4axEHjhuQnW8DbVvAh8kARLm7TxoSRZVByE8vun6A+GX6De8EFV7INHmO
         ka9qRSzlwcLmXfUk+/qDPYbmSynvdREWzQnr942d3RdRaNPQKRCsdJ9GZiP1UuzrHyhE
         jQ78jr/WnjmOXfd2VYJ5GdByo02YhvF3LnQSQvZWOGcyd51/oKwQ4NpxpGrlP39eX0dh
         T/AAQ7XrQTj0Y/laT1+qm96kRbeCTh8HCsD3sLVh5Jobjd8xuIz8xT3XDve1ft2PhiPl
         xvypIopKZApbrX7KclrFb83lLX3kt0X6JSPlAHN1jsGomaTRtorauIpoHgqMUU7kxTYY
         Yq3g==
X-Gm-Message-State: AGRZ1gK8BryFoz3uwDzqetyICCgAg2oG5vev1DtuIN/Nq4mqfj9uRULy
        jWxbhU6v6bt06MDS9Axb3vdAOEP1
X-Google-Smtp-Source: AJdET5cYjw9mFVnbdwTm40kpx5ECkNBxf374mANeHl3fRp3b4gnm2uEpmjVmTrusaG/37eZGzdWOBA==
X-Received: by 2002:a63:b81a:: with SMTP id p26mr3663042pge.433.1541680254297;
        Thu, 08 Nov 2018 04:30:54 -0800 (PST)
Received: from localhost ([39.7.58.178])
        by smtp.gmail.com with ESMTPSA id r1-v6sm5033524pfb.41.2018.11.08.04.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 04:30:52 -0800 (PST)
Date:   Thu, 8 Nov 2018 21:30:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
Message-ID: <20181108123049.GA30440@jagdpanzerIV>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181106143502.GA32748@tigerII.localdomain>
 <20181107102154.pobr7yrl5il76be6@pathway.suse.cz>
 <20181108022138.GA2343@jagdpanzerIV>
 <20181108112443.huqkju4uwrenvtnu@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108112443.huqkju4uwrenvtnu@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/08/18 12:24), Petr Mladek wrote:
> I believe that I mentioned this more times. 16 buffers is the first
> attempt. We could improve it later in several ways

Sure. Like I said - maybe it is a normal development pattern; I really
don't know.

> > Let's have one more look at what we will fix and what we will break.
> > 
> > 'cont' has premature flushes.
> > 
> >   Why is it good.
> >   It preserves the correct order of events.
> > 
> >   pr_cont("calling foo->init()....");
> >   foo->init()
> >    printk("Can't allocate buffer\n");    // premature flush
> >   pr_cont("...blah\h");
> > 
> >  Will end up in the logbuf as:
> >  [12345.123] calling foo->init()....
> >  [12345.124] Can't allocate buffer
> >  [12345.125] ...blah
> > 
> >  Where buffered printk will endup as:
> >  [12345.123] Can't allocate buffer
> >  [12345.124] calling foo->init().......blah
> 
> We will always have this problem with API using explicit buffers.

Exactly.

> What do you suggest instead, please?

So this is why "let's not remove 'cont'" thing. Buffered printk
is not 100% identical to 'cont'. And 'cont' does a good job sometimes,
Because 'cont' looks like a buffered printk, but it behaves like a
normal printk when things go bad. Buffered printk is always buffered;
and not even aware of the fact that things go bad around.

> > If our problem is OOM and lockdep print outs, then let's address only
> > those two; let's not "fix" the rest of the kernel, especially the early
> > boot, - we can break more things than we can mend.
> 
> Do you have any alternative proposal how to handle OOM and lockdep, please?

You misunderstood me. I'm not against the buffered printk in lockdep and
OOM. Albeit I must admit that lockdep patch looks quite big. I don't like
the idea of "we will remove 'cont' and replace it with buffered printk
through out the kernel".

[..]
> > - It seems that buffered printk attempts to solve too many problems.
> >   I'd prefer it to address just one.
> 
> This API tries to handle continuous lines more reliably.
> Do I miss anything, please?

This part:

+       /* Flush already completed lines if any. */
+       for (pos = ptr->len - 1; pos >= 0; pos--) {
+               if (ptr->buf[pos] != '\n')
+                       continue;
+               ptr->buf[pos++] = '\0';
+               printk("%s\n", ptr->buf);
+               ptr->len -= pos;
+               memmove(ptr->buf, ptr->buf + pos, ptr->len);
+               /* This '\0' will be overwritten by next vsnprintf() above. */
+               ptr->buf[ptr->len] = '\0';
+               break;
+       }
+       return r;

If I'm not mistaken, this is for the futute "printk injection" work.

Right now printk("foo\nbar\n") will end up to be a single logbuf
entry, with \n in the middle and at the end. So it will look like
two lines on the serial console:

	[123.123] foo
	          bar

Tetsuo does this \n lookup (on every vprintk_buffered) and split lines
(via memove) for "printk injection", so the output will be

	[123.123] foo
	[123.124] bar

Which makes it simpler to "inject" printk origin into every printed
line.

Without it we can just do

	len = vsprintf();
	if (len && text[len - 1] == '\n' || overflow)
		flush();

Can't we?

	-ss
