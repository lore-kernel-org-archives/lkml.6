Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2816C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE9D20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE9D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLGXM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:12:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:12:28 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E7DED89C;
        Fri,  7 Dec 2018 23:12:26 +0000 (UTC)
Date:   Fri, 7 Dec 2018 15:12:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, mpe@ellerman.id.au,
        paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 0/3] * mm/kvm/vfio/ppc64: Migrate compound pages out
 of CMA region
Message-Id: <20181207151226.cb00ace433738cf550e66885@linux-foundation.org>
In-Reply-To: <20181121092259.16482-1-aneesh.kumar@linux.ibm.com>
References: <20181121092259.16482-1-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 14:52:56 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> Subject: [PATCH V4 0/3] * mm/kvm/vfio/ppc64: Migrate compound pages out of CMA region

Asterisk in title is strange?

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
> patch series add support for migrating compound pages. The first path adds the helper
> get_user_pages_cma_migrate() which pin the page making sure we migrate them out of
> CMA region before incrementing the reference count. 

Very little review activity.  Perhaps Andrey and/or Michal can find the
time..

> mm/migrate.c            | 108 ++++++++++++++++++++++++++++++++++++++++

can we make this code disappear when CONFIG_CMA=n?
