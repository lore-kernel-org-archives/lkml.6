Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D654C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5483E2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRZZjail"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5483E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJJT6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:58:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39551 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJT6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:58:49 -0400
Received: by mail-io1-f67.google.com with SMTP id z16-v6so3732091iol.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 05:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OFgOEIE0zZpQrPIwr1VeeUcXGjgM/50RUStkFcvjXss=;
        b=fRZZjailblvJEF3/RYWm8MdQN8HD3lWWYw/m/VbLAsha4tBxY8/68K/wGqYvMSJYdc
         0gycHJPfhY7ByK8CrZ6F7zEmBsd+b5Hw6snd0Nyz6tdhr0UADpYtFCLFX2NnYUKW+Nmy
         MGhO448QbvbPKpudYOD2OAujDzhS6R1UhhhBmmMedbqWXwCC+1C+HDs/8N4AtmjLFhwA
         BM6LGtzcsHbjvT3wkHuR9HLjcPL8fuVHAOW6nzY8gO/PugYgE2HJBoQQ1XOr27bozPAb
         96fS3P6GU8Ir+/fIPG9qz9d4nK3bbSWHU7XwGSsGNfgsaYSbFfR7E8QJw/sExym3yxXO
         ViyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OFgOEIE0zZpQrPIwr1VeeUcXGjgM/50RUStkFcvjXss=;
        b=gWYI48sviryk2Ohh0fkO1EIYVarnB8hAe3yo59uYpNc4uggoynTSKscI25qkQ5QInk
         39zuaxrS5rEXpqGpITj2uvNGmXq9tqVZ3XICUM4yJhJK+W+ggVD45nJt2GrUsdpy70pw
         uNWctyLRV2TEsPWMKQF3mi6ArRaDq33WsoY3EATMWTmhKW4mXK4lGy8DGbcsBVn1U0rD
         uwvY3wE8ED9Jl2XqaNbP9qub3d9dmc9M6jQP9Xq3oNJRcXlu7dU4UR/RIhIscPGrrI1H
         92UtTbRIX27S7iKWuQZoRoytDOseW3CD9x6ISQMMYsynYSvXrb6mvJjGuCFoqo5FTEJH
         rqAA==
X-Gm-Message-State: ABuFfoh/yTpwSkpklk7yfhDSjWl6kgekVAiypKA4lK/+8bgyPvBhZWN9
        d262UclXVYlGCuB1d6vS3K/fSnddoz0y88dnd5ayyA==
X-Google-Smtp-Source: ACcGV61jF6gLEjnO+k1kDMZcVwNcRUBg8PpvlN9j8WgNoyjTOMnXDFW53PgsbWzLoyUGhCkpn3bE98K3etNeiJTtclU=
X-Received: by 2002:a6b:6209:: with SMTP id f9-v6mr12143922iog.11.1539175009722;
 Wed, 10 Oct 2018 05:36:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 05:36:29
 -0700 (PDT)
In-Reply-To: <CACT4Y+ZfVdeB-WNeLCWJvTHNeCUtR3r1R+3Qjv9XjZXPxaV2WA@mail.gmail.com>
References: <000000000000dc48d40577d4a587@google.com> <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <20181010085945.GC5873@dhcp22.suse.cz> <e72f799e-0634-f958-1af0-291f8577f4e8@i-love.sakura.ne.jp>
 <20181010113500.GH5873@dhcp22.suse.cz> <20181010114833.GB3949@tigerII.localdomain>
 <20181010122539.GI5873@dhcp22.suse.cz> <CACT4Y+ZfVdeB-WNeLCWJvTHNeCUtR3r1R+3Qjv9XjZXPxaV2WA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 14:36:29 +0200
Message-ID: <CACT4Y+bqJeKum7jessccWQF+4BmabnVy48aqHEOypioKwQAMTQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in shmem_fault
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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

On Wed, Oct 10, 2018 at 2:29 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Oct 10, 2018 at 2:25 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> On Wed 10-10-18 20:48:33, Sergey Senozhatsky wrote:
>>> On (10/10/18 13:35), Michal Hocko wrote:
>>> > > Just flooding out of memory messages can trigger RCU stall problems.
>>> > > For example, a severe skbuff_head_cache or kmalloc-512 leak bug is causing
>>> >
>>> > [...]
>>> >
>>> > Quite some of them, indeed! I guess we want to rate limit the output.
>>> > What about the following?
>>>
>>> A bit unrelated, but while we are at it:
>>>
>>>   I like it when we rate-limit printk-s that lookup the system.
>>> But it seems that default rate-limit values are not always good enough,
>>> DEFAULT_RATELIMIT_INTERVAL / DEFAULT_RATELIMIT_BURST can still be too
>>> verbose. For instance, when we have a very slow IPMI emulated serial
>>> console -- e.g. baud rate at 57600. DEFAULT_RATELIMIT_INTERVAL and
>>> DEFAULT_RATELIMIT_BURST can add new OOM headers and backtraces faster
>>> than we evict them.
>>>
>>> Does it sound reasonable enough to use larger than default rate-limits
>>> for printk-s in OOM print-outs? OOM reports tend to be somewhat large
>>> and the reported numbers are not always *very* unique.
>>>
>>> What do you think?
>>
>> I do not really care about the current inerval/burst values. This change
>> should be done seprately and ideally with some numbers.
>
> I think Sergey meant that this place may need to use
> larger-than-default values because it prints lots of output per
> instance (whereas the default limit is more tuned for cases that print
> just 1 line).
>
> I've found at least 1 place that uses DEFAULT_RATELIMIT_INTERVAL*10:
> https://elixir.bootlin.com/linux/latest/source/fs/btrfs/extent-tree.c#L8365
> Probably we need something similar here.


In parallel with the kernel changes I've also made a change to
syzkaller that (1) makes it not use oom_score_adj=-1000, this hard
killing limit looks like quite risky thing, (2) increase memcg size
beyond expected KASAN quarantine size:
https://github.com/google/syzkaller/commit/adedaf77a18f3d03d695723c86fc083c3551ff5b
If this will stop the flow of hang/stall reports, then we can just
close all old reports as invalid.
