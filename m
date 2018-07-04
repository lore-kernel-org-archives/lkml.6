Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F578C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB24D2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBfEHIb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB24D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934173AbeGDIbx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:31:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50616 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932971AbeGDIbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:31:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so4890534wmc.0;
        Wed, 04 Jul 2018 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mskhaBPAgKzQ+4Ow8SNJZwZNe+1vpQmJCFiDaDTfRbs=;
        b=eBfEHIb3MU1r4N8U4RGwQmrKSuQ2x8FnXSFHYQ0aGJUmrSnzyzez9hV7pdvoVsEvPL
         Gl5R/dh0i0ptjhbxJqO3ZIPnU/qDXltqou7Euln+ntlb35sQYYjGxo14CXVEx6UA8P+4
         cK5sUvO/tfY9N55Cjas5Tckcwtm3HNvNyR6BgdeIj25dJ7FV7CoJPM6h8Du17A7c6SLs
         +7DGcPEd2eB3Iyl+GHvAM+eNLmvSZIM9kfi5bdVL1/thi4HgREOygLr3ZTi8ZHw4OYV0
         LnMexFmvf2DnGH5Gv2t9sySziWhwDppB0evIEkGPeyDVdyxKkkS9Ij8qnRlKjkE0LWvz
         kUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=mskhaBPAgKzQ+4Ow8SNJZwZNe+1vpQmJCFiDaDTfRbs=;
        b=ouNZHAgetbzHwAIOPtMB1Bj+fgs15sDep8SlqmWYtDsOE7lHCO9VXFisBhS83RlVs0
         OPDE+4+CKJmTaDucwXvUWePZ5oiKsfjIO9S1BO1cH8uCvWb6U2aTRdfblL/vD9u+JVVE
         7FNitl71T2enBPp7CRPnHdnWXQJ0swEWgu+Y2i2O9/YJGsDQSFqht2lWkllcRTN+g9Ak
         W+NPZgPhysjT6PavA3/Wx5EtAcAcA9Uz/oNZuU6mEQV1Hm9Uq3+lrBumctiUrmB8a9bT
         TM+KUZpwygELNosraBNBp8KU/NiLZ6uPOPAThw2iBkAHfHSF7BgK2js8FuqOIgBwA4xo
         Sw/g==
X-Gm-Message-State: APt69E0iPb2XkbXdb2bgSi7rxYx3lMeqPP4poXooanI8EZ2pHdt8X0lP
        7G3dsWRjn9US2JJ/10lmvRW04WnM
X-Google-Smtp-Source: AAOMgpeyjlFU5kJ5t+kER+iqpHqf21gg53X0um1WZkLhwe5fwzd8Je/d9/t7xxoP4WyZsL0pg0SWsA==
X-Received: by 2002:a1c:ea9c:: with SMTP id g28-v6mr941511wmi.65.1530693109005;
        Wed, 04 Jul 2018 01:31:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id r123-v6sm5586348wmb.21.2018.07.04.01.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 01:31:48 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] dma-buf: Move BUG_ON from _add_shared_fence to
 _add_shared_inplace
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
References: <20180626143147.14296-1-michel@daenzer.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <249b84ea-affe-2e27-abdd-81d61da9cce6@gmail.com>
Date:   Wed, 4 Jul 2018 10:31:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626143147.14296-1-michel@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.06.2018 um 16:31 schrieb Michel Dänzer:
> From: Michel Dänzer <michel.daenzer@amd.com>
>
> Fixes the BUG_ON spuriously triggering under the following
> circumstances:
>
> * ttm_eu_reserve_buffers processes a list containing multiple BOs using
>    the same reservation object, so it calls
>    reservation_object_reserve_shared with that reservation object once
>    for each such BO.
> * In reservation_object_reserve_shared, old->shared_count ==
>    old->shared_max - 1, so obj->staged is freed in preparation of an
>    in-place update.
> * ttm_eu_fence_buffer_objects calls reservation_object_add_shared_fence
>    once for each of the BOs above, always with the same fence.
> * The first call adds the fence in the remaining free slot, after which
>    old->shared_count == old->shared_max.

Well, the explanation here is not correct. For multiple BOs using the 
same reservation object we won't call 
reservation_object_add_shared_fence() multiple times because we move 
those to the duplicates list in ttm_eu_reserve_buffers().

But this bug can still happen because we call 
reservation_object_add_shared_fence() manually with fences for the same 
context in a couple of places.

One prominent case which comes to my mind are for the VM BOs during 
updates. Another possibility are VRAM BOs which need to be cleared.

>
> In the next call to reservation_object_add_shared_fence, the BUG_ON
> triggers. However, nothing bad would happen in
> reservation_object_add_shared_inplace, since the fence is already in the
> reservation object.
>
> Prevent this by moving the BUG_ON to where an overflow would actually
> happen (e.g. if a buggy caller didn't call
> reservation_object_reserve_shared before).
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> ---
>   drivers/dma-buf/reservation.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
> index 314eb1071cce..532545b9488e 100644
> --- a/drivers/dma-buf/reservation.c
> +++ b/drivers/dma-buf/reservation.c
> @@ -141,6 +141,7 @@ reservation_object_add_shared_inplace(struct reservation_object *obj,
>   	if (signaled) {
>   		RCU_INIT_POINTER(fobj->shared[signaled_idx], fence);
>   	} else {
> +		BUG_ON(fobj->shared_count >= fobj->shared_max);
>   		RCU_INIT_POINTER(fobj->shared[fobj->shared_count], fence);
>   		fobj->shared_count++;
>   	}
> @@ -230,10 +231,9 @@ void reservation_object_add_shared_fence(struct reservation_object *obj,
>   	old = reservation_object_get_list(obj);
>   	obj->staged = NULL;
>   
> -	if (!fobj) {
> -		BUG_ON(old->shared_count >= old->shared_max);
> +	if (!fobj)
>   		reservation_object_add_shared_inplace(obj, old, fence);
> -	} else
> +	else
>   		reservation_object_add_shared_replace(obj, old, fobj, fence);
>   }
>   EXPORT_SYMBOL(reservation_object_add_shared_fence);

