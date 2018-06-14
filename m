Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5A27FC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07951208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WD8ImATV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07951208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeFNIE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:04:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41651 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754665AbeFNIEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:04:16 -0400
Received: by mail-wr0-f193.google.com with SMTP id h10-v6so5316422wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EG1aSOWigRlJF2UsrCRA1AixdqnsSCFY5MaCbDd7vhs=;
        b=WD8ImATV4I76FQt8YXmpNOIDQP3FhgzwlIv+IYbUg9S6m+xiOo6TpcpAPaoWSPW8Eq
         BvtMeRcsVcOFsiGj4x6OEt2q6rDlqmwoLvrOndNhrcRGgyrFwS4tvdTANKIdrA7ijyH7
         Iomok4XE2PO3zgU8XicW19xQgr/DFgKAJPaew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EG1aSOWigRlJF2UsrCRA1AixdqnsSCFY5MaCbDd7vhs=;
        b=K0MRMkZFCvmBciUIITDn9gRthkt1ZdD7kPVdAZd9/dRYLTX4DnP9KvueB+ozdBFQ/J
         m3wuCkEevQDfSYR7qt6o2TjLXSAfGAk12EKR3rs+YRe5YvHC/yxxOE0oUPdauA18Anhx
         GazPi0eh/v5XYfsiuEmfwpftUt0mANRKgQ+gubQ1XhsmUPbIb9+sFOBBFp8W51pnyOrF
         Bj+HArRX1Oh+fb7zVXj5UiqonZ+hKfSo25HMuIj996WkiMe8VjcgO7VqT32vfu3/Eh98
         fx+X2Gyol6d5LKq+RVlhfUXNzSdrZ/tOsUdDcs+krSi5ebDJpW2BcuqwQHgj8VLdUrn4
         QJTw==
X-Gm-Message-State: APt69E3V7LATC1h98hkCnlJJTvdGCY5wT4VodrjA4r0swpmpbwYLkROI
        UDiQCiPacsKADJa/1Vz148ZtbA==
X-Google-Smtp-Source: ADUXVKK2NfrW6ZdT2oKhJGrob9Jnq6CHpzJckt/J1FK0fq/Lsr2lhDSXWZaHEXa799xr1d3KDAdYTw==
X-Received: by 2002:adf:fa07:: with SMTP id m7-v6mr1290453wrr.228.1528963454720;
        Thu, 14 Jun 2018 01:04:14 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id l84-v6sm7359893wmi.3.2018.06.14.01.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 01:04:14 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] media: v4l2-ctrl: Change control for VP8 profile
 to menu control
To:     Keiichi Watanabe <keiichiw@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
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
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        s.nawrocki@samsung.com
References: <20180614074652.162796-1-keiichiw@chromium.org>
 <20180614074652.162796-2-keiichiw@chromium.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <2c5a4dbf-6640-052b-a873-76b4c50abe73@linaro.org>
Date:   Thu, 14 Jun 2018 11:04:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180614074652.162796-2-keiichiw@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keiichi,

