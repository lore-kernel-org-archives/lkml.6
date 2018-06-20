Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCAEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5EB20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jBz4RPtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5EB20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754746AbeFTJab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:30:31 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:47074 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754480AbeFTJa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:30:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so1303864pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3qZoHFLP8S1sldjt68jjxNzb8sSPzxPYRpuj7nEj5tE=;
        b=jBz4RPtCMBnmE20/EPpW9MwpjGeYiD8BJ2xL+BirmfVBZOgIUoR7RKxr1Uqsh57lUn
         Rlb1JZhBgik9t/mpU8hFnVMwrk5O7guB0II6K/K7Z4U5hLSuobWXaL0jSlQMiVLHrclI
         82mMjmotQp9LEJ0oHDzuDL40bB/KyhW0wfixbNdJSBJgab116bCMoEXQ9zsrIDcRSNMv
         COSxj3MqnSP/lW6PeCZ2vC75suFuroFHEkADIcQQCtJjWzYohk4yYZ1exjKYp7pAKMHS
         X886x8KMDWjofSTNHQEV0/nFL5GO6WRuYsWteYfYNdslsrJlLxAHbVY8tQpOJ4y7EX3y
         EHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3qZoHFLP8S1sldjt68jjxNzb8sSPzxPYRpuj7nEj5tE=;
        b=edJ5WqmeowvSLFlekvYnQg6BOVGQ4WfEJZ8xvtmudbGiyuF1woHWGwfCp17/jSK6uK
         0OdopgDyf3C85t4lKUFhe0X7pkI9kwgzo9tunGvQSVRc+sl/pgugffdMPGWeps4li+uM
         AIN7eRKYPwoKCxkCI5yHtFrYBddK2tJY1x6+KUcE3YRqPydei/udS3DJae9dt3flqTvc
         Og0xiAey1LpvPP/a/svUoJ9Lu4iVrU7QJ+mcWxLVsji76cNU3bzFm9CPeucJOCGTVx+Y
         zZ8zU9VDqnGlEnqXEVdVoPtKIFGfTJVveTvgoAnHN6rJXsSFIqrMmlb0fVXeO8ZotFqU
         n/Cg==
X-Gm-Message-State: APt69E1bvIM1AsOdnYa7VOZxSwMH0Q4YgMP8ulH84eCo66oz4yeio/HH
        +GDoYBgNcPkqfIAlAzB2XlN68vxXITUr5sNkfi4juA==
X-Google-Smtp-Source: ADUXVKI/tW9e5EGqsj6G1nnTV9MZYAZI5kD8GXPHdXI5d5frCkbThtU8U8e9fmueAFgi4qWIrYLypJrpvqKaacMKw7w=
X-Received: by 2002:a62:a38d:: with SMTP id q13-v6mr21994287pfl.49.1529487026332;
 Wed, 20 Jun 2018 02:30:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 20 Jun 2018 02:30:05
 -0700 (PDT)
In-Reply-To: <20180620090413.GA444@jagdpanzerIV>
References: <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV> <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV> <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <20180524021451.GA23443@jagdpanzerIV> <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV> <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Jun 2018 11:30:05 +0200
Message-ID: <CACT4Y+a6nUqdpSyYGGcXKAgVbcw+uQOz2kYx8tUS+8T5-bzqkg@mail.gmail.com>
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

On Wed, Jun 20, 2018 at 11:06 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> Hi Dmitry,
>
> On (06/20/18 10:45), Dmitry Vyukov wrote:
>> Hi Sergey,
>>
>> What are the visible differences between this patch and Tetsuo's
>> patch?
>
> I guess none, and looking at your requirements below I tend to agree
> that Tetsuo's approach is probably what you need at the end of the day.
>
>> The only thing that will matter for syzkaller parsing in the
>> end is the resulting text format as it appears on console. But you say
>> "I'm not pushing for this particular message format", so what exactly
>> do you want me to provide feedback on?
>> I guess we need to handle pr_cont properly whatever approach we take.
>
> Mostly, was wondering about if:
> a) you need pr_cont() handling
> b) you need printk_safe() handling
>
> The reasons I left those things behind:
>
> a) pr_cont() is officially hated. It was never supposed to be used
>    on SMP systems. So I wasn't sure if we need all that effort and
>    add tricky code to handle pr_cont(). Given that syzkaller is
>    probably the only user of that functionality.

