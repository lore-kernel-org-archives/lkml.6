Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FBEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A716120657
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="fhigaoJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbfAKQIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:08:02 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:41491 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbfAKQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=q1Ni4Y9xes35WERiU2eMbmkZJEsUFDS3fkb7wysMQuk=;
        b=fhigaoJQrmZ0B+5Ba75XFmLasmGhR4sMrSfdp4hi20JmJV22jzErvqJzuSOfWFjoYE5QxN/5lzDcF5B0HS3lE5FrsVBgL/dvooyQW0D4gKCoKqN4MlbMfEGekM6H0nJUOj8TZWo04LUVqHmdSgXJFeXM6xdYGsBomLFYhbMWbYXq5YgI7tr7ypY53HZfG5y5LkU4mQVOzoV9NGA3FOjEIMY/b0SDRDrejYmi8yH9iF2hbczHDSmblFwOpZx/uxhFz0B9ogDRp1IyiTJvUTlUDAfbyhSNKmf2VhivdMlNfwEIfxs+e2KPeVBU1XdU7fZHVItCXxh7IvkRa3J8IeG6QA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:50224 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1ghzLh-0006o4-1Q; Fri, 11 Jan 2019 17:07:57 +0100
Subject: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
To:     CK Hu <ck.hu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        David Airlie <airlied@linux.ie>,
        Alexander Ryabchenko <d3adme4t@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190102084917.4049-1-frank-w@public-files.de>
 <20190107103640.GH21184@phenom.ffwll.local>
 <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
 <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
 <20190110200225.GN21184@phenom.ffwll.local>
 <1547176809.12054.11.camel@mtksdaap41>
 <20190111092042.GP21184@phenom.ffwll.local>
 <1547200155.4209.4.camel@mtksdaap41>
 <20190111102503.GU21184@phenom.ffwll.local>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <afe6ba3f-77ee-1b7c-072e-64ccb161119e@tronnes.org>
