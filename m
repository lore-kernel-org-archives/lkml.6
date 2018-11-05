Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963BBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D8D2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKPVpBRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D8D2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbeKFHXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:23:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41272 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:23:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so11233264wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FhHNxaUnAV2yLa9YkFmiSIqBLaq8FIqwAKQ6l7i1S9k=;
        b=eKPVpBRy4BplOQc+MgtfY9+7pVdT7oW2/6/qjyE2Cuu7I83BF+zlwuGrXVmxJEwZnP
         6scxZ5LFjfYxPJFrdNA7xqGpb81bwSk+/Djz9GuTriUbb60ICI3hUploccCIQyzPMb0k
         GTpRBBbQgSeerYpy6YAnfw5FCMMWP02UhyykT4HzNs2gxe/5exqPF4sXstsoBIySZ43V
         Np5TDE96cN2tzIFh4bOr0U5ZYYi9W7qVE5oAfC7WYyVOqbJN6LNCfUf/GZ6k6A2F4QLA
         0itDW6lByfThlJEohTLhwxRMYHZ1XBcrEVFcHThgbgGiFwSDwDu+coSEZwb93tnRdejF
         puOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FhHNxaUnAV2yLa9YkFmiSIqBLaq8FIqwAKQ6l7i1S9k=;
        b=T7wfGRbPAvdrz3b1rYO8BFuuAceWrZOvTbrDWl/XyEiE7UwIiuk3uSn0qIe1Dy1r35
         u+1W5+l+Ksxz+vCcX2hp0lBDARe1NKEJJWcbGX7v2pAujqosU0IliyNrADKcWGsh9owU
         ICLD+dI4Rgs3X06gD71hgOn79vhBC7wGrLj0T4+YMnioynyrbK2YYgAscn89nlUE/POD
         vvaP34YkrDDn+JQy5RXEqKQbN/NnoJU2JWZkAKSEP8H0s32B5lUweLsd2MetpIJbFadC
         QLGee7iKnrAonIx1ytCKJ6g8DqRjqiuilKKwonYBBfy/bBYks5RwT/wGprYVbAAss39p
         cluw==
X-Gm-Message-State: AGRZ1gJoMQ+IoTVlm9e+ApoFUkglVdLD/JKKm38PxmxsS1DkD3sqhyQ+
        9PONacVkdMsWg7lPFHAnzUw=
X-Google-Smtp-Source: AJdET5ffoPOKZk045rNC+WUfdcpQvz0wP6BBl+fBbVro8r8bbo77BnEVOKVBsCmhf4PO/Rkz1FbwBQ==
X-Received: by 2002:a05:6000:12d0:: with SMTP id l16mr16860707wrx.27.1541455274355;
        Mon, 05 Nov 2018 14:01:14 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 65-v6sm244330wmj.1.2018.11.05.14.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 14:01:13 -0800 (PST)
Date:   Mon, 5 Nov 2018 15:01:11 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] cachefiles: Explicitly cast enumerated type in put_object
Message-ID: <20181105220111.GA7640@flashbox>
References: <20180924173344.27952-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924173344.27952-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:33:44AM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
> 
> fs/cachefiles/namei.c:247:50: warning: implicit conversion from
> enumeration type 'enum cachefiles_obj_ref_trace' to different
> enumeration type 'enum fscache_obj_ref_trace' [-Wenum-conversion]
>         cache->cache.ops->put_object(&xobject->fscache,
> cachefiles_obj_put_wait_retry);
> 
> Silence this warning by explicitly casting to fscache_obj_ref_trace,
> which is also done in put_object.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  fs/cachefiles/namei.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index af2b17b21b94..15e5988a83de 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -244,11 +244,13 @@ static int cachefiles_mark_object_active(struct cachefiles_cache *cache,
>  
>  	ASSERT(!test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags));
>  
> -	cache->cache.ops->put_object(&xobject->fscache, cachefiles_obj_put_wait_retry);
> +	cache->cache.ops->put_object(&xobject->fscache,
> +		(enum fscache_obj_ref_trace)cachefiles_obj_put_wait_retry);
>  	goto try_again;
>  
>  requeue:
> -	cache->cache.ops->put_object(&xobject->fscache, cachefiles_obj_put_wait_timeo);
> +	cache->cache.ops->put_object(&xobject->fscache,
> +		(enum fscache_obj_ref_trace)cachefiles_obj_put_wait_timeo);
>  	_leave(" = -ETIMEDOUT");
>  	return -ETIMEDOUT;
>  }
> -- 
> 2.19.0
> 

Hi David,

Have you had a chance to take a look at this patch?

Thanks,
Nathan
