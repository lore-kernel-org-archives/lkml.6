Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CFAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359CA20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfA2W4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:56:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58458 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfA2W4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:56:55 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35E213470;
        Tue, 29 Jan 2019 22:56:54 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:56:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V7 0/4] mm/kvm/vfio/ppc64: Migrate compound pages out of
 CMA region
Message-Id: <20190129145652.c4021a4adf8416618211c38d@linux-foundation.org>
In-Reply-To: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com>
References: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 15:24:32 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> ppc64 use CMA area for the allocation of guest page table (hash page table). We won't
> be able to start guest if we fail to allocate hash page table. We have observed
> hash table allocation failure because we failed to migrate pages out of CMA region
> because they were pinned. This happen when we are using VFIO. VFIO on ppc64 pins
> the entire guest RAM. If the guest RAM pages get allocated out of CMA region, we
> won't be able to migrate those pages. The pages are also pinned for the lifetime of the
> guest.
> 
> Currently we support migration of non-compound pages. With THP and with the addition of
>  hugetlb migration we can end up allocating compound pages from CMA region. This
> patch series add support for migrating compound pages. 

Very little review activity is in evidence.  Please identify some
appropriate reviewers and ask them to take a look?

