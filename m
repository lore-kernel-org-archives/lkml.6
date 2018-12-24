Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BACEC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001A621773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="jhkb2KLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbeLXKNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 05:13:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42578 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbeLXKNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 05:13:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so7948626lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 02:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XzfSQjR+KWr96uLBUlSlUb2qVfRyzU7+DIpahz0rd/I=;
        b=jhkb2KLdYco0ApRgWfPxnX0RwqFvnhCKgabM6VL3n0yX50DEodHw3w//z+c9vKJp+O
         yy4tIBS9089Y+Zm+TBIs5pGvczF1suQoabY29ogw9BziXXM9I2M4xmjUI8Q1FCU9eV5W
         II2Eh5ggMtVg65vxk59rIQECgnjnZspEytIFOrWCXaDNgQ9lcgVVB+v+bo6XvPdePFwy
         iM8tv1qkYF/Uk12+FZ/eP5BNflHabfdZy26yVrOeGNEOoSvTxZmvd0P/rlR+Wv/vHeSO
         tRSzLMYjWpemWA4GOX3c+7HHuqRGow2U+vvHacodMu/byRpl/RrGQV3+5/k7wUY0eg7b
         PeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XzfSQjR+KWr96uLBUlSlUb2qVfRyzU7+DIpahz0rd/I=;
        b=T3EMRaPm7mQMuxXpZTRGwOQZj5JUbTyvLC3NB3xhWdO9aDdWmhwjqPbUNRyKyOFp6s
         0u4FA0glXhHKIG6XPztzTuRT4+FcnrLJLvUmyphEe4hMFnOH0ob0L9UZA01kBe+eBVgD
         MgXC5MAp8rcuktdDOLmMIo0Dsj/LSpYZlNWK36bGTJq2nbSNpOdbFBzoHtLpIjdoy84J
         6/6h+QMROXwrkJpmT7OkFG5aoEL386Trd4NFwXNwl0ycHl+HBlHdXMzKRYVR+lLIyAC0
         SgPtzh82EfzkKxXyoCYKxqJR2mmoS5/2BoQ4/VDuN6Z+SWqlNXHKLk+N4Ozzc5bUMdbD
         m4FQ==
X-Gm-Message-State: AA+aEWa7f/80UJWxaQOMPJt+vY7QwPOok8dazUaxGH8lafll+RYsPro2
        7ysvuBxfeMsJH3M0YMzeuQ4dWQ==
X-Google-Smtp-Source: AFSGD/WBSS8CLrp5vfe44/oIn5JKDuaAzW2R4SqBILdkLVGrUd2+IqYe2nM8Ar3hFa1dT/Coed8UdQ==
X-Received: by 2002:a19:2d16:: with SMTP id k22mr5940091lfj.12.1545646432196;
        Mon, 24 Dec 2018 02:13:52 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (mm-127-199-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.199.127])
        by smtp.gmail.com with ESMTPSA id 12-v6sm6392392ljs.29.2018.12.24.02.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 02:13:51 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 887B9300816; Mon, 24 Dec 2018 13:13:49 +0300 (+03)
Date:   Mon, 24 Dec 2018 13:13:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/2] hugetlbfs: use i_mmap_rwsem for better
 synchronization
Message-ID: <20181224101349.jjjmk2hzwah6g64h@kshutemo-mobl1>
References: <20181222223013.22193-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222223013.22193-1-mike.kravetz@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 02:30:11PM -0800, Mike Kravetz wrote:
> There are two primary issues addressed here:
> 1) For shared pmds, huge PTE pointers returned by huge_pte_alloc can become
>    invalid via a call to huge_pmd_unshare by another thread.
> 2) hugetlbfs page faults can race with truncation causing invalid global
>    reserve counts and state.
> Both issues are addressed by expanding the use of i_mmap_rwsem.
> 
> These issues have existed for a long time.  They can be recreated with a
> test program that causes page fault/truncation races.  For simple mappings,
> this results in a negative HugePages_Rsvd count.  If racing with mappings
> that contain shared pmds, we can hit "BUG at fs/hugetlbfs/inode.c:444!" or
> Oops! as the result of an invalid memory reference.
> 
> v2 -> v3
>   Incorporated suggestions from Kirill.  Code change to hold i_mmap_rwsem
>   for duration of copy in copy_hugetlb_page_range.  Took i_mmap_rwsem in
>   hugetlbfs_evict_inode to be consistent with other callers.  Other changes
>   were to documentation/comments.
> v1 -> v2
>   Combined patches 2 and 3 of v1 series as suggested by Aneesh.  No other
>   changes were made.
> Patches are a follow up to the RFC,
>   http://lkml.kernel.org/r/20181024045053.1467-1-mike.kravetz@oracle.com
>   Comments made by Naoya were addressed.
> 
> Mike Kravetz (2):
>   hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization
>   hugetlbfs: Use i_mmap_rwsem to fix page fault/truncate race

Looks good to me.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
