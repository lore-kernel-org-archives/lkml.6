Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425610AbeBOQJR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:09:17 -0500
Received: from gateway36.websitewelcome.com ([192.185.179.26]:36436 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1425600AbeBOQJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:09:14 -0500
Subject: Re: [PATCH] drm/i915/selftests: fix inconsistent IS_ERR and PTR_ERR
To: Jani Nikula <jani.nikula@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180214211234.GA22341@embeddedgus> <87vaey4nv8.fsf@intel.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <627959e2-ab9a-49bc-27ea-0a69a17c68a6@embeddedor.com>
Date: Thu, 15 Feb 2018 10:09:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87vaey4nv8.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1emM5x-003rHu-4i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.4.238]:45670
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/15/2018 03:13 AM, Jani Nikula wrote:
> On Wed, 14 Feb 2018, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>> Fix inconsistent IS_ERR and PTR_ERR in shrink_boom.
>> The proper pointer to use is _explode_ instead of _purge_.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Fixes: fe215c8bc426 ("drm/i915/selftests: add missing gtt shrinker test")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> 
> (Having some issues with fdo connections, thus not pushing.)
>

Thanks, Jani
--
Gustavo

>> ---
>>   drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
>> index d806427..89b6ca9 100644
>> --- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
>> +++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
>> @@ -927,7 +927,7 @@ static int shrink_boom(struct drm_i915_private *i915,
>>   
>>   		explode = fake_dma_object(i915, size);
>>   		if (IS_ERR(explode)) {
>> -			err = PTR_ERR(purge);
>> +			err = PTR_ERR(explode);
>>   			goto err_purge;
>>   		}
> 
