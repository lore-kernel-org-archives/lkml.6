Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006321-1523907008-2-16889382545942680250
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
    1523907008; b=HdwTucwynNUbKIXhKB5x+EGnl9GvwFnVXo88MPrY890n7unPEN
    Eyj4d+7Loi43fcWP55QU/QDspzJv6OkTvWK2Fg7E8LKjIti1bSBVabHrkmA+QNZC
    WJ9Nm9TDjb3AddMBIrnzSDVgBqez4ttVpd/66KIKZMWEkGOdNstREZTzvg8nHlit
    7kRnshHnga+iSfk0XsXbH8i2HE9vEIs9R2GXWa04MVKFOf+2gdv+Yqqc4a3Ioswe
    4iDK0D7YI+SkzwPv5Ibmt2HbsfoiF+MUofZhOdIoOGWocAHvbm8CnrVqEVKOcRrO
    rzk0NnfqG2to9cSvNvoQhXyPlUZDz+opIrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523907008;
    bh=Pe6M+U16HVxQdDPa5njeWmNI+NWaXI9sxSk86hsaLMw=; b=o/82Zw2RkSrb
    ZJGx1AApJ0zbf140uVckg0CGG0djKt0NyTDCkWGsr9YfpDuyHFgI285diQ6RmoMs
    gLKZ8w3rLI7wcTmzRAumTgezan2TrsnWBeQhAJyCPqMIn9hqE2AUczxGZYTAHosj
    PRM7QbcW7LElmDZSE8EYaJuhgL2ifRMgYVnCXzZUF6CHgmggoWcwpP5EPh+NYACD
    a9kqEDR5tysNYbiydmI6svuDSnIQjonNeAkefTc4k29rlt8JenY/Y5BwAYr4h3pN
    hszXpjLDWVH1rxI620/vEO/dGWwPRspTqfx9ICnUqlIij9A4ObK48xk8lx6COcH1
    7pXtQcujAQ==
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
X-CM-Envelope: MS4wfEL2rBCiakSQ4EPWg1UsecrX9BOVlShGJ+GDMzUpMekioHDUAWt04cV7zkK3vZ976MQW1jZii39tlXmp3P182/awLi+IawUzHfb9l4At/mjVMT5Xk7Qj
    WpjpsM/iNg22w1o1+pVZ1USMIQEbo0fntqUc8vhg8zLcuYPxPdRSKg9VrATbUPoNLtgo7Y1X8y1HPZ9AIKyZb565biXEkLPuj9CfLXOpSdhSpwmADbhCATex
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=meVymXHHAAAA:8 a=73OFXv_vDWMipwet-sgA:9 a=CjuIK1q_8ugA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeDPTaF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753206AbeDPTaE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 15:30:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA902175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 15:30:00 -0400
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
Message-ID: <20180416153000.3fc795b6@gandalf.local.home>
In-Reply-To: <CA+55aFz0obg3SmCpa7Ff2d91CATF8p-syYjkm4s5FrR+cp5XRA@mail.gmail.com>
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
        <CA+55aFz0obg3SmCpa7Ff2d91CATF8p-syYjkm4s5FrR+cp5XRA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 12:00:08 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:



> > On Mon, Apr 16, 2018 at 11:52 AM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > We're better off making *no* progress, than making "unsteady progress".
> > >
> > > Really. Seriously.  

[ me inserted: ]

> On Mon, 16 Apr 2018 3:24:29 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > I'm talking about the given example of a simple memory bug that caused
> > a very subtle breakage of API, which had another trivial fix that
> > should be backported. I'm not sure that's what you were talking about.

> 
> Side note: the original impetus for this was our suspend/resume mess.
> It went on for *YEARS*, and it was absolutely chock-full of exactly
> this "I fixed the worse problem, and introduced another one".

What you are talking about here isn't what I was talking about above ;-)

-- Steve
