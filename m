Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2885895-1521202387-2-7178548064577087783
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
    t=1521202386; b=u8HeJ2xckPclz6AqOj13r1cExKf3eb3wwyQOxc2ZG2nCyXb
    srbrSvSh5DxxhcpN1ldsfhvfmW1oVFH2/y3bp/kGgu9jLRXYwmWk23rwiqHG1UW2
    XEvZZWSs1V/fNZGh2e1IY/ZXTez/W3KrB071ow6mmFakt0YKw3+4XejMc5ObQj27
    ARqSBtOPHlFXgqFIFdzVR6++lahXA1MjOgM6qYDZmzhc2WXAtgOnI6eoFFQdKRwm
    5JV1Am2jYXwgDtQ2bVEP16+UebsRiry0X/yNFLuO1CTEqEnfPijTe8+p/HW8S87x
    3zCA6g6T8dBYd5twx/4XtHH2SbkvU8sOtbahfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521202386; bh=QvxLmDbGnNXayajr1z4CqLzVJZ
    W9rOHhuXIDpcXTYoI=; b=mOJinBxEtROAGjVMZmyo2oWuDkid315alJvPEadijC
    62Rx7IyOa2goh7b+m1rFi0lv0cDf4BR0wv0RbCtbRZuQgtjK1W7OiX1Bmq3spmbv
    2J2WvrPTd0c/FhinLIX1Rna4ZysZd0ylfbKAz4wtrDX7z+tsKPLqtEbuZ3NMvQYq
    ouA30zTTA1mSJhwZ8h4NCAfuchQaA/l+Eq98IndYLWQTDeskNEw8iqxGXqUOpfg7
    XLsHIBap7vdX2iEwxo2dfjjaut+xOTiHyuS9wtKwQUsaOzX5MBI3k/qJbw3AIy/u
    qkJF/pkA+DaEgmOomO2izEqUWYfb1GfRJMGKUf9DMpBg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1751480AbeCPMNF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 08:13:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:43206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751437AbeCPMNF (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 08:13:05 -0400
Date: Fri, 16 Mar 2018 13:13:03 +0100
From: Michal Hocko <mhocko@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: Do not wait for lock_page() in
 shmem_unused_huge_shrink()
Message-ID: <20180316121303.GI23100@dhcp22.suse.cz>
References: <20180316105908.62516-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316105908.62516-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 16-03-18 13:59:08, Kirill A. Shutemov wrote:
[..]
> @@ -498,31 +498,42 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>  			continue;
>  		}
>  
> -		page = find_lock_page(inode->i_mapping,
> +		page = find_get_page(inode->i_mapping,
>  				(inode->i_size & HPAGE_PMD_MASK) >> PAGE_SHIFT);
>  		if (!page)
>  			goto drop;
>  
> +		/* No huge page at the end of the file: nothing to split */
>  		if (!PageTransHuge(page)) {
> -			unlock_page(page);
>  			put_page(page);
>  			goto drop;
>  		}
>  
> +		/*
> +		 * Leave the inode on the list if we failed to lock
> +		 * the page at this time.
> +		 *
> +		 * Waiting for the lock may lead to deadlock in the
> +		 * reclaim path.
> +		 */
> +		if (!trylock_page(page)) {
> +			put_page(page);
> +			goto leave;
> +		}

Can somebody split the huge page after the PageTransHuge check and
before we lock it?

> +
>  		ret = split_huge_page(page);
>  		unlock_page(page);
>  		put_page(page);
>  
> -		if (ret) {
> -			/* split failed: leave it on the list */
> -			iput(inode);
> -			continue;
> -		}
> +		/* If split failed leave the inode on the list */
> +		if (ret)
> +			goto leave;
>  
>  		split++;
>  drop:
>  		list_del_init(&info->shrinklist);
>  		removed++;
> +leave:
>  		iput(inode);
>  	}
>  
> -- 
> 2.16.1

-- 
Michal Hocko
SUSE Labs
