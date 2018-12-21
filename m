Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30AAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923AE21939
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="0Kywe/eZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390427AbeLUUVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:21:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36208 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbeLUUVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:21:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so5815204ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 12:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oCuWIybZCBvA/WvzquDNFPGfWXKrZE1FK2XTD9BeqdE=;
        b=0Kywe/eZIN5jNgVFiFnsd70xV3iJbzRm+wg6KsnpD4sDO96YzdcE/Xpg3chjvrozUP
         +NUugEcQp9Id6Fi+bwCNQxYvnpcJxrSRd9TdpZ8UiOp5ORMaWuT8/I7D6CNUY5EryfjJ
         Gle0nCXq/46KOT17NYfUuvJaAm6Up9x8fUVdA0nZ7NrQ1BpA8VFETws09u/uhkUsZmvh
         +6jTWiIafS4/QH5j9v27DbcX1jQPricThP8q/kqL/5FfdmaNIeL+BeivscYHwWz0D2np
         gI94xi6jU5ZsRjWkg0W/izRpgm/ISf2uQUaSeXsNH6ChYVGNzaKlZEqj4VMWPzbS2BVL
         gUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oCuWIybZCBvA/WvzquDNFPGfWXKrZE1FK2XTD9BeqdE=;
        b=BcZKdLjq+xsV/eFvniJQxStzA/8oDymnKogr3ktFew5WZnqpBIGWsaz6E/7UqSEQAb
         kSeun4Pg+ofLGorf3aIWtgmsfo/etlDoVm68gN2GtEfLhR+Tlv1UMadNLHIcfnCo5JyV
         j4fu38vhk3eZ20hvp82RIwnKpTolMokwrZ7eYTcfNl77YQ4shqtveyAj46oX0vZJfomY
         tJiAx/ECekOXGq1rFf/c60D3sk5S9xmZDz6aHGjvJTxf5NTkBTqEwwUfLkI3Ki0NYeLg
         qtVb5gJ26C38KGxVJT4A+iLXbLxlxetgNFLaYJ3KILa4jVlPWPV5Hrlvy4ShRbctj2Lf
         3wxw==
X-Gm-Message-State: AJcUukehghYPxSGWqm+4C4DtN7ikrEsBj/reyEQhM50pAFJ3E6qOS+E2
        MpYOdpwmVwu9knSpJPxY1EuZAA==
X-Google-Smtp-Source: ALg8bN4Aft2oOQKrqbOZo+FcuDdVDKKNsaeLb0gHys8m41Q8zS+PyxJ27zQ5cGcjg+zKNQZ9OUjiSw==
X-Received: by 2002:a2e:9256:: with SMTP id v22-v6mr2740535ljg.178.1545423700080;
        Fri, 21 Dec 2018 12:21:40 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (mm-127-199-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.199.127])
        by smtp.gmail.com with ESMTPSA id g70-v6sm4912287ljg.92.2018.12.21.12.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 12:21:39 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 5562F300816; Fri, 21 Dec 2018 23:21:37 +0300 (+03)
Date:   Fri, 21 Dec 2018 23:21:37 +0300
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
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hugetlbfs: Use i_mmap_rwsem to fix page
 fault/truncate race
Message-ID: <20181221202136.crrwojz3k7muvyrh@kshutemo-mobl1>
References: <20181218223557.5202-1-mike.kravetz@oracle.com>
 <20181218223557.5202-3-mike.kravetz@oracle.com>
 <20181221102824.5v36l6l5t2zthpgr@kshutemo-mobl1>
 <849f5202-2200-265f-7769-8363053e8373@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849f5202-2200-265f-7769-8363053e8373@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:28:25AM -0800, Mike Kravetz wrote:
> On 12/21/18 2:28 AM, Kirill A. Shutemov wrote:
> > On Tue, Dec 18, 2018 at 02:35:57PM -0800, Mike Kravetz wrote:
> >> Instead of writing the required complicated code for this rare
> >> occurrence, just eliminate the race.  i_mmap_rwsem is now held in read
> >> mode for the duration of page fault processing.  Hold i_mmap_rwsem
> >> longer in truncation and hold punch code to cover the call to
> >> remove_inode_hugepages.
> > 
> > One of remove_inode_hugepages() callers is noticeably missing --
> > hugetlbfs_evict_inode(). Why?
> > 
> > It at least deserves a comment on why the lock rule doesn't apply to it.
> 
> In the case of hugetlbfs_evict_inode, the vfs layer guarantees there are
> no more users of the inode/file.

I'm not convinced that it is true. See documentation for ->evict_inode()
in Documentation/filesystems/porting:

	Caller does *not* evict the pagecache or inode-associated
	metadata buffers; the method has to use truncate_inode_pages_final() to get rid
	of those.

Is hugetlbfs special here?

-- 
 Kirill A. Shutemov
