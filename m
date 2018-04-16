Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3848786-1523904084-2-15583966193411897246
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523904083; b=JiT7ic+zdOygLuq8gvLglbTTXAAcauhxCKcJUVmZJLGV/eafcD
    8WZVQdhZKOXTljlWDUWVgU3xAMYxcBcIiX5s297XwZ7XZ+z2EAN1/fWOEAZVdq0S
    qIMRqQKaBGTLvQRUvcWhhHWkZaH5mv10SGgwN3eJA1RjR1RkWtes8BiKB+zYuuT1
    O66K0VTR10+XWadXH9xFBHYKVumXi3uIh87/jScL8BkkbZNpRYQ/+jxafYFq/RJM
    zJTNtgGxUGhpGePhXQx3KpZyU6nvnvu1jBUl9ODg8p/rn3HSfY+Ge7GlpFoGgVYs
    tTnb/j+NNSQ2GDThaHiai22435pINKmjRSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523904083;
    bh=ixowC05pjp7BhbN10oyci6J2jpvMg9DgUaThS0q81e4=; b=Qf8w3yafQU6d
    YLUwr3MpyH6SUhXigYLBHLOCz/XzCpoILnAbP9nx9GnECi0zs9N28+WQO7ZRr0Xg
    DOAMueCbgJa6hmN0DgN6Lksvc1ZPlMpFd/8T0dR4xtdGsT1cxovvdq6IzefCAIVl
    PeSF4XXFVJo3GWbdGjEwTo77xkNtdJW1WtpKR5urStyeUB4phpKyviSfM9iFDagI
    Fq+7Pzq9GTTryQIDApRMBH9q1ZLzvatXWpJfLwgiAmwT5lWbH4zQDPayyIMkOn5m
    rmaw0HT6KqDcS2hgxFKT6mGnCSnSVCB17+nApXuajT2P5xcsHHjMkoHOeEydfL/r
    gNIBXCKe9w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO7MhizZROvqcQNwXkMXNKHfiRB2Po2jn2YWnLy2cO3oJ4Z/h6rhPEYP6wOo3WUXu8d+H9papy6qJEBW+3nHMzNmqBf0hmzdYxbSTyHf6CDNS77NaWrZ
    ZSFKdlZ8LmNIdADoGtsWdZBNh8DfRPelxUy90TEi5SqbOFa7ZmvyzT/krycszx+dCj7/25N3LAhYYzCCM8SK56fGF6Lk1VS2vFfhudE+KQqpG3GL3pcnd4qC
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=meVymXHHAAAA:8 a=OO_BU_9qIS-SnmXjew4A:9 a=CjuIK1q_8ugA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeDPSlW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 14:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753077AbeDPSlV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 14:41:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368B12175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 14:41:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416144117.5757ee70@gandalf.local.home>
In-Reply-To: <CA+55aFzggPvS2MwFnKfXs6yHUQrbrJH7uyY4=znwetcdEXmZrw@mail.gmail.com>
References: <20180416153031.GA5039@amd>
        <20180416155031.GX2341@sasha-vm>
        <20180416160608.GA7071@amd>
        <20180416122019.1c175925@gandalf.local.home>
        <20180416162757.GB2341@sasha-vm>
        <20180416163952.GA8740@amd>
        <20180416164310.GF2341@sasha-vm>
        <20180416125307.0c4f6f28@gandalf.local.home>
        <20180416170936.GI2341@sasha-vm>
        <20180416133321.40a166a4@gandalf.local.home>
        <20180416174236.GL2341@sasha-vm>
        <20180416142653.0f017647@gandalf.local.home>
        <CA+55aFzggPvS2MwFnKfXs6yHUQrbrJH7uyY4=znwetcdEXmZrw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 11:30:06 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 16, 2018 at 11:26 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > The problem is that it only fixed a critical bug, but didn't go far
> > enough to keep the bug fix from breaking API.  
> 
> An API breakage that gets noticed *is* a crtitical bug.

I totally agree with you. You misunderstood what I wrote.

I said there were two bugs here. The first bug was a possible accessing
bad memory bug. That needed to be fixed. The problem was by fixing
that, it broke API. But that's because the original code was broken
where it relied on broken code to get right. I never said the second
bug fix should not have been backported. I even said that the first bug
"didn't go far enough".

I hope the answer was not to revert the bug and put back the possible
bad memory access in to keep API. But it was to backport the second bug
fix that still has the first fix, but fixes the API breakage.

Yes, an API breakage is something I would label as critical to be
backported.

-- Steve
