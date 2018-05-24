Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-936554-1527120639-2-15262003155138147250
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527120638; b=arQJZudIRninc327GxFh5bmDrJvGdsTk40fWSshArBJs/uf13z
    wFxV3AeskjMkv/cQ6jc0vN4A0kHcjJdC7KAgtnaMGMpHnqTkiIYOPRMxXfVeX+YJ
    qVw6axly7C1zS78zkc8a4UZv+fOSgAobHJW+qRhKNiS239k/E4Itzkekws8np0FZ
    rEZj+fapuhEHrDEyyrg9suKBtGX2So5OR49+1LoUU7eDJiwa2r3tGZUDR++lw7f2
    eTYKqNltiJ2pj74NOyRO5oSJac9kl7jaOd8W3PEpDD3sUucsM8gWVVyFuJvDe0fh
    WTePPdjUfzFl7/vA0aWKi8/CN/rJEdFHUEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527120638; bh=CoCwYl1/eSa/NVeXAt9IzX1yj0D+GG
    flNRrhGUq1fSo=; b=fq6+zRyk8RDgJa5YNZl81vvHg4RsgJTvA153llCs9iCiyZ
    7Lc1OipKo0Hn5OCUDz4ckkxYvwUACSveEioFFqa0xLlk/jqOXSbkTpAkfYFQIFJ9
    sk2S2FbMDFMCdb/1KNcLDYZbbPUUuwHS/+EnEc+7UKLHl6taT5O3cd+3oC2m627Z
    5E42qvj7yWo2F9OJ+hmmvWuGIJdg5JHZfWtsfZue09rHI5C3tz1+6CnxqpAHHucu
    kNTX4UigcrFSEnw9CMZF+Wwh5ll6+p7cv7+PzRWogFbJ7Z+6If3QmZmdSptcl08Y
    DqwgJ3oLVIH/WRRHRbLqAu8CuOI7MkRc6VwIbKeA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfId83zSnF6n5x0g+05XzP7Q6pmaHHyh7Jl24HfYkIOZ2a4YSDjEIYSdbGv3iLpxCgzvAft5Qhyq5rB1UEjnkXn2jrMT6vIOQY9cwtHpwcwuEk8Lfjk9w
    lvpOA+KTdhgLDiGrDiFKHSWOnsYehNnch7fKpa/8LQVxtDe6f1l6I9uatz6kE9Dfxje/QffuqpESiSHpyd59uyYETNbcYpJns2QV0R3h+TqmUBXNbfON3Grg
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=Q_k2nyfDygmkEbzaU2gA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935125AbeEXAKf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 20:10:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935106AbeEXAKf (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 23 May 2018 20:10:35 -0400
Date: Wed, 23 May 2018 20:10:27 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, stable@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] mm: rework hmm to use devm_memremap_pages
Message-ID: <20180524001026.GA3527@redhat.com>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 21, 2018 at 03:35:14PM -0700, Dan Williams wrote:
> Hi Andrew, please consider this series for 4.18.
> 
> For maintainability, as ZONE_DEVICE continues to attract new users,
> it is useful to keep all users consolidated on devm_memremap_pages() as
> the interface for create "device pages".
> 
> The devm_memremap_pages() implementation was recently reworked to make
> it more generic for arbitrary users, like the proposed peer-to-peer
> PCI-E enabling. HMM pre-dated this rework and opted to duplicate
> devm_memremap_pages() as hmm_devmem_pages_create().
> 
> Rework HMM to be a consumer of devm_memremap_pages() directly and fix up
> the licensing on the exports given the deep dependencies on the mm.

I am on PTO right now so i won't be able to quickly review it all
but forcing GPL export is problematic for me now. I rather have
device driver using "sane" common helpers than creating their own
crazy thing.

Back in couple weeks i will review this some more.

> 
> Patches based on v4.17-rc6 where there are no upstream consumers of the
> HMM functionality.
> 
> ---
> 
> Dan Williams (5):
>       mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL
>       mm, devm_memremap_pages: handle errors allocating final devres action
>       mm, hmm: use devm semantics for hmm_devmem_{add,remove}
>       mm, hmm: replace hmm_devmem_pages_create() with devm_memremap_pages()
>       mm, hmm: mark hmm_devmem_{add,add_resource} EXPORT_SYMBOL_GPL
> 
> 
>  Documentation/vm/hmm.txt |    1 
>  include/linux/hmm.h      |    4 -
>  include/linux/memremap.h |    1 
>  kernel/memremap.c        |   39 +++++-
>  mm/hmm.c                 |  297 +++++++---------------------------------------
>  5 files changed, 77 insertions(+), 265 deletions(-)
