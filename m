Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0FAC64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF01C2088F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GuU1tA5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF01C2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeJHPN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:13:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32862 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeJHPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:13:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so8001831pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oxeM8za1/U2MkfbdVrL+qtk5WmQtU8Evgd30OvNpAQA=;
        b=GuU1tA5lGmAp7VFgs/OzIHyYNr2TcE3gvKTsgA9OtXW9KqOuBSccAX/AWD2ut/QWi8
         LZDfwVe99vRKE7SDUV67KuFQRsaDeaHDbCPessJZZzPLQ8Hebpku+sOX/ZBtbL78FuaV
         Kp2Xksv7dmQzIKeazXnPooTJxw4jkhclftLm6YCbzhkZ9eDh6Hr78Frvokondrik9gaz
         Yc0e59WcJaRgGa8O+Rpn38tVVzxBkSsblZVLPsq0xQNBXvDCI4akfoRyv8dHR6ifzb8D
         oW2mv+2yn3HxFjwoNOybonx7WOuU3iEwYUmS6zMRBh0gaXipS9c5H8UszNCHVn2gXd5F
         oy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oxeM8za1/U2MkfbdVrL+qtk5WmQtU8Evgd30OvNpAQA=;
        b=RHJCF8yblyQd9xaIbQbTnEZxduXtLktChfI/bqJeHeWGG2ErSjaO3NbNyPEKwiPQAB
         8tIa7d2xh1aQD2nFMZfEo9rDk3h6pKVYVjy6Cfk/hXjUOkSdYqr+buYtCWITZ1mWo+AP
         n+3HIO2Zgx8G5KeE+y5+5jrN96+A2QnRzgWhZK69WNUB2aKE2jueL/BQ0AIdVawNeFzc
         C0DZPXSkurF2HcSFJUOzuW/mz9rNJVLeThOs3JwPulbtIQif9Hj89Vffonf37Jnd3bnB
         9/TBikEeeSuw0I6rgdDtTmqXBO3IY36QJ5RDFHnvtgqlJLSdMgbRqWvYDSluR7plbS0y
         RsQQ==
X-Gm-Message-State: ABuFfojDKf9nNFclxCGDkL3HcqQaqjNuyzTzOExLNHir1pAb09YqdF0E
        ZSYd/5DiNPhEUQ8H7/B0OXP5nA==
X-Google-Smtp-Source: ACcGV61XL85YUHKdvA2nCkD6p17Dg7BGXWaWdsiIUYdO3nh2v0cD/xBJr+Gmd6a/32ZTE1HR+ZKF7g==
X-Received: by 2002:a62:968a:: with SMTP id s10-v6mr23652488pfk.191.1538985809595;
        Mon, 08 Oct 2018 01:03:29 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id c2-v6sm10794625pfn.95.2018.10.08.01.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 01:03:28 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 0D4D130002C; Mon,  8 Oct 2018 11:03:24 +0300 (+03)
Date:   Mon, 8 Oct 2018 11:03:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH RFC 1/1] hugetlbfs: introduce truncation/fault mutex to
 avoid races
Message-ID: <20181008080323.xg3v35uxgmakf6wy@kshutemo-mobl1>
References: <20181007233848.13397-1-mike.kravetz@oracle.com>
 <20181007233848.13397-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181007233848.13397-2-mike.kravetz@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 04:38:48PM -0700, Mike Kravetz wrote:
> The following hugetlbfs truncate/page fault race can be recreated
> with programs doing something like the following.
> 
> A huegtlbfs file is mmap(MAP_SHARED) with a size of 4 pages.  At
> mmap time, 4 huge pages are reserved for the file/mapping.  So,
> the global reserve count is 4.  In addition, since this is a shared
> mapping an entry for 4 pages is added to the file's reserve map.
> The first 3 of the 4 pages are faulted into the file.  As a result,
> the global reserve count is now 1.
> 
> Task A starts to fault in the last page (routines hugetlb_fault,
> hugetlb_no_page).  It allocates a huge page (alloc_huge_page).
> The reserve map indicates there is a reserved page, so this is
> used and the global reserve count goes to 0.
> 
> Now, task B truncates the file to size 0.  It starts by setting
> inode size to 0(hugetlb_vmtruncate).  It then unmaps all mapping
> of the file (hugetlb_vmdelete_list).  Since task A's page table
> lock is not held at the time, truncation is not blocked.  Truncation
> removes the 3 pages from the file (remove_inode_hugepages).  When
> cleaning up the reserved pages (hugetlb_unreserve_pages), it notices
> the reserve map was for 4 pages.  However, it has only freed 3 pages.
> So it assumes there is still (4 - 3) 1 reserved pages.  It then
> decrements the global reserve count by 1 and it goes negative.
> 
> Task A then continues the page fault process and adds it's newly
> acquired page to the page cache.  Note that the index of this page
> is beyond the size of the truncated file (0).  The page fault process
> then notices the file has been truncated and exits.  However, the
> page is left in the cache associated with the file.
> 
> Now, if the file is immediately deleted the truncate code runs again.
> It will find and free the one page associated with the file.  When
> cleaning up reserves, it notices the reserve map is empty.  Yet, one
> page freed.  So, the global reserve count is decremented by (0 - 1) -1.
> This returns the global count to 0 as it should be.  But, it is
> possible for someone else to mmap this file/range before it is deleted.
> If this happens, a reserve map entry for the allocated page is created
> and the reserved page is forever leaked.
> 
> To avoid all these conditions, let's simply prevent faults to a file
> while it is being truncated.  Add a new truncation specific rw mutex
> to hugetlbfs inode extensions.  faults take the mutex in read mode,
> truncation takes in write mode.

Hm. Don't we have already a lock for this? I mean i_mmap_lock.

-- 
 Kirill A. Shutemov
