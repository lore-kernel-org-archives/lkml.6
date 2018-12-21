Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5F9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE2321928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M67B5Mqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392051AbeLUV6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:58:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38444 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeLUV6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:58:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so3063277pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tPIyQKEhD8jSuYym3JA98vimnD2uHKo0PyBvCttAp70=;
        b=M67B5Mqm948rD0LRf4ZPMVo+xHTg+EuImBkQtlQ06jbb08eViauzP/ayOcFgEL69Ms
         NT3otIX7hQlTC4vEvmuKVEi0iOeZXoGYZKpZHfywWwDrLxAUnbckPbgNoF0/aJXetfLI
         j48W6ffx/M8XbIrKlqCxAbP1eQQ4jrSIp79tPeZ2I8erPdlG0BuX7P2uwpgJGlhABIpg
         KsJPbwmc/IhAnPgZ8FUuJ4vqsBBNuc2tOqr4gY7Dx9kUfT7hrIuPqRDsZ/7dyFTM9/m0
         ZMf0ttwPZ34U61YBKsyZPE1bKnhQwa2cFfKNukyzHihQZ2cdsHyfrCT0ma6+R1x/Lb94
         dN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tPIyQKEhD8jSuYym3JA98vimnD2uHKo0PyBvCttAp70=;
        b=Rz1EJwyL5sm8hCoq24YZI4aKT2zY2eBXUPs45XSFDbET6ELKmzcck299skQ+JYudc8
         iI6j0zhVve0nZW/I0OaR+XqS1frsy/q2an5/fqJhXhbul4I1upZsZbjIYhL54qwbNSJ4
         TCAHEDQxbRg0FeyMAbrrYXiY2YZPnQWtWvik+zDI1W1njBW0Hkb/QArjFnsJSC0Ai1Tf
         6UmS1tl/u/3TMW2OH0WgCOFyAv2Z1RNqdewj8UdetD+YQW2XoyCFaiQQxK7JPn0UswYv
         rCWow9Xh2oCr8SeoJpbj3im6yR8jJA4u9T8j+75aIBwHvSjy/F4gmz3DLAHGfZrsOL1a
         2dgA==
X-Gm-Message-State: AJcUukcQh1Y8gRjXFW8PgV54jUIPh3Wm1TtB7O4m/42qSVXul/79DsBW
        1DKpZbQmcvEsU3B3yL5sIcsA7A==
X-Google-Smtp-Source: ALg8bN7THH/UMe8WVTeMlD31zR3I/nyagot0sPRVGoPHwqFzd1Sdga4IglBX8w70Ld/X83/h2r74hw==
X-Received: by 2002:a63:e445:: with SMTP id i5mr3999567pgk.307.1545429521165;
        Fri, 21 Dec 2018 13:58:41 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 7sm82600646pfm.8.2018.12.21.13.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 13:58:40 -0800 (PST)
Date:   Fri, 21 Dec 2018 13:58:39 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Nicholas Mc Guire <hofrat@osadl.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Arun KS <arunks@codeaurora.org>, Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] mm: vmalloc: do not allow kzalloc to fail
In-Reply-To: <1545337437-673-1-git-send-email-hofrat@osadl.org>
Message-ID: <alpine.DEB.2.21.1812211356040.219499@chino.kir.corp.google.com>
References: <1545337437-673-1-git-send-email-hofrat@osadl.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018, Nicholas Mc Guire wrote:

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 871e41c..1c118d7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1258,7 +1258,7 @@ void __init vmalloc_init(void)
>  
>  	/* Import existing vmlist entries. */
>  	for (tmp = vmlist; tmp; tmp = tmp->next) {
> -		va = kzalloc(sizeof(struct vmap_area), GFP_NOWAIT);
> +		va = kzalloc(sizeof(*va), GFP_NOWAIT | __GFP_NOFAIL);
>  		va->flags = VM_VM_AREA;
>  		va->va_start = (unsigned long)tmp->addr;
>  		va->va_end = va->va_start + tmp->size;

Hi Nicholas,

You're right that this looks wrong because there's no guarantee that va is 
actually non-NULL.  __GFP_NOFAIL won't help in init, unfortunately, since 
we're not giving the page allocator a chance to reclaim so this would 
likely just end up looping forever instead of crashing with a NULL pointer 
dereference, which would actually be the better result.

You could do

	BUG_ON(!va);

to make it obvious why we crashed, however.  It makes it obvious that the 
crash is intentional rather than some error in the kernel code.
