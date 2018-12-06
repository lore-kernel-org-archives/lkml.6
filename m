Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0DFC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ED320868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOsSUTlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0ED320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeLFVmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:42:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40758 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeLFVmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:42:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so718400pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 13:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZNrhDs5PxEBlWuD1FLLXNATiY6plJdsQy7OCpiATADg=;
        b=FOsSUTlq8CQHjfeavw1acL7sE3waUi7axw308X33qdWeQ2wZiIL+HRU4jrqRdt7W8s
         +Q6jWx1PA+i+5H2iZWctsh+bmGfXGuJ7BWYlzJKq6XT8GUrwnZrbv+0CwppKNXTg/qtX
         O0BSAfmqWV+RRVMcAEQK2Z7HGSj42qO3T45iuAXIdjvQnMIPRGAivbGkRw2ZaATNTVgG
         R1c8/ayyeyll9FkNFIoexY/jk7QraeiCAJX+0vkmcnSur3wjb1PZAjQrXXSMYB7NP638
         7Lk4mujqjDlZmWOPxNVRtn1m+Y6SvIJj3o5dP/6qWoFVd7AhQi9CwQojU7A1/MGTA1XH
         n/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZNrhDs5PxEBlWuD1FLLXNATiY6plJdsQy7OCpiATADg=;
        b=VGcYjY//+zsBoSRqphHOedgVKjLTnAn9rEhTT8+TIoHl4r1pxiVxeMsCKDyMwk0Syt
         u3spubx7SVgiELPhHq6vU5TBzE4iBgp5ScVqtGj6gF6wV5cwXsOuEf19NZBtrJP75Ck1
         eHS89Qy5Ov1x4AA0WrZXQuDL61obpfn5Lfb1qXrfatBnJ3Z239e67tkLsmXgfJtzOZSA
         Hwrz/M9ZI5cGU+x+WXgOehoHzFJFi9hP9KzmkTkxIreKOzjG7U3zJDWjAIFnsAC5iHd5
         09hFYASYRofWd2O1/h/P4+pSNLMGqDLv7hKkkn06Fq8tf0rS90uXwnejNwt3DFefW8QH
         k6CA==
X-Gm-Message-State: AA+aEWaGIVhwecU/50XKOC7z5Jp1BpKKXRKnjOh32mtwuOiPicT6K9X3
        xmm7LCMQf0bH3lAQzOuXADtDvA==
X-Google-Smtp-Source: AFSGD/XiEeW7QB45AyxGaLY6Sy9I9yVIMwNUlXJrDwJNDG2HfVfY/Pfjv1CKpRkHB5PcnNryD4r5oA==
X-Received: by 2002:a62:1c96:: with SMTP id c144mr30106603pfc.129.1544132527260;
        Thu, 06 Dec 2018 13:42:07 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y6sm1939026pfd.104.2018.12.06.13.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 13:42:06 -0800 (PST)
Date:   Thu, 6 Dec 2018 13:42:05 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [patch v2 for-4.20] mm, thp: restore node-local hugepage
 allocations
In-Reply-To: <alpine.DEB.2.21.1812051445390.35948@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1812061341130.144733@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812051445390.35948@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, David Rientjes wrote:

> This is a full revert of ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for
> MADV_HUGEPAGE mappings") and a partial revert of 89c83fb539f9 ("mm, thp:
> consolidate THP gfp handling into alloc_hugepage_direct_gfpmask").
> 
> By not setting __GFP_THISNODE, applications can allocate remote hugepages
> when the local node is fragmented or low on memory when either the thp
> defrag setting is "always" or the vma has been madvised with
> MADV_HUGEPAGE.
> 
> Remote access to hugepages often has much higher latency than local pages
> of the native page size.  On Haswell, ac5b2c18911f was shown to have a
> 13.9% access regression after this commit for binaries that remap their
> text segment to be backed by transparent hugepages.
> 
> The intent of ac5b2c18911f is to address an issue where a local node is
> low on memory or fragmented such that a hugepage cannot be allocated.  In
> every scenario where this was described as a fix, there is abundant and
> unfragmented remote memory available to allocate from, even with a greater
> access latency.
> 
> If remote memory is also low or fragmented, not setting __GFP_THISNODE was
> also measured on Haswell to have a 40% regression in allocation latency.
> 
> Restore __GFP_THISNODE for thp allocations.
> 
> Fixes: ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings")
> Fixes: 89c83fb539f9 ("mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask")
> Signed-off-by: David Rientjes <rientjes@google.com>

We've identified a couple more regressions wrt 89c83fb539f9 ("mm, thp: 
consolidate THP gfp handling into alloc_hugepage_direct_gfpmask") in 
automated testing so I'm going to be proposing a full revert of that 
commit for 4.20 as a follow-up to this.
