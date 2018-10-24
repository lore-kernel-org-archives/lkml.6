Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0642ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AF42075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7dTgP4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83AF42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeJYHbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:31:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51252 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYHbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:31:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so6954838wmf.1;
        Wed, 24 Oct 2018 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pUiKFQkI36XJHPifHvNgkCndVjQT2GzGWI06zA9lZ1U=;
        b=H7dTgP4yeEDbpIfo60PFZmqf4Uc0hE1PWrSPdHmU41MPXM9KO/VYz+KrQ3Tjt4YU6c
         ty12n92S0TxTW2f35ZGHF5NwFd4/gHCVmtd1E4pvvGS5VzyQTrSdL7J4vQpy7QGkQ7go
         PErMuff9X6kA9SRXtZEMOkz37YPWJ3fUZTvMz0LA13FQBiZ/rA9ZUfHFcbi6YFNnMRS4
         MWShTKpGFEjA3mzcSlmTzOofsuPU9kbs3ELR8NUy3LEjr8adhqmXW5NpueJSNpjdbG7m
         aEf7Y0reUS2aQItqSEeaHM4l6XZr1mmkxudhB3IYd7yP1r0H+c0VhpVxxaOeb1zIjN7/
         5eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pUiKFQkI36XJHPifHvNgkCndVjQT2GzGWI06zA9lZ1U=;
        b=cev9GuwDeLxXlnh0QqT/2ath0Ymr+Akaw0gKkaU/SVLD/uidVpj7QP/QcbtQrSwNrh
         h/Cgi6odaB2aANZdSHUSJ/yJKhTfILTPqE9KHdBYt5+DX/c5CQfgB/s6eFG7WlLN3KAm
         RObuwIxIMoYIQAkzmlkm+zkxuzoxvI/u8/0Ze63fvFUjIwNe+imodaOYalmtBpouPrIe
         N4elnLZCR8JoIcL2SqEr4ao6HwZGfqq7bFJ1PXzliPcO7J64F6FxkASJNzb2whCovjsz
         B2oOxuQIcCAhYYwm83OMuDJ3kBJmxwa8InydNjizWw0mTke8RswyvIOF17oBGxDcArzb
         v1jg==
X-Gm-Message-State: AGRZ1gKWbc0kxUHN2vwl33iczB2I0fnj9A+HwJ+8eA0GMmIJmtxHBEP+
        9C9ntuhc3GlPojRrStmNRG35HP1FHzrRiw==
X-Google-Smtp-Source: AJdET5dAH/w22mh/kaFPFlLUAiP0khn2L3sDgltKjJsxDcBPMCsA1Qq69uF03lFGNRowujnXQazWjQ==
X-Received: by 2002:a1c:c58b:: with SMTP id v133-v6mr4393413wmf.139.1540422064351;
        Wed, 24 Oct 2018 16:01:04 -0700 (PDT)
Received: from [10.17.176.77] ([109.144.211.182])
        by smtp.gmail.com with ESMTPSA id x15-v6sm6885306wrt.90.2018.10.24.16.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 16:01:03 -0700 (PDT)
Subject: Re: [PATCH 08/17] prmem: struct page: track vmap_area
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-9-igor.stoppa@huawei.com>
 <20181024031200.GC25444@bombadil.infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <ffb887e1-2029-42d5-3a97-54546e4d28d8@gmail.com>
Date:   Thu, 25 Oct 2018 02:01:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024031200.GC25444@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2018 06:12, Matthew Wilcox wrote:
> On Wed, Oct 24, 2018 at 12:34:55AM +0300, Igor Stoppa wrote:
>> The connection between each page and its vmap_area avoids more expensive
>> searches through the btree of vmap_areas.
> 
> Typo -- it's an rbtree.

ack

>> +++ b/include/linux/mm_types.h
>> @@ -87,13 +87,24 @@ struct page {
>>   			/* See page-flags.h for PAGE_MAPPING_FLAGS */
>>   			struct address_space *mapping;
>>   			pgoff_t index;		/* Our offset within mapping. */
>> -			/**
>> -			 * @private: Mapping-private opaque data.
>> -			 * Usually used for buffer_heads if PagePrivate.
>> -			 * Used for swp_entry_t if PageSwapCache.
>> -			 * Indicates order in the buddy system if PageBuddy.
>> -			 */
>> -			unsigned long private;
>> +			union {
>> +				/**
>> +				 * @private: Mapping-private opaque data.
>> +				 * Usually used for buffer_heads if
>> +				 * PagePrivate.
>> +				 * Used for swp_entry_t if PageSwapCache.
>> +				 * Indicates order in the buddy system if
>> +				 * PageBuddy.
>> +				 */
>> +				unsigned long private;
>> +				/**
>> +				 * @area: reference to the containing area
>> +				 * For pages that are mapped into a virtually
>> +				 * contiguous area, avoids performing a more
>> +				 * expensive lookup.
>> +				 */
>> +				struct vmap_area *area;
>> +			};
> 
> Not like this.  Make it part of a different struct in the existing union,
> not a part of the pagecache struct.  And there's no need to use ->private
> explicitly.

Ok, I'll have a look at the googledoc you made

>> @@ -1747,6 +1750,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>>   	if (!addr)
>>   		return NULL;
>>   
>> +	va = __find_vmap_area((unsigned long)addr);
>> +	for (i = 0; i < va->vm->nr_pages; i++)
>> +		va->vm->pages[i]->area = va;
> 
> I don't like it that you're calling this for _every_ vmalloc() caller
> when most of them will never use this.  Perhaps have page->va be initially
> NULL and then cache the lookup in it when it's accessed for the first time.
> 

If __find_vmap_area() was part of the API, this loop could be left out 
from __vmalloc_node_range() and the user of the allocation could 
initialize the field, if needed.

What is the reason for keeping __find_vmap_area() private?

--
igor
