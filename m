Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAA0ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981312082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgLYO6kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981312082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeJ3F0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:26:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39407 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbeJ3F0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:26:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id p11-v6so7130576lfc.6;
        Mon, 29 Oct 2018 13:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xoROp14gpVcYrnHpanBIcwQXTn+zarzVVmX341Y2MGo=;
        b=ZgLYO6ktDKWE8nwlBLwYEAvIITbNAwmN2nbaOfoGc2SkAy1mIgkxE+e+KiueKVUyM7
         tcuhmKpm2OsOUSthP8WKmze4K+U/bU5b82GDSzaWDzoimBhC/icW7BoAWiM86aF0yTFM
         mSU0RQK5oYbC36tevv801EzhhftwHtTkNHrPUCqRMhan3Kr7GEDyw6hXrmOPjXGgNjFv
         b6/nSaOf3rFDKwRY/2/+n4cyepQ9chQy+Z/oPXlzWfXclCOEyryxy954anxZkxd/pxWv
         kaii2x0K7MdcBOcP/y9P9udgGk/74jIhY98mRt3iIxWoK+QjLeukagDL+r3Pw2w3l+mz
         uzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xoROp14gpVcYrnHpanBIcwQXTn+zarzVVmX341Y2MGo=;
        b=tqYHO9Msmr5SvOwY3+fPOteyO5C5UfHZXvv5fI9UeymWnqsOKRHn9wfGsZHFDRI9av
         KjQmgw9jgEInqH94yOqmPglRZOF3YueImum+K9nILzfW18Iqio7t/goKfFKqBVQYEdda
         8mu2lyrCbYv4nb8jZpPvEMVFoSHVCDoY0v+/r8JxPJyleFyQ6Y/olnZZ8um4O/1SP+Fk
         Oki0JlWTyJH/wFDO3x9uQRMypish5+zMQobjuln2e3lq/lpRHasr9MYg6TmvqCeoPGur
         6KXghe5i9LXXp9CBi2QHl+/pV6FuVccMUX+Vt00x4gJKL1ADIfp8RDO5m8RtN4Jk04MB
         PElQ==
X-Gm-Message-State: AGRZ1gJIMzdtzvmUHjk5G/TgD8jbLHftvcOtJrGdyewl0EBtXpSxM3fj
        HcmUl2ZM+8kjyP63lJefeHh/Gt/88iA=
X-Google-Smtp-Source: AJdET5cSRWcuRdnyf6N20sMcTngnAIq6L/3huRMkYVlpn02LRjkV5zy9SzlMT15UTyLO/2uqkGF0yQ==
X-Received: by 2002:a19:1019:: with SMTP id f25mr150184lfi.54.1540845345157;
        Mon, 29 Oct 2018 13:35:45 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id 71-v6sm3662973lja.90.2018.10.29.13.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 13:35:44 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <cb42d84d-082a-e1e5-7b71-95c2c4a44d0e@gmail.com>
Date:   Mon, 29 Oct 2018 22:35:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026092609.GB3159@worktop.c.hoisthospitality.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2018 10:26, Peter Zijlstra wrote:

>> +- Kernel code is protected at system level and, unlike data, it doesn't
>> +  require special attention.
> 
> What does this even mean?

I was trying to convey the notion that the pages containing kernel code 
do not require any special handling by the author of a generic kernel 
component, for example a kernel driver.

Pages containing either statically or dynamically allocated data, 
instead, are not automatically protected.

But yes, the sentence is far from being clear.

> 
>> +Protection mechanism
>> +--------------------
>> +
>> +- When available, the MMU can write protect memory pages that would be
>> +  otherwise writable.
> 
> Again; what does this really want to say?

That it is possible to use the MMU also for write-protecting pages 
containing data which was not declared as constant.
> 
>> +- The protection has page-level granularity.
> 
> I don't think Linux supports non-paging MMUs.

This probably came from a model I had in mind where a separate execution 
environment, such as an hypervisor, could trap and filter writes to a 
certain parts of a page, rejecting some and performing others, 
effectively emulating sub-page granularity.

> 
>> +- An attempt to overwrite a protected page will trigger an exception.
>> +- **Write protected data must go exclusively to write protected pages**
>> +- **Writable data must go exclusively to writable pages**
> 
> WTH is with all those ** ?

[...]

> Can we ditch all the ** nonsense and put whitespace in there? More paragraphs
> and whitespace are more good.

Yes

> Also, I really don't like how you differentiate between static and
> dynamic wr.

ok, but why? what would you suggest, instead?

[...]

> We already have RO, why do you need more RO?

I can explain, but I'm at loss of what is the best place: I was under 
the impression that this sort of document should focus mostly on the API 
and its use. I was even considering removing most of the explanation and 
instead put it in a separate document.

> 
>> +
>> +   **Remarks:**
>> +    - The "AUTO" modes perform automatic protection of the content, whenever
>> +       the current vmap_area is used up and a new one is allocated.
>> +        - At that point, the vmap_area being phased out is protected.
>> +        - The size of the vmap_area depends on various parameters.
>> +        - It might not be possible to know for sure *when* certain data will
>> +          be protected.
> 
> Surely that is a problem?
> 
>> +        - The functionality is provided as tradeoff between hardening and speed.
> 
> Which you fail to explain.
> 
>> +        - Its usefulness depends on the specific use case at hand
> 
> How about you write sensible text inside the option descriptions
> instead?
> 
> This is not a presentation; less bullets, more content.

I tried to say something, without saying too much, but it was clearly a 
bad choice.

Where should i put a thoroughly detailed explanation?
Here or in a separate document?

> 
>> +- Not only the pmalloc memory must be protected, but also any reference to
>> +  it that might become the target for an attack. The attack would replace
>> +  a reference to the protected memory with a reference to some other,
>> +  unprotected, memory.
> 
> I still don't really understand the whole write-rare thing; how does it
> really help? If we can write in kernel memory, we can write to
> page-tables too.

It has already been answered by Kees, but I'll provide also my answer:

the exploits used to write in kernel memory are specific to certain 
products and SW builds, so it's not possible to generalize too much, 
however there might be some limitation in the reach of a specific 
vulnerability. For example, if a memory location is referred to as 
offset from a base address, the maximum size of the offset limits the 
scope of the attack. Which might make it impossible to use that specific 
vulnerability for writing directly to the page table. But something 
else, say a statically allocated variable, might be within reach.

said this, there is also the almost orthogonal use case of providing 
increased robustness by trapping accidental modifications, caused by bugs.

> And I don't think this document even begins to explain _why_ you're
> doing any of this. How does it help?

ok, point taken

>> +- The users of rare write must take care of ensuring the atomicity of the
>> +  action, respect to the way they use the data being altered; for example,
>> +  take a lock before making a copy of the value to modify (if it's
>> +  relevant), then alter it, issue the call to rare write and finally
>> +  release the lock. Some special scenario might be exempt from the need
>> +  for locking, but in general rare-write must be treated as an operation
>> +  that can incur into races.
> 
> What?!

Probably something along the lines of:

"users of write-rare are responsible of using mechanisms that allow 
reading/writing data in a consistent way"

and if it seems obvious, I can just drop it.

One of the problems I have faced is to decide what level of knowledge or 
understanding I should expect from the reader of such document: what I 
can take for granted and what I should explain.

--
igor