On 06/14/2018 10:46 AM, Keiichi Watanabe wrote:
> Add a menu control V4L2_CID_MPEG_VIDEO_VP8_PROFILE for VP8 profile and
> make V4L2_CID_MPEG_VIDEO_VPX_PROFILE an alias of it. This new control
> is used to select a desired profile for VP8 encoder, and query for
> supported profiles by VP8 encoder/decoder.
> 
> Though we have originally a control V4L2_CID_MPEG_VIDEO_VPX_PROFILE and its name
> contains 'VPX', it works only for VP8 because supported profiles usually differ
> between VP8 and VP9. In addition, this contorol cannot be used for querying
> since it is not a menu control but an integer control, which cannot return an
> arbitrary set of supported profiles.
> 
> The new control V4L2_CID_MPEG_VIDEO_VP8_PROFILE is a menu control as with
> controls for other codec profiles. (e.g. H264)
> 
> In addition, this patch also fixes the use of
> V4L2_CID_MPEG_VIDEO_VPX_PROFILE in drivers of Qualcomm's venus and
> Samsung's s5p-mfc.
> 
> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
> ---
>  .../media/uapi/v4l/extended-controls.rst      | 27 ++++++++++++++++---
>  drivers/media/platform/qcom/venus/core.h      |  2 +-
>  .../media/platform/qcom/venus/hfi_helper.h    | 12 ++++-----
>  .../media/platform/qcom/venus/vdec_ctrls.c    | 10 ++++---
>  drivers/media/platform/qcom/venus/venc.c      | 14 +++++-----
>  .../media/platform/qcom/venus/venc_ctrls.c    | 12 +++++----
>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  | 15 +++++------
>  drivers/media/v4l2-core/v4l2-ctrls.c          | 12 ++++++++-
>  include/uapi/linux/v4l2-controls.h            | 11 +++++++-
>  9 files changed, 79 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
> index 03931f9b1285..de99eafb0872 100644
> --- a/Documentation/media/uapi/v4l/extended-controls.rst
> +++ b/Documentation/media/uapi/v4l/extended-controls.rst
> @@ -1955,9 +1955,30 @@ enum v4l2_vp8_golden_frame_sel -
>  ``V4L2_CID_MPEG_VIDEO_VPX_P_FRAME_QP (integer)``
>      Quantization parameter for a P frame for VP8.
> 
> -``V4L2_CID_MPEG_VIDEO_VPX_PROFILE (integer)``
> -    Select the desired profile for VPx encoder. Acceptable values are 0,
> -    1, 2 and 3 corresponding to encoder profiles 0, 1, 2 and 3.
> +.. _v4l2-mpeg-video-vp8-profile:
> +
> +``V4L2_CID_MPEG_VIDEO_VP8_PROFILE``
> +    (enum)
> +
> +enum v4l2_mpeg_video_vp8_profile -
> +    This control allows to select the profile for VP8 encoder.
> +    This is also used to enumerate supported profiles by VP8 encoder or decoder.
> +    Possible values are:
> +
> +
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_0``
> +      - Profile 0
> +    * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_1``
> +      - Profile 1
> +    * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_2``
> +      - Profile 2
> +    * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
> +      - Profile 3
> 
> 
>  High Efficiency Video Coding (HEVC/H.265) Control Reference
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 0360d295f4c8..f242e7f9f6a2 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -159,7 +159,7 @@ struct venc_controls {
>  	struct {
>  		u32 mpeg4;
>  		u32 h264;
> -		u32 vpx;
> +		u32 vp8;
>  	} profile;
>  	struct {
>  		u32 mpeg4;
> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> index 55d8eb21403a..07bf49dd2ec6 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -333,12 +333,12 @@
>  #define HFI_VC1_LEVEL_3				0x00000040
>  #define HFI_VC1_LEVEL_4				0x00000080
> 
> -#define HFI_VPX_PROFILE_SIMPLE			0x00000001
> -#define HFI_VPX_PROFILE_ADVANCED		0x00000002
> -#define HFI_VPX_PROFILE_VERSION_0		0x00000004
> -#define HFI_VPX_PROFILE_VERSION_1		0x00000008
> -#define HFI_VPX_PROFILE_VERSION_2		0x00000010
> -#define HFI_VPX_PROFILE_VERSION_3		0x00000020
> +#define HFI_VP8_PROFILE_SIMPLE			0x00000001
> +#define HFI_VP8_PROFILE_ADVANCED		0x00000002
> +#define HFI_VP8_PROFILE_VERSION_0		0x00000004
> +#define HFI_VP8_PROFILE_VERSION_1		0x00000008
> +#define HFI_VP8_PROFILE_VERSION_2		0x00000010
> +#define HFI_VP8_PROFILE_VERSION_3		0x00000020

Please do not rename these driver internal defines, just leave VPX as it
is now.


-- 
regards,
Stan
