Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58110ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186D02080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaECEUDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186D02080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbeJ3DLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:11:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37375 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJ3DLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:11:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id c4-v6so8790864lja.4;
        Mon, 29 Oct 2018 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ts1+JJpqKPjlm5tD26SVyb5IaS4Vf+MvFj6AodJ0bRA=;
        b=YaECEUDxehV8xiSwQSMYAb2Htjz6xhLoLrQzkicgjxYuBn5oxTxR6xWqbm9DWYepd8
         qsSjg0aXP78yyb9wgZyQY8nQ4z1IFW0y+WauF3yj9/EL3pNTD/9aUMwtnlBcqKLnJC8Y
         AS360+xAMAR9vRkAMZvXN4Fowd5qgoKTVlH4yze5o1WGedliRrtjnkekg99YWEVARh6i
         Nrs6UQcee8ZJFgEFPkISPB377K9LdzfJTbaw2J4ovmP796GDgw0xnLzqGYC68xcDG/tZ
         k249yK1g+73202JPsivDbJPJXv1VpF1YoGYIpvtm3OnquSP2t1z40VloMEZZXMxxJLUK
         VEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ts1+JJpqKPjlm5tD26SVyb5IaS4Vf+MvFj6AodJ0bRA=;
        b=UouWUpvo8JBBHt1VxV0nZOmnfenbA0TCLPAiYyQut4HJDmd/NlbDZsgkTLsn5gIXhz
         4FQxEBOu1xUEZs7DyPXTPj9NZyxxfliCIAxLWqaKzqFtsOljJCQ0GWGc3fiCfqDOf6GH
         0r5uDHKSJHqMdiFOHKLv29k0LtDSH8a9PCUmWg/UaRdj+iyORNrOcmAgpPrucaHrLRzT
         kGF4M/9xgsJO0SBm/F1fkd09/AIGPT2hyvmgYsTx+CTitLAWx0tdbj3NFLloMfuvuyin
         OX4bUfUPZd1xIMt1ECsDyIER9WyQL/b+D8sGdXynN9Q1NoHvw2prFiLP6yOvcvczMvO3
         wl/A==
X-Gm-Message-State: AGRZ1gKK46m4v2qg641JLUplznltBkyHRLM1utK8E6j6o/SLdpZBpjXD
        7xJrq2ihVBNspDL8MMv3UBzlLLKynLK9Gg==
X-Google-Smtp-Source: AJdET5e8nEF+aFaX9VMbN/KeD+bn8q6hU1zEZxahiCIJ/Qw6hMS9Cwb1LjquEWXPUwpDavJrmGz9Dg==
X-Received: by 2002:a2e:5c89:: with SMTP id q131-v6mr10693964ljb.119.1540837281132;
        Mon, 29 Oct 2018 11:21:21 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id u20-v6sm3315603lfk.55.2018.10.29.11.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:21:20 -0700 (PDT)
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
 <ffb887e1-2029-42d5-3a97-54546e4d28d8@gmail.com>
 <20181025021307.GH25444@bombadil.infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <4b1ed33c-9b3c-a61f-b919-aeed97edddac@gmail.com>
Date:   Mon, 29 Oct 2018 20:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025021307.GH25444@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2018 03:13, Matthew Wilcox wrote:
> On Thu, Oct 25, 2018 at 02:01:02AM +0300, Igor Stoppa wrote:
>>>> @@ -1747,6 +1750,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>>>>    	if (!addr)
>>>>    		return NULL;
>>>> +	va = __find_vmap_area((unsigned long)addr);
>>>> +	for (i = 0; i < va->vm->nr_pages; i++)
>>>> +		va->vm->pages[i]->area = va;
>>>
>>> I don't like it that you're calling this for _every_ vmalloc() caller
>>> when most of them will never use this.  Perhaps have page->va be initially
>>> NULL and then cache the lookup in it when it's accessed for the first time.
>>>
>>
>> If __find_vmap_area() was part of the API, this loop could be left out from
>> __vmalloc_node_range() and the user of the allocation could initialize the
>> field, if needed.
>>
>> What is the reason for keeping __find_vmap_area() private?
> 
> Well, for one, you're walking the rbtree without holding the spinlock,
> so you're going to get crashes.  I don't see why we shouldn't export
> find_vmap_area() though.

Argh, yes, sorry. But find_vmap_area() would be enough for what I need.

> Another way we could approach this is to embed the vmap_area in the
> vm_struct.  It'd require a bit of juggling of the alloc/free paths in
> vmalloc, but it might be worthwhile.

I have a feeling of unease about the whole vmap_area / vm_struct 
duality. They clearly are different types, with different purposes, but 
here and there there are functions that are named after some "area", yet 
they actually refer to vm_struct pointers.

I wouldn't mind spending some time understanding the reason for this 
apparently bizarre choice, but after I have emerged from the prmem swamp.

For now I'd stick to find_vmap_area().

--
igor
