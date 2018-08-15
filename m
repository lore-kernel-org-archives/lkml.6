Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F7BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993202152D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjM/EEpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993202152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeHOWXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:23:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33754 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeHOWXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:23:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so937794pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lqC5wsFIGsfGvtWuKKPTJQujYWbgAaQRHR7fQCh8LzU=;
        b=EjM/EEpNA987O8Vh6w2ppuWjemtNotweRhRyePa5kAG+ldAdVEVyPKwUZ18Ni24SV/
         2cXBmMPrkm87yKKj8DW+C+2saODSjYAaVVH6kyi8PKNbvzxwaF0S6VcskZpYCycHR4n8
         JASmmtjllFAMajAsXD1SygyWj0JNb7rk197YTBACSfPtNt45KfpLtVp6HyTi0muYI5du
         RV2f+2eL48YWOydg+iKrK+e1H2c35FePgDMF6iS7sKr5xtt8UFNUCY8su7oV1US/c1dM
         hVdKn2VW4KN899SBtNjBZM5KpqnmhormUDmaxqEsmMF3a1ulKG9s3GokgO6P5cTOZ2ly
         hScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lqC5wsFIGsfGvtWuKKPTJQujYWbgAaQRHR7fQCh8LzU=;
        b=c6kq/gWH1IlV2uptw1WQ6d0nCcXkDUqSNPgoK4h3+/4h7fRH6VUU5OvW4HK3E/Nppr
         0wtaRYnKv858+hcBv9TCsHOXa0R1Z+/bq/mmqvX08NycVSsH5XSw46EViwidbYmSkyjE
         +aEjSy9WlG292v8Ch3Ps3R+0e0bVF46rZRrdrFs2QC36eQ8P1d7PK/6xwxBbrP9o1lz7
         4+MzV8DjZKC9GzcQxOpBMQ0S0aDhlC4CsMMKBeY1HCUQcx4AUnkgjNSsrGaTTyGhektK
         HUpB04AQfZ2EI8pd6v+Xj22h6fnu/uqFytt79G6Ff6usHznrJjnTAzF16hE46RWyOOXx
         4m2Q==
X-Gm-Message-State: AOUpUlESVY5mz6PVLXhL2LqhKPfGrwklNVper+DKJxf2tMgGQE6ux9QQ
        HAl3Ab2re4b0jqfOoEaATrxaUhIKde54DQ==
X-Google-Smtp-Source: AA+uWPykSDC7ew/TLsDG2jK5+KbWe4ImHusd2kTPl41xrkEVMU6Oa1RTZR7iz1itKhua5RUIp99g7A==
X-Received: by 2002:a62:c4c3:: with SMTP id h64-v6mr28886572pfk.39.1534361421766;
        Wed, 15 Aug 2018 12:30:21 -0700 (PDT)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
        by smtp.gmail.com with ESMTPSA id 22-v6sm39300161pfl.126.2018.08.15.12.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 12:30:21 -0700 (PDT)
Subject: Re: [PATCH] arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()
To:     Will Deacon <will.deacon@arm.com>
Cc:     Greg Hackmann <ghackmann@android.com>,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Steve Capper <steve.capper@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        CHANDAN VN <chandan.vn@samsung.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
References: <20180813193013.236362-1-ghackmann@google.com>
 <20180814104041.GB28664@arm.com>
 <eb90a28e-893c-e02e-a9c2-1d988f08cf3a@google.com>
 <20180814152958.GD567@arm.com>
From:   Greg Hackmann <ghackmann@google.com>
Message-ID: <e5585e80-8c5a-fd39-adc2-3eccd42cae07@google.com>
Date:   Wed, 15 Aug 2018 12:30:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180814152958.GD567@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 08:29 AM, Will Deacon wrote:
> On Tue, Aug 14, 2018 at 08:17:48AM -0700, Greg Hackmann wrote:
>> On 08/14/2018 03:40 AM, Will Deacon wrote:
>>> Hi Greg,
>>>
>>> On Mon, Aug 13, 2018 at 12:30:11PM -0700, Greg Hackmann wrote:
>>>> ARM64's pfn_valid() shifts away the upper PAGE_SHIFT bits of the input
>>>> before seeing if the PFN is valid.  This leads to false positives when
>>>> some of the upper bits are set, but the lower bits match a valid PFN.
>>>>
>>>> For example, the following userspace code looks up a bogus entry in
>>>> /proc/kpageflags:
>>>>
>>>>     int pagemap = open("/proc/self/pagemap", O_RDONLY);
>>>>     int pageflags = open("/proc/kpageflags", O_RDONLY);
>>>>     uint64_t pfn, val;
>>>>
>>>>     lseek64(pagemap, [...], SEEK_SET);
>>>>     read(pagemap, &pfn, sizeof(pfn));
>>>>     if (pfn & (1UL << 63)) {        /* valid PFN */
>>>>         pfn &= ((1UL << 55) - 1);   /* clear flag bits */
>>>>         pfn |= (1UL << 55);
>>>>         lseek64(pageflags, pfn * sizeof(uint64_t), SEEK_SET);
>>>>         read(pageflags, &val, sizeof(val));
>>>>     }
>>>>
>>>> On ARM64 this causes the userspace process to crash with SIGSEGV rather
>>>> than reading (1 << KPF_NOPAGE).  kpageflags_read() treats the offset as
>>>> valid, and stable_page_flags() will try to access an address between the
>>>> user and kernel address ranges.
>>>>
>>>> Signed-off-by: Greg Hackmann <ghackmann@google.com>
>>>> ---
>>>>  arch/arm64/mm/init.c | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> Thanks, this looks like a sensible fix to me. Do you think it warrants a
>>> CC stable?
>>>
>>> Will
>>
>> Yes, I think so.  Should I resend with a "Fixes" field?
> 
> Could do, but I think this goes all the way back to day 1! Doesn't arch/arm/
> also suffer from the same issue?
> 
> Will
> 

Yeah, it looks like this happens on non-LPAE 32-bit kernels too.  LPAE
kernels aren't affected since __pfn_to_phys() promotes to a 64-bit type.

I can submit a fix for that too while I'm at it.
