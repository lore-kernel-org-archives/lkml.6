Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E385C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB1620879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB1620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbeLNBfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:35:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59760 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbeLNBft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:35:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id ACCDD27D9E2
Subject: Re: [PATCH v2] drm/atomic: add ATOMIC_AMEND flag to the Atomic IOCTL.
To:     Tomasz Figa <tfiga@chromium.org>, dnicoara@chromium.org,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
References: <20181123215354.14540-1-helen.koike@collabora.com>
 <CAAFQd5BHPjode=KqEHs=eNqqCe-xvsqx1ko9hQn29djFxuSWUA@mail.gmail.com>
 <20181213090128.GB21184@phenom.ffwll.local>
From:   Helen Koike <helen.koike@collabora.com>
Openpgp: preference=signencrypt
Autocrypt: addr=helen.koike@collabora.com; keydata=
 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
Message-ID: <f337f2d0-70b6-fa72-fc2b-7d33cd536bf5@collabora.com>
Date:   Thu, 13 Dec 2018 23:35:33 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181213090128.GB21184@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 12/13/18 7:01 AM, Daniel Vetter wrote:
> On Thu, Dec 13, 2018 at 04:43:57PM +0900, Tomasz Figa wrote:
>> Hi Helen,
>>
>> On Sat, Nov 24, 2018 at 6:54 AM Helen Koike <helen.koike@collabora.com> wrote:
>>>
>>> This flag tells core to jump ahead the queued update if the conditions
>>> in drm_atomic_async_check() are met. That means we are only able to do an
>>> async update if no modeset is pending and update for the same plane is
>>> not queued.
>>
>> First of all, thanks for the patch. Please see my comments below.
>>
>> If the description above applies (and AFAICT that's what the existing
>> code does indeed), then this doesn't sound like "amend" to me. It
>> sounds exactly as the kernel code calls it - "async update" or perhaps
>> "instantaneous commit" could better describe it?

There is an error in this patch (please, see below).
Async should fail if there is no pending commit, at least is what I
understand from the discussion at
https://patchwork.freedesktop.org/patch/243088/

>>
>>>
>>> It uses the already in place infrastructure for async updates.
>>>
>>> It is useful for cursor updates and async PageFlips over the atomic
>>> ioctl, otherwise in some cases updates may be delayed to the point the
>>> user will notice it. Note that for now it's only enabled for cursor
>>> planes.
>>>
>>> DRM_MODE_ATOMIC_AMEND should be passed to the Atomic IOCTL to use this
>>> feature.
>>>
>>> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> [updated for upstream]
>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>>> ---
>>> Hi,
>>>
>>> This is the second attempt to introduce the new ATOMIC_AMEND flag for atomic
>>> operations, see the commit message for a more detailed description.
>>>
>>> This was tested using a small program that exercises the uAPI for easy
>>> sanity testing. The program was created by Alexandros and modified by
>>> Enric to test the capability flag [2].
>>>
>>> To test, just build the program and use the --atomic flag to use the cursor
>>> plane with the ATOMIC_AMEND flag. E.g.
>>>
>>>   drm_cursor --atomic
>>>
>>> The test worked on a rockchip Ficus v1.1 board on top of mainline plus
>>> the patch to update cursors asynchronously through atomic for the
>>> drm/rockchip driver plus the DRM_CAP_ASYNC_UPDATE patch.
>>>
>>> Alexandros also did a proof-of-concept to use this flag and draw cursors
>>> using atomic if possible on ozone [1].
>>>
>>> Thanks
>>> Helen
>>>
>>> [1] https://chromium-review.googlesource.com/c/chromium/src/+/1092711
>>> [2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/async-capability
>>>
>>>
>>> Changes in v2:
>>> - rebase tree
>>> - do not fall back to a non-async update if if there isn't any
>>> pending commit to amend
>>>
>>> Changes in v1:
>>> - https://patchwork.freedesktop.org/patch/243088/
>>> - Only enable it if userspace requests it.
>>> - Only allow async update for cursor type planes.
>>> - Rename ASYNC_UPDATE for ATOMIC_AMEND.
>>>
>>>  drivers/gpu/drm/drm_atomic_helper.c | 6 +++++-
>>>  drivers/gpu/drm/drm_atomic_uapi.c   | 6 ++++++
>>>  include/uapi/drm/drm_mode.h         | 4 +++-
>>>  3 files changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
>>> index 269f1a74de38..333190c6a0a4 100644
>>> --- a/drivers/gpu/drm/drm_atomic_helper.c
>>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
>>> @@ -934,7 +934,7 @@ int drm_atomic_helper_check(struct drm_device *dev,
>>>         if (ret)
>>>                 return ret;
>>>
>>> -       if (state->legacy_cursor_update)
>>> +       if (state->async_update || state->legacy_cursor_update)
>>>                 state->async_update = !drm_atomic_helper_async_check(dev, state);

I just realized this is wrong, drm_atomic_helper_async_check() should
return error if there is a pending old_plane_state->commit (this v2
patch is not doing this, but v1 was), if drm_atomic_helper_async_check()
returned because of it, then we should return error here to scale this
failure to userspace. Make sense? Tomasz, do you agree?

>>>
>>>         return ret;
>>> @@ -1602,6 +1602,10 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
>>>         if (new_plane_state->fence)
>>>                 return -EINVAL;
>>>
>>> +       /* Only allow async update for cursor type planes. */
>>> +       if (plane->type != DRM_PLANE_TYPE_CURSOR)
>>> +               return -EINVAL;
>>> +
>>
>> So the existing upstream code already allowed this for any planes and
>> we're restricting this to cursor planes only. Is this expected? No
>> potential users that already started using this for other plane types?
> 
> The backend supports it for anything right now (if the driver implements
> it, that is). We do expose it through the legacy cursor api, and the
> legacy page_flip api, but not through atomic itself. It also has the
> problem that the not all drivers who support the async legacy cursor mode
> in atomic use this new infrastructure, so there's a few problems. Plus
> semantics are very ill-defined (we'd definitely need igt testcases for
> this stuff, especially all the new combinations with events, fences, ...).
> 
> I think what we'd need here to make sure we're not digging an uapi hole:
> 
> 1. Entirely remove the legacy_cursor_update hack. There's some patches
> floating around, but would need to be polished.
> 
> 2. Make sure all drivers supporting legacy async cursor updates do through
> the async_plane update infrastructure.
> 
> 3. Get the async plane update stuff merged for amdgpu. Iirc that's still
> stuck somewhere (but I'm not 100% sure what exactly they're doing).
> 
> 4. Pile of igt testcases for all the new corner cases exposing this in
> atomic opens up. Many cases we might want to simply reject it.
> 
> 5. Userspace. Big one I have is whether we need a flag like ALLOW_MODESET,
> since the current code transparently falls back to vblank-synced updates
> if async updates aren't available.
> 
> tldr; lots of work. Also maybe:
> 
> 0. Dump this todo into Documentation/gpu/todo.rst so it won't get lost.
> 
> Cheers, Daniel
> 

Thanks Daniel for pointing those out, I'll start to take a look on them.

> 
>>
>> Best regards,
>> Tomasz
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 


Thanks
Helen
