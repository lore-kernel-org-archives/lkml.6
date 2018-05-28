Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-726422-1527523869-2-17494524288286258290
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527523869; b=HV+YAupFCstuYVasKjvCvvEGO4rFSi4qW2EOTw1ii6QazWZVr2
    vv4UB92OvQCYzJwS6lKTYVL4kL4dQ2qlpfLyK2e5q/VGtqChqCJz2WlfE+ZPN1jF
    KKVA48e6m4pSwJLSZUGQ/6YHKtHAEFk7sESLyybiDEbOmKZgfkoQkLfVihdt5xbx
    0EKa07+F6aWGpFqMXA05eWT97xI3mJKQHpm5qpE+0XLh4bXoCcWQ3lqfgB++x77i
    zhqrxo5QjhDTDheAspKPWV7uvcU9E+bIg5g3vYC3j85FXRQtHKGVDMpimEKstNR8
    Hs+Um0PcdYlrRsVpFDMTuD2F7rD3fYZtlwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527523869;
    bh=Zq68Cwe6iJKRZqH/PnWe6zu6DaoZNklENM1Rqtqd21s=; b=EBYPgZP2q07x
    1tUSYGp8B94zfJy53MRlIipb3dlsj1EBqV+nR/L6PgyNeRFnm60/o9NI4rg4eBdt
    bKg9X4dUw03VgDL8AbQycbYTGzHeShS5Dqx7i66u+kxBb2bi/zKMwm0MnXySdGtw
    NyqxGpnuObQPHW5X5YMt+FKN6xVEs6q3mjrCOouIB8JBqaqi4jsvnY4m4BduTWyb
    eBmFL1WLHvStcpH3lQNocWqB4VBpgA3ZJtY8m75qRaplYlWrcw1ZMSkHESzHZ5OD
    KXFTAjBTyfjDWMy06K50rffq6qCfzqL2q/lZOlDidphJhyA1cN1nj06hhdEluXBp
    TR+MUb4zTw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=EWLswC3n
    header.a=rsa-sha256 header.s=merlin.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=EWLswC3n
      header.a=rsa-sha256 header.s=merlin.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAgM1qCrgrQQcsLF7U0YW8vv29myJuguVFo/h1YOqMmgOfOoY08ii1SNI9djAg3WezKX4gPexyhZYjGyTa3h4xSyi7cGggEBGyzdVV3i5voWLZukvHAa
    IvZT19iebHiPLNTO3NWTuN5w20wgz/p46b4KCKlhsU36FUUT6qIzkaom2nrrUYFQiXhQCqEFDBCpphCo3em5t8VKHWZqHPwsfNcn834/mEAmxWLyUYLUIezF
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=2HiP65eQ2yL5QqEbaIoA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936918AbeE1QKz (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 12:10:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50290 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936814AbeE1QKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 May 2018 12:10:50 -0400
Subject: Re: [PATCH] doc: document scope NOFS, NOIO APIs
To: Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Dave Chinner <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
References: <20180424183536.GF30619@thunk.org>
 <20180524114341.1101-1-mhocko@kernel.org> <20180524221715.GY10363@dastard>
 <20180525081624.GH11881@dhcp22.suse.cz> <20180527124721.GA4522@rapoport-lnx>
 <20180528092138.GI1517@dhcp22.suse.cz>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d2f6c4c1-856a-d233-8610-67a868b856f9@infradead.org>
Date: Mon, 28 May 2018 09:10:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180528092138.GI1517@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/28/2018 02:21 AM, Michal Hocko wrote:
> On Sun 27-05-18 15:47:22, Mike Rapoport wrote:
>> On Fri, May 25, 2018 at 10:16:24AM +0200, Michal Hocko wrote:
>>> On Fri 25-05-18 08:17:15, Dave Chinner wrote:
>>>> On Thu, May 24, 2018 at 01:43:41PM +0200, Michal Hocko wrote:
>>> [...]
>>>>> +FS/IO code then simply calls the appropriate save function right at the
>>>>> +layer where a lock taken from the reclaim context (e.g. shrinker) and
>>>>> +the corresponding restore function when the lock is released. All that
>>>>> +ideally along with an explanation what is the reclaim context for easier
>>>>> +maintenance.
>>>>
>>>> This paragraph doesn't make much sense to me. I think you're trying
>>>> to say that we should call the appropriate save function "before
>>>> locks are taken that a reclaim context (e.g a shrinker) might
>>>> require access to."
>>>>
>>>> I think it's also worth making a note about recursive/nested
>>>> save/restore stacking, because it's not clear from this description
>>>> that this is allowed and will work as long as inner save/restore
>>>> calls are fully nested inside outer save/restore contexts.
>>>
>>> Any better?
>>>
>>> -FS/IO code then simply calls the appropriate save function right at the
>>> -layer where a lock taken from the reclaim context (e.g. shrinker) and
>>> -the corresponding restore function when the lock is released. All that
>>> -ideally along with an explanation what is the reclaim context for easier
>>> -maintenance.
>>> +FS/IO code then simply calls the appropriate save function before any
>>> +lock shared with the reclaim context is taken.  The corresponding
>>> +restore function when the lock is released. All that ideally along with
>>
>> Maybe: "The corresponding restore function is called when the lock is
>> released"
> 
> This will get rewritten some more based on comments from Dave
>  
>>> +an explanation what is the reclaim context for easier maintenance.
>>> +
>>> +Please note that the proper pairing of save/restore function allows nesting
>>> +so memalloc_noio_save is safe to be called from an existing NOIO or NOFS scope.
>>  
>> so it is safe to call memalloc_noio_save from an existing NOIO or NOFS
>> scope
> 
> Here is what I have right now on top
> 
> diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
> index c0ec212d6773..0cff411693ab 100644
> --- a/Documentation/core-api/gfp_mask-from-fs-io.rst
> +++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
> @@ -34,12 +34,15 @@ scope will inherently drop __GFP_FS respectively __GFP_IO from the given
>  mask so no memory allocation can recurse back in the FS/IO.
>  
>  FS/IO code then simply calls the appropriate save function before any
> -lock shared with the reclaim context is taken.  The corresponding
> -restore function when the lock is released. All that ideally along with
> -an explanation what is the reclaim context for easier maintenance.
> -
> -Please note that the proper pairing of save/restore function allows nesting
> -so memalloc_noio_save is safe to be called from an existing NOIO or NOFS scope.
> +critical section wrt. the reclaim is started - e.g. lock shared with the

Please spell out "with respect to".

> +reclaim context or when a transaction context nesting would be possible
> +via reclaim. The corresponding restore function when the critical

"The corresponding restore ... ends."  << That is not a complete sentence.
It's missing something.

> +section ends. All that ideally along with an explanation what is
> +the reclaim context for easier maintenance.
> +
> +Please note that the proper pairing of save/restore function allows
> +nesting so it is safe to call ``memalloc_noio_save`` respectively
> +``memalloc_noio_restore`` from an existing NOIO or NOFS scope.

Please note that the proper pairing of save/restore functions allows
nesting so it is safe to call ``memalloc_noio_save`` or
``memalloc_noio_restore`` respectively from an existing NOIO or NOFS scope.


>  
>  What about __vmalloc(GFP_NOFS)
>  ==============================
> 


-- 
~Randy
