Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EA9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B78720837
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdKoYVG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B78720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeKHLyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:54:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33088 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeKHLyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:54:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id q5-v6so8171185pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 18:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I0zex2MEEnuhs1Nej2Q5AyMi6paSzlpS9UlG4LTzFHg=;
        b=KdKoYVG6s8UKB/OhoCZAZTSBt7x7VygNpSq+qknYb5CCUDz4j06noq0yA1LxEmaRcU
         JRdsE5oE63w3kvyYm7N8gojV1MXHzic5Py21MWmnr1TTENVQFiQoRQw5WQKG5JU1DVON
         0SuwusTmbdNAGFP25h1Sw+sKXcryn2dcQZApy+FpAYNrU8Su0Qf5MSPdxgT8RgQUv0MH
         WplO3pkPqI5qPpcyHms3XF0Wv2/AN2Trkn/V+vBb2+9oBggAscOweNndeothfL9nGn6j
         yagDY9jd2qIvysTl+ErCYK8zAeGZyqVfx+TeOoJCxJAO+LNBU7Givl8ISTTMT4jHpG6t
         pxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I0zex2MEEnuhs1Nej2Q5AyMi6paSzlpS9UlG4LTzFHg=;
        b=nJxtjL4AAjvkBK2SKyGaYCGN23/BILafQ+fKK6eiAIr3xe/JPWwqO1CkXWqnH7dz4R
         1XREO5NMlvlNLos2QItv5bt6T6sou9rLsDyRTKKMFXnFFjnLwe6EslL25msMREAmPuiY
         QpFFHc9o5gSAf6LDQBaZ5j5KuIMNIXSYSp0BYaURoy75ZcrfkF3ZHX30huo5wLQl1kZj
         kmhjGbLnB+Y3DZRt6QjYusQAr8hlIv9nUBP5gHpZfqCyIHin3w022kuWgX9d0en8uM66
         bkfjWV3njs7p9mzvmLXstRdjkn0P5aQbl/z3Y/k065NW4uijYqIJfwzukc1bickhfLf5
         7exA==
X-Gm-Message-State: AGRZ1gJlXMn/cHC0UQ0lNmUBdJUohokNzTJe3vyJr0fDCwLTMYGkXTSn
        oU2pGVg8trFIlGwZo/cTbRE=
X-Google-Smtp-Source: AJdET5dzOy+2BMPR6DcFL/A0C01sq3caj2d9kQusJEjh8ZAeBIHKMNdv1SqLNHoBv7WdT/rmys8p3w==
X-Received: by 2002:a63:6643:: with SMTP id a64-v6mr2249954pgc.15.1541643703006;
        Wed, 07 Nov 2018 18:21:43 -0800 (PST)
Received: from localhost ([39.7.58.178])
        by smtp.gmail.com with ESMTPSA id q134-v6sm3126618pfc.88.2018.11.07.18.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 18:21:41 -0800 (PST)
Date:   Thu, 8 Nov 2018 11:21:38 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20181108022138.GA2343@jagdpanzerIV>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181106143502.GA32748@tigerII.localdomain>
 <20181107102154.pobr7yrl5il76be6@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107102154.pobr7yrl5il76be6@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/07/18 11:21), Petr Mladek wrote:
> > [..]
> > - The printk-fallback sounds like a hint that the existing 'cont' handling
> >   better stay in the kernel. I don't see how the existing 'cont' is
> >   significantly worse than
> > 		bpr_warn(NULL, ...)->printk() // no 'cont' support
> >   I don't see why would we want to do it, sorry. I don't see "it takes 16
> >   printk-buffers to make a thing go right" as a sure thing.
> 
> I see it the following way:
> 
>    + mixed cont lines are very rare but they happen
> 
>    + 16 buffers are more than 1 so it could only be better [*]

Right, so this is where things go a bit shady. I'll try to explain.

What is the problem:
- we have tons of CPUs, with tons of tasks running on them, with preemption,
  and interrupts, and potentially printk-s coming from various
  contexts/CPUs/tasks etc. so one 'cont' buffer is not enough.

What is the proposed solution:
- if 1 is not enough then 16 will do. And if 16 is not enough then this
  is not our problem anymore, it's a kernel misconfiguration and users'
  fault.

So, maybe it is a "common" kernel development pattern, I really don't know;
but it looks like we are just throwing the issue over the fence; and atop
of that we are killing off the existing 'cont'.

> Anyway, I do not think that both implementations are worth it.
> We could keep both for some transition period but we should
> remove the old one later.
>
[..]
>
> This would prevent removing the fallback to struct cont. OOM is
> one important scenario where continuous lines are used.

Let's have one more look at what we will fix and what we will break.

'cont' has premature flushes.

- it's annoying in some cases
- it's good otherwise

  Why is it good.
  It preserves the correct order of events.

  pr_cont("calling foo->init()....");
  foo->init()
   printk("Can't allocate buffer\n");    // premature flush
  pr_cont("...blah\h");

 Will end up in the logbuf as:
 [12345.123] calling foo->init()....
 [12345.124] Can't allocate buffer
 [12345.125] ...blah

 Where buffered printk will endup as:
 [12345.123] Can't allocate buffer
 [12345.124] calling foo->init().......blah

It's very different.

Not to mention that buffered printk does not flush on panic.
So, frankly, as of now, I don't see buffered printk as a 'cont'
replacement.

If our problem is OOM and lockdep print outs, then let's address only
those two; let's not "fix" the rest of the kernel, especially the early
boot, - we can break more things than we can mend.

[..]
> I opened this problem once and it got lost. So I did not want to
> complicate it at this moment.

Right, I saw it. We have similar points; I raised those in private talks:

- we don't need buffered printk in printk_safe/printk_nmi

- we don't need br_cont()

- unlike 'cont' buffer there is no way for us to flush buffered printk
  buffers on panic

- I don't exactly like the completely of the vprintk_buffered. If
  buffered printk is for single line, then it must be for single
  line only. And I'm not buying the "we will need this for printk
  origin info injection" argument.
  Linus was very clear about this whole idea:

  Linus Torvalds wrote:
  :  Sergey Senozhatsky wrote:
  :  >
  :  > so... I think we don't have to update 'struct printk_log'. we can store
  :  > that "extended data" at the beginning of every message, right after the
  :  > prefix.
  :
  :   No, we really can't. That just means that all the tools would have to
  :   be changed to get the normal messages without the extra crud. And
  :   since it will have lost the difference, that's not even easy to do.
  :
  :   So this is exactly the wrong way around.
  :
  :   If people want to see the extra data, it really should be extra data
  :   that you can get with a new interface from the kernel logs. Not a
  :   "let's just a add it to all lines and make every line uglier and
  :   harder to read.

  So the "we need all that complexity to inject printk info in later
  patches" push doesn't look right.

- It seems that buffered printk attempts to solve too many problems.
  I'd prefer it to address just one.

	-ss
