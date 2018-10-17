Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CDAECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22F821476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhxcvwBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22F821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeJRBEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:04:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37805 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeJRBEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:04:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id d14-v6so30891833qto.4;
        Wed, 17 Oct 2018 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cKxq7jnq56JPYFt1vMrA6phH6qVBGV5g77Bd8Nxsjco=;
        b=fhxcvwBdbznTMfGMZQyMyjjw+AzAVjdYSxJMIqk7Kx2J/q6JGdq4qLGnKlDUDPL2a+
         MEDzL+bAWcSZV20dh77vEa2iauftDu8+lDsklYRh+v2wAyQdjQrprb/Ctm8DGkbCXEls
         w7CIC0Z8h5XzUOoC5Z7eeHsJ6Egx0KFrw4IYi9xAN+Q15diohx1mdswrHNnxAdfhb+TS
         jelf9ldB5SOMgV5xRlenNDXySM1ja38bhGiDS8IaKZMUiUtls+KOZnqaHhWeYvhnc2MG
         6mxPK+30x3uiq0nORyN8kmN+feHB63ZOYEfkxApa8oUDg5EarSoaw7RkGIDu4sFwp7ha
         DCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cKxq7jnq56JPYFt1vMrA6phH6qVBGV5g77Bd8Nxsjco=;
        b=ouxHh4p4k2tcRzFNcv4qYuZp7/a5wtXp+pu7u1lUaxExwvATk2E3O/in6kr5n0OXhi
         pKSxZBwnFYtat2Na9N7z56vrYzzaHnqw0w2eNiA6O6KKgVchzxXlMUYLEXPbrdVg0+9j
         kMXKX+A2sPPE2cCphEQ8z5c6gMfKg5RpDvNdImW8ZLkNMlmN+lclcezzcP0VXWGkMhgB
         DGZz4DlvxbcKVBYtXUGrHSwplTv6bKLk0zQFERlI1UfCe3fz5feNNXGa0yQKU1HPb8tY
         vF7d9O7RXMnvxB3IXm2RV27xDV3i90dv308ovfZCJcQfQ6vdXnoAPj+MpUAFJK5MfczZ
         WIYg==
X-Gm-Message-State: ABuFfohZ/KHo0uBqRzGAYFIA41/wk2aRB/y2wNsXZbWFLvteBJUIFZLZ
        zXXk8rLOb/nLorf7X00Uujs=
X-Google-Smtp-Source: ACcGV60ZZPaL3YjLTw9DMGsB/3xJJXBod5ATuc3Erc3PFLwrMXOZ4B3jh/ksrv2e7fA5BCyzXO5Nng==
X-Received: by 2002:a0c:ba11:: with SMTP id w17-v6mr7536890qvf.32.1539796089900;
        Wed, 17 Oct 2018 10:08:09 -0700 (PDT)
