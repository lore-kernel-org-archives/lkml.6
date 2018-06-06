Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63CA560764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeFFPDZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:03:25 -0400
Received: from mail.netline.ch ([148.251.143.178]:47188 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbeFFPDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:03:21 -0400
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Gabriel C <nix.or.die@gmail.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
 <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com>
 <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net>
Date: Wed, 6 Jun 2018 17:03:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-06 04:44 PM, Christian König wrote:
> Am 06.06.2018 um 16:12 schrieb Michel Dänzer:
>> On 2018-06-06 03:33 PM, Gabriel C wrote:
>>> 2018-06-06 14:19 GMT+02:00 Christian König <christian.koenig@amd.com>:
>>>> Am 06.06.2018 um 14:08 schrieb Gabriel C:
>>>>> 2018-06-06 13:33 GMT+02:00 Christian König <christian.koenig@amd.com>:
>>>>>> Am 06.06.2018 um 13:28 schrieb Gabriel C:
>>
>>>>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-sr-iov-off.txt
>>>>>
>>>>>
>>>>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-sr-iov-on.txt
>>>>>
>>>>>
>>>>> Also nothing else changed in that setup just testing kernel 4.17.
>>>>
>>>>
>>>> That has nothing TODO with the driver nor the original bug you
>>>> reported. The
>>>> problem is that SME is active and that is currently not supported at
>>>> all
>>>> with a that hardware.
>>>
>>> Ok .. so are we playing now kernel an AMD Hardware roulette on each
>>> release ?
>>>
>>> SME was like this in kernel 4.16.x here and all worked.
>>
>> If that is true, again please bisect which commit broke it.
>>
>> All the reports I've seen before this indicated that at least amdgpu
>> has never worked with SME (which BTW doesn't mean it's never going to
>> work or that we don't want to support it, just that as far as we know
>> it's currently not working).
> 
> At least in theory it should work when we use the coherent DMA allocator.
> 
> When that really worked before, so the most likely commit which broke
> this is:
> 
> commit fd5fd480dd8fe4910546e7b080b3ae345e57fe9f
> Author: Chunming Zhou <david1.zhou@amd.com>
> Date:   Fri Feb 9 10:44:09 2018 +0800
> 
>     drm/amdgpu: only enable swiotlb alloc when need v2
> 
>     get the max io mapping address of system memory to see if it is over
>     our card accessing range.
>     v2: move checking later
> 
>     Signed-off-by: Chunming Zhou <david1.zhou@amd.com>
>     Reviewed-by: Monk Liu <monk.liu@amd.com>
>     Reviewed-by: Christian König <christian.koenig@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Currently looking into how we could somehow improve this detection.

I guess this could fit for Gabriel, but e.g.
https://bugs.freedesktop.org/104437 says amdgpu was already broken with
SME in 4.15, if not 4.14 (I suspect there was simply no SME support
earlier).


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
