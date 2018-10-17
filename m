Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A37CECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F78C2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9jky8YQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F78C2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeJQXIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:08:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33329 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQXIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:08:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id q40-v6so30444685qte.0;
        Wed, 17 Oct 2018 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZOLe8Zin178/08jruIXW3lOa2XVHqgyRzxpRLU7TLAY=;
        b=O9jky8YQ56anrV+FCIyWWMv25MkPHWb3/G1eNF3erewkrZuBqKdMSnWQ3Kb9rZmz29
         yrFd236go3B6Xz1FJtReh+Z8dMTHZ4rQc35ByA3nKE+OnK3wu9oPuKWT7wW3LHdoYuK8
         pF/i+gIOYBYYiHpaV4jE8GSurkEvUUoyxTqlnAybN8qc8XTgtiQJMzOqIciUDK5CzZiw
         OLZYvNNcJx+9cB9jb2L7csuHVgr7dW7w0J5+PtOuCCflmE7ZQsAVV2aeprNHNHKpdIx4
         VDh+XanVWVi1O1dp/nn+EKTPsA+cKLibvdrM0acUnfFK9l+Z67/2073FMPUdhDLQ4B6t
         HgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZOLe8Zin178/08jruIXW3lOa2XVHqgyRzxpRLU7TLAY=;
        b=BnoqPtt32G1eLIdwwzSBgDOccKpf4wqF3DNmEcR8Jvbe3ifkGa0+F2U2o0FB6MPdzq
         ieoAMIwKVk2i2DQ2y04engnGM9x5xnlwYr7h0oAApryIA4zLgOmGJeOrkLh7Y+iw+IbO
         COVMiNGjyloNggEAbPdjBxt+2c3YzuPxXVri8tSogWNj5BB3LvoYa//xRtiL0BkyTl7p
         7bATKCnyAUnPA/LZ8EWy2Hqnwrvt16UjX31td3YwT4qvpaULpXti8S6v0+ewgUrm7ugR
         U9QCb4t085sYDFak+KueFDbbRpBuIa4pLD3yatKc6pm2U1tSCs355AbMNX13CsLKvfpu
         eQzA==
X-Gm-Message-State: ABuFfogimcg6q74axVWvW/UTk9+p1JTy60jKtFCuN7Rp04PoGzmbD+EP
        a/tBEkmnuecKfsgPVSzZtjUS0T2U
X-Google-Smtp-Source: ACcGV603hgU4IxPb+WTvEX0RVtfWS/X/qyeh0ZtIJyRpb3zBS9809GdqlNkRo1YnP/DzTpKNAdzbUA==
X-Received: by 2002:ac8:1967:: with SMTP id g36-v6mr24062385qtk.193.1539789126420;
        Wed, 17 Oct 2018 08:12:06 -0700 (PDT)
Received: from [192.168.1.10] (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i26-v6sm14352799qta.34.2018.10.17.08.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 08:12:05 -0700 (PDT)
Subject: Re: [mm PATCH v3 1/6] mm: Use mm_zero_struct_page from SPARC on all
 64b architectures
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        pavel.tatashin@microsoft.com, dave.jiang@intel.com,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        davem@davemloft.net, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
 <20181015202656.2171.92963.stgit@localhost.localdomain>
 <20181017084744.GH18839@dhcp22.suse.cz>
 <9700b00f-a8a4-e318-f6a8-71fd1e7021b3@linux.intel.com>
From:   Pavel Tatashin <pasha.tatashin@gmail.com>
Message-ID: <8aaa0fa2-5f12-ea3c-a0ca-ded9e1a639e2@gmail.com>
Date:   Wed, 17 Oct 2018 11:12:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <9700b00f-a8a4-e318-f6a8-71fd1e7021b3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/18 11:07 AM, Alexander Duyck wrote:
> On 10/17/2018 1:47 AM, Michal Hocko wrote:
>> On Mon 15-10-18 13:26:56, Alexander Duyck wrote:
>>> This change makes it so that we use the same approach that was
>>> already in
>>> use on Sparc on all the archtectures that support a 64b long.
>>>
>>> This is mostly motivated by the fact that 8 to 10 store/move
>>> instructions
>>> are likely always going to be faster than having to call into a function
>>> that is not specialized for handling page init.
>>>
>>> An added advantage to doing it this way is that the compiler can get
>>> away
>>> with combining writes in the __init_single_page call. As a result the
>>> memset call will be reduced to only about 4 write operations, or at
>>> least
>>> that is what I am seeing with GCC 6.2 as the flags, LRU poitners, and
>>> count/mapcount seem to be cancelling out at least 4 of the 8
>>> assignments on
>>> my system.
>>>
>>> One change I had to make to the function was to reduce the minimum page
>>> size to 56 to support some powerpc64 configurations.
>>
>> This really begs for numbers. I do not mind the change itself with some
>> minor comments below.
>>
>> [...]
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index bb0de406f8e7..ec6e57a0c14e 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -102,8 +102,42 @@ static inline void set_max_mapnr(unsigned long
>>> limit) { }
>>>    * zeroing by defining this macro in <asm/pgtable.h>.
>>>    */
>>>   #ifndef mm_zero_struct_page
>>
>> Do we still need this ifdef? I guess we can wait for an arch which
>> doesn't like this change and then add the override. I would rather go
>> simple if possible.
> 
> We probably don't, but as soon as I remove it somebody will probably
> complain somewhere. I guess I could drop it for now and see if anybody
> screams. Adding it back should be pretty straight forward since it would
> only be 2 lines.
> 
>>> +#if BITS_PER_LONG == 64
>>> +/* This function must be updated when the size of struct page grows
>>> above 80
>>> + * or reduces below 64. The idea that compiler optimizes out switch()
>>> + * statement, and only leaves move/store instructions
>>> + */
>>> +#define    mm_zero_struct_page(pp) __mm_zero_struct_page(pp)
>>> +static inline void __mm_zero_struct_page(struct page *page)
>>> +{
>>> +    unsigned long *_pp = (void *)page;
>>> +
>>> +     /* Check that struct page is either 56, 64, 72, or 80 bytes */
>>> +    BUILD_BUG_ON(sizeof(struct page) & 7);
>>> +    BUILD_BUG_ON(sizeof(struct page) < 56);
>>> +    BUILD_BUG_ON(sizeof(struct page) > 80);
>>> +
>>> +    switch (sizeof(struct page)) {
>>> +    case 80:
>>> +        _pp[9] = 0;    /* fallthrough */
>>> +    case 72:
>>> +        _pp[8] = 0;    /* fallthrough */
>>> +    default:
>>> +        _pp[7] = 0;    /* fallthrough */
>>> +    case 56:
>>> +        _pp[6] = 0;
>>> +        _pp[5] = 0;
>>> +        _pp[4] = 0;
>>> +        _pp[3] = 0;
>>> +        _pp[2] = 0;
>>> +        _pp[1] = 0;
>>> +        _pp[0] = 0;
>>> +    }
>>
>> This just hit my eyes. I have to confess I have never seen default: to
>> be not the last one in the switch. Can we have case 64 instead or does
>> gcc
>> complain? I would be surprised with the set of BUILD_BUG_ONs.

It was me, C does not really care where default is placed, I was trying
to keep stores sequential for better cache locality, but "case 64"
should be OK, and even better for this purpose.

Pavel

> 
> I can probably just replace the "default:" with "case 64:". I think I
> have seen other switch statements in the kernel without a default so
> odds are it should be okay.
> 
