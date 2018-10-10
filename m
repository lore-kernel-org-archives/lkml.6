Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73DEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C94B2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/V2B+KR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C94B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJJTv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:51:59 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37174 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJJTv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:51:59 -0400
Received: by mail-it1-f196.google.com with SMTP id e74-v6so7653918ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 05:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O0TqrtLynyOzG0Q8a1r+9ryCvb0PwuY8Q+HlWlOqKx0=;
        b=p/V2B+KRHmhZ9Y9x39tDlCaNMIQQR3I4UxwCSo7aB4yUIUYmseTn5XnGpKk8HfV7wB
         th6bwn5NWwP97hWKV0AZIDgPwWK0xqwZAD/tb8tzB6i1Tjw6sc0ptaEKn+38n6LZh71a
         dHdy0dJuRDecm47lhneJjjSTp36N+BKijLmsZxPtps2EgzY5YUctehrGV9MoQMyp8d9K
         Wvr5YxgBye6ij6e5F2PVsNu5WAbi7aJr8mxyocVonJSAp5gurjmUg/SCOb0AWje7v1Ss
         i14HCKB8U+53PCnHKhiO6rDlf8lAoy5RrWJY/9VHF6C/YO0wjbXDe3KEyq1EJaYOMEBq
         F+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O0TqrtLynyOzG0Q8a1r+9ryCvb0PwuY8Q+HlWlOqKx0=;
        b=pHMyLUyiDaXs4RDVuvL5c+NMeHWMl+EmBpd7RYlDW0XNeFGtHyJAVo9x1uKNWlHgGs
         jzHvSiXj1tG2jmF6Hj1px2wJrVnjyYBzJBe+Jc3TEZC75qL/xCSnYt86w+9EXGrTi2tq
         2ka1GStEQ7GtJfMcNB8pHui99hFW1q8yf9efQwlieO6bwQwbyaM57+lCrhaRO/8mnqNP
         tgaUPWRHO8dm7PRxuxqFPviXlAx2V6sJyxkuNp6feekIysdVIxYsfEzTH7n7kQXng3R0
         Y5+rxjZFnj/0aWzbCUHAKrpHy57Y4aKrXcN5qOSHQOc3kORrrDzGy1UBhNYJ1fCOejCG
         5M3A==
X-Gm-Message-State: ABuFfoj+EPI3G1/LE2ZONoiqR3zGInr7BAAnZffdm1PYV3+aeZJ4xa6l
        pPaDwVYJK2LaSsmEBJv06Rosn1e5IXjAJ8fhkWb3Hw==
X-Google-Smtp-Source: ACcGV634IBVxjt8ovIeJas+Lra+md9jIMTLi3AfFyycIbj+ErfxxJ+B8E98KBjlJ14QkEPy1NP95QqI2jNccwdTy40E=
X-Received: by 2002:a24:f584:: with SMTP id k126-v6mr511529ith.166.1539174600624;
 Wed, 10 Oct 2018 05:30:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 05:29:40
 -0700 (PDT)
In-Reply-To: <20181010122539.GI5873@dhcp22.suse.cz>
References: <000000000000dc48d40577d4a587@google.com> <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <20181010085945.GC5873@dhcp22.suse.cz> <e72f799e-0634-f958-1af0-291f8577f4e8@i-love.sakura.ne.jp>
 <20181010113500.GH5873@dhcp22.suse.cz> <20181010114833.GB3949@tigerII.localdomain>
 <20181010122539.GI5873@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 14:29:40 +0200
Message-ID: <CACT4Y+ZfVdeB-WNeLCWJvTHNeCUtR3r1R+3Qjv9XjZXPxaV2WA@mail.gmail.com>
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

On Wed, Oct 10, 2018 at 2:25 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Wed 10-10-18 20:48:33, Sergey Senozhatsky wrote:
>> On (10/10/18 13:35), Michal Hocko wrote:
>> > > Just flooding out of memory messages can trigger RCU stall problems.
>> > > For example, a severe skbuff_head_cache or kmalloc-512 leak bug is causing
>> >
>> > [...]
>> >
>> > Quite some of them, indeed! I guess we want to rate limit the output.
>> > What about the following?
>>
>> A bit unrelated, but while we are at it:
>>
>>   I like it when we rate-limit printk-s that lookup the system.
>> But it seems that default rate-limit values are not always good enough,
>> DEFAULT_RATELIMIT_INTERVAL / DEFAULT_RATELIMIT_BURST can still be too
>> verbose. For instance, when we have a very slow IPMI emulated serial
>> console -- e.g. baud rate at 57600. DEFAULT_RATELIMIT_INTERVAL and
>> DEFAULT_RATELIMIT_BURST can add new OOM headers and backtraces faster
>> than we evict them.
>>
>> Does it sound reasonable enough to use larger than default rate-limits
>> for printk-s in OOM print-outs? OOM reports tend to be somewhat large
>> and the reported numbers are not always *very* unique.
>>
>> What do you think?
>
> I do not really care about the current inerval/burst values. This change
> should be done seprately and ideally with some numbers.

I think Sergey meant that this place may need to use
larger-than-default values because it prints lots of output per
instance (whereas the default limit is more tuned for cases that print
just 1 line).

I've found at least 1 place that uses DEFAULT_RATELIMIT_INTERVAL*10:
https://elixir.bootlin.com/linux/latest/source/fs/btrfs/extent-tree.c#L8365
Probably we need something similar here.
