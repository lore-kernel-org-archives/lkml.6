Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3258746-1524779723-2-5486527259607463592
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
    1524779722; b=C7hR57Cgc9b9Fn+2t9vuM5l8481d2CIljKVVZoOYLQta0ogWHS
    emG1P4kFeWjreGyR6IjzYskZp46Dw0k+XRmIKcpQYXLqdQFPMFHHwtvh93RYWDj+
    cHMX00ME3RPUQa1J9IgyPd7mcsLujdbhMkfjP44PmBSZCfzb6SgWEgbgZAoB3eNj
    CVGoWzf/kY3VC2vqHNSVxR8WY1mOKbmQNRTaIZI1yt9EFZgNnwwUnIzHgf4a5q1c
    S2LL7InzBonXV5mAnCwrNKVXDZ1YUheoUVpgC2nVhvzCwFoYextkASpJVdYn1l2/
    M5XheflikglA/E7Ia7lS5U02nk/i5smp52ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1524779722; bh=m11X7m5M2w7H9Z/zNtfxlxJD0saYzpA1mzxFDIL
    wRAg=; b=Y171Sge+rk/NmQ95HsXZLaktWcSPGpmu6mE1iV2OPYeACQxMYjiA/5a
    R6QHGgm6wI9a6yuRS9mkcN6P72suXTzrdSrBjMbIyDxWmQuL0Q5tMNyQnlym46P7
    GrpzuN9pmw6Ykqy4NUKkJevBB8Ht49aC7aJ377Rl+gGRodUiUNQfmUzMtqkKSofu
    fGymz/Df/UfoqZ9awvy4cdltbqfCCw5Ozc+hJqVo8SWUryHzII2IQM15SrFzP82w
    7YIS260m3cnMoU5Anu2UKfxno7SYG7SUBcRepIHl6EumNCmC6jz8onM50Hlyc6nj
    5O5AE7n7HrWDfbI+1HjZLX03iu50ncw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=YX4h5oLO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tI3Qld0c;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=YX4h5oLO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tI3Qld0c;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKURjs7/wntSCXYvmhpoTe47+T0Jt/o6lqKSVILWdbrtVAGJsXoEF3kQdv44BPPyAXywEcT7YuuFoPshQ4SbAfqk5PomcuGtA4jyFmlyTl25aoQJy4bN
    XiztrWs3iiAsKf4XfLdD1Z3zmeYuJreS9QlbzuGIO9PDJtEUWGNoxMO/3AyVh9SfBa9cvtwZ5N2BFR2b5bWU+ZvLSRQY+iR9R1MSQY3FHSBx/UDbEWLK8Dnr
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=FOH2dFAWAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8
    a=drOt6m5kAAAA:8 a=iox4zFpeAAAA:8 a=ufHFDILaAAAA:8 a=VwQbUJbxAAAA:8
    a=FJhQjeMXZctLDUCBs8cA:9 a=oxnmrYahi5d5i0S2:21 a=mD_BqaylhbH7tJed:21
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=i3VuKzQdj-NEYjvDI-p3:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=ZmIg1sZ3JBWsdXgziEIF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756568AbeDZVzI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 17:55:08 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38035 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754786AbeDZVzH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Apr 2018 17:55:07 -0400
X-Google-Smtp-Source: AB8JxZr1ddzPPiSh4iuWKXPOJ+4Pd7FNutsPZCILV9XQKMgj0EQlvimnBV6tBJ4Rc4qQ2WjGFWcU2w==
Date: Thu, 26 Apr 2018 14:55:05 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@fb.com, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: don't show nr_indirectly_reclaimable in
 /proc/vmstat
In-Reply-To: <20180426200331.GZ17484@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1804261453460.238822@chino.kir.corp.google.com>
References: <20180425191422.9159-1-guro@fb.com> <20180426200331.GZ17484@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 26 Apr 2018, Michal Hocko wrote:

> > Don't show nr_indirectly_reclaimable in /proc/vmstat,
> > because there is no need in exporting this vm counter
> > to the userspace, and some changes are expected
> > in reclaimable object accounting, which can alter
> > this counter.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> 
> This is quite a hack. I would much rather revert the counter and fixed
> it the way Vlastimil has proposed. But if there is a strong opposition
> to the revert then this is probably the simples thing to do. Therefore
> 

Implementing this counter as a vmstat doesn't make much sense based on how 
it's used.  Do you have a link to what Vlastimil proposed?  I haven't seen 
mention of alternative ideas.
