Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7D4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D88208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="juOGvQGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D88208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeHWAk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:40:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47006 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeHWAkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:40:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so1467566pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZeZtC1OZjSMCa2q8CctA0YI/urjnWDXPoeqECLJOF+I=;
        b=juOGvQGZWZh6SN686zjsZ58qM1zDqJDwDu8iqnwVpfSMd+k7263NsLthDE1rfmn0eo
         08B2vkhqPXYjxOahbja7B0PPBmFGuy+5dLMka9eMnBvOzJj0s2aS6zL3uHkEKTv8RPZf
         GxQmgD8EcCGY4j8N0gYHb0Tb2pSTZi5+tqj04eEP93Yyee5qf+XxX2Y5/aXE/KA/U4R+
         /QMMhG9nYPvR0lStHobRoOE8CSwSAWkgyjpf5YoPhDr1p123L/gA6Vpa6ED7O3s9qX58
         5kYC/H1e7v4hcAcB9RXqnOcBgpT3uoSnRqLgQBGriJShvhk1OxdIPFR9Er6esrJwzRa1
         PhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZeZtC1OZjSMCa2q8CctA0YI/urjnWDXPoeqECLJOF+I=;
        b=am2Amb+2xQSR6r1k0csunvWussLypTBUKi0GGgi5wmqTO0zoKizcTVNOBJlmTuZI5+
         CJXxPYhFOTVZt1SRK/+IZuhR1HhcKb7kh8j9ppAlQwYddjoBLUkMVUPZtkPaSQQsbAaI
         aBHNEASEPryfZ4mBtN0Ba84UEo48pLTX7Vwpr5/l4yVopME8f4DT59YaQgRMviz7tOP/
         zR42sq0SQSHk77TjiUAsH2VmgIEAOLMvvGEqIEtX5sFufCDN/0dsbRwZ2Xj7yIpZSwS3
         JP+mGGrjtz/35E+OjsHbMA5yAtpflKWOrw4Egc73ddVqhxdgfHJSuQYFafzy0cSJb51i
         pG2w==
X-Gm-Message-State: AOUpUlEy6ordLfD+rBQmVx/xNpM20szwv4LGzT8e82o0TTfxOdAfVnXq
        8oJGHYwAWUSxceXvU6OieoCvoQ==
X-Google-Smtp-Source: AA+uWPyOd2G9pkkQ5qrPv+75bB37EtxGFWsypSSKjxyQ3UP44TCNfNKRgFkX4ObPKwUTbzo6PU7mRg==
X-Received: by 2002:a63:5143:: with SMTP id r3-v6mr53732383pgl.11.1534972434535;
        Wed, 22 Aug 2018 14:13:54 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id g66-v6sm4537522pfk.39.2018.08.22.14.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 14:13:53 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 3CE1F3000BD; Thu, 23 Aug 2018 00:05:07 +0300 (+03)
Date:   Thu, 23 Aug 2018 00:05:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: migration: fix migration of huge PMD shared
 pages
Message-ID: <20180822210507.lvb26bghqmt6c5fw@kshutemo-mobl1>
References: <20180821205902.21223-2-mike.kravetz@oracle.com>
 <201808220831.eM0je51n%fengguang.wu@intel.com>
 <975b740d-26a6-eb3f-c8ca-1a9995d0d343@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975b740d-26a6-eb3f-c8ca-1a9995d0d343@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 06:10:42PM -0700, Mike Kravetz wrote:
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3103099f64fd..f085019a4724 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4555,6 +4555,9 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
>  
>  	/*
>  	 * check on proper vm_flags and page table alignment
> +	 *
> +	 * Note that this is the same check used in huge_pmd_sharing_possible.
> +	 * If you change one, consider changing both.

Should we have helper to isolate the check in one place?

>  	 */
>  	if (vma->vm_flags & VM_MAYSHARE &&
>  	    vma->vm_start <= base && end <= vma->vm_end)
> @@ -4562,6 +4565,43 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
>  	return false;
>  }
>  
> +/*
> + * Determine if start,end range within vma could be mapped by shared pmd.
> + * If yes, adjust start and end to cover range associated with possible
> + * shared pmd mappings.
> + */
> +bool huge_pmd_sharing_possible(struct vm_area_struct *vma,
> +				unsigned long *start, unsigned long *end)
> +{
> +	unsigned long check_addr = *start;
> +	bool ret = false;
> +
> +	if (!(vma->vm_flags & VM_MAYSHARE))
> +		return ret;

Do we ever use return value? I don't see it.

And in this case function name is not really work...

> +	for (check_addr = *start; check_addr < *end; check_addr += PUD_SIZE) {
> +		unsigned long a_start = check_addr & PUD_MASK;
> +		unsigned long a_end = a_start + PUD_SIZE;
> +
> +		/*
> +		 * If sharing is possible, adjust start/end if necessary.
> +		 *
> +		 * Note that this is the same check used in vma_shareable.  If
> +		 * you change one, consider changing both.
> +		 */
> +		if (vma->vm_start <= a_start && a_end <= vma->vm_end) {
> +			if (a_start < *start)
> +				*start = a_start;
> +			if (a_end > *end)
> +				*end = a_end;
> +
> +			ret = true;
> +		}
> +	}
> +
> +	return ret;
> +}
> +

-- 
 Kirill A. Shutemov
