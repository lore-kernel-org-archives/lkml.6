Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E9C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2728E208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2728E208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934467AbeGDJKL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:10:11 -0400
Received: from mail.netline.ch ([148.251.143.178]:33389 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbeGDJKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:10:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id F174B2A6048;
        Wed,  4 Jul 2018 11:10:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id fLMQzUWg-bRm; Wed,  4 Jul 2018 11:10:00 +0200 (CEST)
Received: from thor (252.228.127.176.dynamic.wline.res.cust.swisscom.ch [176.127.228.252])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 63DE12A6045;
        Wed,  4 Jul 2018 11:09:59 +0200 (CEST)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1fadnS-00052W-T3; Wed, 04 Jul 2018 11:09:58 +0200
Subject: Re: [PATCH] dma-buf: Move BUG_ON from _add_shared_fence to
 _add_shared_inplace
To:     christian.koenig@amd.com, Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-media@vger.kernel.org
References: <20180626143147.14296-1-michel@daenzer.net>
 <249b84ea-affe-2e27-abdd-81d61da9cce6@gmail.com>
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
Message-ID: <f6100513-d31b-b7a2-cc9f-104a60127277@daenzer.net>
Date:   Wed, 4 Jul 2018 11:09:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <249b84ea-affe-2e27-abdd-81d61da9cce6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-04 10:31 AM, Christian König wrote:
> Am 26.06.2018 um 16:31 schrieb Michel Dänzer:
>> From: Michel Dänzer <michel.daenzer@amd.com>
>>
>> Fixes the BUG_ON spuriously triggering under the following
>> circumstances:
>>
>> * ttm_eu_reserve_buffers processes a list containing multiple BOs using
>>    the same reservation object, so it calls
>>    reservation_object_reserve_shared with that reservation object once
>>    for each such BO.
>> * In reservation_object_reserve_shared, old->shared_count ==
>>    old->shared_max - 1, so obj->staged is freed in preparation of an
>>    in-place update.
>> * ttm_eu_fence_buffer_objects calls reservation_object_add_shared_fence
>>    once for each of the BOs above, always with the same fence.
>> * The first call adds the fence in the remaining free slot, after which
>>    old->shared_count == old->shared_max.
> 
> Well, the explanation here is not correct. For multiple BOs using the
> same reservation object we won't call
> reservation_object_add_shared_fence() multiple times because we move
> those to the duplicates list in ttm_eu_reserve_buffers().
> 
> But this bug can still happen because we call
> reservation_object_add_shared_fence() manually with fences for the same
> context in a couple of places.
> 
> One prominent case which comes to my mind are for the VM BOs during
> updates. Another possibility are VRAM BOs which need to be cleared.

Thanks. How about the following:

* ttm_eu_reserve_buffers calls reservation_object_reserve_shared.
* In reservation_object_reserve_shared, shared_count == shared_max - 1,
  so obj->staged is freed in preparation of an in-place update.
* ttm_eu_fence_buffer_objects calls reservation_object_add_shared_fence,
  after which shared_count == shared_max.
* The amdgpu driver also calls reservation_object_add_shared_fence for
  the same reservation object, and the BUG_ON triggers.

However, nothing bad would happen in
reservation_object_add_shared_inplace, since all fences use the same
context, so they can only occupy a single slot.

Prevent this by moving the BUG_ON to where an overflow would actually
happen (e.g. if a buggy caller didn't call
reservation_object_reserve_shared before).


Also, I'll add a reference to https://bugs.freedesktop.org/106418 in v2,
as I suspect this fix is necessary under the circumstances described
there as well.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
