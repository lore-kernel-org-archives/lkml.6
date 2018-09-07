Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6133C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FACF20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cl9hYHLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FACF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeIGUkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:40:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38256 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeIGUkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:40:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so15092507wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+ZR6++p5OdDfOouBlBByaH8T5wkcBYztRaDPUIqWl30=;
        b=Cl9hYHLKbDzl8/8QI4LvxG/FYitkB3fY+o0ANcw26CfrfvJPstA+lpMItWuQyh8f+W
         U38F3ebYgI9l6/fa5UV9x7K3/nrfzqI+uKgv+tZWvfVMlO9K+q/ZoOoqf3AyxnNB2tl4
         mu6PFFH2Zhgl8BjOZ66CTNRfJOPnuk7LIKnp2PWUeu5tIAl91gBLUVwDMxTsl6S62mfy
         +sP7/q/Da6XIKZtw7nS8VRAEYFSf2Alg52sofUQabfcsxTd5mCGcrvxGO3ARAjz48kyM
         NFDqlRG4LUwsW3RUqqsYlengmWCiWS6XfjUrC75O/8Fd6WF5z3DvTxld6tUxttF45wI7
         EzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+ZR6++p5OdDfOouBlBByaH8T5wkcBYztRaDPUIqWl30=;
        b=I1xvc/+VA+hfZmsxeEU1dxHSqem1myuMssszXJm0BpCTaLMr5Zr821IAwwOxHXqRis
         gbrixRN8vx7Mtg6Ua7OSaAHmTcOMlm5OYiUvezmil7berMffVfvO5IufPAbnsaeGOq8y
         kGLeQgLi7As3H6dB9o3moFU3/4VMX4g7DMa54iv7K8gqAnWYZxVfgFMZZDYdl3qlYy54
         0b7UVmGRm5PpyDCej/PDlMW6J7yA2ypYMjteuqSEdjya7kXL8qs4ZFKauZXeZWBWqBNH
         VHecez7IzSz2jJ3J0yRA7cLN8L2YiWIdZi2exhDIq5f7dosxGJwCDFg7YrizPyMRugQw
         euFA==
X-Gm-Message-State: APzg51C96zrYEbfIRE1wKno2zq8CDkc7siTqTlH5aRtnac5uMYozt1IC
        /vaUChp4cABHQ5ZgaYVto0kLHTFNeJlpyQcQFktbXQ==
X-Google-Smtp-Source: ANB0VdZ+m33M+XsHmWOQfUGbL2OovlXa1jWcQ6c7bT+fWtWOkVg1XdsFyMUyO3gIaqgpX7eDMn7A0euBn9iBM5zn+YY=
X-Received: by 2002:a1c:9e89:: with SMTP id h131-v6mr5552161wme.13.1536335916666;
 Fri, 07 Sep 2018 08:58:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:c710:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 08:58:36 -0700 (PDT)
In-Reply-To: <20180907150955.GC11088@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org> <20180905214303.GA30178@cmpxchg.org>
 <20180907110407.GQ24106@hirez.programming.kicks-ass.net> <20180907150955.GC11088@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 7 Sep 2018 08:58:36 -0700
Message-ID: <CAJuCfpG1=pXOg=1GwC33Uy0BcXNq-BsR6dO0JJq4Jnm5TyNENQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v4
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the new patchset! Backported to 4.9 and retested on ARMv8 8
code system running Android. Signals behave as expected reacting to
memory pressure, no jumps in "total" counters that would indicate an
overflow/underflow issues. Nicely done!

Tested-by: Suren Baghdasaryan <surenb@google.com>

On Fri, Sep 7, 2018 at 8:09 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> On Fri, Sep 07, 2018 at 01:04:07PM +0200, Peter Zijlstra wrote:
>> So yeah, grudingly acked. Did you want me to pick this up through the
>> scheduler tree since most of this lives there?
>
> Thanks for the ack.
>
> As for routing it, I'll leave that decision to you and Andrew. It
> touches stuff all over, so it could result in quite a few conflicts
> between trees (although I don't expect any of them to be non-trivial).
