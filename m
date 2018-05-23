Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbeEWLGw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:06:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:45102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932549AbeEWLGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:06:47 -0400
Subject: Re: [PATCH] drm/xen-front: fix pointer casts
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        boris.ostrovsky@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180521073912.13510-1-andr2000@gmail.com>
 <fc2a9af5-dd46-1ff9-c92f-d7e3b102e43e@suse.com>
 <a33efc9f-1212-3e13-202b-35adc34f17e9@gmail.com>
From: Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <11421e59-3219-b9df-7869-0b249041125b@suse.com>
Date: Wed, 23 May 2018 13:06:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a33efc9f-1212-3e13-202b-35adc34f17e9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/18 12:00, Oleksandr Andrushchenko wrote:
> On 05/23/2018 12:19 PM, Juergen Gross wrote:
>> On 21/05/18 09:39, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> Building for a 32-bit target results in warnings from casting
>>> between a 32-bit pointer and a 64-bit integer. Fix the warnings
>>> by casting those pointers to uintptr_t first.
>>>
>>> Signed-off-by: Oleksandr Andrushchenko
>>> <oleksandr_andrushchenko@epam.com>
>>> ---
>>>   drivers/gpu/drm/xen/xen_drm_front.h       | 4 ++--
>>>   drivers/gpu/drm/xen/xen_drm_front_shbuf.c | 2 +-
>>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xen/xen_drm_front.h
>>> b/drivers/gpu/drm/xen/xen_drm_front.h
>>> index 2c2479b571ae..8e15dbebc4ba 100644
>>> --- a/drivers/gpu/drm/xen/xen_drm_front.h
>>> +++ b/drivers/gpu/drm/xen/xen_drm_front.h
>>> @@ -126,12 +126,12 @@ struct xen_drm_front_drm_info {
>>>     static inline u64 xen_drm_front_fb_to_cookie(struct
>>> drm_framebuffer *fb)
>>>   {
>>> -    return (u64)fb;
>>> +    return (u64)(uintptr_t)fb;
>> Do you really still need the cast to u64?
> Indeed, I can remove (u64) now, thank you
>>
>>>   }
>>>     static inline u64 xen_drm_front_dbuf_to_cookie(struct
>>> drm_gem_object *gem_obj)
>>>   {
>>> -    return (u64)gem_obj;
>>> +    return (u64)(uintptr_t)gem_obj;
>>>   }
>>>     int xen_drm_front_mode_set(struct xen_drm_front_drm_pipeline
>>> *pipeline,
>>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>>> b/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>>> index 8099cb343ae3..47fc93847765 100644
>>> --- a/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>>> +++ b/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>>> @@ -122,7 +122,7 @@ static void guest_calc_num_grefs(struct
>>> xen_drm_front_shbuf *buf)
>>>   }
>>>     #define xen_page_to_vaddr(page) \
>>> -        ((phys_addr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
>>> +        ((phys_addr_t)(uintptr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
>> phys_addr_t for a virtual address?
> This is because the resulting value is then passed to gnttab_set_map_op/
> gnttab_set_unmap_op which expects host address to be passed as
> phys_addr_t addr :(

Okay, but this means the compiler should do the necessary cast when
you drop the cast to phys_addr_t in xen_page_to_vaddr(), as the cast
to uintptr_t is already producing an unsigned integer value which can
easily be promoted to more bits, right?


Juergen
