Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2978043-1521205351-2-14321259431356643425
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521205350; b=hPawt7N0N90Iw4KQ+j+rq9aeh3CnRhXRN6HJi5pYIwczhMU
    upOukORU0gZRxS1kE8VjQheQuG0MHQ7EowqT3/AWvok9EUBvS2gHkca7D2XAM9C6
    q+K6Oo0d9caVkxLwq3X+78mbZujPGW6wcwEqtVqjCk21wD1XESn3+i0RlwRniaHN
    OwMNJLkL5FkISj0kl6m7HEpvChCxAEhFs5PdZNbyG0ITxFCU/KD+e+QAXKr1QTk8
    PMXUjKtOYxhCF+etC5Xs2er5hJZnnoCplbIy0wDFCSXE16b2g8+9KaHzf9eClOW6
    HTHRNhbHXaSzt1SAL0Iu+Xo5Ez8BvgrSEIz6VBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521205350; bh=RBvFR887vlqB0wjqWNNXruL6+0
    yDa2XfEtLXdkgWQUo=; b=BRLA+iDF3r8iTwiQgpHSW3M3oSbGTEYolM44UWMW07
    FELZo00HcY4ncSeAA31aL8GwTENI2WtvJVoRma5MUTUVej9w1A6e0KH4Im4LJy3P
    +D0Z5llWYiLW/z0uoDmIPrsc8L9L0+7uMj6H195D8YMewpJl015L/FRQyvZQb8Kz
    gcRLBMpCQ6fx4bxD9pu6uP4y8nT3e0TUF1Hr5gb0WjidHtjp/Iz11dtKpZUWs5+h
    vUB2gUBus6KVwEFCSPCjUmIjOxTJZ1souckXjwb/ukKr/AvT5ifq7muVtkQtklFp
    5aKXAucmE7/Zo6gpiV7BvfOgUs50lFTCbRIzvglsd4Kw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=gp+b3ePa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FvRzIA6o;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=gp+b3ePa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FvRzIA6o;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeCPNC2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 09:02:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52430 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeCPNC1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 09:02:27 -0400
X-Google-Smtp-Source: AG47ELuNZNjBeSFg0mAtXvErMZK6EgQ4Sny6EWJTuxT58480d87ZkRFjbXBexrROp4/Uj5GSoTAmIA==
Date: Fri, 16 Mar 2018 16:02:00 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Michal Hocko <mhocko@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Wheeler <linux-mm@lists.ewheeler.net>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] mm/shmem: Do not wait for lock_page() in
 shmem_unused_huge_shrink()
Message-ID: <20180316130200.rbke66zjyoc6zwzl@node.shutemov.name>
References: <20180316105908.62516-1-kirill.shutemov@linux.intel.com>
 <20180316121303.GI23100@dhcp22.suse.cz>
 <20180316122508.fv4edpx34hdqybwx@node.shutemov.name>
 <20180316125827.GC11461@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316125827.GC11461@dhcp22.suse.cz>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 01:58:27PM +0100, Michal Hocko wrote:
> On Fri 16-03-18 15:25:08, Kirill A. Shutemov wrote:
> > On Fri, Mar 16, 2018 at 01:13:03PM +0100, Michal Hocko wrote:
> > > On Fri 16-03-18 13:59:08, Kirill A. Shutemov wrote:
> > > [..]
> > > > @@ -498,31 +498,42 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
> > > >  			continue;
> > > >  		}
> > > >  
> > > > -		page = find_lock_page(inode->i_mapping,
> > > > +		page = find_get_page(inode->i_mapping,
> > > >  				(inode->i_size & HPAGE_PMD_MASK) >> PAGE_SHIFT);
> > > >  		if (!page)
> > > >  			goto drop;
> > > >  
> > > > +		/* No huge page at the end of the file: nothing to split */
> > > >  		if (!PageTransHuge(page)) {
> > > > -			unlock_page(page);
> > > >  			put_page(page);
> > > >  			goto drop;
> > > >  		}
> > > >  
> > > > +		/*
> > > > +		 * Leave the inode on the list if we failed to lock
> > > > +		 * the page at this time.
> > > > +		 *
> > > > +		 * Waiting for the lock may lead to deadlock in the
> > > > +		 * reclaim path.
> > > > +		 */
> > > > +		if (!trylock_page(page)) {
> > > > +			put_page(page);
> > > > +			goto leave;
> > > > +		}
> > > 
> > > Can somebody split the huge page after the PageTransHuge check and
> > > before we lock it?
> > 
> > Nope. Pin on the page is enough to prevent split.
> 
> Good, I thought so but wasn't really 100% sure. Thanks for the
> clarification and feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

> Maybe you should stick
> Reported-by: Eric Wheeler <linux-mm@lists.ewheeler.net>
> and point to http://lkml.kernel.org/r/alpine.LRH.2.11.1801242349220.30642@mail.ewheeler.net
> because that smells like a bug that this patch would be fixing.

Good point.

Andrew, do you want me repost with tags integrated?

-- 
 Kirill A. Shutemov
