Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1021EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E6521841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3CQGaP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeLRToH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:44:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40708 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeLRToG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:44:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so8275685pgp.7;
        Tue, 18 Dec 2018 11:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FZvEscmbqVBhJvV3+aSjvyOV12Zjv5oGUzrsFfU3VcQ=;
        b=K3CQGaP0r80Z7wmdG/rW8C0A4TUhIcS1ZP1N98L8a9zFgGrI18kWAIAWbrYN9eezQG
         1vCAPVl/3IQSHobYHlABCpqhvzsvfLqZUz23avNuY9RC6ytf5GeEPBywtZGvoWtoiT//
         EBwyq3rfsg+sEWmp5fJdB2myzBbFUkTRXck9ijhz+1FNp4oVTVEbg7g0o0nJ2b+4Chsd
         z/CH7adr4T6WJexkcMWDr+c7AjtB/UWc1GzoPD3LTLrNtUpmEge92Kf06Icc7YNjc0c1
         RNStFKOylPU5OPotyp86DdiyFf/tQkQ3cPfJg1XUCi1yJL5JsAqJ2P5IyQDA2xFRs0XK
         /IHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FZvEscmbqVBhJvV3+aSjvyOV12Zjv5oGUzrsFfU3VcQ=;
        b=i0/wm0l3cDwPdbvTAn5FwZ6v9af8oQ4bs/XI5z787wXp+0atm1eNnI7BzXIOxlqiGL
         t/6+YFeQNw84aJ5Dt97m8eSdp71EjpC5R0PE4eLe6z0mfZjPDoUcpdDdSBapXt6gWHYk
         YnI8WG4c0015Lt+6zvoRJOpqAtZ+IJWMCBGWnCsibltRnegLbcORjUiA5wGkEn/sPWVl
         DpT0VxID42pP6DRBbzxMnP2aYWRod7lSGhYKY8M6frYGNl6qar0xfPjYjwT+RpA39Tpg
         1nfC/Ux6qVVLkq5gVZIk5Bn9EtFRgG/y9Sug7TCQfdnvf+4jRTTmhfoL7Z3DLFPD1z7Z
         o2sQ==
X-Gm-Message-State: AA+aEWZ4hn1Rm+g6dYMNwTviWzvYZFzIoYd/gU/uf6eeige5GzR2696s
        4Oy6amTCXs7LJkxHEs4ddHA=
X-Google-Smtp-Source: AFSGD/XKxXaaMNRjksnsw9PdwLQBDPWA1WVqiwCL+vr22woElwutUfN1DPRd/M98gFcN5Vf8+JvzIQ==
X-Received: by 2002:a63:4d0e:: with SMTP id a14mr438236pgb.408.1545162245942;
        Tue, 18 Dec 2018 11:44:05 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j185sm20389076pge.72.2018.12.18.11.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 11:44:05 -0800 (PST)
Subject: Re: [PATCH v3 1/2] of: of_node_get()/of_node_put() nodes held in
 phandle cache
From:   Frank Rowand <frowand.list@gmail.com>
To:     robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1545162003-11577-1-git-send-email-frowand.list@gmail.com>
 <1545162003-11577-2-git-send-email-frowand.list@gmail.com>
Message-ID: <4852cb6e-a3e6-89ca-c72a-65de40177a5b@gmail.com>
Date:   Tue, 18 Dec 2018 11:44:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545162003-11577-2-git-send-email-frowand.list@gmail.com>
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
> The phandle cache contains struct device_node pointers.  The refcount
> of the pointers was not incremented while in the cache, allowing use
> after free error after kfree() of the node.  Add the proper increment
> and decrement of the use count.
> 
> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> do not "cc: stable", unless the following commits are also in stable:
> 
>   commit e54192b48da7 ("of: fix phandle cache creation for DTs with no phandles")
>   commit b9952b5218ad ("of: overlay: update phandle cache on overlay apply and remove")
>   commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")

I should have carried this forward:

changes since v1
  - make __of_free_phandle_cache() static

-Frank

> 
> 
>  drivers/of/base.c | 70 ++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 46 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 09692c9b32a7..6c33d63361b8 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -116,9 +116,6 @@ int __weak of_node_to_nid(struct device_node *np)
>  }
>  #endif
>  
> -static struct device_node **phandle_cache;
> -static u32 phandle_cache_mask;
> -
>  /*
>   * Assumptions behind phandle_cache implementation:
>   *   - phandle property values are in a contiguous range of 1..n
> @@ -127,6 +124,44 @@ int __weak of_node_to_nid(struct device_node *np)
>   *   - the phandle lookup overhead reduction provided by the cache
>   *     will likely be less
>   */
> +
> +static struct device_node **phandle_cache;
> +static u32 phandle_cache_mask;
> +
> +/*
> + * Caller must hold devtree_lock.
> + */
> +static void __of_free_phandle_cache(void)
> +{
> +	u32 cache_entries = phandle_cache_mask + 1;
> +	u32 k;
> +
> +	if (!phandle_cache)
> +		return;
> +
> +	for (k = 0; k < cache_entries; k++)
> +		of_node_put(phandle_cache[k]);
> +
> +	kfree(phandle_cache);
> +	phandle_cache = NULL;
> +}
> +
> +int of_free_phandle_cache(void)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +
> +	__of_free_phandle_cache();
> +
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +
> +	return 0;
> +}
> +#if !defined(CONFIG_MODULES)
> +late_initcall_sync(of_free_phandle_cache);
> +#endif
> +
>  void of_populate_phandle_cache(void)
>  {
>  	unsigned long flags;
> @@ -136,8 +171,7 @@ void of_populate_phandle_cache(void)
>  
>  	raw_spin_lock_irqsave(&devtree_lock, flags);
>  
> -	kfree(phandle_cache);
> -	phandle_cache = NULL;
> +	__of_free_phandle_cache();
>  
>  	for_each_of_allnodes(np)
>  		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
> @@ -155,30 +189,15 @@ void of_populate_phandle_cache(void)
>  		goto out;
>  
>  	for_each_of_allnodes(np)
> -		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
> +		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL) {
> +			of_node_get(np);
>  			phandle_cache[np->phandle & phandle_cache_mask] = np;
> +		}
>  
>  out:
>  	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>  }
>  
> -int of_free_phandle_cache(void)
> -{
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&devtree_lock, flags);
> -
> -	kfree(phandle_cache);
> -	phandle_cache = NULL;
> -
> -	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> -
> -	return 0;
> -}
> -#if !defined(CONFIG_MODULES)
> -late_initcall_sync(of_free_phandle_cache);
> -#endif
> -
>  void __init of_core_init(void)
>  {
>  	struct device_node *np;
> @@ -1195,8 +1214,11 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>  	if (!np) {
>  		for_each_of_allnodes(np)
>  			if (np->phandle == handle) {
> -				if (phandle_cache)
> +				if (phandle_cache) {
> +					/* will put when removed from cache */
> +					of_node_get(np);
>  					phandle_cache[masked_handle] = np;
> +				}
>  				break;
>  			}
>  	}
> 

