Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220077-1518789584-2-144263765959203694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518789584; b=GZaHZLZu5W9xqPWZgZZvnr8hI3F0REI0iHCosJzYstN/0bB
    xuJMLh1yj67apEsKPLAanU8Uge9Pn7p5+dpo0liLB+OacuTtgt4bU/9rbq0gC+lw
    K8OjrknjTNXYp2gQX/oiY8PDryA60b1BNHJkThC6LSiqAQ2bVYc4sfSBIXKfGC49
    /fvyACT55seHh5II98YPDch8/XATvTp/SNR19h0m+DcEnAA6JxsKM4UzXXFZJCKr
    rzRqlr1H/kFTSN4hxa7oxyIKNY7hraBefEZvH6hHOKvGWTmW4t2awVWhsVJ99P0G
    vol4vQvJSWJFpnNcF0MYm/IaS0o6quBgIaM6elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518789584; bh=u/TWqb4DCL2KT4RJ6LXDsI+jHO
    Q+WcKeCKFrVdQXXWo=; b=NxnmAeHLwLqfCVdCMRmWXL7vvAdtbcc7wpOa7lxfvY
    q7ASDZ01kI98CdopdWiE6eVuGb6SUoY2gBTU/HkTr2i4BxI6T2npT77Uo3DUzN9g
    bvCIKUyhgKZq1hnONRsZyUjWJEmCh7HLFpS6zB9jaIooEVnKpnswrNyG4jSBnqsE
    rBhGhTaWrlB1BrRnKunnCTb8fOqFe+xETX5rOwLaGcbqYPnxTjF3/WpTg9/gWaA1
    SfM7fBKIm4JGydtaYpc6YBzSRCCUWssdRb5rFkC8Rvl1BGQ5+W53tHNbcoYE97+t
    0ugqghyXFtRoYuwYExSEEv3dMsBhcX9g/E4LanhOfu8g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033069AbeBPN7n (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 08:59:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:56537 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032862AbeBPN7m (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Feb 2018 08:59:42 -0500
Date: Fri, 16 Feb 2018 14:59:40 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, akpm@linux-foundation.org,
        stable@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: [PATCH] mm: don't defer struct page initialization for Xen pv
 guests
Message-ID: <20180216135940.GQ7275@dhcp22.suse.cz>
References: <20180216133726.30813-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216133726.30813-1-jgross@suse.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[CC Pavel]

On Fri 16-02-18 14:37:26, Juergen Gross wrote:
> Commit f7f99100d8d95dbcf09e0216a143211e79418b9f ("mm: stop zeroing
> memory during allocation in vmemmap") broke Xen pv domains in some
> configurations, as the "Pinned" information in struct page of early
> page tables could get lost.

Could you be more specific please?

> Avoid this problem by not deferring struct page initialization when
> running as Xen pv guest.
> 
> Cc: <stable@vger.kernel.org> #4.15
Fixes: f7f99100d8d9 ("mm: stop zeroing memory during allocation in vmemmap")

please

> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 81e18ceef579..681d504b9a40 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -347,6 +347,9 @@ static inline bool update_defer_init(pg_data_t *pgdat,
>  	/* Always populate low zones for address-constrained allocations */
>  	if (zone_end < pgdat_end_pfn(pgdat))
>  		return true;
> +	/* Xen PV domains need page structures early */
> +	if (xen_pv_domain())
> +		return true;
>  	(*nr_initialised)++;
>  	if ((*nr_initialised > pgdat->static_init_pgcnt) &&
>  	    (pfn & (PAGES_PER_SECTION - 1)) == 0) {
> -- 
> 2.13.6

-- 
Michal Hocko
SUSE Labs
