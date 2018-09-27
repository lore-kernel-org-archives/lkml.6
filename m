Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D48C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDEB216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDEB216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeI0W3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:29:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:18535 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbeI0W3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:29:17 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8RGAICV088640;
        Fri, 28 Sep 2018 01:10:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Fri, 28 Sep 2018 01:10:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8RGAH29088637
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 28 Sep 2018 01:10:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
 <20180912065307.GA606@jagdpanzerIV>
 <20180912120548.4280f04a@vmware.local.home>
 <20180913071204.GA604@jagdpanzerIV>
 <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
 <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
Message-ID: <758bcf74-f9d6-d3c9-be10-34046166504b@i-love.sakura.ne.jp>
Date:   Fri, 28 Sep 2018 01:10:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/24 17:11, Tetsuo Handa wrote:
> On 2018/09/19 20:02, Tetsuo Handa wrote:
>> On 2018/09/14 21:22, Sergey Senozhatsky wrote:
>>> The "SMP-safe" comment becomes a bit tricky when pr_line is used with a
>>> static buffer. Either we need to require synchronization - umm... and
>>> document it - or to provide some means of synchronization in pr_line().
>>> Let's think what pr_line API should do about it.
>>>
>>> Any thoughts?
>>>
>>
>> I'm inclined to propose a simple one shown below, similar to just having
>> several "struct cont" for concurrent printk() users.
>> What Linus has commented is that implicit context is bad, and below one
>> uses explicit context.
>> After almost all users are converted to use below one, we might be able
>> to get rid of KERN_CONT support.
> 
> The reason of using statically preallocated global buffers is that I think
> that it is inconvenient for KERN_CONT users to calculate necessary bytes
> only for avoiding message truncation. The pr_line might be passed to deep
> into the callchain and adjusting buffer size whenever the content's possible
> max length changes is as much painful as changing printk() to accept only
> one "const char *" argument. Even if we guarantee that any context can
> allocate buffer from kernel stack, we cannot guarantee that many concurrent
> printk() won't trigger lockup. Thus, I think that trying to allocate from
> finite static buffers with a fallback to unbuffered printk() upon failure
> is sufficient.
> 

Hmm, what problem is blocking this topic?

I think that the SMP-safe comment is unnecessary for line buffered printk() API.
What we want to do is to avoid mixing incomplete lines from concurrent printk()
callers (and then, prefix caller's information in order to help grouping multiple
lines) rather than avoid stalls / crashes / lost messages caused by concurrent
printk() callers.

We could avoid crashes if there is no bug in printk() related code. But we can
never avoid stalls / lost messages as long as we floodly call printk(). Even if
line buffered printk() API were SMP-safe, printk() might have to discard the
output. We need to try to avoid too much printk() - as if there is no concept
of SMP-safeness regardless of whether pr_line() is used with a static buffer.

Therefore, I think that "Either we need to require synchronization - umm... and
document it - or to provide some means of synchronization in pr_line()." is a
pointless worry. It is only existing printk() API which needs synchronization. I
think that line buffered printk() API does not need to talk about synchronization.
Just saying "don't share DEFINE_PR_LINE()/DEFINE_PR_LINE_BUF() variables" will be
sufficient.

