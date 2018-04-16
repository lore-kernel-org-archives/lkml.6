Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3972417-1523907508-2-2651522041566364430
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
    1523907504; b=BEtAeYhEGxPJqfuiXXzG3zBCS1C0hgnVVyJUVQ//R2JooANHVt
    FPAdXuSvwq/oOHzCzgCKZJrwUc0f/1U96kt7IckpanA2BkLu6l3+q29e9XIy/psK
    mrZDG54+D6qKaiAPPb9D241eFYWyXs9sQqGHv9FefCjhrFk51ddDm3FsJxFCB1yk
    mrGHwcmS72jBgeooGsbhcGSQJLirx4bwTRbwC2mxIhRENG+OV1Pxo+bbWnGpQEJw
    baDRCEve4PK8IqX4BoSOrRQGLJCCLkGb1sedwr0s3bePYZ40wjfMLahmUWYzhs1d
    P2jN9Zj24ArkIA8FwKxsk7PSNP7rikBX0DBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523907504;
    bh=i1Dac+6aTyPXbqwP4B2ps59XVeCS99z8KhRuPso1V7k=; b=aKy4+gaieo5Y
    2+prOCz01ol2LmWkHgKqfeflsfLey8eF9SYGgzLQvM2jVY36yD5d/1gkLtbWcDD4
    AvdFQIfR+RHXFNAjyEsmrpzYKxiFpvb4QFZqQNgY51cObngSDhwclR//aIGeN6Gh
    edcF3e4sbD+dPFAcbIEqpUSMcJ6lDzk+MthTUyB99fwTgaydWH8D8nmfLfyXn5bH
    mpiAK1RyzG6bRRkaCm5JeY63uoR8uRjjIvVl66Qa8X+FdPk6pPB5WXe3m5DbVTqB
    utg5Iu37WpxnhubL0J5uyLwDhThTb2XOriiVLibVwsl66kP1q08wSh8QY/28ewJR
    eeVlCMoBVg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfMbl+0S69m4Fc0YTbkOKcQyZ4G1rM4qBU1xfgBvoTd7089TBvw0ZC4GgSKTFhScl8KIljkGmccMPot0lVi6rciZ0kmZJJHRhz66qfLmLqlvxOGflpDbF
    EMXy8gcxv93GG8UJjBAh5ZjRbQVw3uJ1izwBfPkSos11RXhHiaIrQs49Rq+hP8knWsDhty+m5cDMdMgEAufBUjqA1AUXr1qoUUEfZl1Zn5DE8Iu7BLBmM+14
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=meVymXHHAAAA:8 a=2QUa1bR8UdYYNfrOGj8A:9 a=CjuIK1q_8ugA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753104AbeDPTiV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbeDPTiV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 15:38:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C54217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 15:38:16 -0400
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
Message-ID: <20180416153816.292a5b5c@gandalf.local.home>
In-Reply-To: <CA+55aFwjSRZDT1f99QdY-Q5R4W_asb_1mZgM69YOqRR9-efmwA@mail.gmail.com>
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
        <20180416144117.5757ee70@gandalf.local.home>
        <CA+55aFyyZ7KmXbEa151JP287vypJAkxugW17YC7Q1B9=TnyHkw@mail.gmail.com>
        <20180416152429.529e3cba@gandalf.local.home>
        <CA+55aFwjSRZDT1f99QdY-Q5R4W_asb_1mZgM69YOqRR9-efmwA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 12:28:21 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 16, 2018 at 12:24 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Right, but the fix to the API was also trivial. I don't understand why
> > you are arguing with me. I agree with you. I'm talking about this
> > specific instance. Where a bug was fixed, and the API breakage was
> > another fix that needed to be backported.  
> 
> Fair enough. Were you there when the report of breakage came in?

No I wasn't.

> 
> Because *my* argument is that reverting something that causes problems
> is simply *never* the wrong answer.
> 
> If you know of the fix, fine. But clearly people DID NOT KNOW. So
> reverting was the right choice.

But I don't see in the git history that this was ever reverted. My reply
saying that "I hope it wasn't reverted", was a response for it being
reverted in stable, not mainline.  Considering that the original bug
would allow userspace to write zeros anywhere in memory, I would have
definitely worked on finding why the API breakage happened and fixing
it properly before putting such a large hole back into the kernel.

I'm assuming that may have been what happened because the commit was
never reverted in your tree, and if I was responsible for that code, I
would be up all night looking for an API fix to make sure the original
fix isn't reverted.

-- Steve
