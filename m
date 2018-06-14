Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 87B3FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B51B208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FDoTJWRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B51B208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbeFNINJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:13:09 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45009 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeFNINE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:13:04 -0400
Received: by mail-lf0-f67.google.com with SMTP id 36-v6so7973626lfr.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/8EIB1DfM8qbKFAopfUKPoAJD6k6g24T+qTVRUFpM8c=;
        b=FDoTJWRq7bvg9kgq7LalDm6bLjMEnrZQQzI/R3oEYbNPajUZ7EtghgXimVB365u8ax
         UgbyIlMo5OjzhYOeH3zTy5L/cZa5PhysFaX/0Js+LC5mZsfZqEIm7n1psFi4lhMLLV6E
         od9GNdhOU9CrPOel097RWJKKfx1mVc5dBKoHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/8EIB1DfM8qbKFAopfUKPoAJD6k6g24T+qTVRUFpM8c=;
        b=Jxg81oMRp2xbIkDv9R0S1sWeEhmk6f90wJTcxUf0Vn4fuzpcN6pgJA3q5ocKqW6k5i
         7dwaaDTg3Ns7ntuK4/Tvp4M8N/aDFL3rjPkfMRdGtmtIz57xirF6D3o1irVoy15z1ahN
         SFdMICe8F2WkCUsbbkZnbwtk4O+FVABfHmIDcqwaoo/MH3bzav6s2EHHWpM3bFo1ZsPQ
         WqUSODshjc0ZWOX/wdPUkaRdyA5wgnvL2wd7J47ejQEZ/WcGmpSUJrZ3zswkqTb9hZ+8
         WBpEPe5QeSq75jNPC8JmudyzuZ2YTvc7ZsAtoBuvmyo7R4M0Ne4UHlYXZft6G0bL2KcE
         c/vg==
X-Gm-Message-State: APt69E1ErpHMd8EiiZywbUPeQwXeP5zYKpqx0AOw14tRenuuqTeEUU7e
        eE+uZ++f63RLuCW+VDatSMizgdsL++QBD8q1XjiWkg==
X-Google-Smtp-Source: ADUXVKJX/dMLul3DJIx5l9/KkYHJ5q5YWgdUlK6sn4sa2ddeYGpOXJGSgJuG+cy0JTX1LnbnG+BLXnxsTAwzwLTE4LA=
X-Received: by 2002:a2e:5687:: with SMTP id k7-v6mr1054599lje.140.1528963982818;
 Thu, 14 Jun 2018 01:13:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:5f96:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 01:13:02
 -0700 (PDT)
In-Reply-To: <2c5a4dbf-6640-052b-a873-76b4c50abe73@linaro.org>
References: <20180614074652.162796-1-keiichiw@chromium.org>
 <20180614074652.162796-2-keiichiw@chromium.org> <2c5a4dbf-6640-052b-a873-76b4c50abe73@linaro.org>
From:   Keiichi Watanabe <keiichiw@chromium.org>
Date:   Thu, 14 Jun 2018 17:13:02 +0900
Message-ID: <CAD90VcZP5ZoeTjNX9b3eTaU9DCMAPBfM9FHwEBT4uRqRH722zQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] media: v4l2-ctrl: Change control for VP8 profile
 to menu control
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Stanimir

