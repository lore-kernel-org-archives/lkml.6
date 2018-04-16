Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006321-1523908690-2-1549697115144050188
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
    1523908690; b=f+bZ+k3apHjhBz7cTql5OnP5ncfviFayF44hCbNxAqYoa7UNkZ
    4GtlHsIpbgXMtTWwJ9fgroFblGuiiu+gKhphAaeOrGgRZH58YerH+Lj1o/pQragP
    meVmLYN0XPQ/IX3MkKha1La3yrAnwCM0hHkIteW1xYvxnLZL9WeHe5jOQfIfzYrG
    lw/PSqN8G4Mb2DXTA/TvrupuTT8FhBNjmKQIDC7Rf0w+5fhvVVHVS9aAtFiB7D+m
    O7YrhqjvweUrJ/sz0KwevLMDPgITnxPGQ+QAyoMuiHHd5ewKtgzOVoGaqtYgP5T+
    l25YmN7U8aHdAsdNnsMDMYOq18Mq9uw7SpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523908690;
    bh=qI87fuY1lTi8O1L5KrnSrr1GzwHTNr9VxdiWqk6ksEA=; b=rUgO0RYpiI1E
    S8lEnfU4wWTWQCrssyle4NdTQACQvP2YyaCpFWnUTRztjofJas80FwfDCtcJqrdF
    InlomLynCCKp3zxse8Lgm2Y5OgjRVyDjhR/evWAI2nUBPq/35H14pI+hFYdbkO0t
    l/GR8/8YA0+XJa1hq+75YQ6shMnSyvMAwdmhpXkKHev1+pO04pRSCJvVOsYHUWiv
    HSmg1sg75a8FreEy1f0iWWJ7mLCgtHCWQy7HTH7ClovB9m2pgFj3jLyLpt79yZu1
    cHNd0HVYEcHI8GqlRLGGwn+vmiv+gDMMepHB4U66rdf9Ckm3hM3YVXdmXXac+uJ5
    UaLM4FaYsw==
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
X-CM-Envelope: MS4wfPT3aqj6IEnPkgQWWdM/dTJy2Uty+FNL6UcjAREb4HHZMd+6TpzACsEaeNFhwpUuYGyV8ah7XxRzrBEIYDh+l9l4YE6e1HS4ToL2/z4LDFjSy7SdmZUn
    A9zlWQwMQ3idY1hEdKSAjrvoGLSmFdqTyu8OQu8XgxWJ2bw6LBSjU5ohIDKwxvPkBWqdvcvKOgXie+sJRr8XjUKcuuuOLlLvgZpnGNFR6XZ1MjsKVjFzfo3i
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=KnVkNnk21E0WwqTMCN4A:9 a=CjuIK1q_8ugA:10
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeDPT6I (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753269AbeDPT6H (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 15:58:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBF0217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 15:58:03 -0400
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
Message-ID: <20180416155803.00aaa5d7@gandalf.local.home>
In-Reply-To: <CA+55aFxVg4FOhvxcrqi7Fs8ohsgSh8DURu3ESbovc_sBxxxpiQ@mail.gmail.com>
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
        <CA+55aFxVg4FOhvxcrqi7Fs8ohsgSh8DURu3ESbovc_sBxxxpiQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 12:31:09 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> But the -stable tree?
> 
> Seriously, what do you expect them to do if they get a report that a
> commit they added to the stable tree regresses?
> 
> "Revert first, ask questions later" is definitely a very sane model there.

The topic of our discussion is on what to backport, and how likely is
it to cause regressions. I'm arguing that the bar for backporting
should be raised, and that only "critical" fixes should be backported.
Sasha pointed this bug fix as an example, and asked me if I would
backport it under my conditions. I said yes. He then said "it was
reverted", pointing me to the commit that fixed it. That confused
me. When I looked further, I noticed that it wasn't reverted, and since
he pointed me to the API fix, I said "I hope it wasn't reverted"
meaning I hope they backported the obvious API fix and didn't just
revert the original fix.

-- Steve
