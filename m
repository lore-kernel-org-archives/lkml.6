Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3317868-1523885466-2-5247858946606157157
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
    1523885466; b=IdtoHkAKR3Ybk7fJU9rCYS9qfstCuVx1q3XoaVVEPyW9RZvsR2
    oTJMZh4binyFVnsax+lALZBQpSOb3Kj6geudv7QCMUVq2tBCKAHmbpOk82/e48d8
    OdOTERTpBACYKkrCDJi/JAJRCz4ZhwZlLMpXduE4ZKC1jcGSB1eCryRPy7Xq9q0E
    Gn9LZ46sjsTUT9mBEw76dGMNnSndNNygA3gj40DyOGNqw+hLQCNVr7dXeZoP2NbD
    iKEZVqbAVjtTD15sw9E3IioywiyL+ee1J8FDdAP8Zu8gC//OCFnfCz2ZqctrBYXi
    A9zMmPEPVpfj1Lc1ABDRAgdfbKUbbeASJfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523885466;
    bh=C6JCd/XO+wEYSKo+BJaREaEAsRoGyfjlmKYj0HhVhpU=; b=Cl8WQ7GldlS4
    ks3DJs+A3RGkPMjKoaY+hIlbO04zoaTq6LLYqQF3eoi3r7iOKHnidUTLlxjbBZ+3
    2OXLBnGLmw3nP6HA+5drRtQgKDRPf1iNEAlbW3xIuc7WqXc2gATh2Tg5vAXMbEbF
    5A7II09EiIXOmVzT2y2Kk8GBoRtAdvntDWCHN2rW1D9c0Xz3CGwV9u5pmmxNlc5m
    qCAVu3/xzJSJW924SZX2/s+xH2qM0aj7SXeQj2+sb49LjFwapGOnumd0r1DbxvYF
    YbAUqe9+z2/5ObzHlOH9Ubq2l7CT0JKAsrxYdCqxuNsCYhgKxC+83+96CEfqXdcs
    SeLFW4cCeQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfJ8fL/leadmhtU0FtjqSgHyEkTULbqhFuU+1/UPZLI5b79vLxH3h0n1IlpTO8NUSU0AXjk7V36WNcZm3AXB8DxaI68pnyVXFP6zmmhVCC/pS4JxP/tBe
    mK0Ro36Xp6pF8k3rvODyyoBzi7PKbDg5gvLkijoMmM/d06dFFr1YA4ydL4dzqetR52m6g3Ix0n1rp59YNC1lCFCjkk+cVv+7Dowx7JxNkv6AyTdAuIxJtB2y
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=SBjhVK9QXOcrMxymIUwA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755033AbeDPNbD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 09:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754974AbeDPNbC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 09:31:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC6C217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 09:30:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416093058.6edca0bb@gandalf.local.home>
In-Reply-To: <20180415144248.GP2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
        <20180409001936.162706-15-alexander.levin@microsoft.com>
        <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
        <20180415144248.GP2341@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 15 Apr 2018 14:42:51 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> On Mon, Apr 09, 2018 at 10:22:46AM +0200, Petr Mladek wrote:
> >PS: I wonder how much time you give people to react before releasing
> >this. The number of autosel mails is increasing and I am involved
> >only in very small amount of them. I wonder if some other people
> >gets overwhelmed by this.  
> 
> My review cycle gives at least a week, and there's usually another week
> until Greg releases them.
> 
> I know it's a lot of mails, but in reality it's a lot of commits that
> should go in -stable.
> 
> Would a different format for review would make it easier?

I wonder if the "AUTOSEL" patches should at least have an "ack-by" from
someone before they are pulled in. Otherwise there may be some subtle
issues that can find their way into stable releases.

-- Steve