On Thu, Jun 14, 2018 at 5:04 PM, Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
> Hi Keiichi,
>
> On 06/14/2018 10:46 AM, Keiichi Watanabe wrote:
>> Add a menu control V4L2_CID_MPEG_VIDEO_VP8_PROFILE for VP8 profile and
>> make V4L2_CID_MPEG_VIDEO_VPX_PROFILE an alias of it. This new control
>> is used to select a desired profile for VP8 encoder, and query for
>> supported profiles by VP8 encoder/decoder.
>>
>> Though we have originally a control V4L2_CID_MPEG_VIDEO_VPX_PROFILE and its name
>> contains 'VPX', it works only for VP8 because supported profiles usually differ
>> between VP8 and VP9. In addition, this contorol cannot be used for querying
>> since it is not a menu control but an integer control, which cannot return an
>> arbitrary set of supported profiles.
>>
>> The new control V4L2_CID_MPEG_VIDEO_VP8_PROFILE is a menu control as with
>> controls for other codec profiles. (e.g. H264)
>>
>> In addition, this patch also fixes the use of
>> V4L2_CID_MPEG_VIDEO_VPX_PROFILE in drivers of Qualcomm's venus and
>> Samsung's s5p-mfc.
>>
>> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
>> ---
>>  .../media/uapi/v4l/extended-controls.rst      | 27 ++++++++++++++++---
>>  drivers/media/platform/qcom/venus/core.h      |  2 +-
>>  .../media/platform/qcom/venus/hfi_helper.h    | 12 ++++-----
>>  .../media/platform/qcom/venus/vdec_ctrls.c    | 10 ++++---
>>  drivers/media/platform/qcom/venus/venc.c      | 14 +++++-----
>>  .../media/platform/qcom/venus/venc_ctrls.c    | 12 +++++----
>>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  | 15 +++++------
>>  drivers/media/v4l2-core/v4l2-ctrls.c          | 12 ++++++++-
>>  include/uapi/linux/v4l2-controls.h            | 11 +++++++-
>>  9 files changed, 79 insertions(+), 36 deletions(-)
>>
>> diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
>> index 03931f9b1285..de99eafb0872 100644
>> --- a/Documentation/media/uapi/v4l/extended-controls.rst
>> +++ b/Documentation/media/uapi/v4l/extended-controls.rst
>> @@ -1955,9 +1955,30 @@ enum v4l2_vp8_golden_frame_sel -
>>  ``V4L2_CID_MPEG_VIDEO_VPX_P_FRAME_QP (integer)``
>>      Quantization parameter for a P frame for VP8.
>>
>> -``V4L2_CID_MPEG_VIDEO_VPX_PROFILE (integer)``
>> -    Select the desired profile for VPx encoder. Acceptable values are 0,
>> -    1, 2 and 3 corresponding to encoder profiles 0, 1, 2 and 3.
>> +.. _v4l2-mpeg-video-vp8-profile:
>> +
>> +``V4L2_CID_MPEG_VIDEO_VP8_PROFILE``
>> +    (enum)
>> +
>> +enum v4l2_mpeg_video_vp8_profile -
>> +    This control allows to select the profile for VP8 encoder.
>> +    This is also used to enumerate supported profiles by VP8 encoder or decoder.
>> +    Possible values are:
>> +
>> +
>> +
>> +.. flat-table::
>> +    :header-rows:  0
>> +    :stub-columns: 0
>> +
>> +    * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_0``
>> +      - Profile 0
>> +    * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_1``
>> +      - Profile 1
>> +    * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_2``
>> +      - Profile 2
>> +    * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
>> +      - Profile 3
>>
>>
>>  High Efficiency Video Coding (HEVC/H.265) Control Reference
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 0360d295f4c8..f242e7f9f6a2 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -159,7 +159,7 @@ struct venc_controls {
>>       struct {
>>               u32 mpeg4;
>>               u32 h264;
>> -             u32 vpx;
>> +             u32 vp8;
>>       } profile;
>>       struct {
>>               u32 mpeg4;
>> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
>> index 55d8eb21403a..07bf49dd2ec6 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
>> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
>> @@ -333,12 +333,12 @@
>>  #define HFI_VC1_LEVEL_3                              0x00000040
>>  #define HFI_VC1_LEVEL_4                              0x00000080
>>
>> -#define HFI_VPX_PROFILE_SIMPLE                       0x00000001
>> -#define HFI_VPX_PROFILE_ADVANCED             0x00000002
>> -#define HFI_VPX_PROFILE_VERSION_0            0x00000004
>> -#define HFI_VPX_PROFILE_VERSION_1            0x00000008
>> -#define HFI_VPX_PROFILE_VERSION_2            0x00000010
>> -#define HFI_VPX_PROFILE_VERSION_3            0x00000020
>> +#define HFI_VP8_PROFILE_SIMPLE                       0x00000001
>> +#define HFI_VP8_PROFILE_ADVANCED             0x00000002
>> +#define HFI_VP8_PROFILE_VERSION_0            0x00000004
>> +#define HFI_VP8_PROFILE_VERSION_1            0x00000008
>> +#define HFI_VP8_PROFILE_VERSION_2            0x00000010
>> +#define HFI_VP8_PROFILE_VERSION_3            0x00000020

>
> Please do not rename these driver internal defines, just leave VPX as it
> is now.
>
I got it. I'll fix it in the next revision of the patch.

Best regards,
Keiichi

>
> --
> regards,
> Stan
