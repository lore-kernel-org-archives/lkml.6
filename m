Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709784-1523900010-5-793546019117757691
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
    1523900009; b=oKbwTejfXXGpmeMXzLia3gxwOPELjfboCdxkmeNb/HvNeYLVR4
    akQLd4EHF0A70CLSDdxTfo0+D3LeIs0gIcebQOSL+DZNCBZv8UHaval678tvTZ3o
    36deJwfgnsGdzKNFw1XHRtMm61jumlzGYxvr6/K0I1vmQgwV0D7/xSFc+i2tVoXF
    ayCpUtU0dIwJP4zTyWuNXTmJeftzmQgs9VKFfP/cSTTvki31bsAi6hqTulwAw9E5
    PorZeR8CXYEcPVk1fGVLZtqudZH2jsiHbcWVAPKpBAs60vxD4BYq6FdLxS44p6Ii
    ymkVIJtYWqCdExQyXB6sjorDf3SEgLyjNgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523900009;
    bh=Cstwj0AL5DPOg4aazE/k7omofvZNeNnVrTzk0oWSAj8=; b=LROLRkzmFPdE
    Aw4kTrS1+pQ6Eq0XBTFh2kmIACDjTTCvYKQE5GJ1i5E71ofYMvGNqqHj+Ud0SAME
    RQLgJXciItfh47DjQmhSF86A1etQ7RLDKymDdmXa1B+CBJpRRr9bfc4MDkBccBVY
    DjVCA4UXZx5clBFq3sqcq5w2yfxtCOI2x582R7akKuaynfsdm4zQN9JAfj7FTrLr
    aaZ2QDqrcUjjXC/+nEtSRtSOZ6gzBQUK/v4Z6q2hgnSRk8h4OXIQFBqKuGL0wAZS
    4ujCyJriyCxMnCuvAk2Xnwnm5tOug827q/DO4ozhBuNDHdQ6TLeZ4kItUs+zZx90
    wWJslmLtdg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfCgbmU34AWS2WI5yJl3B6U4DcQTHKZuEl//Gnfw9Nbr6D9oHnuPeSpe7FFPuaUPbIX68fDw3lOWTDcWziXDm/u8KxzTz365kIewrgCYfnUd43gzruzkV
    VAtn5VrUQYkNqDn0Or3MaMbkQtlNHOzNFQMUfqSBYJg3Wj4tqHOFtQtRngbSysHnEGVYXOEom0Gpaepow+oaXqNO82kTqCJJczHZPcUfFDu1fy6+zg+iAwTM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=K8FhjDzBB6S7N3FoE-kA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeDPRd0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 13:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752604AbeDPRdZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 13:33:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A1721789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 13:33:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Pavel Machek <pavel@ucw.cz>,
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
        Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416133321.40a166a4@gandalf.local.home>
In-Reply-To: <20180416170936.GI2341@sasha-vm>
References: <20180416093058.6edca0bb@gandalf.local.home>
        <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
        <20180416153031.GA5039@amd>
        <20180416155031.GX2341@sasha-vm>
        <20180416160608.GA7071@amd>
        <20180416122019.1c175925@gandalf.local.home>
        <20180416162757.GB2341@sasha-vm>
        <20180416163952.GA8740@amd>
        <20180416164310.GF2341@sasha-vm>
        <20180416125307.0c4f6f28@gandalf.local.home>
        <20180416170936.GI2341@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 17:09:38 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> Let's play a "be the -stable maintainer" game. Would you take any
> of the following commits?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id=fc90441e728aa461a8ed1cfede08b0b9efef43fb

No, not automatically, or without someone from KVM letting me know what
side-effects that may have. Not stopping on a breakpoint is not that
critical, it may be a bit annoying. I would ask the KVM maintainers if
they feel it's critical enough for backporting, but without hearing
from them, I would leave it be.

> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id=a918d2bcea6aab6e671bfb0901cbecc3cf68fca1

Sure. Even if it has a subtle regression, that's a critical bug being
fixed.

> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id=b1999fa6e8145305a6c8bda30ea20783717708e6

I would consider unlocking a mutex that one didn't lock a critical bug,
so yes.

Again, things that deal with locking or buffer overflows, I would take
the fix, as those are critical. But other behavior issues where it's
not critical, I would leave be unless told further by someone else.

-- Steve
