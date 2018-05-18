Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3608381-1526631047-2-7535435640260325479
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526631047; b=cDwA2n3tAdVhpNKXebtN86uq2yyOTtCjtW+DfPtLB0xVmH73yI
    7ge4eNXI+CCKrc2eX884Gq1rT5pWno54eEpI7he3SEgPo0DeZ1qn3ecnCXtHbSQs
    /T76q9ACPgAW2dvM0dnOP3hSSWPAyCAplJcULlWykExsUmvIIGT6r038bxZFUBON
    9jGRHyWTS30xozLzXAYByTddzOnw8wLZLhgX78P418Y96Xop6xh8ysXxNplqa1lf
    Yy0R+b1yw7RYblGey3TMp7LN+/yWf7tBtc/7GFjN8qmAL+n4QpyxtI+54eISnJzX
    mm/qNgETLXhXk2Lb4d2NeLuWZqF6vRd+36QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526631047; bh=S5L65dT2zX3NtbJa0gK/XFbHqSiJ/S
    T4cJdY2aE5P4g=; b=j0T8UykPyn/35aJaTtFxJGJZ8/4yMIKd6DPvOzQSPfeFpV
    yVTsZPe6EQqE+3WaMCNUtztrxREKv122OnqdNKgLStcbo9fjpALENSrw+jZPeAQ5
    +OyPyCaoDXegGSUqI2jGqqRfgG8A6G/7jF4Vd2JJAiEb6JKUm1SHzLCu8x6ZBTti
    qB8PJecQbC6IluXr738ZKJbLlq6pF5+0mgLh8lSiA0XS9sfSOejyAHQvCD7q0M0U
    AMGShpm423AOyUhlrm9L5rL0X9yrlNuZsTxiLh72jL74yg07FswsQcgA5OSLPbjN
    zW9SMzwwO5KXb9l0UHEOsLWyBlYu3x9k2uKMYv+Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE80dl4P6xhDw+d2Ljh5FhM6TLo4xwluCTOtb8KUe15zntgCG0JI0FwPNhKLG4YJ4/xlK5ROOfGS3Y5jFa39fyZSA1sMfLOy0zF+k5LnMc8EraZbYDjY
    HML4KD8z1dZGzQYWHbt3qswKjkzzxeQovWn5dzdUeB4lKLji4N775abMpudOKzrDMwEG9tnDwAE/tp7Oif3oLnOyXTOoZPUfMZis2PPBoPqRacMAr8KMACvT
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=duh8Emjzx6I4phTU5RoA:9 a=8tLWTKrKbwFN5ya6:21 a=d0rtWwwguYIzyjiL:21
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbeERIKq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 04:10:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:38641 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbeERIKo (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 04:10:44 -0400
Date: Fri, 18 May 2018 10:10:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180518081042.6n6guianv3v53e4f@pathway.suse.cz>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180518020705.GB1160@jagdpanzerIV>
 <20180518063820.GA1504@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518063820.GA1504@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 2018-05-18 15:38:20, Sergey Senozhatsky wrote:
> On (05/18/18 11:07), Sergey Senozhatsky wrote:
> > 
> > if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK) ||
> > 	raw_spin_is_locked(&logbuf_lock)
> > 
> > just to check per-CPU `printk_context' first and only afterwards
> > access the global `logbuf_lock'. printk_nmi_enter() happens on
> > every CPU, so maybe we can avoid some overhead by checking the
> > local per-CPU data first.
> 
> Nah, may be it won't. This, probably, would have been the case if we
> had continue to call console drivers from printk_safe section [at least].
> CPUs don't spend that much time in printk_safe sections.

Yeah, I do not think that the more complicated code is worth it.

There is really minimal chance to hit printk_safe context on the given
CPU. The eventual win would be negligible to the cost of printk().
In case of trigger_all_cpu_backtrace(), most CPUs spend a lot
of time waiting for the spinlock in nmi_cpu_backtrace() anyway.

Thanks for the ack.

Best Regards,
Petr
