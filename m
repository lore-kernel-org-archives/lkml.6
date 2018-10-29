Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A08C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3682C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5oTUjMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3682C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeJ3Cwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:52:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33622 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeJ3Cwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:52:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id z21-v6so8748103ljz.0;
        Mon, 29 Oct 2018 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t6xiqK4v9iNRHHQrMF7tqrJ+DDjMcL+GLezehYMFE4c=;
        b=K5oTUjMhkg0q73FRNd8lyRNADWFZDkJt9LISlnPQIxTtc+Q6h08RFofvPO4Y3rwj1u
         b4FQOGE3/Rijvbh8EE8BGNW34pZAtO5YASQjhOKKGR44BMZr9DLC3kr7fXi3l5v1zPHy
         p0gJpAlSs2wGJuASWXTN9GZrT57bwtoS8swLMRd+6oMY3gjexBXNqpBv2pkgIGSDFyo8
         OfcefNTbn6p3msJF87ecWlyGsDzP2ojgogr7EidCyJg+rUEOmry8Wn9ZmAdaql8rX1wI
         S9xZDajHlX45D08PycYyVIJHdcPLfxghji27kbmZ3+l3EoQFvHb6VgZJSllWzP1Ra8Wb
         Dicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t6xiqK4v9iNRHHQrMF7tqrJ+DDjMcL+GLezehYMFE4c=;
        b=IHvDVwJs52sMghi+qd39uPia3DRF5cgAJyzV9GuZYVjmqdSpLEFupZhKPU+FCNsWFZ
         POf0qodel7OUGOQXdxYwB7C9ax/x5AfxfN6Bw4CSqJE5QwJX3cVDBK6u5eFWQXJkKSYt
         Qa4etH2DUlwv5EwRMcbcdo/B41+zUvciH8JhWDDu3+yHFeQyUIIL6d4t+zD9QK0J2sUb
         KLafNjhu1YhlNNkcLjzamdo/NRBwf0abdowc17efFR5U/WwPZy76QmJEdtO1/YKFTGvP
         79Kk2cugGCQSnfUcOacE1WsEgXidUgHC8fsL7SaBSuFMBozIS9xM6EjpTOG2OR03ZHPG
         MMPA==
X-Gm-Message-State: AGRZ1gLyHyegjFxrxgp83mCxJMSRVPdvf0Y6EmbnjgkaJHxG4m2lPdHb
        C49s3RomxdPZEbe5QvY/I5pDTl5NsyotJg==
X-Google-Smtp-Source: AJdET5fCEGLpaah0Tq8vpMZOtvEPJ0sEGUnR3jKVv9n8dFJVLyRt777baMJHNcoCLOLNj4iobj9p2A==
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr10962931lji.130.1540836190393;
        Mon, 29 Oct 2018 11:03:10 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id x29-v6sm1897421ljb.69.2018.10.29.11.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:03:09 -0700 (PDT)
Subject: Re: [PATCH 02/17] prmem: write rare for static allocation
To:     Dave Hansen <dave.hansen@intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-3-igor.stoppa@huawei.com>
 <23022d8a-dcef-20d5-cb07-a218b08b7b9a@intel.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <311d06ab-df6d-134a-82fc-1e2098f8a924@gmail.com>
Date:   Mon, 29 Oct 2018 20:03:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <23022d8a-dcef-20d5-cb07-a218b08b7b9a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2018 01:24, Dave Hansen wrote:
>> +static __always_inline bool __is_wr_after_init(const void *ptr, size_t size)
>> +{
>> +	size_t start = (size_t)&__start_wr_after_init;
>> +	size_t end = (size_t)&__end_wr_after_init;
>> +	size_t low = (size_t)ptr;
>> +	size_t high = (size_t)ptr + size;
>> +
>> +	return likely(start <= low && low < high && high <= end);
>> +}
> 
> size_t is an odd type choice for doing address arithmetic.

it seemed more portable than unsigned long

