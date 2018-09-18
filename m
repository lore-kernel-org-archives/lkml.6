Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E345BECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84ED7214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qY68wHOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84ED7214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbeIRVgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:36:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39827 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbeIRVgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:36:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so2701252wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BMFNQQpQoruj7zBh3aMY+r/etAqs8yFqlr/AFgpS008=;
        b=qY68wHOYFQnd357nu9mKACcCeuQCGcmGrAreZv560ekIDMINaYupSjMuDKjGztbKOF
         DmRzMZhaaSb+OwwmMu7iNtAyT7YTTUJ7g3E976JmaxZLRNctXkXwOPNobmLQYNCpveV9
         IyCqAWzHSK/6h0V6mZdQNa8iadmA02uY1HxkoOYFyQ5sQ74psovs+MQ/njRK+kb2Ubza
         24iI1xN1fl+DhqlidPuObXD//mLBykEpvUXuhdkL5WCHwI0KFt+T9xMsq+OMgycBjxvU
         wWl/NTfx2xphAsKpOlFcn1gJGzm9zWevaWpenTwATkIfeRkrWcSGpPp9S0vLbsizHTgi
         FS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BMFNQQpQoruj7zBh3aMY+r/etAqs8yFqlr/AFgpS008=;
        b=VBiL1JRIaqxoxSln7sesvCOjhst77NMgQOV2GAgwG8DZuGc1Bn70y5/dcIYQAVfMTK
         G6Nt1/dIP/BqLby8GbLqoPJdpwlZ0tPYzin8n6+WTAbvo8DLTQeJB0VPFPjRHVUR1209
         N8NvypB+al+ddObJVmU2M8ySkti9EyhXjxV3LMJkXzgvGOjLZbrQAFt/Asz4WO8wiqi5
         z4KnjOBbwLKDzST272aksi9BC2ooyMegIE7MMjj0ibhkkjL7UMFsrGPq8U0vkarj5PIb
         tI9XGrXWQWW25//m547pzTFeBPWdXNr9DDyyaoqP6ugumzFKJmbusDlIe00XCrNbOT9Z
         IBxQ==
X-Gm-Message-State: APzg51DO0sqTSyCncNa/Rt7091NzCHmJEGl8H6MbXPGh5TJC44lnd/IC
        LGCiR14z9YeeW2m7QZnTIL+ZHdIhgV1b3KAFsVakqQ==
X-Google-Smtp-Source: ANB0VdabDm+3uiDegnAH9/ICacFpetbvCVSUSUmGurSaEWnFnCuKpKu0ZPngna07gNm2RK37JU1v19QQQLhN2a4BCf0=
X-Received: by 2002:adf:9e93:: with SMTP id a19-v6mr24761287wrf.70.1537286585759;
 Tue, 18 Sep 2018 09:03:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:c710:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 09:03:05
 -0700 (PDT)
In-Reply-To: <29f0bb2c-31d4-0b2e-d816-68076b90e9d3@sony.com>
References: <20180828172258.3185-1-hannes@cmpxchg.org> <20180905214303.GA30178@cmpxchg.org>
 <20180907110407.GQ24106@hirez.programming.kicks-ass.net> <20180907150955.GC11088@cmpxchg.org>
 <CAJuCfpG1=pXOg=1GwC33Uy0BcXNq-BsR6dO0JJq4Jnm5TyNENQ@mail.gmail.com> <29f0bb2c-31d4-0b2e-d816-68076b90e9d3@sony.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 18 Sep 2018 09:03:05 -0700
Message-ID: <CAJuCfpFSTEBySRR2X=3b5+pHP_J1MBqfPXPJCUVajGF6AwJDpA@mail.gmail.com>
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v4
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 6:29 AM, peter enderborg
<peter.enderborg@sony.com> wrote:
> Will it be part of the backport to 4.9 google android or is it for test only?

Currently I'm testing these patches in tandem with PSI monitor that
I'm developing and test results look good. If things go well and we
start using PSI for Android I will try to upstream the backport. If
upstream rejects it we will have to merge it into Android common
kernel repo as a last resort. Hope this answers your question.

> I guess that this patch is to big for the LTS tree.
>
> On 09/07/2018 05:58 PM, Suren Baghdasaryan wrote:
>> Thanks for the new patchset! Backported to 4.9 and retested on ARMv8 8
>> code system running Android. Signals behave as expected reacting to
>> memory pressure, no jumps in "total" counters that would indicate an
>> overflow/underflow issues. Nicely done!
>>
>> Tested-by: Suren Baghdasaryan <surenb@google.com>
>>
>> On Fri, Sep 7, 2018 at 8:09 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
>>> On Fri, Sep 07, 2018 at 01:04:07PM +0200, Peter Zijlstra wrote:
>>>> So yeah, grudingly acked. Did you want me to pick this up through the
>>>> scheduler tree since most of this lives there?
>>> Thanks for the ack.
>>>
>>> As for routing it, I'll leave that decision to you and Andrew. It
>>> touches stuff all over, so it could result in quite a few conflicts
>>> between trees (although I don't expect any of them to be non-trivial).
>
>

Thanks,
Suren.
