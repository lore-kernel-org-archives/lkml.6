Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeC2Hj2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:39:28 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33690 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeC2Hj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:39:27 -0400
X-Google-Smtp-Source: AG47ELtlvdOHi9jyDxBI5Sbc/pw2VWtHN3V75CBi9/uVaHcRVKjCYkmBKi/6ZtVS5iNLCM0NHtv/ZraXPjmDiz8GeX8=
MIME-Version: 1.0
X-Originating-IP: [212.51.149.109]
In-Reply-To: <ffc34eb4-c5bd-8e53-0dc5-3a3c7a2e111f@st.com>
References: <20180226121605.12050-1-philippe.cornu@st.com> <20180327155102.GW14155@phenom.ffwll.local>
 <ffc34eb4-c5bd-8e53-0dc5-3a3c7a2e111f@st.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 29 Mar 2018 09:39:25 +0200
X-Google-Sender-Auth: _6AUDQvlToliohEyH_uQIreYGb4
Message-ID: <CAKMK7uHkaKBFXLEdycR-Be_WSVvrTfeO1PTE5i1zVLuKFtrbWA@mail.gmail.com>
Subject: Re: [PATCH] drm: clarify adjusted_mode for a bridge connected to a crtc
To: Philippe CORNU <philippe.cornu@st.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2T7dYuG023016

On Thu, Mar 29, 2018 at 9:35 AM, Philippe CORNU <philippe.cornu@st.com> wrote:
> Hi Daniel,
>
> On 03/27/2018 05:51 PM, Daniel Vetter wrote:
>> On Mon, Feb 26, 2018 at 01:16:04PM +0100, Philippe Cornu wrote:
>>> This patch clarifies the adjusted_mode documentation
>>> for a bridge directly connected to a crtc.
>>>
>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>>> ---
>>> This patch is linked to the discussion https://lkml.org/lkml/2018/1/25/367
>>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Many thanks for the review.
>
>>
>> Aside, and kinda why I noticed this patch to begin with: You have drm-misc
>> commit rights, but you seem to not use that. And with 18 patches in the
>> 4.17 cycle you're the top contributor who's not pushing his own patches.
>>
>> What's the hold-up? Tools don't work, or something else? I really think
>> regular contributors should just push their own stuff themselves (after
>> appropriate review ofc).
>> -Daniel
>>
>
> I still consider myself a drm “beginner”, my first patch in drm was last
> summer so less than 1 year ago.

You're doing great patches, and at least for drm-misc you're the top
contributor who doesn't push stuff himself. You're definitely ready to
do so!

> However, thank you for your encouraging return, I will immediately study
> the matter (dim...) and prepare myself.

Yes please. And for any questions please ask on #dri-devel on
freenode, we're all happy to help out.
-Daniel

>
> Thank you,
> Philippe :-)
>
>>>
>>>   include/drm/drm_bridge.h | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>>> index 3270fec46979..b5f3c070467c 100644
>>> --- a/include/drm/drm_bridge.h
>>> +++ b/include/drm/drm_bridge.h
>>> @@ -177,7 +177,8 @@ struct drm_bridge_funcs {
>>>       * pipeline has been called already. If the bridge is the first element
>>>       * then this would be &drm_encoder_helper_funcs.mode_set. The display
>>>       * pipe (i.e.  clocks and timing signals) is off when this function is
>>> -     * called.
>>> +     * called. If the bridge is connected to the crtc, the adjusted_mode
>>> +     * parameter is the one defined in &drm_crtc_state.adjusted_mode.
>>>       */
>>>      void (*mode_set)(struct drm_bridge *bridge,
>>>                       struct drm_display_mode *mode,
>>> --
>>> 2.15.1
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
