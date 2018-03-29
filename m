Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbeC2Hg3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:36:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33991 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750708AbeC2Hg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:36:27 -0400
From: Philippe CORNU <philippe.cornu@st.com>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
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
Thread-Index: AQHTxeNrXc81Ni58ZkqJDtQmzYCJWqPms5kA
Date: Thu, 29 Mar 2018 07:35:11 +0000
Message-ID: <ffc34eb4-c5bd-8e53-0dc5-3a3c7a2e111f@st.com>
References: <20180226121605.12050-1-philippe.cornu@st.com>
 <20180327155102.GW14155@phenom.ffwll.local>
In-Reply-To: <20180327155102.GW14155@phenom.ffwll.local>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <780965730DA77D4EB87DF9A8B3D46893@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-29_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2T7aWgY023012

Hi Daniel,

On 03/27/2018 05:51 PM, Daniel Vetter wrote:
> On Mon, Feb 26, 2018 at 01:16:04PM +0100, Philippe Cornu wrote:
>> This patch clarifies the adjusted_mode documentation
>> for a bridge directly connected to a crtc.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>> This patch is linked to the discussion https://lkml.org/lkml/2018/1/25/367
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Many thanks for the review.

> 
> Aside, and kinda why I noticed this patch to begin with: You have drm-misc
> commit rights, but you seem to not use that. And with 18 patches in the
> 4.17 cycle you're the top contributor who's not pushing his own patches.
> 
> What's the hold-up? Tools don't work, or something else? I really think
> regular contributors should just push their own stuff themselves (after
> appropriate review ofc).
> -Daniel
> 

I still consider myself a drm “beginner”, my first patch in drm was last 
summer so less than 1 year ago.
However, thank you for your encouraging return, I will immediately study 
the matter (dim...) and prepare myself.

Thank you,
Philippe :-)

>>
>>   include/drm/drm_bridge.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index 3270fec46979..b5f3c070467c 100644
>> --- a/include/drm/drm_bridge.h
>> +++ b/include/drm/drm_bridge.h
>> @@ -177,7 +177,8 @@ struct drm_bridge_funcs {
>>   	 * pipeline has been called already. If the bridge is the first element
>>   	 * then this would be &drm_encoder_helper_funcs.mode_set. The display
>>   	 * pipe (i.e.  clocks and timing signals) is off when this function is
>> -	 * called.
>> +	 * called. If the bridge is connected to the crtc, the adjusted_mode
>> +	 * parameter is the one defined in &drm_crtc_state.adjusted_mode.
>>   	 */
>>   	void (*mode_set)(struct drm_bridge *bridge,
>>   			 struct drm_display_mode *mode,
>> -- 
>> 2.15.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
