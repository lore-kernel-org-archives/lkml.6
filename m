Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDEPQX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:16:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42373 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751179AbeDEPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:16:22 -0400
From: Philippe CORNU <philippe.cornu@st.com>
To: Daniel Vetter <daniel@ffwll.ch>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>
Subject: Re: [PATCH] drm: clarify adjusted_mode for a bridge connected to a
 crtc
Thread-Topic: [PATCH] drm: clarify adjusted_mode for a bridge connected to a
 crtc
Thread-Index: AQHTxeNrXc81Ni58ZkqJDtQmzYCJWqPms5kAgAABN4CAC3/hAA==
Date: Thu, 5 Apr 2018 15:15:58 +0000
Message-ID: <aaf61d18-f68f-9188-f5ef-9a32b41d7560@st.com>
References: <20180226121605.12050-1-philippe.cornu@st.com>
 <20180327155102.GW14155@phenom.ffwll.local>
 <ffc34eb4-c5bd-8e53-0dc5-3a3c7a2e111f@st.com>
 <CAKMK7uHkaKBFXLEdycR-Be_WSVvrTfeO1PTE5i1zVLuKFtrbWA@mail.gmail.com>
In-Reply-To: <CAKMK7uHkaKBFXLEdycR-Be_WSVvrTfeO1PTE5i1zVLuKFtrbWA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9026A6AA473AB743AF3936BE5DBCB3EA@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w35FGT7j030789

On 03/29/2018 09:39 AM, Daniel Vetter wrote:
> On Thu, Mar 29, 2018 at 9:35 AM, Philippe CORNU <philippe.cornu@st.com> wrote:
>> Hi Daniel,
>>
>> On 03/27/2018 05:51 PM, Daniel Vetter wrote:
>>> On Mon, Feb 26, 2018 at 01:16:04PM +0100, Philippe Cornu wrote:
>>>> This patch clarifies the adjusted_mode documentation
>>>> for a bridge directly connected to a crtc.
>>>>
>>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>>>> ---
>>>> This patch is linked to the discussion https://lkml.org/lkml/2018/1/25/367
>>>
>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> Many thanks for the review.
>>
>>>
>>> Aside, and kinda why I noticed this patch to begin with: You have drm-misc
>>> commit rights, but you seem to not use that. And with 18 patches in the
>>> 4.17 cycle you're the top contributor who's not pushing his own patches.
>>>
>>> What's the hold-up? Tools don't work, or something else? I really think
>>> regular contributors should just push their own stuff themselves (after
>>> appropriate review ofc).
>>> -Daniel
>>>
>>
>> I still consider myself a drm “beginner”, my first patch in drm was last
>> summer so less than 1 year ago.
> 
> You're doing great patches, and at least for drm-misc you're the top
> contributor who doesn't push stuff himself. You're definitely ready to
> do so!
> 
>> However, thank you for your encouraging return, I will immediately study
>> the matter (dim...) and prepare myself.
> 
> Yes please. And for any questions please ask on #dri-devel on
> freenode, we're all happy to help out.
> -Daniel

Hi Daniel & Benjamin,

I managed to push a first patch on drm-misc-next :-)

No particular difficulties with dim installation, main encountered 
issues are "corporate proxies" & ubuntu package updates...

So this email is mostly to thank you Benjamin for your good advice and 
support when using dim.

Big thanks,
Philippe :-)

> 
>>
>> Thank you,
>> Philippe :-)
>>
>>>>
>>>>    include/drm/drm_bridge.h | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>>>> index 3270fec46979..b5f3c070467c 100644
>>>> --- a/include/drm/drm_bridge.h
>>>> +++ b/include/drm/drm_bridge.h
>>>> @@ -177,7 +177,8 @@ struct drm_bridge_funcs {
>>>>        * pipeline has been called already. If the bridge is the first element
>>>>        * then this would be &drm_encoder_helper_funcs.mode_set. The display
>>>>        * pipe (i.e.  clocks and timing signals) is off when this function is
>>>> -     * called.
>>>> +     * called. If the bridge is connected to the crtc, the adjusted_mode
>>>> +     * parameter is the one defined in &drm_crtc_state.adjusted_mode.
>>>>        */
>>>>       void (*mode_set)(struct drm_bridge *bridge,
>>>>                        struct drm_display_mode *mode,
>>>> --
>>>> 2.15.1
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
