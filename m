Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3848786-1523903418-2-7365559470186676069
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523903417; b=KomQ84Oa6gnbWVcf7A3GdNsDupd3Btty7ILBzY1agMgZ+PDoXP
    9UWwL/N6NOB1e8gQRrojPJmaUCvQoUNtw0OU0Vpv6CexUUSSvUf/EA2WtPm2BNnE
    2J0dE5gIeg3DuKTernxsMlm5APnf5QP/rk2PTvt7oqrJsedR/jLRQYePxB0NCPSD
    GVzKtlnbeA031gOErJQhZ7W4CSIcMI8BcOYmgUPvTRRJQ3mUnMEi8pzoy0Qumgy/
    0M5D5mII0FjH/r0DKjMA6H59bPi5DLXTlPMMsBX47DFyKTRVlKEsXay8SbdMmIOw
    +Q33CSLOxpP9UcA1vhMorLmPKzwT1cxvLwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523903417; bh=IW6C25otmsZXYt1ljmPTz/MXUkV5cF2AF8a7QhWSeN
    A=; b=m4MaAy4GmnhagzgeQ4u04z4yvC+VYHPqnkpVyg1Azc1Ur7NTOO5RZtUPnh
    5V+aevzGGuIJZ731KYs1GcFOb08u0Jtw83XispzEy36AS3CH4KXi1OE8fsUTiwwF
    KzcpU690UwTOrjv7As3acm3Sx0dS5Z+F94yMc5XOZOLCbseg4lOiYKQXx+iimBUJ
    RBGgzCkl5viOjk6D0QaLOy3G5+2Vhg3mIi81YGWpkCGQF81n/Mg6ZffmLaKr4Y2n
    eiLpt9v++6RVgwsBR+1D8QE2ZLtpEG2ja2ZvplHc3QYYaJvcLRxDWplrcyXw90sb
    3qwUyTLUtUXxL9oPqX35IqZLFPmw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YYyCjsDj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Rwo7VX3y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FJq8Xu4P;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YYyCjsDj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Rwo7VX3y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FJq8Xu4P;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBHFGb5c1V2+GPbHhZnZn5tsugyS7MgoL4FaHlWmdsdc21ZDznWCGr381ZKukeSV+bBUC8t5FEKpd2ZZEPFyWqxOcQrszuZxloRWhXl77oSoiE0r8cL9
    cwwdZGD5zgRrFfxvVLeNu08iDOZOl80v8wN2DDSyK4y1SuvzY6pCgoIz8nkmb8LoO5JrMT1EY8XcSl0OS32ZxWMb/Sc48PX/BNjr8pIe+DDGIPo2uaByGVKi
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=Z879h1h2krkcHNkK6e8A:9 a=QEXdDO2ut3YA:10
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbeDPSaK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 14:30:10 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36128 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753051AbeDPSaH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 14:30:07 -0400
X-Google-Smtp-Source: AIpwx48bLxOlrUmg8z/7gXUcCw0fWIn2R1s7pdTzANStDiUe/s+tSWXv3x8XLJ/C4Dr3PhMBR3qkM0UX9xrMBgcntio=
MIME-Version: 1.0
In-Reply-To: <20180416142653.0f017647@gandalf.local.home>
References: <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416122019.1c175925@gandalf.local.home>
 <20180416162757.GB2341@sasha-vm> <20180416163952.GA8740@amd>
 <20180416164310.GF2341@sasha-vm> <20180416125307.0c4f6f28@gandalf.local.home>
 <20180416170936.GI2341@sasha-vm> <20180416133321.40a166a4@gandalf.local.home>
 <20180416174236.GL2341@sasha-vm> <20180416142653.0f017647@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 11:30:06 -0700
X-Google-Sender-Auth: F3cv73b2qyzCLTZ9np3_zUx3vHE
Message-ID: <CA+55aFzggPvS2MwFnKfXs6yHUQrbrJH7uyY4=znwetcdEXmZrw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
To: Steven Rostedt <rostedt@goodmis.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:26 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The problem is that it only fixed a critical bug, but didn't go far
> enough to keep the bug fix from breaking API.

An API breakage that gets noticed *is* a crtitical bug.

You can't call something else critical and then say "but it broken API".

Seriously. Why do I even have to mention this?

If you break user workflows, NOTHING ELSE MATTERS.

Even security is secondary to "people don't use the end result,
because it doesn't work for them any more".

Really.

Stop with this idiotic "only API". Breaking user space is just about
the only thing that really matters. The rest is "small matter of
implementation".

              Linus
