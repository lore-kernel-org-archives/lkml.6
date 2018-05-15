Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247740-1526419840-2-3621738983197900901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526419839; b=Y/92vrrzwaxy/Mqq/ihZaQKQpGfcH3ngIfZAUSQOVmwJ48zujc
    GFyKCmZSBIJNza9sqnyHAH3eYY0BezOsCmu1ICHECeHU1CqIyeCmDmIWOpwrHCzI
    gHOYUKYomAAAVG7XN0mRnITVNPSln+W+d2/uTfi2Yhtd2hdgzf/EBSKSuk9R0El6
    NcfLJFFWAAGetMJFWSP4ypOtxhIj7oLIVcgK/1mfn4rCD9P+MrTJjNw63rBN3sVi
    6A7mZne0jRMepKmBEV6DiRd8IqtIdm4Jgcwpbn0YcI1FxUCrBgdJ+mDG1FX/YdO0
    2+UIKxvnWawV0Is1xQG7ucSrcGMMlFwqh/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526419839;
    bh=cgeg+pNHMQmSjdmTzgcRir7ZsKLZd553ebJzpSiZxj8=; b=h74ysklUNOaW
    +Rqg58qNgbn44cYHBpsvDWsh0VBUQL91wN7TZcER0PCAgFT7KDG7mkXNm+MhJidj
    MW60k9vGW9X0y7qLVii7/s4JS5URlM2dVn8JNYPqVyGY9Qt/I7flZ+J0wIm/hDAR
    rJaPLJ4ZOqe2Hhfn+WHh4XXpXgEwpMzf/qKqazleefxkQ4Wfi9Mm4xRy8c6aM7JE
    eZRKVumzjSP1WBizjQ5GD7n4H22uZAGwmeo4cW/9NEeAtSwn8QH8mbXZHPKEkwom
    bK5NO/m1W7cfiauyL5K/E81tJSpIDTCfqvYTKQSO9cHOBLm9SqgS7yv8nDAjXbrK
    izA8kw67IQ==
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
X-CM-Envelope: MS4wfNBucn1bMZisqKiOqMc0vj7fNWOrZb71+qNvLTvahViq/sP54C1vS/prR6aXizR64qPkd1TzC7L30TKie0AbGjMFO+oHGSgGUjPXhr0oXDD55e+8hHli
    o7+VYqiJUk3CiC/ILO7nVB8yxcvZS5CD5j40fEYmK7xXtGAFJEYnFRIbLhkRiFkRRqq7TRaus6FB6aIELzbgr2CyR88nGRM6ff4NGsLwX0hmYLxrIjJJEYms
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=lVgIdfSm5OgsJObx6C8A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeEOVah (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 17:30:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752024AbeEOVah (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 17:30:37 -0400
Subject: Re: [PATCH v3 2/2] locking/percpu-rwsem: Annotate rwsem ownership
 transfer by setting RWSEM_OWNER_UNKNOWN
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-3-git-send-email-longman@redhat.com>
 <20180515175805.GN12217@hirez.programming.kicks-ass.net>
 <20180515180219.GA6612@bombadil.infradead.org>
 <4a3fbd3c-3cfa-f9c2-c73c-fa6d9c55c2d5@redhat.com>
 <20180515212130.GA12204@bombadil.infradead.org>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <65b6a078-a063-dc9b-d2de-ec7d37831cba@redhat.com>
Date: Tue, 15 May 2018 17:30:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180515212130.GA12204@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/15/2018 05:21 PM, Matthew Wilcox wrote:
> On Tue, May 15, 2018 at 02:45:12PM -0400, Waiman Long wrote:
>> On 05/15/2018 02:02 PM, Matthew Wilcox wrote:
>>> On Tue, May 15, 2018 at 07:58:05PM +0200, Peter Zijlstra wrote:
>>>> On Tue, May 15, 2018 at 01:38:04PM -0400, Waiman Long wrote:
>>>>> +/*
>>>>> + * Owner value to indicate the rwsem's owner is not currently known.
>>>>> + */
>>>>> +#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-1)
>>>> It might be nice to comment that this works and relies on having that
>>>> ANON_OWNER bit set.
>>> I'd rather change the definition to be ((struct task_struct *)2)
>>> otherwise this is both reader-owned and anonymously-owned which doesn't
>>> make much sense.
>> Thinking about it a bit more. I can actually just use one special bit
>> (bit 0) to designate an unknown owner. So for a reader-owned lock, it is
>> just owner == 1 as the owners are unknown for a reader owned lock. For a
>> lock owned by an unknown writer, it is (owner & 1) && (owner != 1). That
>> will justify the use of -1L and save bit 1 for future extension.
> To quote from your patch:
>
> - * In essence, the owner field now has the following 3 states:
> + * In essence, the owner field now has the following 4 states:
>   *  1) 0
>   *     - lock is free or the owner hasn't set the field yet
>   *  2) RWSEM_READER_OWNED
>   *     - lock is currently or previously owned by readers (lock is free
>   *	  or not set by owner yet)
> - *  3) Other non-zero value
> - *     - a writer owns the lock
> + *  3) RWSEM_ANONYMOUSLY_OWNED
> + *     - lock is owned by an anonymous writer, so spinning on the lock
> + *	  owner should be disabled.
> + *  4) Other non-zero value
> + *     - a writer owns the lock and other writers can spin on the lock owner.
>
> I'd leave these as 0, 1, 2, other.  It's not really worth messing with
> testing bits.
>
> Actually, if you change them to all be values -- s/NULL/RWSEM_NO_OWNER/
>
> then you could define them as:
>
> RWSEM_READER_OWNED	0
> RWSEM_ANON_OWNED	1
> RWSEM_NO_OWNER		2
>
> and rwsem_should_spin() is just sem->owner > 1.

I would like to have owner equal to NULL if it is not locked. If it is
locked, the owner can be used to get information about the owner. So I
am not sure your scheme will work.

Cheers,
Longman
