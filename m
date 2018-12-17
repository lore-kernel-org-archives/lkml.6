Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDADC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94E32133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMSK6tqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbeLQOm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:42:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54846 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLQOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:42:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so12598256wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 06:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iPxGzNvUbpYdaGSMVmTlfEnk5MteCI7PrIFhmPFOTcs=;
        b=EMSK6tqkxYJ4tFea5J7R6n7kYsK3tOxhuRWVlsDvANbFJrpdi9M6seTsNF/HieNAhu
         iQ+gzyEB8EhrZXeol0b4rRCYaiglzTM6YxBmSp8Id8a1Rh4UklAlJT4wgLThxVePD6oM
         SRjb8JkNLx/R1UgtMmveNhVcLLZkNJtrDdzVzjX1BTTm6utRQSad8gNA+nteYKbKDVNn
         RhB7Xk+9UvTaJZVlTpmGavX3DZxvsTeywRtlm+gzAPQHYoVcYQPBz9rf77bVZgWXvRkl
         3JRaf4vQzufbF14anljBwwMCpHDIt0BSNHZoAMngSPEY6BvCsRh19aA+g0ykn1MT/ltG
         vpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iPxGzNvUbpYdaGSMVmTlfEnk5MteCI7PrIFhmPFOTcs=;
        b=H5hCcKHUNtCkUrMnp25jJMWmn3fTmT33EPYvs52VQXJ5Iuae/b8ld7Cm81FM1fB6Bj
         mAht4nTvlOAEBGp8s+cuWfpGKDnsdXMgCZKNeQ4XHnEWXTZWa2BWpkvQkTFH3LqITeQq
         +25cQDx/NKnneCzKUeQ+uiSBSArfWBq+/4dagW0C4I859QjYQEtY8wVJ06nspmjjHiJ4
         ABkQiZN8sU4sb9mgRP0azjmyTk1j7M1z+t+zCMMD2r6lJt4AsMh3jkkRPCWkT5gU/3UL
         iFQLPz8wjvpFNYOvbDDbuWnWby1gi8i1AeqbuVz5KoY7rRPA2H37E5Bm9fFc9IGwebO+
         9p+A==
X-Gm-Message-State: AA+aEWbx0abvhjbv1hXSFWcd99QNv9HqU3fszlFeW+iyaVEcgBdLqyy3
        J47rXs4jthMuB3ZcxO+qMjc=
X-Google-Smtp-Source: AFSGD/UQeYZjmxpDQm8ef+XtsYM0PLt8PS2tll9PxXriI1njZGqKwJqDb2gdR+zgQxsTCeFOvuRCzw==
X-Received: by 2002:a1c:58ce:: with SMTP id m197mr12506247wmb.31.1545057775817;
        Mon, 17 Dec 2018 06:42:55 -0800 (PST)
Received: from [192.168.8.147] (76.42.136.77.rev.sfr.net. [77.136.42.76])
        by smtp.gmail.com with ESMTPSA id f130sm11705291wme.41.2018.12.17.06.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 06:42:54 -0800 (PST)
Subject: Re: [PATCH] iov_iter: optimize page_copy_sane()
To:     Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20181208133735.245799-1-edumazet@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <0d6058b9-8123-6d8c-0571-6ea9a5cd822d@gmail.com>
Date:   Mon, 17 Dec 2018 06:42:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181208133735.245799-1-edumazet@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/08/2018 05:37 AM, Eric Dumazet wrote:
> Avoid cache line miss dereferencing struct page if we can.
> 
> page_copy_sane() mostly deals with order-0 pages.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 54c248526b55fc498c996f2a5ea651262fcc7f61..2a1e282c3d38e2d03b075f54b7f9313e48b90289 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -854,8 +854,18 @@ EXPORT_SYMBOL(_copy_from_iter_full_nocache);
>  
>  static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
>  {
> -	struct page *head = compound_head(page);
> -	size_t v = n + offset + page_address(page) - page_address(head);
> +	struct page *head;
> +	size_t v = n + offset;
> +
> +	/*
> +	 * Fast path if this is an order-0 page,
> +	 * or if the copied area fits the first page of a compound one.
> +	 */
> +	if (likely(n <= v && v <= PAGE_SIZE))
> +		return true;
> +
> +	head = compound_head(page);
> +	v += (page - head) << PAGE_SHIFT;
>  
>  	if (likely(n <= v && v <= (PAGE_SIZE << compound_order(head))))
>  		return true;
> 

Hi Alexander !

Any news on this patch ?

Thanks !
