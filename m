Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3450821-1521219207-2-14408694881088386354
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
    t=1521219206; b=i2zp8/vblDytUmZ02FCwfeF0p7DKn3UN0iguqj5vcldnUKD
    BpTLsnmK6P8iLvBf28/gR5IFFCzXyGF8aj3WXzGU02ejBQMeuaf6kIZWi7TO41zR
    NbnkJ+l9WuJkFOxuEF5kslcB2R+AnPvCiNvmuq/pdPUq+riKCLc5WN4kecM+4wnq
    8JCpIMLx8vn5EqZKRT81A8OvJmAizTBbXhh7n4+D6YBuz6sTKt3VuHSihj1Sjv69
    tOax3O0LIVvF4ISiu/eXUueq9ar6+lLZx/fjeEVcOk8yPd6JlOZk2dpAZMeBi6SW
    6AlSgx3N+i1QMw/1EanNdrPgziP2fdu0SbWuZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521219206; bh=TJCrpH1YFICbzakF9qYkANTEZK
    efpx0jmyAHUSGow0U=; b=CkuUmY5EeJ/j5il8qalkQviR20wU/7qxb7UQT046og
    EVWreDlpKBZH/7mSFoJDuGFgGO2fBGe5Op0ItHSk5FNyhAtQk+H7lZzpHm1WJr51
    fuSkbzBv5X1IEL0eHgOUoZ99zWwfwueOkJIrpy4GX8c8tGot914W79TWdmRanbNj
    NzLqVJRVLpJdLAfGfNSZDO97MUigwAm7pZPW0tVLvdc7g3JACNxfbt0GkYfsUiHv
    MxTZUVZCz9jHRlxuvc+XACBq8VRPV9t4ZOb/UvFtW1viUVKQUa6TgK9Atd5BjNBW
    BPyxA/Ch58/5nmYSGpXFOMyTp+WK0pMDHdGIYtuK317A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S1751348AbeCPQxJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 12:53:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:52533 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752294AbeCPQxI (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 12:53:08 -0400
Date: Fri, 16 Mar 2018 17:53:06 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@bugzilla.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] hugetlbfs: check for pgoff value overflow
Message-ID: <20180316165306.GM23100@dhcp22.suse.cz>
References: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
 <20180309002726.7248-1-mike.kravetz@oracle.com>
 <20180316101757.GE23100@dhcp22.suse.cz>
 <12826dc6-c81e-c22a-2ec1-8e1cf0f07dfc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12826dc6-c81e-c22a-2ec1-8e1cf0f07dfc@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 16-03-18 09:19:07, Mike Kravetz wrote:
> On 03/16/2018 03:17 AM, Michal Hocko wrote:
> > On Thu 08-03-18 16:27:26, Mike Kravetz wrote:
> > 
> > OK, looks good to me. Hairy but seems to be the easiest way around this.
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> <snip>
> >> +/*
> >> + * Mask used when checking the page offset value passed in via system
> >> + * calls.  This value will be converted to a loff_t which is signed.
> >> + * Therefore, we want to check the upper PAGE_SHIFT + 1 bits of the
> >> + * value.  The extra bit (- 1 in the shift value) is to take the sign
> >> + * bit into account.
> >> + */
> >> +#define PGOFF_LOFFT_MAX (PAGE_MASK << (BITS_PER_LONG - (2 * PAGE_SHIFT) - 1))
> 
> Thanks Michal,
> 
> However, kbuild found a problem with this definition on certain configs.
> Consider a config where,
> BITS_PER_LONG = 32 (32bit config)
> PAGE_SHIFT = 16 (64K pages)
> This results in the negative shift value.
> Not something I would not immediately think of, but a valid config.

Well, 64K pages on 32b doesn't sound even remotely sane to me but what
ever.

> The definition has been changed to,
> #define PGOFF_LOFFT_MAX \
> 	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
> 
> as discussed here,
> http://lkml.kernel.org/r/432fb2a3-b729-9c3a-7d60-890b8f9b10dd@oracle.com

This looks more wild but seems correct as well. You can keep my acked-by

Thanks!
-- 
Michal Hocko
SUSE Labs
