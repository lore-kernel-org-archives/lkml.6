Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1313496-1527143382-2-11273670424903812076
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527143381; b=Us1RHuAultd8wQ6Ejt0XjkAL0ACAnfztrNaWhQlKd87cmn0K3E
    fq3BMYCzZFh+RDaQ/MPEdrRfuNaQsw6GC1scQWUPqWFQfi+VQNe063Zt2RVIGxJF
    Ai6IfOdZxaYqVmY7CprN12EQRxJswyD+ktLMu3DvGQdDJzCfeH1eNrGAgTWlG8jI
    4010+iJlRN+mZI8iwU2gVLrthOTQBwI7sDNBq0GZqom2FvSbYjuzeRU1esP4xvsD
    O/bcALuT9TK1sGVU8JZfglmbCJWh58SRskEq91Am9JyW96zua+JvtIAXUA57bK3h
    m7ZHBRLUusyo27Gp24pDXy6oWBNX+qxhGYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527143381; bh=3UxekWG57ZlCFFeb5tg+dgyOCd7tTw
    EyaGmNlFsHHss=; b=MeLQLkY5tRnPvuIyPrHVS55JG286NDcp8mH5ZTf/dERdNi
    xkItBeZ6IqxZ8/lBUYSsE5zGgDhKFYAZddFySPJRlwZYNlXNa8iwEL0wzaJnUC8q
    gfYNvyUvQQ6VT3IhIZsUQ9gywSUtSYQhmEN5VxUBbTMIrKKqlk1mlJNwjAEPUDW5
    rUnsLyTSjUQR6g+P5NDT0kXH1efHDZsoDpDowjuuniS1yGaFxe5353oMMChdDZaQ
    /xXpiozLKlPHnB0YmsHLojKZXInwWD2ySlC+9zkVKI7wa2ikIfDhLxVhCIN8us9B
    BozDRyK245Nlq1m+hzGsQON8yST30Vi1Hn84pidw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN2d+g0fH3ja77fuhOGw4HfMCfXA1By/R+7jWbFS774js3/+npyFsmvGhoHzIJgv863bvoemxwX+Ep6xC9hGkE4Oj2UFprlzfeSJXfFi7Wbc93Ap3WGK
    YrdfRXJDLmEXvI2+MnMsDpUVSWa504wkIZ6H4zk0ZsjyHyfkV8LhZJdHaO4+N0SDyvHnEyFmn2fhpzO7pJseewAm0/m8ccjXtU4iXdR5SfWPNGj1saB6jYRL
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=Liqdb50Gv2oqPZ_3m_wA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755110AbeEXG3i (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 02:29:38 -0400
Received: from verein.lst.de ([213.95.11.211]:57895 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754963AbeEXG3i (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 02:29:38 -0400
Date: Thu, 24 May 2018 08:35:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] mm: rework hmm to use devm_memremap_pages
Message-ID: <20180524063507.GA9750@lst.de>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com> <20180524001026.GA3527@redhat.com> <CAPcyv4hVERZoqWrCxwOkmM075OP_ada7FiYsQgokijuWyC1MbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hVERZoqWrCxwOkmM075OP_ada7FiYsQgokijuWyC1MbA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 08:18:11PM -0700, Dan Williams wrote:
> On Wed, May 23, 2018 at 5:10 PM, Jerome Glisse <jglisse@redhat.com> wrote:
> > On Mon, May 21, 2018 at 03:35:14PM -0700, Dan Williams wrote:
> >> Hi Andrew, please consider this series for 4.18.
> >>
> >> For maintainability, as ZONE_DEVICE continues to attract new users,
> >> it is useful to keep all users consolidated on devm_memremap_pages() as
> >> the interface for create "device pages".
> >>
> >> The devm_memremap_pages() implementation was recently reworked to make
> >> it more generic for arbitrary users, like the proposed peer-to-peer
> >> PCI-E enabling. HMM pre-dated this rework and opted to duplicate
> >> devm_memremap_pages() as hmm_devmem_pages_create().
> >>
> >> Rework HMM to be a consumer of devm_memremap_pages() directly and fix up
> >> the licensing on the exports given the deep dependencies on the mm.
> >
> > I am on PTO right now so i won't be able to quickly review it all
> > but forcing GPL export is problematic for me now. I rather have
> > device driver using "sane" common helpers than creating their own
> > crazy thing.
> 
> Sane drivers that need this level of deep integration with Linux
> memory management need to be upstream. Otherwise, HMM is an
> unprecedented departure from the norms of Linux kernel development.

Agreed.  I consider every driver using this a derived work, independ
on the marking or not.  And I'm willing to enforce this.
