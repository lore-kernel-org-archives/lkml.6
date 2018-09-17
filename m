Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9663AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595A4214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595A4214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeIQS5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:57:11 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:2096 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728273AbeIQS5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:57:10 -0400
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v4
To:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180905214303.GA30178@cmpxchg.org>
 <20180907110407.GQ24106@hirez.programming.kicks-ass.net>
 <20180907150955.GC11088@cmpxchg.org>
 <CAJuCfpG1=pXOg=1GwC33Uy0BcXNq-BsR6dO0JJq4Jnm5TyNENQ@mail.gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <29f0bb2c-31d4-0b2e-d816-68076b90e9d3@sony.com>
Date:   Mon, 17 Sep 2018 15:29:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJuCfpG1=pXOg=1GwC33Uy0BcXNq-BsR6dO0JJq4Jnm5TyNENQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will it be part of the backport to 4.9 google android or is it for test only?
I guess that this patch is to big for the LTS tree.

On 09/07/2018 05:58 PM, Suren Baghdasaryan wrote:
> Thanks for the new patchset! Backported to 4.9 and retested on ARMv8 8
> code system running Android. Signals behave as expected reacting to
> memory pressure, no jumps in "total" counters that would indicate an
> overflow/underflow issues. Nicely done!
>
> Tested-by: Suren Baghdasaryan <surenb@google.com>
>
> On Fri, Sep 7, 2018 at 8:09 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
>> On Fri, Sep 07, 2018 at 01:04:07PM +0200, Peter Zijlstra wrote:
>>> So yeah, grudingly acked. Did you want me to pick this up through the
>>> scheduler tree since most of this lives there?
>> Thanks for the ack.
>>
>> As for routing it, I'll leave that decision to you and Andrew. It
>> touches stuff all over, so it could result in quite a few conflicts
>> between trees (although I don't expect any of them to be non-trivial).


