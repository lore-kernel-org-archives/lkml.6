Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25D4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A4C20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWjGY87l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A4C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754956AbeFTJbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:31:32 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34324 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754670AbeFTJb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:31:29 -0400
Received: by mail-pl0-f66.google.com with SMTP id g20-v6so1460500plq.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dOl1IYJqyWdcKPUCjZvLKKL+ep57g+1fDjhJs+MD1Es=;
        b=ZWjGY87lG3NcaeKYLmzJJ4VJxSVsK6WnR4E4Rbg4nfoC5H7gh0AUktSIwCEWQB+KlB
         r2rRgh3V8ubf8VEBUNivUN6nVM0pbOuDSVqu1gvSA7oNtoEJR0Ty4sM8rgA6VElr6rKI
         qgBe+zmdEsTzQEIfNaIiSASNxpjHUY/CX7MPB1/6GHj34xqGHNos0q/NEHErUcSy4fVo
         8z2wW5JtizSIOM17W4dccVa/jeIazaL0c0HjHloU0rCcPdL2LzkJhDWuzx/j3qA+8aQG
         tDaq1UzaVoX98WckoJp14zVsHVUeQyybZJh2EXWxsAbSvMdzp351jYNw/VAsfUsqmUY4
         Otpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dOl1IYJqyWdcKPUCjZvLKKL+ep57g+1fDjhJs+MD1Es=;
        b=UCMvcpBdhWPe4XHuB/8gzueWqdRV8NgLUgSxGdg7WRkCuP4PLayg0e1pq5u2v4otrN
         489oUcdwYxJ4O0vGnrYhNnotduGW+BPQ3Cp3YCVNBCjoAR9KUiTsn1aqyPGxE+IlH/25
         w4XijK5PFbMh+Dde8Xbz5eJkA2LBlloNm92NXEKDwqymcnVaoF1cdyBl+zQUcsN9GrH3
         fZfX2IjpTX5XNtG17VDx7yzXUIVJe373GzZntg9/bsrDBus+Lz9ZwmTAOWZMFfvMzc/5
         xo3rHZJPiC4sSrXldmjPq2W/nkbuqqxXEAFmSpgS2TmFrrewdcSH5zyb+igCWQZPgCQ9
         BPxg==
X-Gm-Message-State: APt69E2XScqrWjEPVm+T4Aw6xgxt4kilmCuhq6787HGZOz3DAz+aleE3
        anatVn/iJMmmcL8DOvXke7Pe5fbq14eqSToimyz5gA==
X-Google-Smtp-Source: ADUXVKJ7bQgOtRvAal8d1qq/icR8i5xvYz9LD0Sg5TqI8cDrIV2VbaDkd3PqE722BIBC97egwWXWYzVSP73VBiRPixM=
X-Received: by 2002:a17:902:8d85:: with SMTP id v5-v6mr22819026plo.93.1529487089112;
 Wed, 20 Jun 2018 02:31:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 20 Jun 2018 02:31:08
 -0700 (PDT)
In-Reply-To: <20180620091541.GB444@jagdpanzerIV>
References: <20180511095004.GA6575@jagdpanzerIV> <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV> <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <20180524021451.GA23443@jagdpanzerIV> <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV> <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV> <20180620091541.GB444@jagdpanzerIV>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Jun 2018 11:31:08 +0200
Message-ID: <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
Subject: Re: [PATCH] printk: inject caller information into the body of message
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:18 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (06/20/18 18:06), Sergey Senozhatsky wrote:
>>
>> b) printk_safe output is quite uncommon. And we flush per-CPU buffer
>>    from the same CPU which has caused printk_safe output [except for
>>    panic() flush] therefore logging the info available to log_store()
>>    seemed enough. IOW, once again, was a bit unsure if we want to add
>>    some complex code to already complex code, with just one potential
>>    user.
>
> BTW, pr_cont() handling is not so simple when we are in printk_safe()
> context. Unlike vprintk_emit() [normal printk], we don't use any
> dedicated pr_cont() buffer in printk_safe. So, at a glance, I suspect
> that injecting context info at every printk_safe_log_store() call for
> `for (...) pr_cont()' loop is going to produce something like this:
>         I<10> 23 I<10> 43 I<10> 47 ....
>
>         // Hmm, maybe the line will endup having two prefixes. Once
>         // from printk_safe_log_store, the other from normal printk
>         // log_store().
>
> While the same `for (...) pr_cont()' called from normal printk() context
> will produce
>         I<10> 32 43 47 ....
>
> It could be that I'm wrong.
> Tetsuo, have you tested pr_cont() from printk_safe() context?


So this is another reason to get rid of pr_cont entirely, right?
