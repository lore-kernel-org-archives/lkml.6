Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vZdSAiFOGlvsdwAAmS7hNA
	; Fri, 08 Jun 2018 09:40:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 33A5E605A5; Fri,  8 Jun 2018 09:40:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 673F660275;
	Fri,  8 Jun 2018 09:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 673F660275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeFHJka (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:40:30 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:33145 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751195AbeFHJk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:40:28 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id RDsbfnzyCtLaARDsffy3Kn; Fri, 08 Jun 2018 11:40:27 +0200
Subject: Re: [PATCH v2 1/2] media: v4l2-ctrl: Add control for VP9 profile
To: Tomasz Figa <tfiga@chromium.org>
Cc: keiichiw@chromium.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?=
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?=
        <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        smitha.t@samsung.com, tom.saeger@oracle.com,
        andriy.shevchenko@linux.intel.com,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, svarbanov@mm-sol.com
References: <20180530071613.125768-1-keiichiw@chromium.org>
 <20180530071613.125768-2-keiichiw@chromium.org>
 <a16dca32-4198-72c1-cf22-83f18a8cfcb6@xs4all.nl>
 <CAAFQd5B8W0KqnPXs3yo8-ndKTE2n5yYmNEjbCWq6yR6iQYjouA@mail.gmail.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <2dabdd75-1351-ae71-7d40-8d836ec05308@xs4all.nl>
Date: Fri, 8 Jun 2018 11:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5B8W0KqnPXs3yo8-ndKTE2n5yYmNEjbCWq6yR6iQYjouA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE1eMTbVjtBCSq83UD7YfFsCnvrahBZivOGBUmlykusKaz3glJU6rsS+1j9fj8F5yqsmXRpyKqCOSgxv2AipMiA0afYG6jidvZRGNUiEC4s5zPkEktT7
 wY9VeN052IoB4vkJ3Tsfq3BVZIFmGiwi/zXR8MYJh4TR5iMYsEGzV5jOgZxMm7NbnN74qt7TAQjlLW9RMPZwQrVNibDZVhYK+1QohmsDgzeKLQJk0TQaJT+R
 shgIbqG1Ny7cbO85jRgpTNTNNFFhGWKjEsCm2UXQHSt9xdFGRIJ12CWh4jjKn7X5/N4u2uycTg5t/Z1WRymsGiSM/ok1mH3KXeRV7a+s9nJ/+hH4YYIT3CrP
 0/5MQ8v9vhSynbnn2oIAPRYyIuX0m/QtrBiI9jneWVcEmw2oNSE04lMMUfaWRJdM9MHxmVpzw++i23US6CKkZkgH6UilwU5wVV7aw2RcCisNZs+TBGMGEoRL
 XBip4LCXIzS2bkvjCEZg4Pg4hwjVsiLURm4moBXny8WrZ/sjw9EydIVW4Zyw85QsZYwyuODmcFYQ6LoGH6EqGJqL9vOxzdJz/sG3e7hqZdScw+0OO0AIqnMG
 o91l73OSdqS49EH5rU4+pMQs5IIrQSdZGXPEVzzCSSS23kNutvZIkVhuY6XqSjT+a8uP2W7aaA34EUyv3d+/1K6tHDGjP4vCWYLyf3ItSqLmPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 11:31 AM, Tomasz Figa wrote:
> Hi Hans,
> 
> On Fri, Jun 8, 2018 at 6:29 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> On 05/30/2018 09:16 AM, Keiichi Watanabe wrote:
>>> Add a new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for selecting desired
>>> profile for VP9 encoder and querying for supported profiles by VP9 encoder
>>> or decoder.
>>>
>>> An existing control V4L2_CID_MPEG_VIDEO_VPX_PROFILE cannot be
>>> used for querying since it is not a menu control but an integer
>>> control, which cannot return an arbitrary set of supported profiles.
>>>
>>> The new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE is a menu control as
>>> with controls for other codec profiles. (e.g. H264)
>>
>> Please ignore my reply to patch 2/2. I looked at this a bit more and what you
>> should do is to change the type of V4L2_CID_MPEG_VIDEO_VPX_PROFILE to enum.
> 
> Note that we still need a way to query VP8 and VP9 separately, since
> the supported profiles will differ. (Most of hardware we have today
> support all 4 profiles of VP8 and only profile 0 of VP9.)

Urgh. So V4L2_CID_MPEG_VIDEO_VPX_PROFILE is really just for VP8?

In that case I would suggest that we rename V4L2_CID_MPEG_VIDEO_VPX_PROFILE to
V4L2_CID_MPEG_VIDEO_VP8_PROFILE and change it to an enum. Also add this line
to v4l2-controls.h:

#define V4L2_CID_MPEG_VIDEO_VPX_PROFILE V4L2_CID_MPEG_VIDEO_VP8_PROFILE

And add a new V4L2_CID_MPEG_VIDEO_VP9_PROFILE (basically this patch).

Would that work?

This standardizes on enums for all profile controls (except s5p-mfc, which
makes its own int control, up to samsung to decide whether or not to change
that), and you have VP8 and VP9 specific profiles.

Regards,

	Hans

> 
> Best regards,
> Tomasz
> 
>>
>> All other codec profile controls are all enums, so the fact that VPX_PROFILE
>> isn't is a bug. Changing the type should not cause any problems since the same
>> control value is used when you set the control.
>>
>> Sylwester: I see that s5p-mfc uses this control, but it is explicitly added
>> as an integer type control, so the s5p-mfc driver should not be affected by
>> changing the type of this control.
>>
>> Stanimir: this will slightly change the venus driver, but since it is a very
>> recent driver I think we can get away with changing the core type of the
>> VPX_PROFILE control. I think that's better than ending up with two controls
>> that do the same thing.
>>
>> Regards,
>>
>>         Hans
>>
>>>
>>> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
>>> ---
>>>  .../media/uapi/v4l/extended-controls.rst      | 26 +++++++++++++++++++
>>>  drivers/media/v4l2-core/v4l2-ctrls.c          | 12 +++++++++
>>>  include/uapi/linux/v4l2-controls.h            |  8 ++++++
>>>  3 files changed, 46 insertions(+)
>>>
>>> diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
>>> index 03931f9b1285..4f7f128a4998 100644
>>> --- a/Documentation/media/uapi/v4l/extended-controls.rst
>>> +++ b/Documentation/media/uapi/v4l/extended-controls.rst
>>> @@ -1959,6 +1959,32 @@ enum v4l2_vp8_golden_frame_sel -
>>>      Select the desired profile for VPx encoder. Acceptable values are 0,
>>>      1, 2 and 3 corresponding to encoder profiles 0, 1, 2 and 3.
>>>
>>> +.. _v4l2-mpeg-video-vp9-profile:
>>> +
>>> +``V4L2_CID_MPEG_VIDEO_VP9_PROFILE``
>>> +    (enum)
>>> +
>>> +enum v4l2_mpeg_video_vp9_profile -
>>> +    This control allows to select the profile for VP9 encoder.
>>> +    This is also used to enumerate supported profiles by VP9 encoder or decoder.
>>> +    Possible values are:
>>> +
>>> +
>>> +
>>> +.. flat-table::
>>> +    :header-rows:  0
>>> +    :stub-columns: 0
>>> +
>>> +    * - ``V4L2_MPEG_VIDEO_VP9_PROFILE_0``
>>> +      - Profile 0
>>> +    * - ``V4L2_MPEG_VIDEO_VP9_PROFILE_1``
>>> +      - Profile 1
>>> +    * - ``V4L2_MPEG_VIDEO_VP9_PROFILE_2``
>>> +      - Profile 2
>>> +    * - ``V4L2_MPEG_VIDEO_VP9_PROFILE_3``
>>> +      - Profile 3
>>> +
>>> +
>>>
>>>  High Efficiency Video Coding (HEVC/H.265) Control Reference
>>>  -----------------------------------------------------------
>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
>>> index d29e45516eb7..401ce21c2e63 100644
>>> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
>>> @@ -431,6 +431,13 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>>>               "Use Previous Specific Frame",
>>>               NULL,
>>>       };
>>> +     static const char * const vp9_profile[] = {
>>> +             "0",
>>> +             "1",
>>> +             "2",
>>> +             "3",
>>> +             NULL,
>>> +     };
>>>
>>>       static const char * const flash_led_mode[] = {
>>>               "Off",
>>> @@ -614,6 +621,8 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>>>               return mpeg4_profile;
>>>       case V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_SEL:
>>>               return vpx_golden_frame_sel;
>>> +     case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
>>> +             return vp9_profile;
>>>       case V4L2_CID_JPEG_CHROMA_SUBSAMPLING:
>>>               return jpeg_chroma_subsampling;
>>>       case V4L2_CID_DV_TX_MODE:
>>> @@ -841,6 +850,8 @@ const char *v4l2_ctrl_get_name(u32 id)
>>>       case V4L2_CID_MPEG_VIDEO_VPX_P_FRAME_QP:                return "VPX P-Frame QP Value";
>>>       case V4L2_CID_MPEG_VIDEO_VPX_PROFILE:                   return "VPX Profile";
>>>
>>> +     case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:                   return "VP9 Profile";
>>> +
>>>       /* HEVC controls */
>>>       case V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP:               return "HEVC I-Frame QP Value";
>>>       case V4L2_CID_MPEG_VIDEO_HEVC_P_FRAME_QP:               return "HEVC P-Frame QP Value";
>>> @@ -1180,6 +1191,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>>>       case V4L2_CID_DEINTERLACING_MODE:
>>>       case V4L2_CID_TUNE_DEEMPHASIS:
>>>       case V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_SEL:
>>> +     case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
>>>       case V4L2_CID_DETECT_MD_MODE:
>>>       case V4L2_CID_MPEG_VIDEO_HEVC_PROFILE:
>>>       case V4L2_CID_MPEG_VIDEO_HEVC_LEVEL:
>>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>>> index 8d473c979b61..56203b7b715c 100644
>>> --- a/include/uapi/linux/v4l2-controls.h
>>> +++ b/include/uapi/linux/v4l2-controls.h
>>> @@ -589,6 +589,14 @@ enum v4l2_vp8_golden_frame_sel {
>>>  #define V4L2_CID_MPEG_VIDEO_VPX_P_FRAME_QP           (V4L2_CID_MPEG_BASE+510)
>>>  #define V4L2_CID_MPEG_VIDEO_VPX_PROFILE                      (V4L2_CID_MPEG_BASE+511)
>>>
>>> +#define V4L2_CID_MPEG_VIDEO_VP9_PROFILE                      (V4L2_CID_MPEG_BASE+512)
>>> +enum v4l2_mpeg_video_vp9_profile {
>>> +     V4L2_MPEG_VIDEO_VP9_PROFILE_0                           = 0,
>>> +     V4L2_MPEG_VIDEO_VP9_PROFILE_1                           = 1,
>>> +     V4L2_MPEG_VIDEO_VP9_PROFILE_2                           = 2,
>>> +     V4L2_MPEG_VIDEO_VP9_PROFILE_3                           = 3,
>>> +};
>>> +
>>>  /* CIDs for HEVC encoding. */
>>>
>>>  #define V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP              (V4L2_CID_MPEG_BASE + 600)
>>> --
>>> 2.17.0.921.gf22659ad46-goog
>>>
>>
