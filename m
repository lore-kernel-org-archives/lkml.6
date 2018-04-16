Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3647214-1523895655-2-6330251477141247859
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
    1523895654; b=WvUeLF45ZRtIfrUJ9p88HyAi/loeLyNNtzBKQq2PzprQWGzVdH
    LjE1EpcF1eYgAXVNHC7ZilUGMixQI6f1WQS4bjVJ/Sz55IEcGZrnGvxdvHPrW25N
    AvSNDXPxuqV60dPEFrJHsE9alq+x5MRTUJtN1rZMYcyaZQ0R6MH9EVjllmD3cVCg
    WwmZgdaHQlR8x3fYkxanM3aLMxEU2Y8XrrZLdx3OIPVyOGSOzrjC2/qlcvSX8LN5
    DY4CNnfYBGxNnGV06Z1TAxodHmwkw3MSw1dcei0mdmVRo4gT+o3SwID5puaNk456
    79bPhIE2uyjGMow5yrL74EUZyR9vdVioD4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523895654;
    bh=tPrqPWtN0MuvXDyj0hReavQbWc1uJ7rC+4LDyGrS8Ak=; b=MBsKdkyNJCQu
    pym6GiDjL+JbedobFJwggFwESBVXWdj3JwHhMPhR9I9hWlpQaHhyLdBy9ZRXBYSO
    87zVDVbtXr1IfzKwy5ckNvt0ttG3pW3AARP3ti/02UvxCIou9OIhFmttOr2r+AzK
    h8A6vIdlQXCTWLsdrTx80oWRzyujGXSxpQ8pxtYz5rzRhzyNSONF6Sl9WXahFgXt
    OeLKZjFfoqnsFgMc5daQtNXvPLlIQLOuZBW3OBpfbL5FNlgAVSOkJ2CM6Y2CCYx7
    K8XT1CYaHYygJTRPtT/BMzm65+IIlT6iNrKt1nnDR9BKDZ73qzsPh5tMfJNav0Z/
    ZK+V3HsECA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfFAYuAjNI83B/a5eyVRtyt060cXeLY138I7BxYjhRv6RK+xtMwWBEQmfRI+4OAFC8zAGfaDdeMYQfIH9B/JY6U6etaMeJDrIzEo/9e5ZoO0HCdtTk+pq
    wUZe1rn3pQbLSxMF1C8oso9pxQUPYbXq6/f5D15DWba5zPSniho8ZxiRkNmAZyKeCUx77NktpD1iLJStoid5tx1nM+WCkQsJU6zWBAZhhq01F+LGS9avYrGc
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=zSL8B4tAg-wWYITcwbMA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeDPQUY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbeDPQUX (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:20:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE9421838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 12:20:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
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
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416122019.1c175925@gandalf.local.home>
In-Reply-To: <20180416160608.GA7071@amd>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
        <20180409001936.162706-15-alexander.levin@microsoft.com>
        <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
        <20180415144248.GP2341@sasha-vm>
        <20180416093058.6edca0bb@gandalf.local.home>
        <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
        <20180416153031.GA5039@amd>
        <20180416155031.GX2341@sasha-vm>
        <20180416160608.GA7071@amd>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 18:06:08 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> That means you want to ignore not-so-serious bugs, because benefit of
> fixing them is lower than risk of the regressions. I believe bugs that
> do not bother anyone should _not_ be fixed in stable.
> 
> That was case of the LED patch. Yes, the commit fixed bug, but it
> introduced regressions that were fixed by subsequent patches.

I agree. I would disagree that the patch this thread is on should go to
stable. What's the point of stable if it introduces regressions by
backporting bug fixes for non major bugs.

Every fix I make I consider labeling it for stable. The ones I don't, I
feel the bug fix is not worth the risk of added regressions.

I worry that people will get lazy and stop marking commits for stable
(or even thinking about it) because they know that there's a bot that
will pull it for them. That thought crossed my mind. Why do I want to
label anything stable if a bot will probably catch it. Then I could
just wait till the bot posts it before I even think about stable.

-- Steve
