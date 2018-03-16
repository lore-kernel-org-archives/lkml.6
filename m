Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3031306-1521206428-2-11276464642780980787
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
    t=1521206427; b=YZ8CkJX5ku5n7ToNGPVuEwoGsNOZHpag/cTIg3Hz6Qr++s9
    WfjHpCu0vRC3bmU9TB/svarhC/UgBD3vuBfphp53v4QxZ1CF8KLckkVU6scsaMrw
    Gks7dT83eB+trQZHIFMsJG7As5ArtVzLoFf+T2S7RNWNL8Bhna2B+yB7101pl0tt
    Whqbv2+zgSO0F6X5TpqPmzOPCCxZ0ACC4VB/aC5eVnp0vYCp8toeXp158eJAMEMn
    hDpUkY2lI8STZYV/kwJgzlZypTB/AKeG6F+6ndoXMzogXjw6haR59rr6NCCcOUiq
    /U21fe/d1DUYZQUaTUevpgapT7g+4PhgKyiLo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521206427; bh=KycqZDSC47CWq6OUc6ZoKmTnt+
    fF5mgNgJcrwBXt24M=; b=kIzIibqYXIcUmkl+C9OG82CtNcPNO71GaKBl+EG2Fo
    by3+K5di+OIgdDLIwYIQ+ltJqN3cmFf1hXNjQGTqb2MOyjm7nSGdLStCZZLsEAYI
    LK6mRo1z2VtS5mfGeFlp5vtdYr0keZSylxusad0LxaTY/9SyFQKTRW0PRAQFwPdr
    swx4Cxbp2M5080hbe+WZw5jTF6SmFCZgrUtm61MF66hVKOLHh1EVsQPLgpF0Vk2G
    e6mVpYLFqAZsh3kCjFX3TcFhDYAoIOsoqlzUTd57RlVZ/QBOfthThs+APeUOFpC4
    pNnG9PcUH/Yw7hxqJ1wuZR8xNqKxk66OLvdFadveSolQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeCPNU0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 09:20:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:51087 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeCPNUZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 09:20:25 -0400
Date: Fri, 16 Mar 2018 14:20:23 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: kirill@shutemov.name, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@lists.ewheeler.net
Subject: Re: [PATCH] mm/shmem: Do not wait for lock_page() in
 shmem_unused_huge_shrink()
Message-ID: <20180316132023.GK23100@dhcp22.suse.cz>
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
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 16-03-18 22:14:24, Tetsuo Handa wrote:
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

I haven't checked whether we have enough users of this pattern to create
a helper.

> Also, won't
> 
> ----------
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 34ce3ebf..0cfc329 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -479,6 +479,8 @@ static inline int trylock_page(struct page *page)
>  static inline void lock_page(struct page *page)
>  {
>  	might_sleep();
> +	WARN_ONCE(current->flags & PF_MEMALLOC,
> +		  "lock_page() from reclaim context might deadlock");
>  	if (!trylock_page(page))
>  		__lock_page(page);
>  }

lock_page is called from many (semi)hot paths so I wouldn't add
additional code there. Maybe we can hide it in VM_WARN. I would have
to think much more to be sure this won't lead to some strange false
positives. I suspect it won't but wouldn't bet my head on that.

In any case, you can try to send a patch and we can stick it into mmotm
and have it there for few cycles to see what falls out...
-- 
Michal Hocko
SUSE Labs