Date:   Fri, 11 Jan 2019 17:07:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111102503.GU21184@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 11.01.2019 11.25, skrev Daniel Vetter:
> On Fri, Jan 11, 2019 at 05:49:15PM +0800, CK Hu wrote:
>> Hi, Daniel:
>>
>> On Fri, 2019-01-11 at 10:20 +0100, Daniel Vetter wrote:
>>> On Fri, Jan 11, 2019 at 11:20:09AM +0800, CK Hu wrote:
>>>> Hi, Daniel:
>>>>
>>>> On Thu, 2019-01-10 at 21:02 +0100, Daniel Vetter wrote:
>>>>> On Thu, Jan 10, 2019 at 08:01:37PM +0100, Frank Wunderlich wrote:
>>>>>> Hi Daniel,
>>>>>>
>>>>>>>> Would be good to use the new generic fbdev emulation code here, for even
>>>>>>>> less code. Or at least know why this isn't possible to use for mtk (and
>>>>>>>> maybe address that in the core code). Hand-rolling fbdev code shouldn't be
>>>>>>>> needed anymore.
>>>>>>>
>>>>>>> Back on the mailing list, no private replies please:
>>>>>>
>>>>>> i don't wanted to spam all people with dumb questions ;)
>>>>>
>>>>> There's no dumb questions, only insufficient documentation :-)
>>>>>
>>>>>>> For examples please grep for drm_fbdev_generic_setup(). There's also a
>>>>>>> still in-flight series from Gerd Hoffmann to convert over bochs. That,
>>>>>>> plus all the kerneldoc linked from there should get you started.
>>>>>>> -Daniel
>>>>>>
>>>>>> this is one of google best founds if i search for drm_fbdev_generic_setup:
>>>>>>
>>>>>> https://lkml.org/lkml/2018/12/19/305
>>>>>>
>>>>>> not very helpful...
>>>>>>
>>>>>> so i tried kernel-doc
>>>>>>
>>>>>> https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html?highlight=drm_fbdev_generic_setup#c.drm_fbdev_generic_setup
>>>>>>
>>>>>> which is nice function-reference but i've found no generic workflow
>>>>>>
>>>>>> as the posted driver is "only" a driver ported from kernel 4.4 by Alexander, i don't know if this new framework can be used and which parts need to be changed. I only try to bring his code Mainline....
>>>>>> Maybe CK Hu can help here because driver is originally from him and he knows internals. Or maybe you can help here?
>>>>>>
>>>>>> i personally make my first steps as spare-time kernel-developer :)
>>>>>
>>>>> There's a ton of in-kernel users of that function already, I meant you can
>>>>> use those to serve as examples ... If those + the kerneldoc aren't
>>>>> good enough, then we need to improve them.
>>>>> -Daniel
>>>>
>>>> I've tried with drm_fbdev_generic_setup() and it works fine with simple
>>>> modification. The patch is
>>>>
>>>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>>> @@ -16,6 +16,7 @@
>>>>  #include <drm/drm_atomic.h>
>>>>  #include <drm/drm_atomic_helper.h>
>>>>  #include <drm/drm_crtc_helper.h>
>>>> +#include <drm/drm_fb_helper.h>
>>>>  #include <drm/drm_gem.h>
>>>>  #include <drm/drm_gem_cma_helper.h>
>>>>  #include <drm/drm_of.h>
>>>> @@ -379,6 +380,7 @@ static void mtk_drm_kms_deinit(struct drm_device
>>>> *drm)
>>>>         .gem_prime_get_sg_table = mtk_gem_prime_get_sg_table,
>>>>         .gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
>>>>         .gem_prime_mmap = mtk_drm_gem_mmap_buf,
>>>> +       .gem_prime_vmap = mtk_drm_gem_prime_vmap,
>>>>         .ioctls = mtk_ioctls,
>>>>         .num_ioctls = ARRAY_SIZE(mtk_ioctls),
>>>>         .fops = &mtk_drm_fops,
>>>> @@ -416,6 +418,8 @@ static int mtk_drm_bind(struct device *dev)
>>>>         if (ret < 0)
>>>>                 goto err_deinit;
>>>>
>>>> +       drm_fbdev_generic_setup(drm, 32);
>>>> +
>>>>         return 0;
>>>>
>>>>
>>>> But I implement .gem_prime_vmap with a workaround,
>>>>
>>>>
>>>> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
>>>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
>>>> @@ -280,3 +280,8 @@ int mtk_gem_create_ioctl(struct drm_device *dev,
>>>> void *data,
>>>>         mtk_drm_gem_free_object(&mtk_gem->base);
>>>>         return ret;
>>>>  }
>>>> +
>>>> +void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
>>>> +{
>>>> +       return (void *)1;
>>>> +}
>>>>
>>>> Current drm_fb_helper depends on drm_client to create fbdev. When
>>>> drm_client create drm_client_buffer, it need to vmap to get kernel
>>>> vaddr. But I think for fbdev, the vaddr is useless. Do you agree that I
>>>> temporarily implement .gem_prime_vmap in such way?
>>>
>>> The vmap is used by fbcon, without that fbdev won't really work I think.
>>> So I'm rather confused on what you tested ...
>>>
>>> Adding Noralf, he's the expert here.
>>> -Daniel
>>
>> I test with fb_test [1], it is a user space program just open /dev/fb0
>> and mmap it to user space. I does not turn on fbcon so everything looks
>> well. If support fbcon is essential, I would implement vmap correctly.
>> If it's not essential, I think I could return 0 when
>> CONFIG_FRAMBUFFER_CONSOLE is defined.
> 
> I think fbdev emulation without working fbcon is fairly useless. And it
> shouldn't be that much work to make it work, we have quite a few more
> helers for gem bo nowadays.

If the virtual address is not set, fbcon can't be used and that means it
has to be disabled using something like this in the driver Kconfig:
	depends on !FRAMEBUFFER_CONSOLE

Otherwise it will crash if someone tries to use it.

The problem here is that this driver doesn't map a virtual address for
its buffers:
	mtk_gem->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;

Probably because of limited virtual address space.
rockchip is in the same situation.

I'm aware of this shortcoming of the generic emulation, but I don't see
how it can be solved without using somekind of flag attached to the dumb
buffer creation request.

Noralf.
