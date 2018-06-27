Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2886C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C3525BC1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C3525BC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934946AbeF0QEL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:04:11 -0400
Received: from mail.netline.ch ([148.251.143.178]:57198 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934246AbeF0QEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:04:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 0D72C2A6050;
        Wed, 27 Jun 2018 18:04:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id c4oEIfSx2jT7; Wed, 27 Jun 2018 18:04:07 +0200 (CEST)
Received: from thor (252.228.127.176.dynamic.wline.res.cust.swisscom.ch [176.127.228.252])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id D58B32A6045;
        Wed, 27 Jun 2018 18:04:06 +0200 (CEST)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1fYCvN-0007MK-VA; Wed, 27 Jun 2018 18:04:05 +0200
Subject: Re: [PATCH] dma-buf: Move BUG_ON from _add_shared_fence to
 _add_shared_inplace
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org
References: <20180626143147.14296-1-michel@daenzer.net>
 <153010024207.8693.14587899562244751472@mail.alporthouse.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Openpgp: preference=signencrypt
Autocrypt: addr=michel@daenzer.net; prefer-encrypt=mutual; keydata=
 xsDiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPM0jTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD7CXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkLOwE0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpcJGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAn2Ufk2d6/3p4
 Cuyz/NX7KpL2dQ8WAJ9UD5JEakhfofed8PSqOM7jOO3LCA==
Message-ID: <d38ba7df-d3b4-2c90-3482-21f40ea18a00@daenzer.net>
Date:   Wed, 27 Jun 2018 18:04:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <153010024207.8693.14587899562244751472@mail.alporthouse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-27 01:50 PM, Chris Wilson wrote:
> Quoting Michel Dänzer (2018-06-26 15:31:47)
>> From: Michel Dänzer <michel.daenzer@amd.com>
>>
>> Fixes the BUG_ON spuriously triggering under the following
>> circumstances:
>>
>> * ttm_eu_reserve_buffers processes a list containing multiple BOs using
>>   the same reservation object, so it calls
>>   reservation_object_reserve_shared with that reservation object once
>>   for each such BO.
>> * In reservation_object_reserve_shared, old->shared_count ==
>>   old->shared_max - 1, so obj->staged is freed in preparation of an
>>   in-place update.
>> * ttm_eu_fence_buffer_objects calls reservation_object_add_shared_fence
>>   once for each of the BOs above, always with the same fence.
>> * The first call adds the fence in the remaining free slot, after which
>>   old->shared_count == old->shared_max.
>>
>> In the next call to reservation_object_add_shared_fence, the BUG_ON
>> triggers. However, nothing bad would happen in
>> reservation_object_add_shared_inplace, since the fence is already in the
>> reservation object.
>>
>> Prevent this by moving the BUG_ON to where an overflow would actually
>> happen (e.g. if a buggy caller didn't call
>> reservation_object_reserve_shared before).
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
> 
> I've convinced myself (or rather have not found a valid argument
> against) that being able to call reserve_shared + add_shared multiple
> times for the same fence is an intended part of reservation_object API 
> 
> I'd double check with Christian though.

Right, I'm interested in Christian's feedback.


> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Thanks!


>>  drivers/dma-buf/reservation.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
>> index 314eb1071cce..532545b9488e 100644
>> --- a/drivers/dma-buf/reservation.c
>> +++ b/drivers/dma-buf/reservation.c
>> @@ -141,6 +141,7 @@ reservation_object_add_shared_inplace(struct reservation_object *obj,
>>         if (signaled) {
>>                 RCU_INIT_POINTER(fobj->shared[signaled_idx], fence);
>>         } else {
>> +               BUG_ON(fobj->shared_count >= fobj->shared_max);
> 
> Personally I would just let kasan detect this and throw away the BUG_ON
> or at least move it behind some DMABUF_BUG_ON().

Hmm. Normally, I'm not a fan of BUG(_ON) either. But in this case, it's
clear that the caller is buggy, and proceeding to write beyond the end
of the array could have far-reaching consequences. I'm leaving that to
somebody else.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
