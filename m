Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932142AbeAaPmP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:42:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:39630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932066AbeAaPmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:42:12 -0500
Date: Wed, 31 Jan 2018 16:42:10 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: jpoimboe@redhat.com, jikos@kernel.org, Jason Baron <jbaron@akamai.com>,
        jeyu@kernel.org, Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: PATCH v6 4/6] livepatch: Allow to unpatch only functions of the
 given type
In-Reply-To: <20180125160203.28959-5-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1801311639450.7649@pobox.suse.cz>
References: <20180125160203.28959-1-pmladek@suse.com> <20180125160203.28959-5-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +void klp_unpatch_object(struct klp_object *obj, enum klp_func_type ftype)
>  {
>  	struct klp_func *func;
> +	bool patched = false;
>  
> -	klp_for_each_func(obj, func)
> -		if (func->patched)
> +	klp_for_each_func(obj, func) {
> +		if (!func->patched)
> +			continue;
> +
> +		if (ftype == KLP_FUNC_ANY || ftype == func->ftype)

You defined klp_is_func_type() exactly for this purpose.

Otherwise, it looks good. There is no functional change.

Miroslav
