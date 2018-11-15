Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B93C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F2A2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F2A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbeKOWGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:06:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15103 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728859AbeKOWGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:06:15 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4C44394AF5CAC;
        Thu, 15 Nov 2018 19:56:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 15 Nov 2018
 19:56:32 +0800
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variable 'ring'
To:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        "Xu, Feifei" <Feifei.Xu@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>
References: <1542279133-103893-1-git-send-email-yuehaibing@huawei.com>
 <BY2PR12MB0040A0E1C221A3EBBF270C30ECDC0@BY2PR12MB0040.namprd12.prod.outlook.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <6e67a5b3-6a0e-6c3a-af90-2125713f522f@huawei.com>
Date:   Thu, 15 Nov 2018 19:56:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <BY2PR12MB0040A0E1C221A3EBBF270C30ECDC0@BY2PR12MB0040.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/15 19:49, Huang, Ray wrote:
>> -----Original Message-----
>> From: YueHaibing [mailto:yuehaibing@huawei.com]
>> Sent: Thursday, November 15, 2018 6:52 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
>> <David1.Zhou@amd.com>; airlied@linux.ie; Liu, Shaoyun
>> <Shaoyun.Liu@amd.com>; Francis, David <David.Francis@amd.com>; Huang,
>> Ray <Ray.Huang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Gao, Likun
>> <Likun.Gao@amd.com>
>> Cc: YueHaibing <yuehaibing@huawei.com>; amd-gfx@lists.freedesktop.org;
>> dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; kernel-
>> janitors@vger.kernel.org
>> Subject: [PATCH -next] drm/amdgpu: remove set but not used variable 'ring'
>>
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/gpu/drm/amd/amdgpu/psp_v10_0.c: In function
>> 'psp_v10_0_ring_stop':
>> drivers/gpu/drm/amd/amdgpu/psp_v10_0.c:230:19: warning:
>>  variable 'ring' set but not used [-Wunused-but-set-variable]
>>
>> It not used since commit
>> 4ef72453311a ("drm/amdgpu: added api for stopping psp ring (v2)")
> 
> Thanks, please also remove the similar code in psp_v3_1. 
> With that updates, patch is Reviewed-by: Huang Rui <ray.huang@amd.com>
> 

Ok, will send v2.

>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/psp_v10_0.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>> index 295c220..d78b430 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>> @@ -240,12 +240,9 @@ static int psp_v10_0_ring_stop(struct psp_context
>> *psp,
>>  			       enum psp_ring_type ring_type)  {
>>  	int ret = 0;
>> -	struct psp_ring *ring;
>>  	unsigned int psp_ring_reg = 0;
>>  	struct amdgpu_device *adev = psp->adev;
>>
>> -	ring = &psp->km_ring;
>> -
>>  	/* Write the ring destroy command to C2PMSG_64 */
>>  	psp_ring_reg = 3 << 16;
>>  	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
>>
>>
>>
>>
> 
> 
> .
> 

