Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A12ADC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C646208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HPai9xv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C646208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754762AbeFNJMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:12:05 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41986 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754602AbeFNJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:12:02 -0400
Received: by mail-lf0-f65.google.com with SMTP id v135-v6so8239725lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 02:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WTbn5oXf2SomWOkWjU8Y/keaF7OL567/hSGcNfLeMqE=;
        b=HPai9xv9QKF8CNtAqsc/TStTPwRs0JxZRs+1KsNIfV9xQWR/Q5xilOyQm30xWsiIE9
         gyxQi2/k8Bp6rMNCdv1X2qZ/I1z+v1HUzlYZ/UjpunLFwGbaN4PCjQwBKFGUDR/ptmhf
         w2DY6QhW3kAq+nT297sTBiRq/6FYcL7S2vDVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WTbn5oXf2SomWOkWjU8Y/keaF7OL567/hSGcNfLeMqE=;
        b=nNM/pseBDh9Ow2vM3B//Qcuqkj5imAp3pvA0DJb1NYV7DoyL/xFQrdkYwzVoXCO54q
         lpgkGOYEA4j/V4dZDAqA3FNv2Mj+zRiuFLdZeCbVj0NzuYkw12fRqG4DOLC9G0isW/eB
         CSqKCzZBqAmWxsVdI81XloUt/ErjQSQAdzJEZCUhe3YTVDsaY5TIP/ttjgbC3Z7C+Kvz
         oTB0nc8CWpo2jg8cjvcdZkgwGhPT2ktT/srKZFI7WR3YFIosgCXJN9E3fOG8VsiaG7Su
         HxHKRXyMplzaVTe2UnxVdZdSkMqV8RUHofp51mK3VkJH3wC2XOTzylF7s6AjlBVBZVii
         dM4Q==
X-Gm-Message-State: APt69E3N1YH/lZtoW67BPgfYLXjksxp6DyWMKNRIPFuUFXgBEdo+W4lO
        iCZ+UOtVenFosE5bs/3ejC5DiQv0oSEYM7/fEJXgbQ==
X-Google-Smtp-Source: ADUXVKIunGyD7zIZxeWE1WoeQl772prSzunBoYVvR3S017bjJuKLqcTtVzv6pHu6C9iJCWDr/Nrf39dLKpbjSSEoVA4=
X-Received: by 2002:a2e:28b:: with SMTP id y11-v6mr1138475lje.27.1528967521368;
 Thu, 14 Jun 2018 02:12:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:5f96:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 02:12:00
 -0700 (PDT)
In-Reply-To: <9cb304df-c600-918a-1c73-8daa9644f9c3@linaro.org>
References: <20180614074652.162796-1-keiichiw@chromium.org>
 <20180614074652.162796-3-keiichiw@chromium.org> <9cb304df-c600-918a-1c73-8daa9644f9c3@linaro.org>
From:   Keiichi Watanabe <keiichiw@chromium.org>
Date:   Thu, 14 Jun 2018 18:12:00 +0900
Message-ID: <CAD90VcZT7M+egaBYXMdyGHUNq4wXmog9qFw3RjiPJ6cNszfkvA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] media: v4l2-ctrl: Add control for VP9 profile
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

Hi Stanimir,

On Thu, Jun 14, 2018 at 5:06 PM, Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
> Hi Keiichi,
>
> On 06/14/2018 10:46 AM, Keiichi Watanabe wrote:
>> Add a new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for VP9
>> profiles. This control allows to select a desired profile for VP9
>> encoder and query for supported profiles by VP9 encoder/decoder.
>>
>> Though this control is similar to V4L2_CID_MPEG_VIDEO_VP8_PROFILE, we need to
>> separate this control from it because supported profiles usually differ between
>> VP8 and VP9.
>>
>> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
>> ---
>>  .../media/uapi/v4l/extended-controls.rst      | 25 +++++++++++++++++++
>>  drivers/media/v4l2-core/v4l2-ctrls.c          | 11 ++++++++
>>  include/uapi/linux/v4l2-controls.h            |  7 ++++++
>>  3 files changed, 43 insertions(+)
>>
>> diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
>> index de99eafb0872..095b42e9d6fe 100644
>> --- a/Documentation/media/uapi/v4l/extended-controls.rst
>> +++ b/Documentation/media/uapi/v4l/extended-controls.rst
>> @@ -1980,6 +1980,31 @@ enum v4l2_mpeg_video_vp8_profile -
>>      * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
>>        - Profile 3
>>
>> +.. _v4l2-mpeg-video-vp9-profile:
>> +
>> +``V4L2_CID_MPEG_VIDEO_VP9_PROFILE``
>> +    (enum)
>> +
>> +enum v4l2_mpeg_video_vp9_profile -
>

> what about vp9 levels, shouldn't we add them too? Or we will add it when
> there is a user.
>
It sounds good, but I don't think we should include them in this
series of patches now.
As you said, we can add them when someone wants to use them.

Best regards,
Keiichi

>
> --
> regards,
> Stan
