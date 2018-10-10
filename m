Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7DCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C012064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJWTt4bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C012064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJJUk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:40:28 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37907 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJJUk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:40:27 -0400
Received: by mail-it1-f195.google.com with SMTP id i76-v6so7868199ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 06:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yqPkDfc4/FsaElQ/ahG9Lz9ytpXoIU+2BPWNbeJxY7Y=;
        b=OJWTt4bjlDpCrnATIxNGvKZXJRe0RWGuvrLHKc4XVHOs6hEtsHcbIT7qVO7AssO+OH
         wCcXscsibL13NXr1j9/TELN2r9ja857Lz3Z4BZTLWnUk5yKxv/ZIFa4B3Yp+QNC+po3O
         ut4Gz1GmDYnc+0lw3xECb8aVKZdTiVshqNMX8UB6VrFfjN7ZM2jl1jCAlEOaXUFe4ZOw
         vVAEcAMop8VLAnZtYE5fbp99fsvctpI5zhXHLpolP+0XG5fCaL9HvWZNTiK0GCoMaHWg
         WchvImZ5/WpM0e1hASdJiXiKzQ7XLaOkB95U+0bMNTWRTTmGMfuu8HacazzieGzsDAzm
         kovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yqPkDfc4/FsaElQ/ahG9Lz9ytpXoIU+2BPWNbeJxY7Y=;
        b=iePpHlRnQjF9Y71yPSCaUUiknh21S4if3Ef7v8qU57MSd6lO68swh1Y+Ijbu+yKEYO
         aUQfkqNFLzFiB+g0YbzPVCHSJFTMle0B/dfEmMjfIZMc+vxELvwPlYPL+FsxWD66LB5D
         dSbvMl/+QJ6JR4lgqwpOyu/1d3Op88FOeyOscIUhv4T+M8Ushjo0eXEfrFpufPARulUe
         dBSQGqsnRtZknccYm2VVAreGpsh+6CO/b9KAK55Mh/qvXaZwhd3LV0m/qpc8MTbjUfPd
         gNesogv+RVzeObLehYJZRO7+WmohGsi/na29w5vQluTG5uxbypA0i77PUJEByQ8xTQP8
         VbDA==
X-Gm-Message-State: ABuFfogqUAOfxFsH+PCmv5DDESYT3sqaqrmLcvf+s9MT27z2CwlK2pbv
        KI95Is9AojwEq1rQHCodfaW7D4mdIV+SJ2XNwpxfgA==
X-Google-Smtp-Source: ACcGV60pak1h6ynu3WOHQHweAK8k9R1Bx3Q/ztpOo/F5TqL0ZWcc6+O5KC/yBIKSw4lCI16PYb1TjYOHpobnXIXK6VA=
X-Received: by 2002:a24:24c9:: with SMTP id f192-v6mr640576ita.144.1539177497854;
 Wed, 10 Oct 2018 06:18:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 06:17:57
 -0700 (PDT)
In-Reply-To: <b7727ff0-b34f-25a2-b9e7-56e70d9349c4@i-love.sakura.ne.jp>
References: <000000000000dc48d40577d4a587@google.com> <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <20181010085945.GC5873@dhcp22.suse.cz> <e72f799e-0634-f958-1af0-291f8577f4e8@i-love.sakura.ne.jp>
 <20181010113500.GH5873@dhcp22.suse.cz> <20181010114833.GB3949@tigerII.localdomain>
 <20181010122539.GI5873@dhcp22.suse.cz> <CACT4Y+ZfVdeB-WNeLCWJvTHNeCUtR3r1R+3Qjv9XjZXPxaV2WA@mail.gmail.com>
 <CACT4Y+bqJeKum7jessccWQF+4BmabnVy48aqHEOypioKwQAMTQ@mail.gmail.com> <b7727ff0-b34f-25a2-b9e7-56e70d9349c4@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 15:17:57 +0200
Message-ID: <CACT4Y+bQOr=+e8y5so3V9K390uJnMy4+FR7_t9G7Fjn12S4hoA@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in shmem_fault
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yang Shi <yang.s@alibaba-inc.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 3:10 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>>>> Just flooding out of memory messages can trigger RCU stall problems.
>>>>>>> For example, a severe skbuff_head_cache or kmalloc-512 leak bug is causing
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>> Quite some of them, indeed! I guess we want to rate limit the output.
>>>>>> What about the following?
>>>>>
>>>>> A bit unrelated, but while we are at it:
>>>>>
>>>>>   I like it when we rate-limit printk-s that lookup the system.
>>>>> But it seems that default rate-limit values are not always good enough,
>>>>> DEFAULT_RATELIMIT_INTERVAL / DEFAULT_RATELIMIT_BURST can still be too
>>>>> verbose. For instance, when we have a very slow IPMI emulated serial
>>>>> console -- e.g. baud rate at 57600. DEFAULT_RATELIMIT_INTERVAL and
>>>>> DEFAULT_RATELIMIT_BURST can add new OOM headers and backtraces faster
>>>>> than we evict them.
>>>>>
>>>>> Does it sound reasonable enough to use larger than default rate-limits
>>>>> for printk-s in OOM print-outs? OOM reports tend to be somewhat large
>>>>> and the reported numbers are not always *very* unique.
>>>>>
>>>>> What do you think?
>>>>
>>>> I do not really care about the current inerval/burst values. This change
>>>> should be done seprately and ideally with some numbers.
>>>
>>> I think Sergey meant that this place may need to use
>>> larger-than-default values because it prints lots of output per
>>> instance (whereas the default limit is more tuned for cases that print
>>> just 1 line).
>
> Yes. The OOM killer tends to print a lot of messages (and I estimate that
> mutex_trylock(&oom_lock) accelerates wasting more CPU consumption by
> preemption).
>
>>>
>>> I've found at least 1 place that uses DEFAULT_RATELIMIT_INTERVAL*10:
>>> https://elixir.bootlin.com/linux/latest/source/fs/btrfs/extent-tree.c#L8365
>>> Probably we need something similar here.
>
> Since printk() is a significantly CPU consuming operation, I think that what
> we need to guarantee is interval between the end of an OOM killer messages
> and the beginning of next OOM killer messages is large enough. For example,
> setup a timer with 5 seconds timeout upon the end of an OOM killer messages
> and check whether the timer already fired upon the beginning of next OOM killer
> messages.
>
>>
>>
>> In parallel with the kernel changes I've also made a change to
>> syzkaller that (1) makes it not use oom_score_adj=-1000, this hard
>> killing limit looks like quite risky thing, (2) increase memcg size
>> beyond expected KASAN quarantine size:
>> https://github.com/google/syzkaller/commit/adedaf77a18f3d03d695723c86fc083c3551ff5b
>> If this will stop the flow of hang/stall reports, then we can just
>> close all old reports as invalid.
>
> I don't think so. Only this report was different from others because printk()
> in this report was from memcg OOM events without eligible tasks whereas printk()
> in others are from global OOM events triggered by severe slab memory leak.

Ack.
I guess I just hoped deep down that we somehow magically get rid of
all these reports with some simple change like this :)
