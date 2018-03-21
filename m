Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeCUMz7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 08:55:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:43447 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751502AbeCUMz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 08:55:56 -0400
Date: Wed, 21 Mar 2018 13:55:54 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Initialize shadow variables by init
 function safely
In-Reply-To: <20180313155448.1998-2-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1803211352090.19993@pobox.suse.cz>
References: <20180313155448.1998-1-pmladek@suse.com> <20180313155448.1998-2-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -186,10 +198,13 @@ static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
>   * Return: the shadow variable data element, NULL on duplicate or
>   * failure.
>   */
> -void *klp_shadow_alloc(void *obj, unsigned long id, void *data,
> -		       size_t size, gfp_t gfp_flags)
> +void *klp_shadow_alloc(void *obj, unsigned long id,
> +		       size_t size, gfp_t gfp_flags,
> +		       klp_shadow_init_func_t init_func,
> +		       void *init_data)

The comment above the function should be also updated, because the 
function's parameters changed.

>  {
> -	return __klp_shadow_get_or_alloc(obj, id, data, size, gfp_flags, true);
> +	return __klp_shadow_get_or_alloc(obj, id, size, gfp_flags,
> +					 init_func, init_data, true);
>  }
>  EXPORT_SYMBOL_GPL(klp_shadow_alloc);
>  
> @@ -212,10 +227,13 @@ EXPORT_SYMBOL_GPL(klp_shadow_alloc);
>   *
>   * Return: the shadow variable data element, NULL on failure.
>   */
> -void *klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
> -			       size_t size, gfp_t gfp_flags)
> +void *klp_shadow_get_or_alloc(void *obj, unsigned long id,
> +			      size_t size, gfp_t gfp_flags,
> +			      klp_shadow_init_func_t init_func,
> +			      void *init_data)

Ditto.

Thanks,
Miroslav
