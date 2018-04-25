Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1367245-1524691213-2-10069037766067448867
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524691212; b=pFtn6eY68g2i4S/kUlYsx1T6tEJFpGSrAM9260tEiSqFgXKbco
    2Ydefu9lJv2gMyVys6qEzMewQOE4ztRJAxArZ1qQhu8WEKZdxf9LrjpxNOnIPURv
    TxcIR8oyZduESOydN9t/u4KaIsrAAW1iZd7V0TLKYfZLm7gO3kfEA0V/pyQ9B9hN
    kw4HZ0Rf3sh/+eFggHhCvYGtCUp3D6bhv0EZM79bBMKXCswMVu7O/sbRN2MHcQa9
    jQ3wvJL2/qADs8+j+RjKPdWPj9U1+Ga9OI4qkAL5RUqf97uYYXtJa/TrR4z8xy8m
    85u6VTBrbZnMxpkjRw/UBbfKV8EFDtJQuZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1524691212; bh=WrYS5/KV7AtHr7veNsj7yAVs/wJ1slqv8EkWJyc
    OmDc=; b=kuaDHnON5Yp+8CJIo8SZtQ7twluFtpRCkG5CSrfXxYFYDXj2sAsd4yp
    05Olnbtz7utEn0PB8GzZFcOmAb89uPOpDo/sSbatUTrDdwc4YILq3ItDe1XcDvWR
    PxgFLi4s6HVIYsjtn1drNoIKBC+o3OCJOleGYObNkLTQaY5JoPPP8b54MlANZG2G
    KwsEg9UfuJowuU1Yy390uFzQ39afFthe/YtdhNvs2NIt1CtK1I9jPXJsX2Nqp2aG
    HHtlNbURGY+6UH72k7mL9FIXP9KatN7+xO8WLllgXu4Gy/nnVBDaht7kXSEBagAr
    JC04mOwTYKSKKAfthY2gZRnU5OJtw0A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=n3FML7dG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SpgSc/67;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=n3FML7dG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SpgSc/67;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEuxrbMesLBuAEN+Ki9g+kceqzKTDz6PtIIcbU2oNGJsEde2uhtRlH2cha8uxy6T7kJ0pnz9H6/6fK32529u+GSsj0HVheBaSHJ4tA5OHFrizzz/Hxe1
    UDYptzOOWEUQ/gNYFue09GliFXtxXNJj1jecAjgY7jCH6TJFmHFvHeBgiWZPGJa9hVjR2bIvijAik9z6TU66HAe+Ro5fqaJAXTpkJ6U1NcbNqD3bvMq+t/q2
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=ILOYNr3988GFYAbVIXUA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeDYVUJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 17:20:09 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40277 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbeDYVUJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 17:20:09 -0400
X-Google-Smtp-Source: AIpwx49V7WUzlson2idGZCQyroBX3SAYSsEnkutRfbsI5PhFCJ9G7Qzb3TD1l+/ZNHtzIBiF/NsuMg==
Date: Wed, 25 Apr 2018 14:20:07 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Roman Gushchin <guro@fb.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, kernel-team@fb.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: don't show nr_indirectly_reclaimable in
 /proc/vmstat
In-Reply-To: <20180425210143.GA10277@castle>
Message-ID: <alpine.DEB.2.21.1804251419040.166306@chino.kir.corp.google.com>
References: <20180425191422.9159-1-guro@fb.com> <alpine.DEB.2.21.1804251235330.151692@chino.kir.corp.google.com> <20180425210143.GA10277@castle>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018, Roman Gushchin wrote:

> > > Don't show nr_indirectly_reclaimable in /proc/vmstat,
> > > because there is no need in exporting this vm counter
> > > to the userspace, and some changes are expected
> > > in reclaimable object accounting, which can alter
> > > this counter.
> > > 
> > 
> > I don't think it should be a per-node vmstat, in this case.  It appears 
> > only to be used for the global context.  Shouldn't this be handled like 
> > totalram_pages, total_swap_pages, totalreserve_pages, etc?
> 
> Hi, David!
> 
> I don't see any reasons why re-using existing infrastructure for
> fast vm counters is bad, and why should we re-invent it for this case.
> 

Because now you have to modify the existing infrastructure for something 
that shouldn't be a vmstat in the first place?
