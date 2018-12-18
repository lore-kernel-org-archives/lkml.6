Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D98DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3244421873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8Y3UnCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeLRS5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:57:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38900 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeLRS5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:57:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so8220100pgc.5;
        Tue, 18 Dec 2018 10:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PjGvbnfLhPPm0SXuTZwSXCShHgZC59Z+ZbinXYEiYTs=;
        b=Y8Y3UnCjUXV1Q6D/GQNvBx801eNl6axxfPaRiHADiu0HhnvGSyA2fkRoBziYcQ7Wwq
         gqEZPKIWl+QbgaD48J8xJNvqM4EKJVYNrQWJo9iaPHo0lgbtBnoGnqVRnwEl3mSkeIfu
         Xvrinz4txoQ4zWSRlTiiRJSfCqYx17ThRLzdkTY38ay/uDj1lMzyw5F9GKRtRpYpeMdI
         2cb239brHOQ2i0qYqQy+PgTWbulb9OD3YuC74h+fQlfitrTMW//b/8c6/kcD2RB/vvYQ
         EQJSTxNw28b7Y48XoAHpiLwVAfJoXakkVvUGYZCpblXF63IpSZJJ/7Js8EvO1LA/bgYi
         GR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PjGvbnfLhPPm0SXuTZwSXCShHgZC59Z+ZbinXYEiYTs=;
        b=KZSGs2qb7KsaavtL3FU6tCP5XGkbQu1Hq6lOuGP+armeKYYMNjK6dYTb7c9vgCBKiz
         fQkGJUECsaghuqKiwUIJLXOQuJnNq7dwn7V7PvdaYMVQ8lZzEjgJzsYGBnvQvybKnMPf
         7Ao3B+SpYV1OFsH3NthHpGBMm8PUgwXXlVS/CQsWGe0B0FesXkq/BPa0Amu3aWgCsf+z
         uwzj708XuUm1jTKWN2uSEMK1si+zkVKK4qXk9aOMAjkvUR3JAAG2b3Q300mvB4bokhsZ
         /VZhQo0nXmnxt7F2JgHlhom8Pj9nCk/Ic0h6CrEXsNbbnMocz5hgkKKpdgaELv2nQe83
         +tCw==
X-Gm-Message-State: AA+aEWYzORgMxrTq8CwzvqBRPUN6P2zoNIza4XqXL1QRcAeyA6tbKm5y
        FFobpQatL38+KRWGLNiH3Ho=
X-Google-Smtp-Source: AFSGD/USb3bGS65TzadVotpbTeAD9u2bdXqPb2wxYQL69++1fMVq960yXPVtkkNVsAKDzK+boOWKIA==
X-Received: by 2002:a62:a510:: with SMTP id v16mr17596135pfm.18.1545159461094;
        Tue, 18 Dec 2018 10:57:41 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id p24sm22878563pfk.155.2018.12.18.10.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:57:40 -0800 (PST)
Subject: Re: [PATCH v2 2/2] of: __of_detach_node() - remove node from phandle
 cache
To:     Michael Ellerman <mpe@ellerman.id.au>, robh+dt@kernel.org,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
 <1545033396-24485-3-git-send-email-frowand.list@gmail.com>
 <871s6gv30z.fsf@concordia.ellerman.id.au>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b81f9268-a36c-963d-5b1e-d81b38b05143@gmail.com>
Date:   Tue, 18 Dec 2018 10:57:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <871s6gv30z.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 2:52 AM, Michael Ellerman wrote:
> Hi Frank,
> 
> frowand.list@gmail.com writes:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Non-overlay dynamic devicetree node removal may leave the node in
>> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
>> will incorrectly find the stale entry.  Remove the node from the
>> cache.
>>
>> Add paranoia checks in of_find_node_by_phandle() as a second level
>> of defense (do not return cached node if detached, do not add node
>> to cache if detached).
>>
>> Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
> 
> Similarly here can we add:
> 
> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")

Yes, thanks.


> Cc: stable@vger.kernel.org # v4.17+

Nope, 0b3ce78e90fc does not belong in stable (it is a feature, not a bug
fix).  So the bug will not be in stable.

I've debated with myself over this, because there is a possibility that
0b3ce78e90fc could somehow be put into a stable despite not being a
bug fix.  We can always explicitly request this patch series be added
to stable in that case.


> Thanks for doing this series.
> 
> Some minor comments below.
> 
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 6c33d63361b8..ad71864cecf5 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -162,6 +162,27 @@ int of_free_phandle_cache(void)
>>  late_initcall_sync(of_free_phandle_cache);
>>  #endif
>>  
>> +/*
>> + * Caller must hold devtree_lock.
>> + */
>> +void __of_free_phandle_cache_entry(phandle handle)
>> +{
>> +	phandle masked_handle;
>> +
>> +	if (!handle)
>> +		return;
> 
> We could fold the phandle_cache check into that if and return early for
> both cases couldn't we?

We could, but that would make the reason for checking phandle_cache
less obvious.  I would rather leave that check
> 
>> +	masked_handle = handle & phandle_cache_mask;
>> +
>> +	if (phandle_cache) {
> 
> Meaning this wouldn't be necessary.
> 
>> +		if (phandle_cache[masked_handle] &&
>> +		    handle == phandle_cache[masked_handle]->phandle) {
>> +			of_node_put(phandle_cache[masked_handle]);
>> +			phandle_cache[masked_handle] = NULL;
>> +		}
> 
> A temporary would help the readability here I think, eg:
> 
> 	struct device_node *np;
>         np = phandle_cache[masked_handle];
> 
> 	if (np && handle == np->phandle) {
> 		of_node_put(np);
> 		phandle_cache[masked_handle] = NULL;
> 	}

Yes, much cleaner.


>> @@ -1209,11 +1230,18 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>>  		if (phandle_cache[masked_handle] &&
>>  		    handle == phandle_cache[masked_handle]->phandle)
>>  			np = phandle_cache[masked_handle];
>> +		if (np && of_node_check_flag(np, OF_DETACHED)) {
>> +			WARN_ON(1);
>> +			of_node_put(np);
>
> Do we really want to do the put here?
> 
> We're here because something has gone wrong, possibly even memory
> corruption such that np is not even pointing at a device node anymore.
> So it seems like it would be safer to just leave the ref count alone,
> possibly leak a small amount of memory, and NULL out the reference.

I like the concept of the code being a little bit paranoid.

But the bug that this check is likely to cache is the bug that led
to this series -- removing a devicetree node, but failing to remove
it from the cache as part of the removal.  So I think I'll leave
it as is.

> 
> 
> cheers
> 

Thanks for the thoughts and suggestions!

-Frank

