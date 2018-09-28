Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E10C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1170E2152A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzWhMpF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1170E2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeI1PTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:19:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44230 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbeI1PTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:19:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so3847991pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K3WawUMBkjO8V8vva+1GM5fHMpdGexVIsgsqIyqxBEI=;
        b=pzWhMpF6IvDRSUw2TZ3AH6zCVAMMzVAAu1K7qVYztXkvKtuDrVqVsd4uKukarCp+Q8
         ZGnRnbp8FAzwdaddBRqbenn4Gb5ceLV+33kGIdOvv8ctI7uAIS1jhqpigD5t8lGxk4gY
         mipoewIQLHuCGAfsNwWdl1wEV4vDSavUkaBNhtKO8RIuWmBhoaNrsFfpUYxmZwPsrSuZ
         mBfJTpAKlF6v3HkrhTrRgRh9RxFWiqOQQKDqDauZ8lUFvMIPesaNYXNwZHHouiZ28ghd
         v7xWqm1tOlzmzEawE7ncewlGeGbbMRlM2v6NbB72AGIOK/Qvx1BfJqp+5vgSWtyTDkI1
         IOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K3WawUMBkjO8V8vva+1GM5fHMpdGexVIsgsqIyqxBEI=;
        b=PQoNYbaMZOuraWtQ4IjklvbhIMSaLSUPDV/BD7aX/nCTLFon+/UFEJxGkD5y9tVrVG
         MN4gfJhJUpim2MbXt6DAXlMiUc4w3Mx7WFML0qs1RukSJvM5J8xwZj+7yK86TPOXVYbp
         ZNJ8vFbNtmxbhNNq2DL2xCmzVj/Up4Z6WE00ErPyZP2wJ4jy5nfnSTZBwgXjOJWBktM0
         YgQJiz2Y+Jf/y/EJqX+x/5i9wYIZF9u0MSxT2S53YHIohuR5k0Ko73YU56qs35HZSZX6
         5f+e9Dt885bG1eJarHTehmpkAhzKUuoXhDybUSxVNJ1aB5+ESHlpUk7tPLo0slEr+Nij
         lzFg==
X-Gm-Message-State: ABuFfojpPBEP29ESqrg2r5+1X9pL7Dn7CcllZtbWWQfnid7QR9g5+Ttc
        0uMHxMuVh3kmLqZKbLtRg58=
X-Google-Smtp-Source: ACcGV62p/KiQf81s5gD5usMP0/95OVbZBp7lU0QpjByqRFV0GYt5ywBXT9Bn/hDpVqVhstwVRGBbuQ==
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr15087324plf.320.1538125014094;
        Fri, 28 Sep 2018 01:56:54 -0700 (PDT)
Received: from localhost ([110.70.14.151])
        by smtp.gmail.com with ESMTPSA id q2-v6sm10910419pfc.17.2018.09.28.01.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 01:56:52 -0700 (PDT)
Date:   Fri, 28 Sep 2018 17:56:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20180928085648.GC1160@jagdpanzerIV>
References: <20180912120548.4280f04a@vmware.local.home>
 <20180913071204.GA604@jagdpanzerIV>
 <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
 <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/19/18 20:02), Tetsuo Handa wrote:
> I'm inclined to propose a simple one shown below, similar to just having
> several "struct cont" for concurrent printk() users.

Tetsuo, thanks for the patch.

> What Linus has commented is that implicit context is bad, and below one
> uses explicit context.
> After almost all users are converted to use below one, we might be able
> to get rid of KERN_CONT support.

The good thing about cont buffer is that we flush it on panic. E.g.
core/arch early boot stage can do:

	pr_cont("going to call early_init_foo()...");
	early_init_foo();
	pr_cont("OK\n");

should early_init_foo() panic the system we will have
"going to call early_init_foo()" on the serial console. This can
be addressed if you'd iterate printk_buffers[] in flush_on_panic().

> +#define MAX_PRINTK_BUFFERS 16
> +static struct printk_buffer printk_buffers[MAX_PRINTK_BUFFERS];

Well, hmm, maybe. Now can we have a problem of either too-small or too-large
MAX_PRINTK_BUFFERS. 16 buffers on a 4 CPU arm board most probably will just
waste some memory. At the same time we probably don't want to have NR_CPUS
buffers. The fallback to "regular printk" is still a bit troubling - technically
there may be cases when we don't fix anything.

So, overall, I'm not against your patch. There are some pros and cons,
however.

pr_line() patch seems to be simpler [probably] and smaller [definitely].
The only problem, as you have mentioned, is that people may miscalculate
the size of the buffer, which won't crash us or anything; people can overshot
even a LOG_LINE_MAX buffer. So probably I'm not completely sold on having
a fixed size printk_buffers[].

May be all we want at the end is to drop explicit buffer API and have just
two options in pr_line:

 DEFINE_PR_LINE()	-- 80-bytes (or 256) pr_line // implicit buffer
 DEFINE_PR_LINE_HUGE()	-- 1024-bytes pr_line        // implicit buffer

So, no explicit buffers, just "a normal" pr_line or "a huge" pr_line.
And no "normal printk" fallback; buffered printk line stays buffered.

The 80-bytes limit can be lifted to, say, 256-bytes.

Tetsuo, do you still want to have a fixed size array of printk buffers?

What do others think?


BTW, Tetsuo, I have addressed your pr_line suggestions/corrections.
Couldn't send the patch or reply to emails because I was offline for
a week due to personal reasons; but I can send it now - it does not
have DEFINE_PR_LINE_HUGE() macro. Just a previous version with
corrections which you have pointed out.

	-ss
