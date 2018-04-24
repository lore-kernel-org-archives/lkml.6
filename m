Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124706-1524577114-6-13756315910628874499
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524577113; b=T6hq/s0/yKdqHKyUtExQfqddNV8NpIqipjou0k1M4/xn7zaJgO
    K3ifpYrW8D2jTVwMSFcJI+MAuLCd7sxG3A15gc9xP/q8nnok9mHQ+4xT65LuAAc3
    NAUhu8c2KiGP8k+0H/1MJbJ566sgjQe4VpPBn+4v7hLfmkwDqnhmh9W3GpML8o1z
    7KH+RUPRQciNXt6e0JZ7EjoQfUTvAGN6Gbk1ot5XaD8camKVp26YoDqv0ZUKcI01
    FPx7rSRfww99uA6HG8oMhwvjeu9OWZikI1mzcvTPTI4xppf5J22NM4IOrTRe6pk8
    iYL3xjT+Wt/EqFbM4p0lEh04gHbp9xV4oEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524577113; bh=LhXxFheypIY3H9qt2fivM+o4+nbq3q
    MXAJ1nKf86aeI=; b=m6fYAo9hVNJuTGPb0DGdFymZDkJmAxyR+cC6JOR3u+Xym7
    ZTLtc5/KrV9N+xtdkLFdIgKBz4f3IEHi4TBxacB/XqfA7YRSVmq2Cp4SY1zp51KT
    8alJcLKIH5DEWGtl+3Yy63AwWmHzF+9zZOBStju+3h0g7f8q6FL9C5Debt6uWnRJ
    EMcHBEQF8ssp682QCV6O1NSycuMd9qEKVQJIJyF4C7M/HjPjTfDO/oJbhlZFj9ew
    wrWBVRo//k3xCfBpK5pQnQogiHx+90HJfxdTQsCfMDZ7hT6FkoAZbsiYmIUv+iDm
    T52YmncwKBNRPJpoIH5FaQqgX0oCuglcSc1O0+TQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP9BAnEkpk4W21Sf6SUmibmSn0EnW4m1MNQgqkOER2eKJ+ddEr9ohjvVSaAA7+3pqJ3LJNtHTEgo6btDJNAw3le43KQm0nEK8W8zfv6P22vtpivV52EO
    CiRUGpChKGLLlauMQkjrZiKnSsFJy6vKxkZh4gdiz+f8aEMsbsYk/tRJ45A31h2aP9DzhUmpLrrDoGv0N85tXFCv3fQkkQqARDpZb5oY2dwdEKuq3vhAcRDi
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=cDQm2WSucXWwO-Ly-boA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934416AbeDXNhu (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 09:37:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:52761 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933250AbeDXNhr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 24 Apr 2018 09:37:47 -0400
Date: Tue, 24 Apr 2018 07:37:40 -0600
From: Michal Hocko <mhocko@kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] mm: add find_alloc_contig_pages() interface
Message-ID: <20180424133740.GH17484@dhcp22.suse.cz>
References: <20180417020915.11786-1-mike.kravetz@oracle.com>
 <20180417020915.11786-3-mike.kravetz@oracle.com>
 <20180423000943.GO17484@dhcp22.suse.cz>
 <fc28bcb7-8f9a-e841-0fdf-8636523ebc2a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc28bcb7-8f9a-e841-0fdf-8636523ebc2a@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun 22-04-18 21:22:07, Mike Kravetz wrote:
> On 04/22/2018 05:09 PM, Michal Hocko wrote:
[...
> > Also do we want to check other usual suspects? E.g. PageReserved? And
> > generally migrateable pages if page count > 0. Or do we want to leave
> > everything to the alloc_contig_range?
> 
> I think you proposed something like the above with limited checking at
> some time in the past.  In my testing, allocations were more likely to
> succeed if we did limited testing here and let alloc_contig_range take
> a shot at migration/allocation.  There really are two ways to approach
> this, do as much checking up front or let it be handled by alloc_contig_range.

OK, it would be great to have a comment mentioning that. The discrepancy
will just hit eyes 

[...]
> Unless I am missing something, calls to alloc_contig range need to have
> a size that is a multiple of page block.  This is because isolation needs
> to take place at a page block level.  We can easily 'round up' and release
> excess pages.

I am not sure but can we simply leave a part of the page block behind? I
mean it might have a misleading migrate type but that shouldn't matter
much, no?

Thanks!
-- 
Michal Hocko
SUSE Labs
