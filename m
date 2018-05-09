Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539398-1525878597-2-15816345512652548303
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525878596; b=eTqshnzlQMvmEbr1Yx/R5A0L6iswHG+aL9Yt+dfjasvPgVwgYQ
    zwClGKZ/Q4sxcDqNRHyExwFT+va0kmNHAX4QhxeOLsRPo5suT9tLR9/YUSA+34vU
    C5YdIJz5mPDzq9vCmM/6vq4RYMMjaPD1pfXByLvy/Sa50+4iPPh+x3W/x5wjI491
    M1E1HLKsZqO9gNn/4kbnuY2Q/GyE4AqSfRFBABgf456eDEQr8rcrJYA4+yaqZpMM
    CEmUgOgmIf/0mrMDU31oQGK3mPtZ6lXAd7TvAVzCO/t4p/B2AVM0j7ZXzYTl5q9g
    2usE4M5nXjKG/HNCVon7Xry8Sma4Ku2d8sYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525878596; bh=/r6DzH54CiTW8qJhCA7+hVY4eqzj+1
    2ETn1Xe7dGscA=; b=dg1gM+5zzZH/ReD/UVCizaN+R0pWYxR5Ys6ViLIIRPZDHu
    8Yj4E7A30RQ53DlUB68kyAZDxQdRoQQqcwUyPAmSv1/eoQOAMDv3Edkm3zO3E6qh
    jmlwz1mKkyr1nMtIbudl+3+iPN/qnBOLePubudajVyb6FzMxUDgGhHP41hqQT5Yr
    zfQLn/jf27zVaYtSZ+2XWhfI6u3NtnBdVdgr7hr63nTgYGrJYrmC4vVj/pGzW4+a
    e0IjZyGtPYQgJgIH9SXMZoYmxE1GhKwxD6TLEPEQML6HmrhKiJa3IilKs6cfQbC8
    4K12g5EeVi9qLT+BAIehYTCN5uMNZQpx9BGOkVGg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHGWQtwe/HG7gImc8EJttV182KfcWR8iV0lSeVrdkLaAIbhivRCJEYF1MatYIUs100XfMWDo4ne1M95jMVdxtpQSvnn6XptWTOs88Im1z1bPnJS+HdNz
    CCV9ST/qSXldAFdNlUENa/UAJI6wWHuGfQfp28THLYObIa27HNK9cESnor67HU/fDuaqj49P984Wos/7W1iRRgX0eDvf2sJYKEiUoLl+D2k+pse1ltfAgZ3p
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=95H62BSV9jZzOz3ZCT0A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964815AbeEIPJr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 11:09:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:14855 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935065AbeEIPJn (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 9 May 2018 11:09:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54492399"
Date: Wed, 9 May 2018 09:09:38 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Jan Kara <jack@suse.cz>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, linux-nvdimm@lists.01.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5/5] radix tree: fix multi-order iteration race
Message-ID: <20180509150938.GA3814@linux.intel.com>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
 <20180503192430.7582-6-ross.zwisler@linux.intel.com>
 <20180509124611.6hoa743z4qrx6bgc@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509124611.6hoa743z4qrx6bgc@quack2.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 02:46:11PM +0200, Jan Kara wrote:
> On Thu 03-05-18 13:24:30, Ross Zwisler wrote:
> > Fix a race in the multi-order iteration code which causes the kernel to hit
> > a GP fault.  This was first seen with a production v4.15 based kernel
> > (4.15.6-300.fc27.x86_64) utilizing a DAX workload which used order 9 PMD
> > DAX entries.
> > 
> > The race has to do with how we tear down multi-order sibling entries when
> > we are removing an item from the tree.  Remember for example that an order
> > 2 entry looks like this:
> > 
> > struct radix_tree_node.slots[] = [entry][sibling][sibling][sibling]
> > 
> > where 'entry' is in some slot in the struct radix_tree_node, and the three
> > slots following 'entry' contain sibling pointers which point back to
> > 'entry.'
> > 
> > When we delete 'entry' from the tree, we call :
> >   radix_tree_delete()
> >     radix_tree_delete_item()
> >       __radix_tree_delete()
> >         replace_slot()
> > 
> > replace_slot() first removes the siblings in order from the first to the
> > last, then at then replaces 'entry' with NULL.  This means that for a brief
> > period of time we end up with one or more of the siblings removed, so:
> > 
> > struct radix_tree_node.slots[] = [entry][NULL][sibling][sibling]
> > 
> > This causes an issue if you have a reader iterating over the slots in the
> > tree via radix_tree_for_each_slot() while only under
> > rcu_read_lock()/rcu_read_unlock() protection.  This is a common case in
> > mm/filemap.c.
> > 
> > The issue is that when __radix_tree_next_slot() => skip_siblings() tries to
> > skip over the sibling entries in the slots, it currently does so with an
> > exact match on the slot directly preceding our current slot.  Normally this
> > works:
> >                                     V preceding slot
> > struct radix_tree_node.slots[] = [entry][sibling][sibling][sibling]
> >                                             ^ current slot
> > 
> > This lets you find the first sibling, and you skip them all in order.
> > 
> > But in the case where one of the siblings is NULL, that slot is skipped and
> > then our sibling detection is interrupted:
> > 
> >                                            V preceding slot
> > struct radix_tree_node.slots[] = [entry][NULL][sibling][sibling]
> >                                                   ^ current slot
> > 
> > This means that the sibling pointers aren't recognized since they point all
> > the way back to 'entry', so we think that they are normal internal radix
> > tree pointers.  This causes us to think we need to walk down to a struct
> > radix_tree_node starting at the address of 'entry'.
> > 
> > In a real running kernel this will crash the thread with a GP fault when
> > you try and dereference the slots in your broken node starting at 'entry'.
> > 
> > We fix this race by fixing the way that skip_siblings() detects sibling
> > nodes.  Instead of testing against the preceding slot we instead look for
> > siblings via is_sibling_entry() which compares against the position of the
> > struct radix_tree_node.slots[] array.  This ensures that sibling entries
> > are properly identified, even if they are no longer contiguous with the
> > 'entry' they point to.
> > 
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > Reported-by: CR, Sapthagirish <sapthagirish.cr@intel.com>
> > Fixes: commit 148deab223b2 ("radix-tree: improve multiorder iterators")
> > Cc: <stable@vger.kernel.org>
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thank you for the review, Jan.
