Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-987394-1524675670-5-13175826899729613151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524675670; b=lZ/mFYs2XfkIaoH0UMwYZLoYaWCnfLUFE53U3sTM54kzxfaTNB
    fxlu7WWudCHvhsYXkcoH0x0gtuzkfHHyfNdtaWYotQagPIsivPwl9LXFL5Z23Kcn
    IugddmIQ55kVjemV+iwDMOPCkyyV+60oYjlop6nIiJk1c1Kns1D/G54mOcmMd5co
    FWL36JJTYNf5iffx+4l8Xa73q7UKex0ruBy+P427jlmJvMkLeVDV9/c9HkVROZOJ
    +pPSX+Xx6ip6rNCZcWqgYSX5Y30uTRu90cpKFD2Th7a0CNj6f0LEbvHhmxwC1Slk
    xh0JFgjA1/USu2Q563kbwGDGlqT/Ea07MXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524675670;
    bh=espkSNu8Iz/G+yqEKLBiptf4D0pW9O7JCIpS1nxyaIY=; b=vc5cgpPJRqze
    ay14n3OZWd8nwPPb9kpvSG42mhfg+OT/adcVUCdtq/5bY9Js4Pu1eN7KDqBkgZi7
    oykp+ItVJE1Desgeiq8UW7hRtPDln+sxr/U7cSaJGsIVHIlBPOxRP5JooMUYE77r
    AoBdKwmGceTdlvbKlinCGMcoRRzvgJYX8W1529wKUHuEKj/3z0F1VjQp9wAVrsLJ
    f3oKq7LB6SPF4bx/DOj3AAPTuANi4jpOAzHKKKdCqCAIHJqGbTY4C2uL5qQgWsyl
    TipPjCOrIj52x29TXxxHRNvvsK3bvZqM0XSQ+8OhWohuAqub9VRyeLJAFuE0jHeO
    VZFh18W16Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGtaOg+KCsWZN7Z1NClPSILdPewDIfLdbU3dGtjHA6GmpzYcR9nSVqxIszTFxcHd8htVpR7qUjgGh02URn3DbC5Ih+ph/ca3noXMq8tNv1K6zgyhnHcB
    y2QSTcktjMnnjp0ZMlsOEWfuJNQwauQufmWFhQsV/HWOdWwz9hguAVs+eCTd1xqCLADeBHbP7f5k5lT9iRVCqfBXtnP+kz9rBec1y/k4wEUrJ05tlwzk+Ukv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=-aMR6oKcYKtIDxl3OdQA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755245AbeDYRBG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 13:01:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:57711 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754618AbeDYRBF (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Apr 2018 13:01:05 -0400
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
To: Matthew Wilcox <willy@infradead.org>,
        vinayak menon <vinayakm.list@gmail.com>
Cc: Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Linux API <linux-api@vger.kernel.org>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
 <20180411135624.GA24260@castle.DHCP.thefacebook.com>
 <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
 <20180412145702.GB30714@castle.DHCP.thefacebook.com>
 <CAOaiJ-=JtFWNPqdtf+5uim0-LcPE9zSDZmocAa_6K3yGpW2fCQ@mail.gmail.com>
 <20180425155539.GB8546@bombadil.infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <04bd46b5-b67b-9b0c-edb9-7e92427b9cef@suse.cz>
Date: Wed, 25 Apr 2018 18:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425155539.GB8546@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/25/2018 05:55 PM, Matthew Wilcox wrote:
> On Fri, Apr 13, 2018 at 05:43:39PM +0530, vinayak menon wrote:
>> One such case I have encountered is that of the ION page pool. The page pool
>> registers a shrinker. When not in any memory pressure page pool can go high
>> and thus cause an mmap to fail when OVERCOMMIT_GUESS is set. I can send
>> a patch to account ION page pool pages in NR_INDIRECTLY_RECLAIMABLE_BYTES.
> 
> Why not just account them as NR_SLAB_RECLAIMABLE?  I know it's not slab, but
> other than that mis-naming, it seems like it'll do the right thing.

Hm I think it would be confusing for anyone trying to correlate the
number with /proc/slabinfo - the numbers there wouldn't add up.

