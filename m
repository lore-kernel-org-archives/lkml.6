Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB26FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB38D2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wdh7YQog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfA1Tge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:36:34 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43997 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfA1Tgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:36:33 -0500
Received: by mail-yw1-f68.google.com with SMTP id n21so7209769ywd.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7nA1rh5clpPWyjE2+QFEZW9/hzDdThSWfKGCF1muAus=;
        b=Wdh7YQog2T/LXRedMjM3PT45gUb4rkUcWSUd2hfnbzbuSMpKuV2uRUjTSvgq6Iod9/
         sHtP1F2y2DEE8d0PfzpxK0nWDPS896YzpF8XMVy6BWPRH9th5PV0Nbz41HRwEIsJTBB0
         +ev7MyN4Gyqks2lk2GKz6p3dqIQVQZ1UFdxqxnWTrSKBypOvOyvHU8od2Mhz7hsJK9rb
         yc57RjMfk6a53ail08PL0ccDPBOGVeGFQ9+wPJKhUPgnBihHJK0I6Tl4mJR1k/tJrBrD
         TIKM+agJC8SdJqjCKFR5hadv01MQAuLW5VeUvpeohE2NVgR+YosGyueYaXqLYgF5nE92
         JL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nA1rh5clpPWyjE2+QFEZW9/hzDdThSWfKGCF1muAus=;
        b=j2smRVvuj2EC9aoXMKNMV1zfw98kWsAtp5aKldtDEUSkL5nPH2yCsE+piMmPzSmbHZ
         MPW8w3GALHEuBbFbj6+VX5ceBaiRXy3aQ8E8MfQ9c8Ew5Y3wRObukIM5VJo7BW5g3bOt
         jK1DGnKw7T49lLILmBT5+tcYe/yfCX4CPeU3OXizIGPcJrNI4bMcAXm6alAjDz5QEKVZ
         jBTp1FzW9OQ98Ei3DqW8Ci8DLMsjy0ptbmY0SsbX3WMrIBRSJKKapcDGjdCQnyEC/015
         L97DP5hes4ce/dp+MXFoTWUTxYVzQCAXKd/IUd8EZcuHYOVh7g+ne+8YIJGZcGR6BGza
         mHuw==
X-Gm-Message-State: AJcUukfUBeR6LJq0hIY5sgnDYOhP2/nZDSKgh+0tvMinqin/OX0bUcbs
        Fi2I7VXiBoDwpIPMDL/ywapBhR7hogX9UYOSSXhdDQ==
X-Google-Smtp-Source: ALg8bN7oJK0WI+M00Gb4FkOEcBA6fOxq01s9+VwoM5dAXEtsqgLAttWL146IfmCsPvm7i0m6uay8jg83nnZRC1ZfOSw=
X-Received: by 2002:a81:ac1f:: with SMTP id k31mr22006175ywh.320.1548704192720;
 Mon, 28 Jan 2019 11:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20190126095131.4756-1-enric.balletbo@collabora.com> <20190126095131.4756-12-enric.balletbo@collabora.com>
In-Reply-To: <20190126095131.4756-12-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 28 Jan 2019 11:36:22 -0800
Message-ID: <CABXOdTdcmW+VciVP_t8aa64m=_KS0zMsbObpSMpi9eWZ8_NvMw@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] platform/chrome: cros_ec_lightbar: remove
 pr_fmt() define
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 1:51 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> This driver no longer has any pr_{level} messages. Remove the pr_fmt().
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v2: None
>
>  drivers/platform/chrome/cros_ec_lightbar.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> index 37689ad79544..d30a6650b0b5 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -3,8 +3,6 @@
>  //
>  // Copyright (C) 2014 Google, Inc.
>
> -#define pr_fmt(fmt) "cros_ec_lightbar: " fmt
> -
>  #include <linux/ctype.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> --
> 2.20.1
>
