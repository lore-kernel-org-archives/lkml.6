Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCF3C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD8C2064D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6oTkOhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD8C2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeI2Rl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:41:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43842 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeI2RlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:41:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so5993966pfi.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XctN4Oil2ZIMUkzlwW5cB7VzAMDdqsxuCozgYH8Up9U=;
        b=m6oTkOhFIIdEq2hTjO+nRt9vhWcU3GXJZmxBtx1s0WJXgINLFKAiWB3AzqIdI8qUPr
         /NPSK45r26R+tfHv6rYKLzXX5q6Y9E4kNB5jPhU1VIUCNXELyb20cIacAeEga8rlqFoo
         1ReUB2DWGpIXtAb/JfmQmTc4V5c+Tm6jwkDaM6sDQnmRguvqbENZe54P+VXEA0nZ+7RS
         UOVmR+OXms1zaWD90F2RzxvURyPRpWFFt/8yeHsZv+H7LcowocqxVXX3u6WPITSmWWGd
         Mu9QVe3nGHPw173f/TNXZgHSKCJV5jzGcChDP9zI1gR4PtuLrEIOwi4T8RwI5s76zkMv
         bmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XctN4Oil2ZIMUkzlwW5cB7VzAMDdqsxuCozgYH8Up9U=;
        b=jn+ObkrHiu+CAGoBLD+1WjqK8Ze2ydufwxLU7orCvcV+cf+P840PoRVQiWYC6kaxI0
         wnERpRy6KT6fBV6lEC5vtsfQLwIu26lNWgq/TG5CntdplFdD4BBnU9bjpVrR4+IZf9OA
         g2uyYITljNhSyvnD5dW1a1PcYLy6589oXZU+EtvGCv6vdy1TAi5J3ZzILHF9hYWqX1+5
         7wp6wpIKXvKGqysSqf4sJYN/2Mh8ZLSD7VbeJLc4WOjEUZGH6P4ir5AkGDj9TTC3jxuA
         ehfbhrp79E7c0stguJcZ2zsV6d/wzDYu7Ipo75wD8oVZc8mL3wjQwMTNElUGKsUy3uJt
         YDFw==
X-Gm-Message-State: ABuFfog6wvcy//mgS2irQ0mDAxTUdQ7CIUbKDhP9GZ+8ABUBj9Zbbhbh
        7EUI4Blwf4CAKOWamV0ouaE=
X-Google-Smtp-Source: ACcGV60MhQTTMv+zTsZCQLZJO3jJlw+9cGTWcM5WNVmT2T2LqREj9TaR4M19TgnJCeFGbKZDL1af/A==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9-v6mr2805051plo.183.1538219602447;
        Sat, 29 Sep 2018 04:13:22 -0700 (PDT)
Received: from localhost ([110.70.26.9])
        by smtp.gmail.com with ESMTPSA id q85-v6sm11040318pfa.151.2018.09.29.04.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 04:13:21 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 29 Sep 2018 20:13:17 +0900
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
Message-ID: <20180929111317.GB1392@tigerII.localdomain>
References: <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
 <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <20180928085648.GC1160@jagdpanzerIV>
 <802130a3-b8c1-3973-933b-d6dc5ff2930d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <802130a3-b8c1-3973-933b-d6dc5ff2930d@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/28/18 20:21), Tetsuo Handa wrote:
> On 2018/09/28 17:56, Sergey Senozhatsky wrote:
> > The good thing about cont buffer is that we flush it on panic. E.g.
> > core/arch early boot stage can do:
> > 
> > 	pr_cont("going to call early_init_foo()...");
> > 	early_init_foo();
> > 	pr_cont("OK\n");
> > 
> 
> Is printing
> 
>   going to call early_init_foo()...OK
> 
> in one line so critically important?

Could be. If this is the last thing you are about to see on your
serial console. panic_on_flush() is not guaranteed to succeed.

... Hmm. But it seems that this has changed.

We used to flush "incomplete" cont lines (fragments) from console_unlock().

void console_unlock(void)
{
...
        /* flush buffered message fragment immediately to console */
        console_cont_flush(text, sizeof(text));
again:
        for (;;) {
	...
	}
...
}

Unless I'm missing something, we don't anymore.
Since 5c2992ee7fd8a29d04125dc0aa3522784c5fa5eb.
Now we print only log_buf entries. So we either wait for a \n to flush
a complete cont buffer, or for a race to preliminary flush cont buffer.


> > Tetsuo, do you still want to have a fixed size array of printk buffers?
> 
> For my intended users where printk() is used for reporting errors (e.g.
> stack backtrace, GFP_ATOMIC memory allocation failure, lockdep splat),
> being prepared for already tight stack is preferable.

Agreed. A list of printk buffers has some interesting features and may
be we will use it after all.
At the same time the functions you have mentioned can use static char
buffers for pr_line.

> > What do others think?
> 
> Yes, I want to hear from others.

Yep.

	-ss
