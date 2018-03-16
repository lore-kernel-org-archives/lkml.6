Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2978043-1521205113-2-17775140817495456037
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521205113; b=boeSRCffpoj+PHmF3w3sEULcyA7gGn+S34nwAa4syHvnkRf
    g6RSPaqRtqDArb5a3zGXBj4ZH/zbI8jPtGP1qVifXh03+bVFL574HaPAO3a4TEMw
    CNRN29lUnloMsXrdN3LrUknilQq1Xu9MI/Gf8WES015biTtOS9niu6SiCvU3qPrw
    pzOn9APy+MKuf4muGo8m5Mf1zNZhYxzNXWwVo7U92zYeOBS5NFvPZBHorlYMz0Cc
    ISzCa7rBQQMP1av2UhLsR70pgxm8WM3VRlyffcnBmnP4GQZXqy0N7K12kHiS7DYQ
    tWMdbMnZE55yjWELCCkPvdQBIF0dZaba9oyhodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521205113; bh=Jmx4VpQ7kSEopXco2GmdAwHhZC
    g2PNXIraA8hIjR2X0=; b=RNaSrw7KNYdEVxg9BoRnWJS78qNgEYJOUPbVmhFx9d
    lUKjKeLMRvKJaqUZOIeFpQUxnkuyWvNxjVwRuub3ir1xcTLdAA6t0IZ0bP2leabx
    Pvbwy2TRLEnr+qU1y1WJQsF9w5y0otIbEAGSk4zM5XYQUQmDUHaH8bwqUT/E706r
    pM/u2W3gLDERWf3WZpPeDrBoTY/MvVk0HkellsVUqtohWnH0Wpn0IJqLkH+Kmwpm
    g/KVwesJpCiIYXcTBez7GiTdz/Ub+5m2tKXE7gVc8QPRsoi04FyTVS9wXVIjHjqW
    H3sXZkjSRYwBifjXU9oStdF2joMHrAXE/Gzja2NJltxQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeCPM6c (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 08:58:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:47251 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeCPM6b (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 08:58:31 -0400
Date: Fri, 16 Mar 2018 13:58:27 +0100
From: Michal Hocko <mhocko@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Wheeler <linux-mm@lists.ewheeler.net>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] mm/shmem: Do not wait for lock_page() in
 shmem_unused_huge_shrink()
Message-ID: <20180316125827.GC11461@dhcp22.suse.cz>
References: <20180316105908.62516-1-kirill.shutemov@linux.intel.com>
 <20180316121303.GI23100@dhcp22.suse.cz>
 <20180316122508.fv4edpx34hdqybwx@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316122508.fv4edpx34hdqybwx@node.shutemov.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 16-03-18 15:25:08, Kirill A. Shutemov wrote:
> On Fri, Mar 16, 2018 at 01:13:03PM +0100, Michal Hocko wrote:
> > On Fri 16-03-18 13:59:08, Kirill A. Shutemov wrote:
> > [..]
> > > @@ -498,31 +498,42 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
> > >  			continue;
> > >  		}
> > >  
> > > -		page = find_lock_page(inode->i_mapping,
> > > +		page = find_get_page(inode->i_mapping,
> > >  				(inode->i_size & HPAGE_PMD_MASK) >> PAGE_SHIFT);
> > >  		if (!page)
> > >  			goto drop;
> > >  
> > > +		/* No huge page at the end of the file: nothing to split */
> > >  		if (!PageTransHuge(page)) {
> > > -			unlock_page(page);
> > >  			put_page(page);
> > >  			goto drop;
> > >  		}
> > >  
> > > +		/*
> > > +		 * Leave the inode on the list if we failed to lock
> > > +		 * the page at this time.
> > > +		 *
> > > +		 * Waiting for the lock may lead to deadlock in the
> > > +		 * reclaim path.
> > > +		 */
> > > +		if (!trylock_page(page)) {
> > > +			put_page(page);
> > > +			goto leave;
> > > +		}
> > 
> > Can somebody split the huge page after the PageTransHuge check and
> > before we lock it?
> 
> Nope. Pin on the page is enough to prevent split.

Good, I thought so but wasn't really 100% sure. Thanks for the
clarification and feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Maybe you should stick
Reported-by: Eric Wheeler <linux-mm@lists.ewheeler.net>
and point to http://lkml.kernel.org/r/alpine.LRH.2.11.1801242349220.30642@mail.ewheeler.net
because that smells like a bug that this patch would be fixing.
-- 
Michal Hocko
SUSE Labs
