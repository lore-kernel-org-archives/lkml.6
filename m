Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A0EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618FF213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VHY4+MR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618FF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJCN4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:56:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41051 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeJCN4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:56:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id u21-v6so4066848lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kI52v10MqoxOuS4pw6k9BVvYhLPHE4BwGAyXOAHYHBQ=;
        b=VHY4+MR1B2E8vqMwGImVO760qB77RNVKfguU75jc1Xnm0zczmR/2Y1g6Tx0MoAh9N6
         rSOlTKmriNI3l7rQ9vJZNa/uTg9VXRnwnZNSw40pScCjJ18/F5xEvTmISuLPXNi8dUy9
         7jahvCnZmF6MfwAHt7X0UtH6VXn1nnf+EoPJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kI52v10MqoxOuS4pw6k9BVvYhLPHE4BwGAyXOAHYHBQ=;
        b=Pi9HlzLBJo5bCPv9JwdIu74mHo83rMC1FkazXMZ/+ScCrTslK1touPOaxg9R+v1dz+
         09sv+xy9WLIr0Yh4KjycyvwpWKETTTm0yFLTGtRXJBUGTpaCc+K9wyWFxMtXl6pvpf9F
         GeM0+RW69IzfvEP5SQpsfnB3HFgtAv8eKwaVGbaCd26fvyWuAFZKZii//4kHstxsGMl7
         q7aZB+mwI5Rpg98e8JFAuzZyMdSYHf+LODF1RX9C1j7IQ/N5elQeSq3159Ucxv2cGhse
         Z4+X9PTq9FSD8VlAjH4TY4sT7uuvs1Fu7wk/GMdDQqrTBMbx0/F3aDfl3nSdLQUl7ZBX
         Sh9w==
X-Gm-Message-State: ABuFfojb8oE61MuPRHepr+i3MdXX0x0yCjQuonxZKSqzAjImv52pISKZ
        y1VkQjO/F9ul3cE78JOk/ARTpJInVucuJEC1xje06w==
X-Google-Smtp-Source: ACcGV61Oan5QVhY3C7PykICF/Tjkf2AnDFsL15wbRP46Zn6vT2jsVudW3pkVjjs9lL9RHNn1xxKP29ieaWlMuXED7o4=
X-Received: by 2002:a2e:2997:: with SMTP id p23-v6mr142017ljp.12.1538550538685;
 Wed, 03 Oct 2018 00:08:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:92c8:0:0:0:0:0 with HTTP; Wed, 3 Oct 2018 00:08:58 -0700 (PDT)
In-Reply-To: <20181003070656.193854-1-keiichiw@chromium.org>
References: <20181003070656.193854-1-keiichiw@chromium.org>
From:   Keiichi Watanabe <keiichiw@chromium.org>
Date:   Wed, 3 Oct 2018 16:08:58 +0900
Message-ID: <CAD90VcbBUcpwLsY0sHim+mML6esSjZA2ocX0Ff-YiZxBsLTZ+w@mail.gmail.com>
Subject: Re: [PATCH] media: vivid: Support 480p for webcam capture
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricky Liang <jcliang@chromium.org>,
        Shik Chen <shik@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think 480p is a common frame size and it's worth supporting in vivid.
But, my patch might be ad-hoc. Actually, I'm not sure which values are
suitable for the intervals.

We might want to add a more flexible/extensible way to specify frame sizes.
e.g. passing frame sizes and intervals as module parameters

Kei

On Wed, Oct 3, 2018 at 4:06 PM, Keiichi Watanabe <keiichiw@chromium.org> wrote:
> Support 640x480 as a frame size for video input devices of vivid.
>
> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
> ---
>  drivers/media/platform/vivid/vivid-vid-cap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/vivid/vivid-vid-cap.c b/drivers/media/platform/vivid/vivid-vid-cap.c
> index 58e14dd1dcd3..da80bf4bc365 100644
> --- a/drivers/media/platform/vivid/vivid-vid-cap.c
> +++ b/drivers/media/platform/vivid/vivid-vid-cap.c
> @@ -51,7 +51,7 @@ static const struct vivid_fmt formats_ovl[] = {
>  };
>
>  /* The number of discrete webcam framesizes */
> -#define VIVID_WEBCAM_SIZES 5
> +#define VIVID_WEBCAM_SIZES 6
>  /* The number of discrete webcam frameintervals */
>  #define VIVID_WEBCAM_IVALS (VIVID_WEBCAM_SIZES * 2)
>
> @@ -59,6 +59,7 @@ static const struct vivid_fmt formats_ovl[] = {
>  static const struct v4l2_frmsize_discrete webcam_sizes[VIVID_WEBCAM_SIZES] = {
>         {  320, 180 },
>         {  640, 360 },
> +       {  640, 480 },
>         { 1280, 720 },
>         { 1920, 1080 },
>         { 3840, 2160 },
> @@ -75,6 +76,8 @@ static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
>         {  1, 5 },
>         {  1, 10 },
>         {  1, 15 },
> +       {  1, 15 },
> +       {  1, 25 },
>         {  1, 25 },
>         {  1, 30 },
>         {  1, 50 },
> --
> 2.19.0.605.g01d371f741-goog
>
