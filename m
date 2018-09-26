Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05542C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A3720685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A3720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeIZQGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:06:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726565AbeIZQGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:06:05 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D456C99D3827A;
        Wed, 26 Sep 2018 17:53:53 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 17:53:46 +0800
Subject: Re: [PATCH 0/3] HiBMC driver fixes
To:     Xinliang Liu <xinliang.liu@linaro.org>
References: <1537550727-21257-1-git-send-email-john.garry@huawei.com>
 <CAGd==05wySTNy9rOrv7Hb3V1ihD9wQZjN+v5RrfmG=0DAwsUsA@mail.gmail.com>
 <cb029b9e-3a2c-a26c-56af-038a566715c6@huawei.com>
 <CAGd==04qFCv2eC1=a9yVAzi3Hwj4NiOR+oxu_sUq9dX0EycphQ@mail.gmail.com>
CC:     "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
        XinWei Kong <kong.kongxinwei@hisilicon.com>,
        Feng Chen <puck.chen@hisilicon.com>,
        "David Airlie" <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, <baowenyi@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linuxarm <linuxarm@huawei.com>,
        Rongrong Zou <zourongrong@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <77674be9-734f-12e3-5327-dee89f1f0299@huawei.com>
Date:   Wed, 26 Sep 2018 10:53:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAGd==04qFCv2eC1=a9yVAzi3Hwj4NiOR+oxu_sUq9dX0EycphQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2018 10:41, Xinliang Liu wrote:
> On Wed, 26 Sep 2018 at 16:46, John Garry <john.garry@huawei.com> wrote:
>>
>> On 26/09/2018 04:00, Xinliang Liu wrote:
>>> Thanks John, good addressing!
>>> The root cause as you said, our hibmc previous frame buffer format
>>> depth setting is wrong which does not pass the new format sanity
>>> checking drm_mode_legacy_fb_format.
>>> For this series,  Reviewed-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
>>> Applied to hisilicon-drm-next.
>>
>> I can't see this branch in the git associated with this driver from its
>> MAINTAINERS entry (git://github.com/xin3liang/linux.git), but please
> Not a branch, it is a tag: drm-hisilicon-next-2018-09-26
>
>> ensure these fixes are included in 4.19
>
> As it doesn't affect 4.19-rcx, I send a PULL for 4.20.
> See mail "[GIT PULL] drm-hisilicon-next-2018-09-26"

When Chris' change goes into 4.20 - which I suspect will be before yours 
- boot-time bisect will be broken.

John

>
>>
>> Thanks,
>> John
>>
>>>
>>> Thanks,
>>> Xinliang
>>>
>>> On Sun, 23 Sep 2018 at 20:32, John Garry <john.garry@huawei.com> wrote:
>>>>
>>>> This patchset fixes a couple of issues in probing the HiBMC driver, as
>>>> follows:
>>>> - fix the probe error path to not carry an error code in the pointer
>>>> - don't use invalid legacy fb bpp/depth combination
>>>>
>>>> Another more trivial patch is for using the standard Huawei PCI vendor ID
>>>> instead of hard-coding it.
>>>>
>>>> Tested on Huawei D05 board. I can see tux on BMC VGA console.
>>>>
>>>> John Garry (3):
>>>>   drm/hisilicon: hibmc: Do not carry error code in HiBMC framebuffer
>>>>     pointer
>>>>   drm/hisilicon: hibmc: Don't overwrite fb helper surface depth
>>>>   drm/hisilicon: hibmc: Use HUAWEI PCI vendor ID macro
>>>>
>>>>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 2 +-
>>>>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 2 +-
>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> --
>>>> 1.9.1
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>
>>> .
>>>
>>
>>
>
> .
>


