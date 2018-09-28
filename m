Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2497C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F212215EB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="R4DJTxZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F212215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeI1P1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:27:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46632 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeI1P1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:27:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id d8-v6so3861686pfo.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9EJnHDpoIikFB2pJG1iawXE70HuqjIU3jUKHsRIGvM=;
        b=R4DJTxZUF6o091yHbSpChA7THlszAOwlOXHCCbuR/sfIrw3hju8vR0GUHwAZtcAqAT
         oRtUe9XKPxM0DJq28sEdKyZBNGQoSR7JNIz3MeRXcxaRpwQL9ScsQjmYryzeRRewEzlk
         /ePujeBanMNYKgfqtFy1CZ6kjC0sk+gBYgUR0rxpGnTasIMHgolJfHFZ5MyBsp0yO8LQ
         Xl8UzJK8vtbleGSr6HyvgCgckNavPW/8uPHw6LhIB1sqU28C8DDxTfVRj4/V82mI0437
         2J3uQZSG833UZftralROrcOzoRmeBshQYSjNqL0y3QIhA4q9bUxF34SX8RBmd47xtSW+
         Hfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9EJnHDpoIikFB2pJG1iawXE70HuqjIU3jUKHsRIGvM=;
        b=pFnkZmBpXBKhi4Bz8NFfe2YPbGh4r6tFF61N/gqMIstSHWqkmtdZv28Rd/Xub8vB/n
         2lsMyfp9wpmO5rBbQorigOZqM8ynj8i9TwHq0ua4L+4QIXN7QG2SkpGxj3Y7RZV0puqC
         Qu28rOitv6HkOnMt00zL/L/JklUdCOssC5ZY5T/B0Ug4/ZfQajLVWDZ6iUanH5uw2rgi
         /8DDZ/uHMv0dGqNdGJGLtFP+QTO2gKOj50shPLSiAZdJQsjdVHlR0m1m/tXbinQ4wKwF
         1Hp6tlsEnevZkXobHxu91BYc/yPyHBufZD5+iGPkeEuSB5emmk7xcYtbMQDtdnF4REGk
         YN4Q==
X-Gm-Message-State: ABuFfojSOG7x7IpWtkKhokPxkoswUcIKbm2uj+UG48lAXniD9iH0Q/3B
        0YLmu9xW+wimwpcGbpdwHGOwaacKFF7reWDYcMAb
X-Google-Smtp-Source: ACcGV61LcHFqN4iCYseWhU+KAyvKZOijcPyopF0YRUWO8Aw0HDyfzJDnaQh3Zws6OBKoItMYNrbVxqq8G5x4/Qxc91I=
X-Received: by 2002:a17:902:e85:: with SMTP id 5-v6mr14835799plx.73.1538125482911;
 Fri, 28 Sep 2018 02:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180928005038.1697-1-natechancellor@gmail.com>
In-Reply-To: <20180928005038.1697-1-natechancellor@gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.org>
Date:   Fri, 28 Sep 2018 10:04:29 +0100
Message-ID: <CAAoAYcMMiiDXCcnZ=DP9Y9Xs+xdq-jasj8G_W0jrnQV9so79=A@mail.gmail.com>
Subject: Re: [PATCH] staging: bcm2835-camera: Avoid unneeded internal
 declaration warning
To:     natechancellor@gmail.com
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nate

Thanks for the patch.

On Fri, 28 Sep 2018 at 01:53, Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/staging/vc04_services/bcm2835-camera/controls.c:59:18: warning:
> variable 'mains_freq_qmenu' is not needed and will not be emitted
> [-Wunneeded-internal-declaration]
> static const s64 mains_freq_qmenu[] = {
>                  ^
> 1 warning generated.
>
> This is because mains_freq_qmenu is currently only used in an ARRAY_SIZE
> macro, which is a compile time evaluation in this case. Avoid this by
> adding mains_freq_qmenu as the imenu member of this structure, which
> matches all other controls that uses the ARRAY_SIZE macro in v4l2_ctrls.
> This turns out to be a no-op because V4L2_CID_MPEG_VIDEO_BITRATE_MODE is
> defined as a MMAL_CONTROL_TYPE_STD_MENU, which does not pass the imenu
> definition along to v4l2_ctrl_new in bm2835_mmal_init_controls.

There's a slight confusion betwen V4L2_CID_MPEG_VIDEO_BITRATE_MODE and
V4L2_CID_POWER_LINE_FREQUENCY in your description.

However you're right that MMAL_CONTROL_TYPE_STD_MENU calls
v4l2_ctrl_new_std_menu which doesn't need a menu array (it's
v4l2_ctrl_new_int_menu that does). That means the correct fix is to
define the max value using the relevant enum (in this case
V4L2_CID_POWER_LINE_FREQUENCY_AUTO) and remove the array.

The same is true for V4L2_CID_MPEG_VIDEO_BITRATE_MODE - max should be
V4L2_MPEG_VIDEO_BITRATE_MODE_CBR, and remove the bitrate_mode_qmenu
array.

Thanks,
  Dave

> Link: https://github.com/ClangBuiltLinux/linux/issues/122
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/vc04_services/bcm2835-camera/controls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> index cff7b1e07153..a2c55cb2192a 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> @@ -1106,7 +1106,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
>         {
>                 V4L2_CID_POWER_LINE_FREQUENCY, MMAL_CONTROL_TYPE_STD_MENU,
>                 0, ARRAY_SIZE(mains_freq_qmenu) - 1,
> -               1, 1, NULL,
> +               1, 1, mains_freq_qmenu,
>                 MMAL_PARAMETER_FLICKER_AVOID,
>                 &ctrl_set_flicker_avoidance,
>                 false
> --
> 2.19.0
>
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
