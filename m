Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2978043-1521203150-2-4271277971267660662
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
    t=1521203150; b=PoX+4u5wgGi7ELEa1MkRX6yzpXE9e39Ig8zDSUKTsvrd812
    Y7hvRZTeXTK8xWoXs3RluINlL0gTW7p40v+LV8t8XISyUQbwq2lJDnx/rNZqcWZ0
    W0/0WhRFP6cfv+aOcq0g54RIUW+agW/v+IxxBxlrVbePQdF8ZExmqTSedG8owh+N
    YDGy0uL/uiwPKhw2/LTfbftNTFVPEy0EYljpk9DDFYzZryvJICvJtETwQ7u56061
    LqWUsttv9OSCA67sbHdipn7kBjX9q+O5yYt9f7veSTLWYLZMAJFMq+TzxiYsLrUy
    x/T1dgEt6j7ezCuY5SAjJunYspgEc1w/WeSYuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521203150; bh=QhO5wH5cxrYYFGw5INhk2Ld5yF
    R9eYA5yAWLaEi8sJo=; b=DaxeWYJ7+01Uf6nf7qgCXOPkTJVA006zOuy75Koxkn
    930YbAK3wFsaDFtwfq401C0nizY75t9nzGh2T8yCi7fC79V91/HHzhrthBQrQeD8
    1X8BGULBOxxmQiWRjWBsJCfO3j9oyJ5aOHW2mkXov5BMtV/AAM/4E2LqgGIQgav2
    346IOzrOeOkfWx8Tjj0aVzVAU0g/H20QnlX6Ei42pkI8qJSpOHIoF1tD4QhFG0Dj
    WjZh2vJkmuIiLfKiYc3OlwW0YUH+V5fZM0AtDcumZYrPDFa5qupY0hs9deflbxjz
    YKoAoKQqmdkwrByNjGsdwLCfI/HjOC8SMyL3lkgXEcDg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=z2sm5ArV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m1ShT/eB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=z2sm5ArV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m1ShT/eB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbeCPMZf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 08:25:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39217 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbeCPMZe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 08:25:34 -0400
X-Google-Smtp-Source: AG47ELtRF31Epart+28rxGWC8E/R88Ul11+6eHn02vvFX99tKsa+b02WqaBkcvgugO3AeNCF5TdLVQ==
Date: Fri, 16 Mar 2018 15:25:08 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Michal Hocko <mhocko@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: Do not wait for lock_page() in
 shmem_unused_huge_shrink()
Message-ID: <20180316122508.fv4edpx34hdqybwx@node.shutemov.name>
References: <20180316105908.62516-1-kirill.shutemov@linux.intel.com>
 <20180316121303.GI23100@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316121303.GI23100@dhcp22.suse.cz>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 01:13:03PM +0100, Michal Hocko wrote:
> On Fri 16-03-18 13:59:08, Kirill A. Shutemov wrote:
> [..]
> > @@ -498,31 +498,42 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
> >  			continue;
> >  		}
> >  
> > -		page = find_lock_page(inode->i_mapping,
> > +		page = find_get_page(inode->i_mapping,
> >  				(inode->i_size & HPAGE_PMD_MASK) >> PAGE_SHIFT);
> >  		if (!page)
> >  			goto drop;
> >  
> > +		/* No huge page at the end of the file: nothing to split */
> >  		if (!PageTransHuge(page)) {
> > -			unlock_page(page);
> >  			put_page(page);
> >  			goto drop;
> >  		}
> >  
> > +		/*
> > +		 * Leave the inode on the list if we failed to lock
> > +		 * the page at this time.
> > +		 *
> > +		 * Waiting for the lock may lead to deadlock in the
> > +		 * reclaim path.
> > +		 */
> > +		if (!trylock_page(page)) {
> > +			put_page(page);
> > +			goto leave;
> > +		}
> 
> Can somebody split the huge page after the PageTransHuge check and
> before we lock it?

Nope. Pin on the page is enough to prevent split.

-- 
 Kirill A. Shutemov
