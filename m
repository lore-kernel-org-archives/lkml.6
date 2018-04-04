Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-470151-1522859123-2-14717435776741170265
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522859122; b=Ak6SWn7d4JdxzIyg9kUzJGdHVarWfN67oGnry9bu+x3f5JKPiV
    LWyTz+ojo0+ZoATZp0bIyexVMEuzB7rlnGIhWK7oe++Nhtvg1Qn33Q5Nfp0+dsrW
    pyPS80+k9aYr1ZcjbJrTt8K4o/3d1bNaCC6ltJ0EA4kZmZ3uGb4uLWgO/P+0EY7a
    r3GmqxV51sZOO2EzVKlRCoRVW+qpYn9N+yklVMVpQjWn8oKY+Y4WJB0+5npxD0oo
    gr4BXx6Lf6nWv9Uth7U2JQCwCLlqRfyhbaPtorImnbjRykUrOIrjTODIMh8oMaOA
    NRZv5thxcU3+IWKQGd1y4ibMWgXy2fS93G7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522859122;
    bh=irXUMwZmnGXyKEzVzMkQ+o+jU6E2OUuCmBk2W+Nvkjg=; b=qzqW4ezVxVnu
    MSNF5XOLNx2gmHOpQ0aoYhDpCtFY59K16B7Y/DFWp58UAEf26lnEWPiQz2O202QY
    Ekwz6tVtlCmElU2ijkRHB/1R8+A6X0ENAEfiYsYBGFqcohkMgegOfE/+w5ElwB8G
    sJnQQf0Sno/j/oryV4y4oOgOzjQbpDExwu9FT/pKI3OSoc2UjRJ3q+JUBnn1YlE8
    jHwUnvS5rz6ILaGEnaqoXClEXRWn5DGJ0SZmnmKrz8kGZ8ZqLGRYbVgUxRHVcMnI
    0ycJ1Np0YcGE+wbBeBRNOfxnSmMXICPjBNxh6DDXg/2KeU00sqFFfkaZpj5UAqId
    xMvoAYi9RA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBFVdZhB3BkUj3COcnRe4ho68zfkE8BdBcM79SFJmuFGTazK1TG38q0a76936TIsZ8gIsy57DHNw4IWKu7USF4/Hv+R9IrsqrovJRgRvE9BNYCWfecvQ
    i/PF3oSRvEUMtEj0VpkcQPxhucFry46yadfauEnrhwEOrnh5nD6A0/QXgz7EodskxeCIB2VCGq49jZxlLmNg0B0CVQZj+2JurY5PBZZoweaUOF2baYu2j3w/
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=KIOjnaEbyqMKDg1P-y8A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeDDQZV convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 4 Apr 2018 12:25:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751887AbeDDQZU (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 12:25:20 -0400
Subject: Re: [PATCH] locking/qrwlock: Give priority to readers with irqs
 disabled to prevent deadlock
To: Kirill Tkhai <ktkhai@virtuozzo.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
References: <152285543936.4080.5025412328012618076.stgit@localhost.localdomain>
 <20180404153534.GI4043@hirez.programming.kicks-ass.net>
 <3c9b507c-c6bb-3e13-2a82-f3504626d016@virtuozzo.com>
 <af5e2a7b-7dec-6bf3-08e5-f6c4ebaf59a5@virtuozzo.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <242ecfc9-34c9-dfc1-bd36-b9073fbcde93@redhat.com>
Date: Wed, 4 Apr 2018 12:25:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <af5e2a7b-7dec-6bf3-08e5-f6c4ebaf59a5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/04/2018 11:55 AM, Kirill Tkhai wrote:
> On 04.04.2018 18:51, Kirill Tkhai wrote:
>> On 04.04.2018 18:35, Peter Zijlstra wrote:
>>> On Wed, Apr 04, 2018 at 06:24:39PM +0300, Kirill Tkhai wrote:
>>>> The following situation leads to deadlock:
>>>>
>>>> [task 1]                          [task 2]                         [task 3]
>>>> kill_fasync()                     mm_update_next_owner()           copy_process()
>>>>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>>>>   send_sigio()                    <IRQ>                             ...
>>>>    read_lock(&fown->lock)         kill_fasync()                     ...
>>>>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
>>>>
>>>> Task 1 can't acquire read locked tasklist_lock, since there is
>>>> already task 3 expressed its wish to take the lock exclusive.
>>>> Task 2 holds the read locked lock, but it can't take the spin lock.
>>>>
>>>> The patch makes queued_read_lock_slowpath() to give task 1 the same
>>>> priority as it was an interrupt handler, and to take the lock
>>> That re-introduces starvation scenarios. And the above looks like a
>>> proper deadlock that should be sorted by fixing the locking order.
>> We can move tasklist_lock out of send_sigio(), but I'm not sure
>> it's possible for read_lock(&fown->lock).
>>
>> Is there another solution? Is there reliable way to iterate do_each_pid_task()
>> with rcu_read_lock()?
> In case of &fown->lock we may always disable irqs for all the places, where it's
> taken for read, i.e. read_lock_irqsave(&fown->lock). This seems to fix the problem
> for this lock.

One possible solution is add a flag in send_sigio() to use a
read_trylock(&tasklist_lock) instead of read_lock(). If the trylock
fails, returns an error and have the caller (kill_fasync) release
fa->fa_lock and retry again. Task 1 has 3 levels of nested locking and
so it should be the one that does a retry if the innermost locking
fails. An warning can be printed if the retry count is too large.

-Longman
