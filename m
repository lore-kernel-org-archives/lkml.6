Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3063729-1521207290-2-18283397079105619845
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
    t=1521207289; b=H8uy+E91hBXsPe1aUKHlT9945/GWMLqclV5QM2BXco6Tl+n
    iGME34E7tbgQ7zpepFfm6e112Z7370KTFzxeyZKvDks8Wkxf7gwbMm6uKtmkg4Mx
    +1/+yEpaBpl0hE4UMzHRHWUDDjPoMy97FwIQ9n4BNIiZYb3wGUd8FnrM2whf3oh+
    2V39sBleBEPOr2uzoU0uiximtCG+x35QYRqN8Ci7gKzXviMNOFubDiH2zSP7+6e3
    VzMrIJvTIFhV1VySAMekVJ+gjUY/TSrK2NLS0Xa+eAvDbgqcbV/zdi/r2wecEqmO
    6CFi4+dZYbAbDg1rKVvSWvR3UNC61Qy778QM2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521207289; bh=aD7QWyvbbuxnYxUyHBoYQdiRDe
    DHEccnvCvfcRcyt+0=; b=G2NU9ZNTRDZmksxXLcRVGDjzSY5isCQGKBij3Ge4Ul
    U7huI/s9LpD7gtVlJw4/ZdhKHTyI1jw8k/6pynCsM/+l6elMUVTtiVrMtgcrUoIJ
    NeQ75RiZfieRXtU3fhvmdi3jr9TffnJSxYzciHu90jbt2a1eRkkyzqfmHtaWeHuf
    fEbSXY5cdtZ+R9Gg1FYrJGgV1RJc4kvAimAzxWwC9QOZFpZDCtJaASrlCQibFwKK
    fYCfSiRUerkPNuB+fmvTk723S48qWO1VyYGrJovPCKqE2eqKpddALNSghbj4hkIp
    y9c0xwP5O5bw6EjJD0xyo3FXpKagzZstMunZsFZxMTHg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=mvWZZuQM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H+tZCndl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=mvWZZuQM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H+tZCndl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753181AbeCPNep (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 09:34:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54689 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbeCPNeo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 09:34:44 -0400
X-Google-Smtp-Source: AG47ELsb+UCA0sDKyp+aG0H31rIS7WxgspdbGYtthuMZjp4A/pQmvjWrkf47wrHv+ksOtPW9ixrMuA==
Date: Fri, 16 Mar 2018 16:34:17 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@lists.ewheeler.net
Subject: Re: [PATCH] mm/shmem: Do not wait for lock_page() in
 shmem_unused_huge_shrink()
Message-ID: <20180316133417.hk2lvnvgildsc65n@node.shutemov.name>
References: <20180316105908.62516-1-kirill.shutemov@linux.intel.com>
 <20180316121303.GI23100@dhcp22.suse.cz>
 <20180316122508.fv4edpx34hdqybwx@node.shutemov.name>
 <20180316125827.GC11461@dhcp22.suse.cz>
 <20180316130200.rbke66zjyoc6zwzl@node.shutemov.name>
 <201803162214.ECJ30715.StOOFHOFVLJMQF@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803162214.ECJ30715.StOOFHOFVLJMQF@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 10:14:24PM +0900, Tetsuo Handa wrote:
> f2fs is doing
> 
>   page = f2fs_pagecache_get_page(inode->i_mapping, 0, FGP_LOCK|FGP_NOWAIT, 0);
> 
> which calls
> 
>   struct page *pagecache_get_page(inode->i_mapping, 0, FGP_LOCK|FGP_NOWAIT, 0);
> 
> . Then, can't we define
> 
>   static inline struct page *find_trylock_page(struct address_space *mapping,
>   					     pgoff_t offset)
>   {
>   	return pagecache_get_page(mapping, offset, FGP_LOCK|FGP_NOWAIT, 0);
>   }
> 
> and replace find_lock_page() with find_trylock_page() ?

This won't work in this case. We need to destinct no-page-in-page-cache
from failed-to-lock-page. We take different routes depending on this.

-- 
 Kirill A. Shutemov