>> +/**
>> + * wr_memset() - sets n bytes of the destination to the c value
>> + * @dst: beginning of the memory to write to
>> + * @c: byte to replicate
>> + * @size: amount of bytes to copy
>> + *
>> + * Returns true on success, false otherwise.
>> + */
>> +static __always_inline
>> +bool wr_memset(const void *dst, const int c, size_t n_bytes)
>> +{
>> +	size_t size;
>> +	unsigned long flags;
>> +	uintptr_t d = (uintptr_t)dst;
>> +
>> +	if (WARN(!__is_wr_after_init(dst, n_bytes), WR_ERR_RANGE_MSG))
>> +		return false;
>> +	while (n_bytes) {
>> +		struct page *page;
>> +		uintptr_t base;
>> +		uintptr_t offset;
>> +		uintptr_t offset_complement;
> 
> Again, these are really odd choices for types.  vmap() returns a void*
> pointer, on which you can do arithmetic.  

I wasn't sure of how much I could rely on the compiler not doing some 
unwanted optimizations.

> Why bother keeping another
> type to which you have to cast to and from?

For the above reason. If I'm worrying unnecessarily, I can switch back 
to void *
It certainly is easier to use.

> BTW, our usual "pointer stored in an integer type" is 'unsigned long',
> if a pointer needs to be manipulated.

yes, I noticed that, but it seemed strange ...
size_t corresponds to unsigned long, afaik

but it seems that I have not fully understood where to use it

anyway, I can stick to the convention with unsigned long

> 
>> +		local_irq_save(flags);
> 
> Why are you doing the local_irq_save()?

The idea was to avoid the case where an attack would somehow freeze the 
core doing the write-rare operation, while the temporary mapping is 
accessible.

I have seen comments about using mappings that are private to the 
current core (and I will reply to those comments as well), but this 
approach seems architecture-dependent, while I was looking for a 
solution that, albeit not 100% reliable, would work on any system with 
an MMU. This would not prevent each arch to come up with own custom 
implementation that provides better coverage, performance, etc.

>> +		page = virt_to_page(d);
>> +		offset = d & ~PAGE_MASK;
>> +		offset_complement = PAGE_SIZE - offset;
>> +		size = min(n_bytes, offset_complement);
>> +		base = (uintptr_t)vmap(&page, 1, VM_MAP, PAGE_KERNEL);
> 
> Can you even call vmap() (which sleeps) with interrupts off?

I accidentally disabled sleeping while atomic debugging and I totally 
missed this problem :-(

However, to answer your question, nothing exploded while I was testing 
(without that type of debugging).

I suspect I was just "lucky". Or maybe I was simply not triggering the 
sleeping sub-case.

As I understood the code, sleeping _might_ happen, but it's not going to 
happen systematically.

I wonder if I could split vmap() into two parts: first the sleeping one, 
with interrupts enabled, then the non sleeping one, with interrupts 
disabled.

I need to read the code more carefully, but it seems that sleeping might 
happen when memory for the mapping meta data is not immediately available.

BTW, wouldn't the might_sleep() call belong more to the part which 
really sleeps, instead than to the whole vmap() ?

>> +		if (WARN(!base, WR_ERR_PAGE_MSG)) {
>> +			local_irq_restore(flags);
>> +			return false;
>> +		}
> 
> You really need some kmap_atomic()-style accessors to wrap this stuff
> for you.  This little pattern is repeated over and over.

I really need to learn more about the way the kernel works and is 
structured. It's a work in progress. Thanks for the advice.

> ...
>> +const char WR_ERR_RANGE_MSG[] = "Write rare on invalid memory range.";
>> +const char WR_ERR_PAGE_MSG[] = "Failed to remap write rare page.";
> 
> Doesn't the compiler de-duplicate duplicated strings for you?  Is there
> any reason to declare these like this?

I noticed I have made some accidental modifications in a couple of 
cases, when replicating the command.

So I thought that if I really want to use the same string, why not doing 
it explicitly? It seemed also easier, in case I want to tweak the 
message. I need to do it only in one place.

--
igor
