Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3069754-1526409340-2-17911939018331545809
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526409340; b=b6E/X2mJPEYVpzE6mcynsNvnVe4fgHvwbRc2eNGaa1W3zGtozf
    NlXIQOrWuzYTGnmd9UDSyQfvmr6eld/9byNGtY/aoZGzfdfEehrlOVm4aL76oWC6
    jQyR3pxOgs+xs2mTOmCzBFyz+txpIYSa7SRqno0Q/9amz+IN4DQxzKg7VodBHBWu
    H73OsS/T7EcAkFB14M1hOgzET6yb3KOKoqSc9eAXDCwNnYalBgZgbALFbiXmfN7D
    7Um8jFbiTUW9tCIDWs3P87iRyf1zzKhsME2sQNMf6uRWXg0RmDML4hxjaqUo0bQY
    yRDfbPoraU3XRc55zacv+HWJxYYelA4Tav4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526409340;
    bh=gfpUCpG9y0kZiVtVbZRGJRkcfeYPcfkOkEIxpdU+LPs=; b=gH7zHKPTFKcV
    yPvIho7v+KLXYaqYi15dMisSjNV1YbUSwk9KY+ZboKoG6re2nuTE6Q4UL4Qirgf2
    TBD2RT7g/ZSKX00IQy2ywyeuuCAk6kCZaI9jT2qe6mDy4LOXCP1dF+VUaOKZZTpA
    JqF54zRQYxcjpSUzSDAyDmPnyucStMgKCdWngKEtOdDrrfBqfKUDJGmYFaA61wOO
    e+JIdu9MUd/Z71pR2AhwuYkKaiZ6kbYjYZYpdwJoiDSU06FBp3FL82hpP4qrIryg
    JHNWZW9XoOn7Gdmc6HcmoMAqduVm/llwpSxqDi3O/psld5XRQ+sqVEjz5pos7gpQ
    y3xFRT9ldA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIBpNP2Ge0sOXLClogqoTXMUFLW51/WHMFVwOonpfhxPe2V/E6HaGqGnJFsbYm6ArZPKVC6COpZGHkTbqTBVIjhEbEM7j2X9aIWiQ3Q7Kk7uxQwYXiaQ
    6ydihIW63DIrVdKme39R8KXWiy7itGI07IjfeSG1EvmoMpnaP6ARmxJgCemlCWk/yBuJP0kNHsIWEUOkUdLgCNT+cUdiInZS7DK1edvXkQcOZgj9Jx+at76r
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=WQhqEe2HgKeNbJqoAeAA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeEOSfi (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 14:35:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752668AbeEOSfi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 14:35:38 -0400
Subject: Re: [PATCH v3 2/2] locking/percpu-rwsem: Annotate rwsem ownership
 transfer by setting RWSEM_OWNER_UNKNOWN
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-3-git-send-email-longman@redhat.com>
 <20180515175805.GN12217@hirez.programming.kicks-ass.net>
 <1baa1a1a-a4a7-d706-8c01-5ff6a8757f97@redhat.com>
 <20180515180549.GP12217@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <fcdd9ebd-05b9-30b1-877a-db84aaa96770@redhat.com>
Date: Tue, 15 May 2018 14:35:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180515180549.GP12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/15/2018 02:05 PM, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 02:02:00PM -0400, Waiman Long wrote:
>> On 05/15/2018 01:58 PM, Peter Zijlstra wrote:
>>> On Tue, May 15, 2018 at 01:38:04PM -0400, Waiman Long wrote:
>>>> +/*
>>>> + * Owner value to indicate the rwsem's owner is not currently known.
>>>> + */
>>>> +#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-1)
>>> It might be nice to comment that this works and relies on having that
>>> ANON_OWNER bit set.
>> I am just trying not to expose internal working of rwsem, but I can
>> document that one of the bits is the real deal without specifying which one.
> Thing is, you don't want someone changing this without knowing about
> that one magic bit. It doesn't hurt to be explicit here.
>
> Also, do we want -1L instead of a -1 literal?
>
Yes, I should -1L instead.

Cheers,
Longman
