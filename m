Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E3EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898FF2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqcwSpFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898FF2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeJBNUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:20:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40295 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeJBNUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:20:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id 1-v6so192537plv.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 23:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4JHd2/E/sXwr35mN9r+j8fsbSVQUZAuC4e4Tq5gQ9s4=;
        b=kqcwSpFfwOl9flNwjnfiD0U8VaLJARlkucqwGIbPmt8Sg4R/g09IBZPKiyncjsynhz
         lp3QM9s6owNJ12BTQA/p7ucnmI1ForSLje90t4a2giBtW4d+GarMCMadeEZhp/qKEU3l
         wsmIf37EPAtvSVNFg8q0RVhMkmV7Zkf3MG20V8yFGS5LMXHrY1V4SFypOPMvNOJamyrW
         xNLfLI95NLi5uD/1v80lddImGBzQ7d7or0gro5O5WE8LvB8HPA4pC5Bx5FBpA+dRKUtV
         NX21sE2HhOn+JwGOECe+5WlG70I+d4BsbiDgcjfbqerQsuZ6lfZ/pmBtlryCFjsRAit2
         4UYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4JHd2/E/sXwr35mN9r+j8fsbSVQUZAuC4e4Tq5gQ9s4=;
        b=kJmPk6ZESYGod3oZmr7EYcW6vGUIweQFtVAXSk6rDgmjSn7gYG+UvWTcszyutczXgk
         GlRN6pHULksfeaMrhmACndDwZcVSvST0nNxxImhn/TGIG2CaIf+CbiLasl+NZLqdJ8AO
         RBMwTYx1K5KTdPNQWphLVx53x5wm4GiFtg4qfPzR09NGcAzqxPVgiOmFq27YJ+1gO2Cv
         1LPESvWBu07YY9boRGDwRNsFJpnqJvS2RK2PflvYEj73RFjmb2rmmCBrDlys9Pf1lzqc
         RfzF2Fjcrj0MMg69cJwm3b6FlWhAtt9BZATYuqCgWsw4+IubtKPBBg6vPq2KeaOPh6YV
         XKuw==
X-Gm-Message-State: ABuFfojKCKq/so8kc1ZyF0N8j9xq9c382Q3Vyu1dWBfihnjepP0AT9gm
        0qkO8UrOprLnDMPquEL4B6Y=
X-Google-Smtp-Source: ACcGV63dnW/yXixx104SBUbdlps5wa3iPoFLn+2zYaot8UWWeRM6FYPRonpGeAV5tZg/UqCbrwb17w==
X-Received: by 2002:a62:5e04:: with SMTP id s4-v6mr466372pfb.146.1538462336861;
        Mon, 01 Oct 2018 23:38:56 -0700 (PDT)
Received: from localhost ([39.7.19.27])
        by smtp.gmail.com with ESMTPSA id k71-v6sm19489760pge.44.2018.10.01.23.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 23:38:55 -0700 (PDT)
Date:   Tue, 2 Oct 2018 15:38:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20181002063851.GF598@jagdpanzerIV>
References: <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
 <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
 <20180929105151.GA1392@tigerII.localdomain>
 <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
 <20181001023721.GA6409@jagdpanzerIV>
 <880ef52f-dff7-af91-5353-f63513265ffe@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <880ef52f-dff7-af91-5353-f63513265ffe@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/01/18 20:21), Tetsuo Handa wrote:
> >> Because there is no guarantee that memory information is dumped under the
> >> oom_lock mutex. The oom_lock is held when calling out_of_memory(), and it
> >> cannot be held when reporting GFP_ATOMIC memory allocation failures.
> > 
> > IOW, static pr_line buffer needs additional synchronization for OOM. Correct?
> 
> Yes (assuming that your OOM refer to both out_of_memory() and warn_alloc()).

Yes, both out_of_memory() and warn_alloc().

> By the way, only up to two threads (the active printer thread and a thread
> which is marked as console_waiter) can stall inside printk(), doesn't it?

Correct.

> Then, can you imagine a situation where 1024 (NR_CPUS) threads are stalling
> inside printk() waiting for flush?

No, not really. Both console_sem owner and waiter should spin outside of
logbuf_lock, so other CPUs can flush/log_store() in the meantime.

> Maybe "struct printk_buffer" after all becomes identical to "struct cont". But
> I guess that even 16 printk_buffer-s is practically sufficient for 1024 CPUs
> system, and allocating NR_CPUS printk_buffer-s will be too wasteful.

NR_CPUS buffers is quite a lot, indeed. Maybe we can do something like
NR_CPUS/4 + 1, etc. Kconfig option will be super hard to get right for
distributions. If people who wrote the code didn't agree on the correct
number of buffers and passed it to the distributions, then it's a good
sign than distributions will have problems picking up the good number as
well.

I'm not experienced enough, and need more opinions here.


I have sketched a very silly, quick-and-dirty implementation using
struct cont. It derives all the good features of the existing pr_cont.
I didn't spend enough time on this. It's just a sketch... which compiles
and that's it.

> I'm saying that I don't like discarding overflowed part because you are
> using seq_buf_vprintf() which just marks "overflowed" rather than
> "flush incomplete line" and "store the new data".
[..]
> Your DEFINE_PR_LINE() is limiting to far smaller than LOG_LINE_MAX.

Yes, you are right, and I was wrong about it (like I said in my email
elsewhere).

The existing cont support is "special", apparently. And it does automatic
flushing and split cont line in separate records when the cont buffer is
about of overflow. So the following loop can pr_cont() more than 1024 bytes
in total:

	for (......)
		pr_cont(.....);
	pr_cont("\n");

Thus new API should have exactly the same characteristics/guarantees. Agreed.

	-ss
