Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29A3C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764172086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEBTspBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764172086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeKIPvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:51:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42761 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbeKIPvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:51:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so404907pgq.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9BqsfatM35ZqGp/QL+JAY1k1nAVAQcnUhzXOfcjNzAQ=;
        b=LEBTspBLe9cJMmnrhzBTAD5Ll3+I27jrV8LpKrlCbi2mmrw45U27tQwtrS1PrQ8YOu
         j+NBAkxsoGYqMnNsMsXjBbx8L1P4K4gfzacBsboDCkwFU/tRmYujoXhxmwgCJKOiul/p
         ekc472JghO8zFARqDfnvGpXIqA+fraJ7BmwhyCXb497N5Pao6kb9cd99vrXM3L4Ur/AW
         cXpROOjtdOiAOctiCCAPPqC52xn1FbdoNrbFHH3gT63rLv7Wga2W6K8qOzyyeLWYcQSJ
         phDFBIw9dYPaZ9QmYPaDykq6WRjv7Gvrhf52VcF8clOp/5AvuqPa0yidlACv1+EIEoVH
         6bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9BqsfatM35ZqGp/QL+JAY1k1nAVAQcnUhzXOfcjNzAQ=;
        b=TME+y1uwRkkebd9d3Mdug8OVvjSCuQuF5+zMCSjb6D6AvLCclcILSRtQqTvmdHraR9
         3bamkAHH5jrRaTCuJTKk1cHBn2a+TEH8N5sY1g4Yt5dndR0LJ0KzpIHf/UwafelLg1SX
         GCfveZUVpMVB30wiq+10IegkAiLkAQozJnsjsYCv1acwbJs9sNDcWKTAH3jOjyKczqKa
         krBuEeUHKZsyE6Rkv6R5FTuhbXlZTP46bfCrJlAYA4Y19mBLC78DKxtvUokdnWjeeHBZ
         BuHnW9LAVxX5dhV9Um7j9NjvrSJlsp74Kn/ldn3W/Ti9RlG5D8hJ6+iF0SqcfLYtolgx
         a8bQ==
X-Gm-Message-State: AGRZ1gI2+8Ko/ivwtBkobD4/oYhEG38zT68y01xWuJGGSsobQDS5cy1G
        7iaNHiiBMtQU4/34dG0v0Sc=
X-Google-Smtp-Source: AJdET5fOkZ2AHRdWgXNRuenQl1R/lX0Jyia8m2ARWWd+7PgJZdCIxKNh6CcsygT/lc9WVpWkEYR4Kw==
X-Received: by 2002:a63:ba48:: with SMTP id l8mr6271528pgu.72.1541743929795;
        Thu, 08 Nov 2018 22:12:09 -0800 (PST)
Received: from localhost ([110.70.55.191])
        by smtp.gmail.com with ESMTPSA id r124-v6sm7334749pfr.151.2018.11.08.22.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 22:12:08 -0800 (PST)
Date:   Fri, 9 Nov 2018 15:12:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181109061204.GC599@jagdpanzerIV>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
 <20181108044510.GC2343@jagdpanzerIV>
 <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/08/18 20:37), Tetsuo Handa wrote:
> On 2018/11/08 13:45, Sergey Senozhatsky wrote:
> > So, can we just do the following? /* a sketch */
> > 
> > lockdep.c
> > 	printk_safe_enter_irqsave(flags);
> > 	lockdep_report();
> > 	printk_safe_exit_irqrestore(flags);
> 
> If buffer size were large enough to hold messages from out_of_memory(),
> I would like to use it for out_of_memory() because delaying SIGKILL
> due to waiting for printk() to complete is not good. Surely we can't
> hold all messages because amount from dump_tasks() is unpredictable.
> Maybe we can hold all messages from dump_header() except dump_tasks().
> 
> But isn't it essentially same with
> http://lkml.kernel.org/r/1493560477-3016-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
> which Linus does not want?

Dunno. I guess we still haven't heard from Linus because he did quite a good
job setting up his 'email filters' ;)

Converting the existing users to buffered printk is not so simple.
Apparently there are different paths; some can afford buffered printk, some
cannot. Some of 'cont' users tend to get advantage of transparent 'cont'
context: start 'cont' output in function A: A()->pr_cont(), continue it in
B: A()->B()->pr_cont(), and then in C: A()->B()->C()->pr_cont(), and
finally flush in A: A()->pr_cont(\n). And then some paths have the
early_printk requirement. We can break the 'transparent cont' by passing
buffer pointers around [it can get a bit hairy; looking at lockdep patch],
but early_printk requirement is a different beast.

So in my email I was not advertising printk_safe as a "buffered printk for
everyone", I was just talking about lockdep. It's a bit doubtful that Peter
will ACK lockdep transition to buffered printk.

	-ss
