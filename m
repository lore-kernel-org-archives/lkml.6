Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99383C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4538A2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBje5dZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4538A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeI2RT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:19:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43932 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbeI2RTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:19:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so5971714pfi.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 03:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zln91acq4o46Cfehz+bcCHEN4qAvsTb14HXagEnlgH0=;
        b=mBje5dZPJshH+6j1hGqAWvFnqsnQESc8vCCiJMxbxbi0VdLIZVhiauUhM8laGw89Cm
         jhwpP9lS0+OqtBnTll71RRTtsXwaRNBaElVn5HST9Hpv5L5WtS02iI6pB9XbwVBTFoos
         CaWb7pv4Ral5HTL7yW0CjzPIe39fFS7HZaOmvMCuVexfXKVFa3eq8Xr2zeXlOoPddkoc
         xpyaPIWiOOQO8Z/WWlDVrimIHbkriO1IVgOaTK8qrsHqGPpfzpFjU9LfcnAN/5YcLoAL
         /GNSoWI8mSdRLNIm1n6PB9/HOf2dUYX4yaURFWIt94+uxpJE154K6na+hVJhNxLd/jrP
         Qz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zln91acq4o46Cfehz+bcCHEN4qAvsTb14HXagEnlgH0=;
        b=ALXKhSQwGc0DfqQ+78a/p4t7TMVTbzWmdI0dhL9ShsPnWaLlonhFyIs4Xbi6WqKHAr
         4mpYM4zoyxxhAcik20ayL/VlRrSGBU8fzn3R1ubDkylHYGlmbAYiVSpfzb6nrNOSIGVU
         08yGtx6Lp5HXH/szVG5hpeS4xWFwJne8Rg11GnlmogZbox2nFNqJ0hMlGgBku0JH/Jhf
         3T3r93DIt3XWNzt6TGBNYLb/YzYult3i5YSgLN3k+kYgloAlrSvbFfC1/5yT2OY8DaoY
         w+xbgW8YKqpizpsx2oGJDS80JlboEDpx6J1p/fvFHGuqFyHJVCdE7Gg+NFcmTwFZQV70
         a+AQ==
X-Gm-Message-State: ABuFfog8gPrisBdOtLePrnfOoGV/nrjHfeZMZ/KkMtN6TXYRqU1OHfk4
        fvHkp59clUIHKnQEkjifojikWeSplTw=
X-Google-Smtp-Source: ACcGV62j4G5Ul/r65RvEAb3B+Py/wU43EiHvIrQW+lylR7sT0JePDzgOh5NooHnflK+H3xIxgUwlpg==
X-Received: by 2002:a65:5004:: with SMTP id f4-v6mr2466870pgo.54.1538218316721;
        Sat, 29 Sep 2018 03:51:56 -0700 (PDT)
Received: from localhost ([110.70.26.9])
        by smtp.gmail.com with ESMTPSA id w12-v6sm11084787pfd.110.2018.09.29.03.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 03:51:55 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 29 Sep 2018 19:51:51 +0900
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
Message-ID: <20180929105151.GA1392@tigerII.localdomain>
References: <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
 <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/28/18 20:01), Tetsuo Handa wrote:
> > Yes, this makes sense. At the same time we can keep pr_line buffer
> > in .bss
> > 
> > 	static char buffer[1024];
> > 	static DEFINE_PR_LINE_BUF(..., buffer);
> > 
> > just like you have already mentioned. But that's going to require a
> > case-by-case handling; so a big list of printk buffers is a simpler
> > option. Fallback, tho, can be painful. On a system with 1024 CPUs can
> > one have more than 16 concurrent cont printks? If the answer is yes,
> > then we are looking at the same broken cont output as before.
> 
> I'm OK with making "16" configurable (at kernel configuration and/or
> at kernel boot like log_buf_len= kernel command line parameter).

Do we really want this? Why .bss placement doesn't work for you?

	void oom(...)
	{
		static DEFINE_PR_LINE(KERN_ERR, pr);

		pr_line(&pr, ....);
		pr_line(&pr, "\n");
	}

the underlying buffer will be static; the pr_line will get re-init
(offset = 0) every time we call the function, which is OK. And we can
pass &pr to any function oom() invokes. What am I missing?

> We could even allow each "struct task_struct" to have corresponding
> "struct printk_buffer".

Tetsuo, realistically, we can't. Sorry. No one will let us to have a printk
buffer on per-task_struct basis. Even if someone will let us to do this,
a miracle, a single per-task_struct buffer won't work. Because, then
someone will discover that a very simple API

	buffered_printk(current->printk_buffer, "......");

does not work if buffered_printk() gets interrupted by IRQ, etc. in case
if that new context also does

	buffered_printk(current->printk_buffer, "......");

So then we will have per-context per-task_struct printk buffer: for task,
for exceptions, for softirq, for hardirq, for NMI, etc. This is not worth
it.

Let's just have a very simple seq_buf based pr_line API. No config options,
no command line arguments - heap, bss or stack for buffer placement. Or even
simpler.

	-ss
