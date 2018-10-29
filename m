Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1932AC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E7920880
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdYBRsbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E7920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbeJ3Evi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:51:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37501 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeJ3Evi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:51:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id c4-v6so9089176lja.4;
        Mon, 29 Oct 2018 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TLUjEGuOtOvRkbxWiZWPWrLvobGSOVuiXeWjVsEyOZo=;
        b=MdYBRsbs3ctFw1ugW+m4ixvGjd0UxLnxRjMiGEmB49tp9R2HLLiUNt0ZX3z0muHt+s
         XHEyzdqyaQBEp9tuNwiU4v7fJU8HG/ykpxG+bUgJ2GX2d/F9s1bxd/WD9Holi13K3Heo
         JRduAdbgooPEt0XgeuQszq8KQlHAZsCi0hPP18Jzt/TT5zae5gCtTmXDK7p11/3wq8vp
         P8f/LhNWuisArMBfuXAx3M6tD/4vXOc9Zp74oK8uZJSdxfwXGndgAxBp3I7NiHViIyan
         5lAXnmuCiS3l+Ly3hNrwuBU825JTZEKB83euPN1vC6KfYsgxt78zky6rbfilnJYUP7Vm
         omBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TLUjEGuOtOvRkbxWiZWPWrLvobGSOVuiXeWjVsEyOZo=;
        b=H1gDlzPzngtzF3aAwf6uFwlAm8876uLZ7hiyjG6mvWzdHLiV2YPFm24/0wFN5RP4bO
         ifROjX2yxvGCuP/EE+FDDdOpQiVckQRPrbnnIHk2WgkKDfUspKohYISehBMvPjdY9+IK
         /kVSYllbgXFhYzswFYu6Df+kH+C51wAadTqc1DPz/8yQekdtk+sgNzB8hOnYUSfZhS0w
         BFQAZNrUWQp90xVRzJW2c8RiqtjQz0Qx0I4ylZ4zlevwi5j4VPKvktP4GHaQANZvg3/Q
         jSAn+pWiI+ToaPBn3+BC8C4sX+Gp/AMZVpHIEo6pWiY7j/HfqsecA8DGGGkGUb7b0jCY
         bRnQ==
X-Gm-Message-State: AGRZ1gI4eJgEKs/OCFgPXBOEviFdH/NCut3VVvJJv83MYz4TN1fURV9C
        ZrtqAg8fSIlJXqx0VtzL0dI0pPnFpLQ=
X-Google-Smtp-Source: AJdET5c2nbSnnBiqZ7n+Ku2eLzIrOFPRDtjO8OfOgX+rr/mimWTd2WhnzzxT1xbpKrDjRBC9ZFzPlQ==
X-Received: by 2002:a2e:59ca:: with SMTP id g71-v6mr9812056ljf.79.1540843285129;
        Mon, 29 Oct 2018 13:01:25 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id r22-v6sm2041418ljh.77.2018.10.29.13.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 13:01:24 -0700 (PDT)
Subject: Re: [PATCH 02/17] prmem: write rare for static allocation
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-3-igor.stoppa@huawei.com>
 <20181026094105.GE3159@worktop.c.hoisthospitality.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <e3ef00ef-3d28-2336-7bae-2e4f738a6e44@gmail.com>
Date:   Mon, 29 Oct 2018 22:01:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026094105.GE3159@worktop.c.hoisthospitality.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/2018 10:41, Peter Zijlstra wrote:
> On Wed, Oct 24, 2018 at 12:34:49AM +0300, Igor Stoppa wrote:
>> +static __always_inline
> 
> That's far too large for inline.

The reason for it is that it's supposed to minimize the presence of 
gadgets that might be used in JOP attacks.
I am ready to stand corrected, if I'm wrong, but this is the reason why 
I did it.

Regarding the function being too large, yes, I would not normally choose 
it for inlining.

Actually, I would not normally use "__always_inline" and instead I would 
limit myself to plain "inline", at most.

> 
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
>> +
>> +		local_irq_save(flags);
>> +		page = virt_to_page(d);
>> +		offset = d & ~PAGE_MASK;
>> +		offset_complement = PAGE_SIZE - offset;
>> +		size = min(n_bytes, offset_complement);
>> +		base = (uintptr_t)vmap(&page, 1, VM_MAP, PAGE_KERNEL);
>> +		if (WARN(!base, WR_ERR_PAGE_MSG)) {
>> +			local_irq_restore(flags);
>> +			return false;
>> +		}
>> +		memset((void *)(base + offset), c, size);
>> +		vunmap((void *)base);
> 
> BUG

yes, somehow I managed to drop this debug configuration from the debug 
builds I made.

[...]

> Also, I see an amount of duplication here that shows you're not nearly
> lazy enough.

I did notice a certain amount of duplication, but I didn't know how to 
exploit it.

--
igor
