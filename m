Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3647214-1523897602-2-8325883380029339826
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
    1523897601; b=ouerNhEVdg8hq52d3pDhcnVudM7y5kiQDLhTo1U+yR0dIWpoRE
    gnTmijftAwT/TjDbHHaQHppLNdXFovaYLAeo3wp294UXoVi+y+atzrqcRPIuUio2
    vluKXM5ERQyE/sD4/fbcZl9OyAVMY4B5G3wLgNpDmmkwcb7vrfDbO0lmerdpYVJe
    a4iynexLkBaxtyfInDwN1dtZ5ase/Poj+9oCweHnbGXMICNpcK52QtiNnafwEs2R
    1Irf22jxU6ci27ddeW52jJPYMVjd48sQnvBhVxAQ80dgzv9o1ccd2dOf0pYmgGTo
    REZq8P1rbMEGHuUcetD9jqwYD6iqwcqfd+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523897601;
    bh=SM/WEyas0YdD8ZeJRTpYIUKj54JwZN8u20zEsZUwsJ0=; b=SW6JGz14RuTX
    ID0b0t7zUb+mScGq2ikMgt5v6TQPDgYus2jWv2SX3d8drbDKcgXIrbN8Ryb0XZny
    kaTlHusNKHdfZNK1gyXAhPnxgCz75TJ0Cn3WhfwIk/YDtEWeegmeTuoLyLC992oT
    iAZ/DGhwwinhG8h5Ym7Y7UmdCQ8PFnMru930U/79Alv8sWBrx0ZJq423YPJJs0Qy
    QL94mi8k9ifMugxsyN3EUOjZBfncZqpr3K9T2Iu4N66fcvA2Ydm10DhBoxLudSkF
    AYQCrRRV0xgtEZaZSxm1tWbRB0XDEcaVJb8r1aCKcxnXMBbuYSq6cl6POo2dukl6
    nFDbThCKVg==
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
X-CM-Envelope: MS4wfOI6DXo1jfRWoaKyAeTKu4qRvwsaOvhAXCMsHZSbgmk/I3pB/QHAetRwJQd0hLCRTfVwz1x4MdszQbmqP3NnrIMmSlP2SQ0KWrwzsGh/GuYt0iMcObxr
    ACiFnR27mhFrgqiNnAWwTmLDutgfPp5T1wN6WHuOqOxUk9WN6Smu5yHRNvFn0i1ImUaKHHaURtYPh82tJ3v829CF2bK0v1C5S4rrRLLyzBiAAiQ2skS0RGTR
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=1ITkU6B9KL6Jdgch7I0A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeDPQxO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752975AbeDPQxL (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:53:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDCB21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 12:53:07 -0400
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
Message-ID: <20180416125307.0c4f6f28@gandalf.local.home>
In-Reply-To: <20180416164310.GF2341@sasha-vm>
References: <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
        <20180415144248.GP2341@sasha-vm>
        <20180416093058.6edca0bb@gandalf.local.home>
        <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
        <20180416153031.GA5039@amd>
        <20180416155031.GX2341@sasha-vm>
        <20180416160608.GA7071@amd>
        <20180416122019.1c175925@gandalf.local.home>
        <20180416162757.GB2341@sasha-vm>
        <20180416163952.GA8740@amd>
        <20180416164310.GF2341@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 16:43:13 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> >If you are worried about people not putting enough "Stable: " tags in
> >their commits, perhaps you can write them emails "hey, I think this
> >should go to stable, do you agree"? You should get people marking
> >their commits themselves pretty quickly...  
> 
> Greg has been doing this for years, ask him how that worked out for him.

Then he shouldn't pull in the fix. Let it be broken. As soon as someone
complains about it being broken, then bug the maintainer again. "Hey,
this is broken in 4.x, and this looks like the fix for it. Do you
agree?"

I agree that some patches don't need this discussion. Things that are
obvious. Off-by-one and stack-overflow and other bugs like that. Or
another common bug is error paths that don't release locks. These
should just be backported. But subtle fixes like this thread should
default to (not backport unless someones complains or the
author/maintainer acks it).

-- Steve
