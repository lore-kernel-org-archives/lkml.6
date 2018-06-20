Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615CBC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0508020846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZnDCD8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0508020846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbeFTLca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:32:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:32869 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbeFTLc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:32:28 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so1631486plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 04:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y0+djVGhA6riyyXJNog/IxCc1PvKjVtmM8gQdG4Pues=;
        b=WZnDCD8OglBfOwvcf+JPH6FH4XKqcu+CN8E3QPu2ajwXcp1sAGAC8Y9UeRgcMdxzNA
         2VbcThohY3hsNuSjJmXWF7zzQ0GcjvPBMPP730Z5KMPj0BiI6bv0+iXKDmpv63w2U3vp
         9xjAzsbWIjL3NXa2QhVHGK455K9zHhXBDRRljt8nKqqgJPrOhN48yr/87HL7BvIuyB6F
         BqWVxb7VbGybRjU1DP4lH7zM92yTrbQI7VppjCqzhTorxNWjFZIxB/R6TNJ0/KFVWwXV
         M3B0woRbWo3MnL0Oe37/KRrH6vPdFhBHBFhcV2v5W0DBoxeiujDK5alKwFDUCSgiG7xi
         n6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y0+djVGhA6riyyXJNog/IxCc1PvKjVtmM8gQdG4Pues=;
        b=W/5nJnxzkItiylwdtZWRSwTWSb9ty+G7+ioHs87Ao7r7UI05dSPZBI8gXj3UClMlTt
         MU0vz5DIQd7aMQc3MBEhqbgRZiByVfmwH/IfqhYOihGPkt1GWP1fAAYfEbr52TwRKqOD
         LNlpFTHgpRKa7qZpDgQBqj7EDucA3Ff7MMXwzSli5V6WfHbihiXHToawL2gRI2c7YC0S
         XSvpppsGvOl2HOooO3PRT43VO/oLGzE9+gVTcR8ksAGqTpifBEgMzGTO/MDPvdMNAv24
         orF80Mh+8NeMapOIIMrjXwBmAys1ubN0fhvH7ZnRvKU8YEHb2wtuPnEBJpSpRirLgn3G
         S5Vg==
X-Gm-Message-State: APt69E2TsGBNKBwnzTq5miXk2TGF44EPzqAsi5x8x/Iq3P5z1sI15Ihi
        JGc6wXy2Z/DbgRdFm9m3J3vUiLoWab8Ifv5nH56qpA==
X-Google-Smtp-Source: ADUXVKL8jgr1mvA4mzijyFP/06PhX01gJaSbMxDtIkpooIZEhCw6F17l90O50izAjwfYqx8/D/1KR1V3rOICy5r0uNQ=
X-Received: by 2002:a17:902:8d85:: with SMTP id v5-v6mr23315407plo.93.1529494348120;
 Wed, 20 Jun 2018 04:32:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 20 Jun 2018 04:32:07
 -0700 (PDT)
In-Reply-To: <20180620110759.GD444@jagdpanzerIV>
References: <20180517112135.GB20796@jagdpanzerIV> <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <20180524021451.GA23443@jagdpanzerIV> <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV> <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV> <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com> <20180620110759.GD444@jagdpanzerIV>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Jun 2018 13:32:07 +0200
Message-ID: <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
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

On Wed, Jun 20, 2018 at 1:07 PM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (06/20/18 11:31), Dmitry Vyukov wrote:
>> > BTW, pr_cont() handling is not so simple when we are in printk_safe()
>> > context. Unlike vprintk_emit() [normal printk], we don't use any
>> > dedicated pr_cont() buffer in printk_safe. So, at a glance, I suspect
>> > that injecting context info at every printk_safe_log_store() call for
>> > `for (...) pr_cont()' loop is going to produce something like this:
>> >         I<10> 23 I<10> 43 I<10> 47 ....
>> >
>> >         // Hmm, maybe the line will endup having two prefixes. Once
>> >         // from printk_safe_log_store, the other from normal printk
>> >         // log_store().
>> >
>> > While the same `for (...) pr_cont()' called from normal printk() context
>> > will produce
>> >         I<10> 32 43 47 ....
>> >
>> > It could be that I'm wrong.
>> > Tetsuo, have you tested pr_cont() from printk_safe() context?
>>
>>
>> So this is another reason to get rid of pr_cont entirely, right?
>
> Getting rid of pr_cont() from important output would be totally cool.
> Quoting Linus:
>
>     Only acceptable use of continuations is basically boot-time testing,
>     when you do things like
>
>      printk("Testing feature XYZ..");
>      this_may_blow_up_because_of_hw_bugs();
>      printk(KERN_CONT " ... ok\n");
>
>
> I can recall at least 4 attempts when people tried to introduce new pr_cont()
> or some concept with similar functionality to pr_cont(), but SMP safe. We
> brought the first one - per-CPU pr_cont() buffers - to KS several years ago
> but Linus didn't like it. Then there was a buffered printk() mode patch from
> Tetsuo, then a solution from Steven, then I had my second try with a
> soft-of-pr_cont() replacement.
>
> So, if we could get rid of pr_cont() from the most important parts
> (instruction dumps, etc) then I would just vote to leave pr_cont()
> alone and avoid any handling of it in printk context tracking. Simply
> because we wouldn't care about pr_cont(). This also could simplify
> Tetsuo's patch significantly.

Sounds good to me.