Received: from [192.168.1.10] (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w22-v6sm19386668qtb.8.2018.10.17.10.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 10:08:09 -0700 (PDT)
Subject: Re: [mm PATCH v3 1/6] mm: Use mm_zero_struct_page from SPARC on all
 64b architectures
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Michal Hocko <mhocko@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pavel.tatashin@microsoft.com" <pavel.tatashin@microsoft.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yi.z.zhang@linux.intel.com" <yi.z.zhang@linux.intel.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ldufour@linux.vnet.ibm.com" <ldufour@linux.vnet.ibm.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
 <20181015202656.2171.92963.stgit@localhost.localdomain>
 <20181017084744.GH18839@dhcp22.suse.cz>
 <9700b00f-a8a4-e318-f6a8-71fd1e7021b3@linux.intel.com>
 <8aaa0fa2-5f12-ea3c-a0ca-ded9e1a639e2@gmail.com>
 <7d313318f1234a1eb45b608bd853c17c@AcuMS.aculab.com>
 <e7cd1e6f-cc04-31ea-3322-5c8e25a6e58a@linux.intel.com>
From:   Pavel Tatashin <pasha.tatashin@gmail.com>
Message-ID: <287a794f-9c51-00ea-f0b5-1669f537a74f@gmail.com>
Date:   Wed, 17 Oct 2018 13:08:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e7cd1e6f-cc04-31ea-3322-5c8e25a6e58a@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/18 12:31 PM, Alexander Duyck wrote:
> On 10/17/2018 8:40 AM, David Laight wrote:
>> From: Pavel Tatashin
>>> Sent: 17 October 2018 16:12
>>> On 10/17/18 11:07 AM, Alexander Duyck wrote:
>>>> On 10/17/2018 1:47 AM, Michal Hocko wrote:
>>>>> On Mon 15-10-18 13:26:56, Alexander Duyck wrote:
>>>>>> This change makes it so that we use the same approach that was
>>>>>> already in
>>>>>> use on Sparc on all the archtectures that support a 64b long.
>>>>>>
>>>>>> This is mostly motivated by the fact that 8 to 10 store/move
>>>>>> instructions
>>>>>> are likely always going to be faster than having to call into a
>>>>>> function
>>>>>> that is not specialized for handling page init.
>>>>>>
>>>>>> An added advantage to doing it this way is that the compiler can get
>>>>>> away
>>>>>> with combining writes in the __init_single_page call. As a result the
>>>>>> memset call will be reduced to only about 4 write operations, or at
>>>>>> least
>>>>>> that is what I am seeing with GCC 6.2 as the flags, LRU poitners, and
>>>>>> count/mapcount seem to be cancelling out at least 4 of the 8
>>>>>> assignments on
>>>>>> my system.
>>>>>>
>>>>>> One change I had to make to the function was to reduce the minimum
>>>>>> page
>>>>>> size to 56 to support some powerpc64 configurations.
>>>>>
>>>>> This really begs for numbers. I do not mind the change itself with
>>>>> some
>>>>> minor comments below.
>>>>>
>>>>> [...]
>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>> index bb0de406f8e7..ec6e57a0c14e 100644
>>>>>> --- a/include/linux/mm.h
>>>>>> +++ b/include/linux/mm.h
>>>>>> @@ -102,8 +102,42 @@ static inline void set_max_mapnr(unsigned long
>>>>>> limit) { }
>>>>>>     * zeroing by defining this macro in <asm/pgtable.h>.
>>>>>>     */
>>>>>>    #ifndef mm_zero_struct_page
>>>>>
>>>>> Do we still need this ifdef? I guess we can wait for an arch which
>>>>> doesn't like this change and then add the override. I would rather go
>>>>> simple if possible.
>>>>
>>>> We probably don't, but as soon as I remove it somebody will probably
>>>> complain somewhere. I guess I could drop it for now and see if anybody
>>>> screams. Adding it back should be pretty straight forward since it
>>>> would
>>>> only be 2 lines.
>>>>
>>>>>> +#if BITS_PER_LONG == 64
>>>>>> +/* This function must be updated when the size of struct page grows
>>>>>> above 80
>>>>>> + * or reduces below 64. The idea that compiler optimizes out
>>>>>> switch()
>>>>>> + * statement, and only leaves move/store instructions
>>>>>> + */
>>>>>> +#define    mm_zero_struct_page(pp) __mm_zero_struct_page(pp)
>>>>>> +static inline void __mm_zero_struct_page(struct page *page)
>>>>>> +{
>>>>>> +    unsigned long *_pp = (void *)page;
>>>>>> +
>>>>>> +     /* Check that struct page is either 56, 64, 72, or 80 bytes */
>>>>>> +    BUILD_BUG_ON(sizeof(struct page) & 7);
>>>>>> +    BUILD_BUG_ON(sizeof(struct page) < 56);
>>>>>> +    BUILD_BUG_ON(sizeof(struct page) > 80);
>>>>>> +
>>>>>> +    switch (sizeof(struct page)) {
>>>>>> +    case 80:
>>>>>> +        _pp[9] = 0;    /* fallthrough */
>>>>>> +    case 72:
>>>>>> +        _pp[8] = 0;    /* fallthrough */
>>>>>> +    default:
>>>>>> +        _pp[7] = 0;    /* fallthrough */
>>>>>> +    case 56:
>>>>>> +        _pp[6] = 0;
>>>>>> +        _pp[5] = 0;
>>>>>> +        _pp[4] = 0;
>>>>>> +        _pp[3] = 0;
>>>>>> +        _pp[2] = 0;
>>>>>> +        _pp[1] = 0;
>>>>>> +        _pp[0] = 0;
>>>>>> +    }
>>>>>
>>>>> This just hit my eyes. I have to confess I have never seen default: to
>>>>> be not the last one in the switch. Can we have case 64 instead or does
>>>>> gcc
>>>>> complain? I would be surprised with the set of BUILD_BUG_ONs.
>>>
>>> It was me, C does not really care where default is placed, I was trying
>>> to keep stores sequential for better cache locality, but "case 64"
>>> should be OK, and even better for this purpose.
>>
>> You'd need to put memory barriers between them to force sequential
>> stores.
>> I'm also surprised that gcc doesn't inline the memset().

I meant sequential only as hint, there is no reason for them to be
strictly sequential, and barrier is one of the reasons why memset() is
slower compared to having these stores here. As, most of memset()
implementations include barrier. As Alex said, compiler will most likely
drop some unnecessary stores anyway because of inlines in
__init_single_page()

Pavel

>>
>>     David
> 
> We don't need them to be sequential. The general idea is we have have to
> fill a given amount of space with 0s. After that we have some calls that
> are initialing the memory that doesn't have to be zero. Ideally the
> compiler is smart enough to realize that since we don't have barriers
> and we are performing assignments after the assignment of zero it can
> just combine the two writes into one and drop the zero assignment.
> 
> - Alex
