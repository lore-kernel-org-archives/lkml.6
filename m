Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597E2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A69218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjuQmUMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfB0C42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 21:56:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34707 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfB0C41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 21:56:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id u9so7254438pfn.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 18:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/zU7cP6nwLYr1hHjUk4Ns8SEqRpaGRDTbUyV4GYcFU=;
        b=HjuQmUMyYnv1hsn+Q/3NHBp/3L0ncVSJSSbE8O1fz4s/Zs2QXq4sFe6fCdRsi3ihcW
         2YCyLYjtZgHkzUu1VjFvWHy9xB20ZqwbnyzgMtNw3ivYeZbIOGqGYNcpCyWDu/P1lHDm
         MsbJx7fK1i6tYX9gMdJ+UyPERItTjolPa6aKHSTEM3vqyPRfHUK0tj+0tqP6wLDD5Bs4
         VMqY2DxBQxaNvDPjaRTg9iu+WcbKiiytT7q35WxXLjXWPA9lXeUrtp64cx87xbW8Ro7I
         PbQPiVE5wWDVulQAzY55jq/ikrpSTnoD0eSJUxZrKk8vsIetx3j4BC6et9m26ljflwn4
         Qq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/zU7cP6nwLYr1hHjUk4Ns8SEqRpaGRDTbUyV4GYcFU=;
        b=evD4PIYQweyhV3hWzhQOw1LW3qseMyztai8Ei+ebGbjnzurjpBFRAvU2Xg2cAkyB7j
         uOBst69au+1N5jwTgXxfrlgrGjVWwjqFlAk2D/Y3CXqC2A/EPHHrfx4It5i0KqDiTfsx
         dC48SYThYTteoI4FZIdwZpRzz4hh/527l2GM+M7oVSKIJi3RnTq+AAsOO8zvrFQpvJvf
         XJzPhLoAunLdJ+axa8mDBNbIFH5bRZSBi2siwJl6IxDJYLLRkf9XpmYg+do3ZbjJT3Bu
         8wdqGzyhT52oaHjrCCmuTEZuNOt3TCM0p74ym6Go9zLdt6q58kaq6R65PZbYuhjEE0xN
         fgRA==
X-Gm-Message-State: AHQUAuYXDUUA+cq9qc7EvVi5hDLGomUfnUeoCjaHIBaQDMZ5JScniMkz
        VD84OVwqsJq/5IJcwb3o0X4=
X-Google-Smtp-Source: AHgI3IapQlvrL7/gGS8FtL3PKc5oZxKTwGvnWjrQMYMxmHPVKTIX09msjndE0fn1YJZfbMN3M74ikQ==
X-Received: by 2002:a63:e410:: with SMTP id a16mr785713pgi.28.1551236187188;
        Tue, 26 Feb 2019 18:56:27 -0800 (PST)
Received: from localhost ([175.223.3.190])
        by smtp.gmail.com with ESMTPSA id h10sm830353pfo.128.2019.02.26.18.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 18:56:26 -0800 (PST)
Date:   Wed, 27 Feb 2019 11:55:59 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk/console: Do not suppress information about
 dropped messages
Message-ID: <20190227025559.GA18340@jagdpanzerIV>
References: <20190226124945.7078-1-pmladek@suse.com>
 <87k1hmzfam.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1hmzfam.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/26/19 17:26), John Ogness wrote:
[..]
> >  		if (console_seq < log_first_seq) {
> > -			len = sprintf(text,
> > -				      "** %llu printk messages dropped **\n",
> > -				      log_first_seq - console_seq);
> > +			console_dropped_cnt += log_first_seq - console_seq;
> >  
> >  			/* messages are gone, move to first one */
> >  			console_seq = log_first_seq;
> >  			console_idx = log_first_idx;
> > -		} else {
> > -			len = 0;
> >  		}
> >  skip:
> >  		if (console_seq == log_next_seq)
> > @@ -2435,6 +2441,13 @@ void console_unlock(void)
> >  			exclusive_console = NULL;
> >  		}
> >  
> > +		if (unlikely(console_dropped_cnt)) {
> > +			len = sprintf(text,
> > +				      "** %llu printk messages dropped **\n",
> > +				      console_dropped_cnt);
> > +			console_dropped_cnt = 0;
> > +		}
> > +
> 
> My only objection to this is that the "messages dropped" only comes if a
> non-supressed message comes. So information about dropped information
> may never get printed unless some task prints something non-supressed.
> 
> Imagine a situation where I am expecting a message to come, but don't
> see it because it was dropped. But if no more non-supressed messages
> come, I see neither the expected message nor the dropped message.

I think this is exactly the problem (and thus the patch) we discussed some
3 years ago. I had a number of rather strangely looking serial logs, which
clearly had lost messages but no "%llu printk messages dropped" markers. So
I added `static bool lost_messages' to console_unlock(), set it when printing
loop would discover lost messages, then print "%llu printk messages dropped"
attached to whatever msg was next in the logbuf, regardless of msg->level.
IOW, if lost_messages was set then suppress_message_printing(msg->level)
was not even invoked. Yes, that would sometimes print several "debugging
noise" messages, but the main part was that I would have "%llu printk
messages dropped" markers in the logs; which was much more important to
me.

P.S. I'm very sorry, I'm overloaded with work at the moment; will start
     looking at pending patches in a day or two, or three, or four...

	-ss
