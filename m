Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C750BC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6789D20853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V75fnljr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6789D20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJOQRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:17:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43461 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeJOQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:17:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id p24-v6so9294174pff.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 01:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yq4s+teHWk6mhEQ7xflzL98C7IKgJ0BsTWv7BiVEvw4=;
        b=V75fnljrk2PIihZEaj2DTWFuACO7MgdwwqsElB24EYsV9nprzptEKY7l6x/V5IAZbZ
         JJE3hlOnOOJUCaGAjjzC07CwkgcRjRFO6lROKiflSRvHZiDXN054KIvagTGubLUIJP2Z
         lan5A62x4hYvjK8rxZQZAc6Fasea3jWZKY2KcyBDe+cm20TKjiyvTA4xLcIEA4L+lu7n
         E7dzgiYQQmLW5eupQWHDgszafP6m2QZO7q9lyAbYL/HFvd64GWsKHKYjb5WnmvpBfdkE
         H3EgG2clIWYJxb1+Ka/WeeaUCAJBKuYu4MIJk2zJPnszZbQdso+KSmb0ojIHk4elE4Mq
         bMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yq4s+teHWk6mhEQ7xflzL98C7IKgJ0BsTWv7BiVEvw4=;
        b=pM6R9QY535Dwqa5tqQtnxJ/bUwg4I4rHtXbox81dLDnRftCkFmph+MMuP4DtQ6c7Az
         38uqvBseg7s6D1DBOxVGsufXuNGn3HhZQTlec83S0pMvdRPYEABcjaqSB0Bsya2w/pNU
         kdb8K4elVH3EvGtRlNUPM2tIyUwRbVaYFnG/TG0PgjquyHbyYSU/uL7t6OEYaDCxaGF4
         bsk7N+zz2j/gyb7HSu1YyLYkogO6ipm3/kYbLCTVjcXl+pyWInH3fvKZXTpBoGEDa72s
         g10IuC6DA8dG3eXKQHLvdZj40Tu6KvemkK4Em4gQXJa8hDF5oi2PcEZRBDWxSFtqSsqf
         wi2Q==
X-Gm-Message-State: ABuFfoiMAH2GGokHtZcOT6p+EUMGcSF+PVXJCdC2zo+OijLuLNOBkVCc
        t+rkBTLIVU7UaifV5n+FUQk=
X-Google-Smtp-Source: ACcGV60TWM7AB0FTbAoytATzjAWd3wn5X7LCbi275/s/k/nFmiUkffHvckOZ/TwHl30wQuINeip5ug==
X-Received: by 2002:a62:67c3:: with SMTP id t64-v6mr9097463pfj.76.1539592373718;
        Mon, 15 Oct 2018 01:32:53 -0700 (PDT)
Received: from [192.168.0.123] ([49.207.50.246])
        by smtp.gmail.com with ESMTPSA id v26-v6sm5904810pfg.43.2018.10.15.01.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 01:32:52 -0700 (PDT)
From:   "Aneesh Kumar K.V" <aneeshkumar.opensource@gmail.com>
X-Google-Original-From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        mhocko@suse.com, zi.yan@cs.rutgers.edu
References: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
 <20181009130421.bmus632ocurn275u@kshutemo-mobl1>
 <20181009131803.GH6248@arm.com>
 <fb0ee5dd-5799-f5af-891a-992dd9a16a9f@arm.com>
Message-ID: <4bf3951d-410f-fac4-dfb2-7dee5568e6ff@linux.ibm.com>
Date:   Mon, 15 Oct 2018 14:02:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <fb0ee5dd-5799-f5af-891a-992dd9a16a9f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 1:32 PM, Anshuman Khandual wrote:
> 
> 
> On 10/09/2018 06:48 PM, Will Deacon wrote:
>> On Tue, Oct 09, 2018 at 04:04:21PM +0300, Kirill A. Shutemov wrote:
>>> On Tue, Oct 09, 2018 at 09:28:58AM +0530, Anshuman Khandual wrote:
>>>> A normal mapped THP page at PMD level should be correctly differentiated
>>>> from a PMD migration entry while walking the page table. A mapped THP would
>>>> additionally check positive for pmd_present() along with pmd_trans_huge()
>>>> as compared to a PMD migration entry. This just adds a new conditional test
>>>> differentiating the two while walking the page table.
>>>>
>>>> Fixes: 616b8371539a6 ("mm: thp: enable thp migration in generic path")
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> On X86, pmd_trans_huge() and is_pmd_migration_entry() are always mutually
>>>> exclusive which makes the current conditional block work for both mapped
>>>> and migration entries. This is not same with arm64 where pmd_trans_huge()
>>>> returns positive for both mapped and migration entries. Could some one
>>>> please explain why pmd_trans_huge() has to return false for migration
>>>> entries which just install swap bits and its still a PMD ?
>>>
>>> I guess it's just a design choice. Any reason why arm64 cannot do the
>>> same?
>>
>> Anshuman, would it work to:
>>
>> #define pmd_trans_huge(pmd)     (pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
> yeah this works but some how does not seem like the right thing to do
> but can be the very last option.
> 


There can be other code paths that makes that assumption. I ended up 
doing the below for pmd_trans_huge on ppc64.

/*
  * Only returns true for a THP. False for pmd migration entry.
  * We also need to return true when we come across a pte that
  * in between a thp split. While splitting THP, we mark the pmd
  * invalid (pmdp_invalidate()) before we set it with pte page
  * address. A pmd_trans_huge() check against a pmd entry during that time
  * should return true.
  * We should not call this on a hugetlb entry. We should check for HugeTLB
  * entry using vma->vm_flags
  * The page table walk rule is explained in Documentation/vm/transhuge.rst
  */
static inline int pmd_trans_huge(pmd_t pmd)
{
	if (!pmd_present(pmd))
		return false;

	if (radix_enabled())
		return radix__pmd_trans_huge(pmd);
	return hash__pmd_trans_huge(pmd);
}

-aneesh
