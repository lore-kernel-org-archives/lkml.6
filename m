Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3575EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AABA218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeLRWK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:10:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeLRWK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:10:56 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 00D0AD1F;
        Tue, 18 Dec 2018 22:10:54 +0000 (UTC)
Date:   Tue, 18 Dec 2018 14:10:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/3] hugetlbfs: Use i_mmap_rwsem to fix page
 fault/truncate race
Message-Id: <20181218141053.e2725111ce5cc91493efab5f@linux-foundation.org>
In-Reply-To: <dbc4abb9-aa7b-6515-0f37-23a77b50ff6e@oracle.com>
References: <20181203200850.6460-1-mike.kravetz@oracle.com>
        <20181203200850.6460-3-mike.kravetz@oracle.com>
        <27f8893b-57b3-088d-2d48-9e8acc5987bd@linux.ibm.com>
        <f6fd9491-4b3d-16ca-f606-025c78756936@oracle.com>
        <dbc4abb9-aa7b-6515-0f37-23a77b50ff6e@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 16:17:52 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> ...
>
> > As you suggested in a comment to the subsequent patch, it would be better to
> > combine the patches and remove the dead code when it becomes dead.  I will
> > work on that.  Actually some of the code in patch 3 applies to patch 1 and
> > some applies to patch 2.  So, it will not be simply combining patch 2 and 3.
> 
> On second thought, the cleanups in patch 3 only apply to patch 2.  So, just
> combining those two patches with a slightly updated commit message as below
> makes the most sense.

All confused.  I dropped the current version, let's try again.

This:

> Hoping to get more comments on the overall direction and locking changes
> of this and the previous patch.

and this:

> Cc: <stable@vger.kernel.org>
> Fixes: ebed4bfc8da8 ("hugetlb: fix absurd HugePages_Rsvd")

make for a hot combination.  Could people please prioritize review of
this code?

Perhaps a refresh and resend is in order.
