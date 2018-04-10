Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3875449-1523365671-2-16779047294769986432
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523365670; b=i3FOJAve0rp2s8b45cMe2x3+K4VkiqLxIk04CtlK07ZsXgsyKF
    PyWc6pBOUSdfh43dnKg2k7f66Wm/TM/2VsZDFpOR72tLTwhB/xgNv1oVEtQwDlGN
    U8PN3nAwYJ3fbhIONpHicGtBdzaMuREINLfmcHDjwJz/R2UaFUnd10BLSW/XYIVn
    VT9aqTIFwlRsfbITl8PJv1dG/mvS/0+I7QFcPev0ujhsl5YpysEF8Y6AeF0zlujR
    XiTfhHG+NwCBsWF9Gx2LtvMWg1JPeNtIiDcOEm6pUDpvk0IsMJpuhSlXhOlv5MGa
    wNwLnq8COiuguGwNHlnCznk3JNN/f2pULMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523365670; bh=vQyNRLSKY52aRp5d5gtAc50dF/i6Ky
    Dl1a6zi7R360I=; b=n6lvrtj9Bn8oucaKP761JeL9lJFXV080LHiUuydukFNTrH
    JkvHX1z9dWWSnQ3OZGS4q+r2y0DHPXIBiRU1nBXHUeRskwpHcuOxJU1C13yVf0Rn
    fz5cB1Vu5R5uI3cjeY4DEPoMw3Dgy3L+V5dBXhyZ3rMAY1iQW8k/vheh5/9m+O1P
    fMNeLIEz2xPpDRlN42DJO+3LnNDOZgpQ0Y2b7xvHaZOLEsICPL3WwBiYEkHGIq1v
    3kZsZWc2WxazNghlSWqxatvTTOb1tY9+2OcdJOp6hcjmV7UschwfL7eCOmnqJirK
    QRm+zfB8yk5cHYLUiICROj3wG4wtCqIT7uvdwZbQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGduAkkYnZWRIQRusuF/fO1t9XzikcKQo2h6i0cJD0NzIlTbdtko2AhLD7W56x1IV5R/AoAsfy41xINw7IULta/Y0P4dzjJtW+5HhgjQAc3r70ZbAaXq
    Awd7rmX5N5X41XzyDYMvwYFD0mYJyoQvOG73R+8gcDjuqU0gvDDurlVEbtQyTQQ5exP37HPxXs1cHKJSi9Cnqenjrx3/usTc5zeU3kGzxUarcJu7ByS5ovQj
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=wFfjXEGv2hVsUhVf7DgA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeDJNHr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:07:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:46983 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbeDJNHr (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:07:47 -0400
Date: Tue, 10 Apr 2018 15:07:42 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a constructor
Message-ID: <20180410130742.GM21835@dhcp22.suse.cz>
References: <20180410125351.15837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410125351.15837-1-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 10-04-18 05:53:50, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> __GFP_ZERO requests that the object be initialised to all-zeroes,
> while the purpose of a constructor is to initialise an object to a
> particular pattern.  We cannot do both.  Add a warning to catch any
> users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
> a constructor.
> 
> Fixes: d07dbea46405 ("Slab allocators: support __GFP_ZERO in all allocators")
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/slab.c | 6 ++++--
>  mm/slob.c | 4 +++-
>  mm/slub.c | 6 ++++--
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 38d3f4fd17d7..8b2cb7db85db 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3313,8 +3313,10 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
>  	local_irq_restore(save_flags);
>  	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
>  
> -	if (unlikely(flags & __GFP_ZERO) && ptr)
> -		memset(ptr, 0, cachep->object_size);
> +	if (unlikely(flags & __GFP_ZERO) && ptr) {
> +		if (!WARN_ON_ONCE(cachep->ctor))
> +			memset(ptr, 0, cachep->object_size);
> +	}
>  
>  	slab_post_alloc_hook(cachep, flags, 1, &ptr);
>  	return ptr;

Why don't we need to cover this in slab_alloc and kmem_cache_alloc_bulk as well?

Other than that this patch makes sense to me.
-- 
Michal Hocko
SUSE Labs
