Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3782214-1523900670-2-8199498125734441557
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
    1523900670; b=fht2evxfr0GSCUvZN61kdmh9Wsos4D5vweyBRe7Lo5A/CSjpEe
    6kqIM0UXmaaOJZW/jvPJ2OLvauNxEpYrEIpMOjgisJj7ecnGIZHe9yfE4YzS7/q6
    ASypfYIVntZ2GrcGGsy7iUdX1KHd0ifJxvPdGWRoW5Nk58WTsp49LnEViAiBSh1P
    qUoF6ktTQYgHENQLrRRKgIwi0UvKBZc53pufFx8/ewVoh24guhIf+gSfLVJ4VwkX
    rxn6TLRuaBGXNiM4aNtfrbH8E7La5EE2eE9Rw5ovV9ZHcY8A55Quksk51UJ9AbYP
    fZT+sDPQ/0tnJMdK2ZcjoEWnht5Naemx+3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523900670;
    bh=IjImT+B/ZwzEU5wK02yKx6IFhnpMIS9yw7tbzC/HzxY=; b=kCq//ivQVJdn
    Jzt6ZPQVCZ+oIIA/iNaIfiILYi44PrWpvcH2h9qaHpZMAhn0eEuN++qK3Y4s3HsA
    vdXVqa2/8YLt6pHzoQqE1fLN+Qww+urEbfte1zZprj+3X3TlaumIl0WQj36mzxAo
    6q/CFooH7pfgZwgU5vcZB7VrGyz8g6O9jUboQAIidDp+pksYkckMhK4kr4LOf7+i
    euMaikArB31qHXjUheBrN7dsf4peUDf8qSJaXyYg1fVXWVQM98MfzhHoKVyHoraw
    7Bdbkr5To+MbrYvzJ4ZENhHpurnEa8qxW1lMX0hZkh0oDNS1jIb+oD9fdM0ff32F
    Gwu2N9JBrQ==
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
X-CM-Envelope: MS4wfPt7hU6hfAav+JXBAF65crqXrdPAZDfbVIfb+KMOvtDpZ8E93xmofAiXeXxT2uZzOP9x5F+4+DR4Mg1lk5ASW8e68cpeG0kN7HbkXZ8i2JEVNCvWm5OX
    cwa9kaAXpISCr0xOPtKLkdZbsZ1qTSEbTHBNxERcZcnKp/HAdAe/i5ikQUXUB4LkJf96vJb2qs5LBtp+3iatVbOZMbpRw2td1db37qhVulEvai5N1/bzaryW
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=R5iCcuE7m3DCqLyTV6YA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDPRo2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 13:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752177AbeDPRo1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 13:44:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D0E21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 13:44:23 -0400
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
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416134423.2b60ff13@gandalf.local.home>
In-Reply-To: <20180416171607.GJ2341@sasha-vm>
References: <20180409001936.162706-15-alexander.levin@microsoft.com>
        <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
        <20180415144248.GP2341@sasha-vm>
        <20180416093058.6edca0bb@gandalf.local.home>
        <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
        <20180416153031.GA5039@amd>
        <20180416155031.GX2341@sasha-vm>
        <20180416160608.GA7071@amd>
        <20180416161412.GZ2341@sasha-vm>
        <20180416170501.GB11034@amd>
        <20180416171607.GJ2341@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 17:16:10 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

 
> So if a user is operating a nuclear power plant, and has 2 leds: green
> one that says "All OK!" and a red one saying "NUCLEAR MELTDOWN!", and
> once in a blue moon a race condition is causing the red one to go on and
> cause panic in the little province he lives in, we should tell that user
> to fuck off?
> 
> LEDs may not be critical for you, but they can be critical for someone
> else. Think of all the different users we have and the wildly different
> ways they use the kernel.

We can point them to the fix and have them backport it. Or they should
ask their distribution to backport it.

Hopefully they tested the kernel they are using for something like
that, and only want critical fixes. What happens if they take the next
stable assuming that it has critical fixes only, and this fix causes a
regression that creates the "ALL OK!" when it wasn't.

Basically, I rather have stable be more bug compatible with the version
it is based on with only critical fixes (things that will cause an
oops) than to try to be bug compatible with mainline, as then we get
into a state where things are a frankenstein of the stable base version
and mainline. I could say, "Yeah this feature works better on this
4.x version of the kernel" and not worry about "4.x.y" versions having
it better.

-- Steve
