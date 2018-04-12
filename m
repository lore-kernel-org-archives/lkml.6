Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-868050-1523533946-2-12452629311053458864
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
    1523533945; b=Zkg+DcdVIsNmKSdsGHsdNGJDkzSCQ25inBxZUh6xzlZPX83/zo
    q8o9AZanrCOLMM3ONtC58hbHC/UsboknfMr0dJwTe5YvBtsJK9DjAmMpzEn1q8VR
    hR3VG8YN4282oILU91nSu2pBHSdTJHjmX9gwT7HvBi5O8wxW1ckNRhi48HnyzetD
    UwhBWSyNgU8VUVYJEc+KW3TCvN7n3co7Ks8YD5lUwFjryWwrMGT98YDF1XgM1rk4
    RHqjpGlYwUzdhA/0/JewZFmQeDJ/I2gU5ZfswNd/lkB7rlMG2OuvkAsdMRxhmUEm
    9ZNC1Uv5ToquWCuyWaeQO/Zjw1oakF1uyjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523533945; bh=6iiXHn3v8rVuKNBP56BwpSP3jNZNHV
    5oQtEYKtwL0mk=; b=Bm+mp7V/cse9rSKxlRGgvvUrxQytTIn0g5lw957w+vpSjU
    Ye6nvMG2/PKF7NzuqGP3/o51CcBOuzF7IsmxplL9FOTQBC83HPsG4TplVgk+T/OI
    EGSbs1XMa9Mutns0cwIsv3M6WmX3hz4SO61h0urjvb2uGrJNKipvWwTb/BMtv7Ri
    fGx/ocj/TJ8dNWEQjocxPz3GLJSNMjx2JkgdmnqYGfLS1e16GxFkE36naNF2ptJW
    MFrWm0GKlXcMLmIzt7lNInFNcm1o2eEyMvkQt2HjS0jaO8ty8yqP6SrEjNEcc4ql
    7VJzjHNpWlPp4L5RPPH27rBmOECMM8ES8Du6zt1A==
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
X-CM-Envelope: MS4wfAhEZQoy2aLvAfXK17hleVsMZVsoL53ahm7uj7orZxvSjx4Oms1JR2BntVYGUnKn7zZfCrR9J0pVV1h9lnXuLMO/0HnwQahE4lNb5FLyukq6M+qE1ugY
    ytWR0tm/TZz83pJASVx54Z8l8zlmh5CKrUGNyOaR9IeIPAfumV4M7MMjhW6IFGqWrxyp2CO+slv7INxJ/LDP2IEPloY8Fs/d8ZS6Ol3kYjlkfYM/SPWP+2Gq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=XkYjAJIbA45OdLdjHWEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeDLLwX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 07:52:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:49376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751889AbeDLLwW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 12 Apr 2018 07:52:22 -0400
Date: Thu, 12 Apr 2018 13:52:17 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
Message-ID: <20180412115217.GC23400@dhcp22.suse.cz>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
 <20180411135624.GA24260@castle.DHCP.thefacebook.com>
 <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 12-04-18 08:52:52, Vlastimil Babka wrote:
> On 04/11/2018 03:56 PM, Roman Gushchin wrote:
> > On Wed, Apr 11, 2018 at 03:16:08PM +0200, Vlastimil Babka wrote:
[...]
> >> With that in mind, can we at least for now put the (manually maintained)
> >> byte counter in a variable that's not directly exposed via /proc/vmstat,
> >> and then when printing nr_slab_reclaimable, simply add the value
> >> (divided by PAGE_SIZE), and when printing nr_slab_unreclaimable,
> >> subtract the same value. This way we would be simply making the existing
> >> counters more precise, in line with their semantics.
> > 
> > Idk, I don't like the idea of adding a counter outside of the vm counters
> > infrastructure, and I definitely wouldn't touch the exposed
> > nr_slab_reclaimable and nr_slab_unreclaimable fields.

Why?

> We would be just making the reported values more precise wrt reality.

I was suggesting something similar in an earlier discussion. I am not
really happy about the new exposed counter either. It is just arbitrary
by name yet very specific for this particular usecase.

What is a poor user supposed to do with the new counter? Can this be
used for any calculations?
-- 
Michal Hocko
SUSE Lab
