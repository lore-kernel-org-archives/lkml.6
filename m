Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32097C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCBD2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mc8IWPHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCBD2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJIPOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:14:49 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:32800 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbeJIPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:14:46 -0400
Received: by mail-yw1-f66.google.com with SMTP id m127-v6so275464ywb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfC2K77BgCfSmtV8fbfFim7K+3NV2MODtzHITr4r8xU=;
        b=mc8IWPHO7Omu+x4RIA/W9p1MWJhGluVGsXIP7HA0oyEL6EIBf8rcOuh9Pywaeh02FQ
         LdyYkkfNoJ9KDQsBgfUo7cYjicdv/8TRqoYB9v2QNJjaAB2X2ZSDyWoIpZSQOr1HkSwL
         HgMlPi+1jGPixDHZXcVe7p2YmGV4yVNkHQySk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfC2K77BgCfSmtV8fbfFim7K+3NV2MODtzHITr4r8xU=;
        b=Q5cfWRQ9PLEpB9ABWf51x4pvMn7s677S/UQa69PW01bTMs84HEn4z6c+dd1LZ6E0D+
         /4sOg4TesI2cwGI9wOw7bl9StesMIYQgiZe3eHjJr5yErEwbI0jjUE6Nh4WHxC4POA8r
         MyFyL5E5G4eRoEppshEDxnQbgHzsoxxitzxT0dDhiHtzJlPEQXYKOKt9LhbLhTkyTxo4
         8VM8HcIlV29iQXY+QMYuFAs1S9Dk2hoVZqkaN5ZpI5kuKtzRwXBwmrcM2A1lEYmDMmva
         eR0W5v2JKDrQA7gdYU8e0j4cuRa/eJcnWJ9Xp6KFhQBgXkX54UyfTj1ACZKC/k0m/UQ4
         NK5g==
X-Gm-Message-State: ABuFfohrvdpU68Zg8NXVHOCksBp8+ir3F+KuhAcXNs9pGNHT8+paaSGU
        Ff9TRmCVAGC0dhSFLW1p0VIkyVTud/Xd5A==
X-Google-Smtp-Source: ACcGV62ybXq6i6dc1CZ7Q4DWkA5Sn09hTPrNVcBk/G3QasZECEjoVAcL7wWRV+ErggpWslUKLQdNhA==
X-Received: by 2002:a81:a10c:: with SMTP id y12-v6mr15169927ywg.178.1539071946196;
        Tue, 09 Oct 2018 00:59:06 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id l128-v6sm2703655ywd.35.2018.10.09.00.59.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 00:59:05 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id h1-v6so264119ybm.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:59:05 -0700 (PDT)
X-Received: by 2002:a25:ac68:: with SMTP id r40-v6mr15375162ybd.285.1539071944661;
 Tue, 09 Oct 2018 00:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181004133739.19086-1-mjourdan@baylibre.com>
In-Reply-To: <20181004133739.19086-1-mjourdan@baylibre.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 9 Oct 2018 16:58:53 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BTD6mwB1O4SVeKfKOho7cMMufuenu5xE0BjCAq1GuTag@mail.gmail.com>
Message-ID: <CAAFQd5BTD6mwB1O4SVeKfKOho7cMMufuenu5xE0BjCAq1GuTag@mail.gmail.com>
Subject: Re: [PATCH] media: videodev2: add V4L2_FMT_FLAG_NO_SOURCE_CHANGE
To:     mjourdan@baylibre.com
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, Oct 4, 2018 at 10:38 PM Maxime Jourdan <mjourdan@baylibre.com> wrote:
>
> When a v4l2 driver exposes V4L2_EVENT_SOURCE_CHANGE, some (usually
> OUTPUT) formats may not be able to trigger this event.
>
> Add a enum_fmt format flag to tag those specific formats.
>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  Documentation/media/uapi/v4l/vidioc-enum-fmt.rst | 5 +++++
>  include/uapi/linux/videodev2.h                   | 5 +++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst b/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
> index 019c513df217..e0040b36ac43 100644
> --- a/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
> +++ b/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
> @@ -116,6 +116,11 @@ one until ``EINVAL`` is returned.
>        - This format is not native to the device but emulated through
>         software (usually libv4l2), where possible try to use a native
>         format instead for better performance.
> +    * - ``V4L2_FMT_FLAG_NO_SOURCE_CHANGE``
> +      - 0x0004
> +      - The event ``V4L2_EVENT_SOURCE_CHANGE`` is not supported
> +       for this format.
> +
>
>
>  Return Value
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 3a65951ca51e..a28acee1cb52 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -723,8 +723,9 @@ struct v4l2_fmtdesc {
>         __u32               reserved[4];
>  };
>
> -#define V4L2_FMT_FLAG_COMPRESSED 0x0001
> -#define V4L2_FMT_FLAG_EMULATED   0x0002
> +#define V4L2_FMT_FLAG_COMPRESSED       0x0001
> +#define V4L2_FMT_FLAG_EMULATED         0x0002
> +#define V4L2_FMT_FLAG_NO_SOURCE_CHANGE 0x0004

I think it indeed makes sense. I'd suggest submitting this patch
together with the series that adds the affected driver, though, since
we'd be otherwise just adding a dead API.

Also, it would be good to refer to it from the Decoder Interface
documentation. Depending on which one gets in earlier, you might
either want to base on it or I'd add a note myself.

Best regards,
Tomasz
