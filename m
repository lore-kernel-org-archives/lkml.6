Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799E4C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA4F2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="PSaS/yO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA4F2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeIZSx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:53:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36465 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIZSx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:53:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id b7-v6so5976418pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E0J3V4AW01U5Wv2URu1E6DqtJjLetMpEEm0wumBcFyc=;
        b=PSaS/yO8YCnjLuDkJa16qXz1/aTVQz7jsXMYxg0CBfTNnsK57jLtl+NtD/La+sBwPs
         8aX6YeZc7YjHQxjseoYeG0kpG6XYTmZhfOI2reA9vzhNU68i//i+KkRMrDkWx8wTQ3d8
         weflInNtFARH5Zt/FIuIfszWqrD4e1wRfct2nHXaUtOHEduP5FwuSY7ZHKfxWhc1T6qU
         vn9wfv/1VugxIE1S2weI3BuzNvyNjdxnd3aQgk/9utBLEwHWtIZHfJuycUnGCK6ptUBN
         bJKgnT8J9zJoww6+QVqBMm5nzz1DBNYl2HzEgLNiiBvJMdmcrWmUZLa0EqAu/ZKTyQzY
         5AUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E0J3V4AW01U5Wv2URu1E6DqtJjLetMpEEm0wumBcFyc=;
        b=jtM0kfa/rJy4hpwKxZjnX7xqZjoTfpjbA2ExxjMT4TbWbKqY7mtMD4xehEGHb7FCgC
         zApTaD2SDb9Stk9SLjKvr11KtwE8I/aug7doy4mu6mNT7KcgEdQyXVyVUcKmGzVzamo/
         IioomfK1cggh8yD2AqptCKjGyD2CLuTS+79akDp5h7rIk4SGY3z5CYN52OkE11hoAX5c
         T/Im+3vCqyjfuTTm4Nw1SEzzmfpRHHTfWtVuvRqIZJGkMkZ2NPJn1/W5UpAOJQTNlPrF
         sErEI0g/2GUiAyv+9U42/IlOgJjFHlmudtqDEr03di26dmI1eARfwFLIsDOPI4bILl/P
         bvRQ==
X-Gm-Message-State: ABuFfogdgS1TU8cRx8xKn7yXXAeLaXoCIpWcREgXk1g1xfMEC6MTu/fC
        8HbodCseC2kKqpVPUcIkO4lohw==
X-Google-Smtp-Source: ACcGV61uW7/APAM95kSAEM8vzjvthkTRc6y8leuJ9REs7oPI3GJtCs4aS8qkiPE6ZF9yXmq5yZtnQQ==
X-Received: by 2002:a62:8490:: with SMTP id k138-v6mr2962884pfd.177.1537965637173;
        Wed, 26 Sep 2018 05:40:37 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id 5-v6sm16209671pgt.83.2018.09.26.05.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 05:40:35 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 1D3B4300029; Wed, 26 Sep 2018 15:40:32 +0300 (+03)
Date:   Wed, 26 Sep 2018 15:40:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: Recheck page table entry with page table lock held
Message-ID: <20180926124032.gxvo43sisumybysu@kshutemo-mobl1>
References: <20180926031858.9692-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926031858.9692-1-aneesh.kumar@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 08:48:58AM +0530, Aneesh Kumar K.V wrote:
> We clear the pte temporarily during read/modify/write update of the pte. If we
> take a page fault while the pte is cleared, the application can get SIGBUS. One
> such case is with remap_pfn_range without a backing vm_ops->fault callback.
> do_fault will return SIGBUS in that case.
> 
> cpu 0		 				cpu1
> mprotect()
> ptep_modify_prot_start()/pte cleared.
> .
> .						page fault.
> .
> .
> prep_modify_prot_commit()
> 
> Fix this by taking page table lock and rechecking for pte_none.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> V1:
> * update commit message.

You choosed to stick with VM_FAULT_NOPAGE, that's fine.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Should it be in stable?

-- 
 Kirill A. Shutemov