Well, if I put my syzkaller hat on, then I don't care what exactly
happens in the kernel, the only thing I care is well-formed output on
console that can be parsed unambiguously in all cases.
From this point of view I guess pr_cont is actually syzkaller's worst
enemy. If pr_const is officially hated, and it causes corrupted crash
reports, then we can resolve it by just getting rid of more pr_cont's.
So potentially we do not need any support for pr_cont in this patch.
However, we also need to be practical and if there are tons of
pr_cont's then we need some intermediate support of them, just because
we won't be able to get rid of all of them overnight.

But even if we attach context to pr_cont, it still causes problems for
crash parsing, because today we see:

BUG: unable to handle
... 10 lines ...
kernel
... 10 lines ...
paging request
... 10 lines ...
at ADDR

Which is not too friendly for parsing regardless of contexts.
So I am leaning towards to getting rid of pr_cont's as the solution to
the problem.

Looking at current uses of pr_cont:
https://elixir.bootlin.com/linux/latest/ident/pr_cont
It does not look too bad. arch/ except for x86 and exotic drivers
won't cause problems for syzbot today, so we can live with these uses
for now.



> b) printk_safe output is quite uncommon. And we flush per-CPU buffer
>    from the same CPU which has caused printk_safe output [except for
>    panic() flush] therefore logging the info available to log_store()
>    seemed enough. IOW, once again, was a bit unsure if we want to add
>    some complex code to already complex code, with just one potential
>    user.


I can't fully answer this because I don't understand what are the
implications on actual output.
You can use this as litmus test: can you write a simple script that
will parse such output and make sense out of it?

Well, it's not for one user. It affects each and every single user of
Linux kernel out there. Just take a look at these, that's complete
nonsense, it's not that syzkaller can't make sense out of it, it's
nobody can make sense out of it:

https://gist.githubusercontent.com/dvyukov/1528e86e5139f2fd1bf9902398d48298/raw/3b42148554eefed210f1e626d5befd50405c5487/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/6e08ac521f3e19534970ed97aeee1603/raw/0f0bb361902de94e7ee331ac500a3ceebf812c22/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/6e9db2313e48773ad1cd861da8020008/raw/d5b7c023fc8a38c72b1cf8bb1da85fb1c31cea5f/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/3d1bda4c690414ac027de1da45759751/raw/2c68980eabf4f6be24060e807a75f2d3570b5a42/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/9b8831e9ac73ffafa111a33ad40c5667/raw/f4097fbea8f89b25a282a6ef7e648145e10ae4b7/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/d78a3187a1b4e004820e92efcb16f9e0/raw/5530bcbf009c3fba3c581b2d24c523c673c6ef12/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/da1e42436af9ad2afc7de49f2d503510/raw/7dd4cbcc651c5b87122f066a3c689999ae8c4121/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/4571b94bd8cbd78d759412c560fa395c/raw/964c73fc993fc8a9000571e0b7618000584f3638/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/b6deac5faa958ae3733413b34dd5feed/raw/c4da219e284f7fc55da8c3c3af623a87f31bf653/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/2f54c6a2e45347ea76d9c5ce3c0ff091/raw/45f4873898ec8e0d9aa16b9c5c63a85410fd05e0/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/96cb39e29124dbbe2a65a91ec7a5639e/raw/aa8f7b2b1dfa5b8bb8cf93d8a821ca9938e8fc54/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/424da8282d5b28f8be10eab595d37444/raw/acc2fb1ececc1ea9a8215213f7e37e08b524c096/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/b07f37720c632d6d56ae67d95e5599b3/raw/8624ba47d6eb4e7d4d58e3ae1242ebe6cc46d361/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/bc24a7b92289ec04587fb29fc1085045/raw/3136e9262ee2233b5ab369a4a82e83953fc2d8a2/gistfile1.txt
