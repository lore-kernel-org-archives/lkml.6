Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3892947-1523367657-2-13541415542461823989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523367657; b=fg09gT7aWbaCh2+3e+mI0SWqaMwEcAFx+3p5Kr6qMaxDz0Jn/I
    YqJuWJLrLMgkZufHuPwNyElT8fk+J1P67rZqpyl1Ab3iVQk7h0/BnYnPMwAdJ3uh
    TSpLnqMWNDb0RHYKb0Ly291WXG1Kzv5sULuMDds8nM3sPj+l3OcQkIigjiCjhfCr
    uuaYlNpMatBnH24No7oMGzpB5RKYdp+C/P/usUYiGMt2y/SM+vca48A/+x4/dGW+
    I1SXmbd3NuY4HHTNqhpXoImM13MpgYrc8PlKJubR7W5F/Gb3RZG6j6yD3AwXPfk7
    mVSVLOSKB02zIuubBeq0r2FNy2BmAQwQ7/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523367657;
    bh=XuwjmwI5M/oOebwQJsEc4yMFdelpXgIVKBApZqSgtX4=; b=L5qCs0q0oMrQ
    vIkZSyC4lPZhLR8f16n42XaqhZ+zd2Ipn6oFoERWMB+8RmAiUNpPDi88zNaJgVgl
    mS4boJci0faKfgAba3/lvPa0MVokWMlZsZVadjwn4LLlRf3MXmRslBTQpH6vfCYH
    RY3rPgYPQ5ano1IZmULxInTVBgaH9Lb6P4EkX3XrbJR6cZg1UTjStXdxxrHN580c
    ha4DTIooH40KHuzcpdP+BtLohgLk/ifL7u1RRjyjKAS5cQt8VWODedaYQIz8Ct7F
    nV7SA+gkxOPX1hMm+4vD23SY3JFYd5/ZxceOB7lQbgUAuoJcUz3RyEo4dpBgtsEV
    wpKN0vu38Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBqa6F5Rdzr2w/sZwh0rEuek8983djX85PO22jvisDTq0tzmRaHxpn02xP0KMQ+LXEAY93zP7MLCzTsU0XAFGf1Yzc1FQd4ItjEoIXWEI/V9nX0bCG4E
    Pm+M8zBd797h5EW9vKiPbd5kr97EiEjen2ObjrOBmQ0s/idNiL4T9n5cytBGTEV/5Xf/Qa/YeUC526lqMfzZtjA/q+zhWfdDDdzWK8p7ZHa/0q7HgjM7+t9i
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=_0KR-ZLPx33bMruvSWQA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeDJNky (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:40:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752587AbeDJNkx (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:40:53 -0400
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a constructor
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
References: <20180410125351.15837-1-willy@infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSFWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmNvbT7CwZcEEwEKAEECGwMFCwkIBwMFFQoJCAsFFgIDAQAC
 HgECF4ACGQEWIQSpQNQ0mSwujpkQPVAiT6fnzIKmZAUCWi/zTwUJBbOLuQAKCRAiT6fnzIKm
 ZIpED/4jRN/6LKZZIT4R2xoou0nJkBGVA3nfb+mUMgi3uwn/zC+o6jjc3ShmP0LQ0cdeuSt/
 t2ytstnuARTFVqZT4/IYzZgBsLM8ODFY5vGfPw00tsZMIfFuVPQX3xs0XgLEHw7/1ZCVyJVr
 mTzYmV3JruwhMdUvIzwoZ/LXjPiEx1MRdUQYHAWwUfsl8lUZeu2QShL3KubR1eH6lUWN2M7t
 VcokLsnGg4LTajZzZfq2NqCKEQMY3JkAmOu/ooPTrfHCJYMF/5dpi8YF1CkQF/PVbnYbPUuh
 dRM0m3NzPtn5DdyfFltJ7fobGR039+zoCo6dFF9fPltwcyLlt1gaItfX5yNbOjX3aJSHY2Vc
 A5T+XAVC2sCwj0lHvgGDz/dTsMM9Ob/6rRJANlJPRWGYk3WVWnbgW8UejCWtn1FkiY/L/4qJ
 UsqkId8NkkVdVAenCcHQmOGjRQYTpe6Cf4aQ4HGNDeWEm3H8Uq9vmHhXXcPLkxBLRbGDSHyq
 vUBVaK+dAwAsXn/5PlGxw1cWtur1ep7RDgG3vVQDhIOpAXAg6HULjcbWpBEFaoH720oyGmO5
 kV+yHciYO3nPzz/CZJzP5Ki7Q1zqBb/U6gib2at5Ycvews+vTueYO+rOb9sfD8BFTK386LUK
 uce7E38owtgo/V2GV4LMWqVOy1xtCB6OAUfnGDU2EM7BTQRWXZsWARAAyS3vr9khnfXSX3zU
 v2JIH8zP/aIwjAlIeekU7RYeIamGNm2qL1O1ZxQm4LH73YQpfVFpZbBMA6/jo+X38D+6b+7i
 Ea4f8otSBwHfTuV2mcwmo9OZjcsTsN01lq1i4mxA6fThBLJr/KDzW+kfq6lxN9/mEmhDjGIx
 cGWXvYY2Aa+QWNcMsIcXAwQWDx4ATrBvVAC5ezsuJwidNYgdMZr/1667W4jdUdxaASwYxT7N
 0rjbCfpvdEUbZ66+mGup+46su/ijlRlr1X8+4n4OYWz9AmRGe0pcCl2trZpWcxE3t2T9S0yR
 uMlCgEIU8edyGVtmhuDJ0PGzinlNYnUikdvJIfNHT0SkMdEeuwAnBArwEl+d35g6RnyQA0im
 fSTb/R6OiavZZzHm5ywrdFo0ZCcJi5cVM5YwPgh7hWtDVd3Wj644mbV1wXVcU2TyQPwG0D+m
 BARx9WEHmz2orqLZyGwolYrk/5VLuTv7N/bp9OkIVx5a+YwfNyalZvBbsR2Pu4cLVNaKHR80
 4IrZI4cX26hy8Obsnuaex4homJLR2ACl/DhBGyqv4MNMwmkHxihv+q08fzKQEkXrK0UTssnW
 eUfB0oNmZteVxphgurn2f5OtasseGhbp7DvQnsK3t7JLhzN/qu4jtZ+udqrY41axBAthI6Z6
 ShIddANj0Ly4T3u/Q4EAEQEAAcLBZQQYAQoADwUCVl2bFgIbDAUJAeEzgAAKCRAiT6fnzIKm
 ZLV4EACAu3CiyTMfJt8h85vKp86C/v1/UkcUeKwGyeVgXwdXOJH9U6uF25QCoeXd77qBb+7O
 Eksos+clgzz83WIP7R9VlfOg6NU5E+OBU1zpXpiUUwfK3n7lPnpfPN3iSVT8Qh55phuis4CZ
 PqqHbBh8FFh2wfJQzp69eQnkYlxADZ6S2/e6rUtaZQNWHUmNV3dbts1n6fAtWChQw6IOFQv0
 OzAWSNAjzk/AhS1a1jEcOD4L1AHtbQty0a6ajhwayl0MQGjD380R48mV24TQgHrb+8qoXF6A
 K9MC0W1KZaHZlcng1ArxnhKbRrTMInH/B+YaSSomayAPdt9rfnXlhy/FSRMAdAsa6Ui9wG+S
 8LyiV/EgMJzsTmQIJlF9plYd+G1QLQi8lP9C+lw6Wn92sJR5sQo719GUwXtozxOy5aVEfBy/
 hIYgXNwKMQEymAkiJAHunTmGDL0OrFY37+TvO+8Z3AcqnV04pCDzLkmDgbsBNwsqCoHRtNSh
 Gx2mu0G1U19yuDlQK92M+d4Dfb43IMuoT2c+zdMmUGeZMPhKgGc3BDBJ2UQyn2VCaxpDPgmx
 3x1zA7K5E/ZIqD5Oo71qTRRonRZ74w0JLDzgDSK7d9lLmtOobstclGT4hChSTblDuMGLFy8J
 dfyae8NugjBzvIomGBWOsmMGmCeB6tqPObIqLio3T8LBfAQYAQoAJgIbDBYhBKlA1DSZLC6O
 mRA9UCJPp+fMgqZkBQJaL/NjBQkFs4vNAAoJECJPp+fMgqZk50AQALKEAzCj6kLU6KH7dUZY
 16M74NCtpaMDO5/4Shwu+oS8H//b29GHtZVVGudfwBNmuIRSSxdpJkLsmqoLLEQTCzs2szH1
 r5+uOiZTuKbgx2HJNaCqoHuotPSOdoVsKg27UxbkJraqSNyzgex0kKNO8HQltdvF20MXvPFu
 IKc6/Y/NTWQqaamXQBZA6HoSQKfuJmM0zQy3SWdcuz79K2Q4ftR2VNuu8UYB0bfTD7LCTguP
 PpYC0ePRFmYuiMP5T8DA9NKYiN+71RtcAQTJM8WTidJQ3gaBG1s3kiyqBoqQvkLFExUOBTDi
 /qukcTh/deKpfaUSIrX+JbrlFIFcwQ0Ql3bAE24hu1nRkFiBSPcoDdDS7Iu3MOwZik3SL6ZH
 qGo/KlmKiqTyCAs0WgOHnzXeX18/sS048NuOCwqfjn5cbDdbThpX+vRoWBV/rrYMFPgHCigK
 Ertp0r/zjPaqFHtdxvChwmbTvu44ddRvcCR/3v1zmeUAtxw6guSlvmVDzLwr35czpGrbcydq
 FPbL9fuTVKAXvkmKzuY0ye5tmJAsyYqgV5l+jaGt6oFEGFj5XZQvO6ic5lmjTHz9b6lUg8at
 uInmlw5eLxByeMA81R3sJvNbtGfCcqQfVkJAn2S4RYpDtAKI7QM+ydrdH3STBRaC1IuD0YWr
 A3XDrKOXTZil3g8D
Message-ID: <84575e2b-1d67-905d-9d04-023622b49855@suse.cz>
Date: Tue, 10 Apr 2018 15:40:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410125351.15837-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/10/2018 02:53 PM, Matthew Wilcox wrote:
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

It doesn't fix any known problem, does it? Then the stable tag seems too
much IMHO. Especially for fixing a 2007 commit.

Otherwise
Acked-by: Vlastimil Babka <vbabka@suse.cz>

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
> diff --git a/mm/slob.c b/mm/slob.c
> index 1a46181b675c..958173fd7c24 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -556,8 +556,10 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
>  					    flags, node);
>  	}
>  
> -	if (b && c->ctor)
> +	if (b && c->ctor) {
> +		WARN_ON_ONCE(flags & __GFP_ZERO);
>  		c->ctor(b);
> +	}
>  
>  	kmemleak_alloc_recursive(b, c->size, 1, c->flags, flags);
>  	return b;
> diff --git a/mm/slub.c b/mm/slub.c
> index 9e1100f9298f..0f55f0a0dcaa 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2714,8 +2714,10 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>  		stat(s, ALLOC_FASTPATH);
>  	}
>  
> -	if (unlikely(gfpflags & __GFP_ZERO) && object)
> -		memset(object, 0, s->object_size);
> +	if (unlikely(gfpflags & __GFP_ZERO) && object) {
> +		if (!WARN_ON_ONCE(s->ctor))
> +			memset(object, 0, s->object_size);
> +	}
>  
>  	slab_post_alloc_hook(s, gfpflags, 1, &object);
>  
> 
