Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3533CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EBF21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0E9/vej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeLRToM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:44:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35325 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeLRToJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:44:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so8283722pgs.2;
        Tue, 18 Dec 2018 11:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XU/SeUvQ2jX8Gn96XZciqfS70zf1BrIRvyoEZrQ3AdU=;
        b=U0E9/vejXMo+VknBnFnQW8UMwWE7yIKdgJkdSxDs9xIV8twplq3XAjXlAscowOHDxC
         6EPBWh3231/bbFNJvnabFbTj/PxlzcWdbKCwALxdpBONtU7YXYMVEOuglkdTKHcLAjqg
         SjcaiwGeAkXrFjDAk0DJcapMt24jutLCdxPmS1NZFuPJuJ1ldyq4Eoo1cn5Sg0gV4yAe
         r67ZtrlOterhKnAQXXVB/zEZcReFj8C1ec5E8q/Au0i3ouJ6I0jSPu5J3IKHY6YCB1we
         qmyBvqWPh0lJKBnATkprI0ilalaF6oi3nwia7ekkwyCgJIVD6PwhNJDYLH76ULmYv0ej
         iXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XU/SeUvQ2jX8Gn96XZciqfS70zf1BrIRvyoEZrQ3AdU=;
        b=g85IavRsbY1Ouio7VUcvVBI++BkQaclly8eACQtLsPb0eb00uipWFtFYRZZtUGwzWN
         qTZOuOC7PFFNN53jC6RQTjmOUaS6ht0TyzL+uUyR2RMDhg2XhmznCvpBNTaf+WMqYL2l
         QnXxvMZ1P8RWSAdiBW6x6g2DHaqO8YXz5LiRaib8fV12zN75liTHJyeUqEIbRE8ozr+s
         /Yui/BkFq3K2v4acs3OpdQMgPwtV9TrfHFHh0g3q9wqBRZt0c2jRqzrnbViCtD7RZKkK
         tNBqVFRakA3ykvfvjA+DH1EAUFB8VrVMMJfbot2c2Z6E8JiYP9saUFNFPnBZcvm0P4ip
         Dj3w==
X-Gm-Message-State: AA+aEWYu7GfBtvOi50oBRK3K9bSD4MlFep2b5Hzhu83OrNs2Ak1oAydW
        CytLrLH70R7emxsfFYRqyOw=
X-Google-Smtp-Source: AFSGD/XUPQXCJgfL1F5lO45htEgoJA4EIdAwR+ySkwfbhIfzbbo9EMncZBhCfw2iUxLTu2nnS2+1yA==
X-Received: by 2002:a63:1c61:: with SMTP id c33mr16543205pgm.354.1545162248940;
        Tue, 18 Dec 2018 11:44:08 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v191sm39479518pgb.77.2018.12.18.11.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 11:44:08 -0800 (PST)
Subject: Re: [PATCH v3 2/2] of: __of_detach_node() - remove node from phandle
 cache
From:   Frank Rowand <frowand.list@gmail.com>
To:     robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1545162003-11577-1-git-send-email-frowand.list@gmail.com>
 <1545162003-11577-3-git-send-email-frowand.list@gmail.com>
Message-ID: <8236132c-ccfd-4d2a-c490-7a52ec9df0e8@gmail.com>
Date:   Tue, 18 Dec 2018 11:44:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545162003-11577-3-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 11:40 AM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Non-overlay dynamic devicetree node removal may leave the node in
> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
> will incorrectly find the stale entry.  Remove the node from the
> cache.
> 
> Add paranoia checks in of_find_node_by_phandle() as a second level
> of defense (do not return cached node if detached, do not add node
> to cache if detached).
> 
> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
> Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> do not "cc: stable", unless the following commits are also in stable:
> 
>   commit e54192b48da7 ("of: fix phandle cache creation for DTs with no phandles")
>   commit b9952b5218ad ("of: overlay: update phandle cache on overlay apply and remove")
>   commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
> 
> 
> Changes since v2:
>   - add temporary variable np in __of_free_phandle_cache_entry() to improve
>     readability
>   - explain reason for WARN_ON() in comment
>   - add Fixes tag in patch comment

I should have carried this forward:

changes since v1:
  - add WARN_ON(1) for unexpected condition in of_find_node_by_phandle()

-Frank

> 
>  drivers/of/base.c       | 31 ++++++++++++++++++++++++++++++-
>  drivers/of/dynamic.c    |  3 +++
>  drivers/of/of_private.h |  4 ++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 6c33d63361b8..6d20b6dcf034 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -162,6 +162,28 @@ int of_free_phandle_cache(void)
>  late_initcall_sync(of_free_phandle_cache);
>  #endif
>  
> +/*
> + * Caller must hold devtree_lock.
> + */
> +void __of_free_phandle_cache_entry(phandle handle)
> +{
> +	phandle masked_handle;
> +	struct device_node *np;
> +
> +	if (!handle)
> +		return;
> +
> +	masked_handle = handle & phandle_cache_mask;
> +
> +	if (phandle_cache) {
> +		np = phandle_cache[masked_handle];
> +		if (np && handle == np->phandle) {
> +			of_node_put(np);
> +			phandle_cache[masked_handle] = NULL;
> +		}
> +	}
> +}
> +
>  void of_populate_phandle_cache(void)
>  {
>  	unsigned long flags;
> @@ -1209,11 +1231,18 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>  		if (phandle_cache[masked_handle] &&
>  		    handle == phandle_cache[masked_handle]->phandle)
>  			np = phandle_cache[masked_handle];
> +		if (np && of_node_check_flag(np, OF_DETACHED)) {
> +			WARN_ON(1); /* did not uncache np on node removal */
> +			of_node_put(np);
> +			phandle_cache[masked_handle] = NULL;
> +			np = NULL;
> +		}
>  	}
>  
>  	if (!np) {
>  		for_each_of_allnodes(np)
> -			if (np->phandle == handle) {
> +			if (np->phandle == handle &&
> +			    !of_node_check_flag(np, OF_DETACHED)) {
>  				if (phandle_cache) {
>  					/* will put when removed from cache */
>  					of_node_get(np);
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index f4f8ed9b5454..ecea92f68c87 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -268,6 +268,9 @@ void __of_detach_node(struct device_node *np)
>  	}
>  
>  	of_node_set_flag(np, OF_DETACHED);
> +
> +	/* race with of_find_node_by_phandle() prevented by devtree_lock */
> +	__of_free_phandle_cache_entry(np->phandle);
>  }
>  
>  /**
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 5d1567025358..24786818e32e 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -84,6 +84,10 @@ static inline void __of_detach_node_sysfs(struct device_node *np) {}
>  int of_resolve_phandles(struct device_node *tree);
>  #endif
>  
> +#if defined(CONFIG_OF_DYNAMIC)
> +void __of_free_phandle_cache_entry(phandle handle);
> +#endif
> +
>  #if defined(CONFIG_OF_OVERLAY)
>  void of_overlay_mutex_lock(void);
>  void of_overlay_mutex_unlock(void);
> 

