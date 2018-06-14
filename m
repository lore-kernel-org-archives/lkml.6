Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 75A9AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5FC208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IV38/kZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5FC208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754781AbeFNIGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:06:30 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42907 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754602AbeFNIGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:06:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so5343258wrk.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1/Ia9tp2e9yRXrVd3q0TCGex9EjGpq4XLaI2O9fGVro=;
        b=IV38/kZFiBYvRKfuRfIxN65+Fman677QgxgW8fbNEMIUPz/LUIehENoswiSGO3G2a2
         wXxKCHRCALu1TMu1a/FI2QRHM+IE7yzSgIZkyAtgJ9OMOJMRZpMYZzqn4q3bGLiWbLc1
         Q3jyFPZLQq5hDxstJ1HH+KqhKIEoA/nnw1g3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1/Ia9tp2e9yRXrVd3q0TCGex9EjGpq4XLaI2O9fGVro=;
        b=KRzSHjBLwAPEn9DC5VCu/o13/tjYIM6o3JqeqPa2Oifqa0N83hpsG55oU32TouRHAY
         L1wMi9NRc3Fl1BA+TrC6GaWnktm0I9ap1M38stTInpBuCjdiWjJNr21383yhulRX6ehA
         1Ny4E6WxtUpQlm0gR+R6FySeMq8BT1F+msecPK9gmYqZ1k/OkjIFlOyK/Y7AmGa+nJHU
         UDrA07L6xTAJ+3onJZLk7wKD+Aolqto+O+NiByon8CQQYxRNX2M5DgHaGzOmiRhWeprY
         gUzht+sMEBxO4/TiZOboLMwwpBSfo6RHoMhVrIFThKCyliZkQOHOKEcZoDXmV1CzEAyN
         SdPw==
X-Gm-Message-State: APt69E3HXJBbKzmKLRWGMDbiEE5CMcnoZoJVUNkaYLPOyR2BCnZTaNgx
        hq8uQOIpNeASkx+Lk33+QSOhOA==
X-Google-Smtp-Source: ADUXVKJraPthgAtuuyTtgqPlDm/iMavSRkFzLNAr2c7gCqia8DtC/ufuPVUp8hg1Ps1/GY1Epr7p6A==
X-Received: by 2002:adf:b297:: with SMTP id g23-v6mr1174442wrd.218.1528963582601;
        Thu, 14 Jun 2018 01:06:22 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id q70-v6sm5223970wmd.45.2018.06.14.01.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 01:06:22 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] media: v4l2-ctrl: Add control for VP9 profile
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
 <20180614074652.162796-3-keiichiw@chromium.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <9cb304df-c600-918a-1c73-8daa9644f9c3@linaro.org>
Date:   Thu, 14 Jun 2018 11:06:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180614074652.162796-3-keiichiw@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keiichi,

On 06/14/2018 10:46 AM, Keiichi Watanabe wrote:
> Add a new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for VP9
> profiles. This control allows to select a desired profile for VP9
> encoder and query for supported profiles by VP9 encoder/decoder.
> 
> Though this control is similar to V4L2_CID_MPEG_VIDEO_VP8_PROFILE, we need to
> separate this control from it because supported profiles usually differ between
> VP8 and VP9.
> 
> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
> ---
>  .../media/uapi/v4l/extended-controls.rst      | 25 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls.c          | 11 ++++++++
>  include/uapi/linux/v4l2-controls.h            |  7 ++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
> index de99eafb0872..095b42e9d6fe 100644
> --- a/Documentation/media/uapi/v4l/extended-controls.rst
> +++ b/Documentation/media/uapi/v4l/extended-controls.rst
> @@ -1980,6 +1980,31 @@ enum v4l2_mpeg_video_vp8_profile -
>      * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
>        - Profile 3
> 
> +.. _v4l2-mpeg-video-vp9-profile:
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_PROFILE``
> +    (enum)
> +
> +enum v4l2_mpeg_video_vp9_profile -

what about vp9 levels, shouldn't we add them too? Or we will add it when
there is a user.


-- 
regards,
Stan
