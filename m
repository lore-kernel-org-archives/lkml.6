Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4489C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1B720693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itD1mQ3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1B720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753774AbeFTAtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:49:50 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46843 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeFTAtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:49:46 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so746563pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JpFWqVr5vWw+tyS7McnlpT+MWLRu44AXJHuMei2pYI0=;
        b=itD1mQ3wB/IgDD9LwqgB/GZagqzk+aMcuQc/02T3x4sse1KRXJnd98sIlqPdK5bQz1
         t/6/Bv6AE6BHEFAbl5j9N7AJbrrR3SwZv2ZjnHlQWQAfRW7Dbvr+I/buRhoGBy2cRqbw
         fW0CZylUtDC+VQQVYzxmUzU5fwyW37VA9xkJQ68z9JkKVOP4IHDRrKa6d+CzMNzlYoe3
         ZrBcDMBnfEK2JgzLhBwkqFJF13La5IgzNkK36j+qMQlC2Hln6ZAfwEL68VWNj1vFsLtE
         1/8ukQjGj0B/wmEpb+UzrvRfrS5WBGq7y3I1aRykc0QCI2bggHlZ2c1Q4w+y0GBf8jZK
         CQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JpFWqVr5vWw+tyS7McnlpT+MWLRu44AXJHuMei2pYI0=;
        b=qx+gEdl/e77Wpl0gVwlX2l7mCMdrRvpkHjJ9au/dPHMNXKA9jGrfXiBSRbjJB/sIFi
         6u0Y7rTlZMGB9/MeVdqVk1/3+Cz7GuFFhuDgM6cE47B2UPSF0o5hZy6/1JuJt3qr8pxV
         GbD1UPmDAkloOB102Z3KrvyTYsmPS3ngYUclULEkizRwTGj1TipjQbsr2vFq3Zd2yKzQ
         qiOXL2T3RHxMp2QxeOwHvgAG63CwhJVbQf66/hDE+fEftWdK+mxenWDWXRhzHURir4uH
         ED+xTj2KRXbaf+aALeBJ76IpZQyoFzbTqMeXqgIkCcfOehoFl2mc2Bgsq2Mv0I7DXgtz
         biuA==
X-Gm-Message-State: APt69E1ONQwdQyzKQ36V1M1UpLhfzxd5XZ+XgCARvYBXg6bOHk3kwLAP
        WudUKFjMCTfojfKqDE3uNRdjDbeGZrw=
X-Google-Smtp-Source: ADUXVKLacoDf8BYw7HqChGsjCLDSgQUINF5JK6tnarSvg2Oa6lxs3XbDw4WVj6Vv/tTJWHC5jfyF+g==
X-Received: by 2002:a17:902:2884:: with SMTP id f4-v6mr21243564plb.204.1529455785612;
        Tue, 19 Jun 2018 17:49:45 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id n76-v6sm1219764pfg.98.2018.06.19.17.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 17:49:44 -0700 (PDT)
Date:   Tue, 19 Jun 2018 17:49:44 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Shakeel Butt <shakeelb@google.com>
cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] slub: fix __kmem_cache_empty for !CONFIG_SLUB_DEBUG
In-Reply-To: <20180619213352.71740-1-shakeelb@google.com>
Message-ID: <alpine.DEB.2.21.1806191748040.25812@chino.kir.corp.google.com>
References: <20180619213352.71740-1-shakeelb@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018, Shakeel Butt wrote:

> diff --git a/mm/slub.c b/mm/slub.c
> index a3b8467c14af..731c02b371ae 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3673,9 +3673,23 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
>  
>  bool __kmem_cache_empty(struct kmem_cache *s)
>  {
> -	int node;
> +	int cpu, node;

Nit: wouldn't cpu be unused if CONFIG_SLUB_DEBUG is disabled?

>  	struct kmem_cache_node *n;
>  
> +	/*
> +	 * slabs_node will always be 0 for !CONFIG_SLUB_DEBUG. So, manually
> +	 * check slabs for all cpus.
> +	 */
> +	if (!IS_ENABLED(CONFIG_SLUB_DEBUG)) {
> +		for_each_online_cpu(cpu) {
> +			struct kmem_cache_cpu *c;
> +
> +			c = per_cpu_ptr(s->cpu_slab, cpu);
> +			if (c->page || slub_percpu_partial(c))
> +				return false;
> +		}
> +	}
> +
>  	for_each_kmem_cache_node(s, node, n)
>  		if (n->nr_partial || slabs_node(s, node))
>  			return false;

Wouldn't it just be better to allow {inc,dec}_slabs_node() to adjust the 
nr_slabs counter instead of doing the per-cpu iteration on every shutdown?
