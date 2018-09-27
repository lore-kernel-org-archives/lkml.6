Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41707C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD7C216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4qMOu54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD7C216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeI0U7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:59:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41260 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbeI0U7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:59:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id j15-v6so2901845wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXFw4Cc/SAxkOPPa6TJI9fGx0DGhFSOcOugeqnkYz7M=;
        b=k4qMOu54+7yVCr8W0IezrXvJuIfS06MYb4AI3by1E2Fi9hJR5tTbc7jcSGgzpeY9Zj
         F96skEihZiYGf2g3vlYi0ngXd/JPiPftXD5k1pN0w80FDiODSWWDIBLVW0QFo6VMGASa
         2iBm/KKvNybBAeMZBjHCKbGubTrO4BtkYEHn6QzBisIPxkc+1He1WqNp7Z3NBOWLBOXP
         0LpZmRWYNjcrFipbsjELAWvAxp/uJy0LgaZgHxT5xefKawOUwt6Z3WlhEHkvXYzVe4LE
         JUphlqs06Z+dlNy/nQwjcuWxW+RZQsljjD98KcGWXFQijUjs8DESJ1pR/XFbvXLu5QaS
         9iTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXFw4Cc/SAxkOPPa6TJI9fGx0DGhFSOcOugeqnkYz7M=;
        b=hNhzclVBelOYmU35rawGNGdma9idS7NNMgcWSSNe6TZevwCXgECb7kTMJNKAbC5Z9y
         ZdiHcgi+rGu+qcT3HUSGjj3LVtKZKUSuWILRQ/H5sFPYYygxaYPhbe5zKIzoEETbx1yU
         LPdxjipe4lW8FFadeIM3GMsmUpifVE2ybcym8eD+KoMy+GHIkQw1HjpNRGWVCvXlTIvp
         xt4JRBVDlhXxIGL4n24IhddwyzjymASLq1uRBJ7C2DxiwXTY2iaP1O931lYBa7TGR2S3
         KSfMj6H7dZLF2ddwzChuB2kBhmT7Zb4CpMsv3Ddcv0dnM7pxWTxa1mqvSFCbh9YHMz9M
         86Ng==
X-Gm-Message-State: ABuFfoi2ctDAh3IA13yZpJf/EI9Wdoi1+yGjTjUQ7UhJiXsSPsOYHzYP
        rUGqe7NSn0qIU2wdJ7CpYE7nXYyKdSLSglfaUBvPFYyy
X-Google-Smtp-Source: ACcGV612HFLwluLBc0DkpEP0GNlVZ7ZKP5JW5ewVwEvOVOYcfRTnStb/BUBrlvVE2ctD0ws2OyiVoURSM7mpsWDF4yE=
X-Received: by 2002:adf:eb87:: with SMTP id t7-v6mr9291723wrn.123.1538059265583;
 Thu, 27 Sep 2018 07:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180921210106.24310-1-natechancellor@gmail.com>
In-Reply-To: <20180921210106.24310-1-natechancellor@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 Sep 2018 10:40:52 -0400
Message-ID: <CADnq5_P1uq=k4V9A_H+kewbaKtO6tnXXE_DBcuK-Q3tpuYJNow@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Change id parameter type in pp_atomfwctrl_get_clk_information_by_clkid
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex
On Sat, Sep 22, 2018 at 2:29 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang generates warnings when one enumerated type is implicitly
> converted to another.
>
> drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/ppatomfwctrl.c:532:57:
> warning: implicit conversion from enumeration type 'enum
> atom_smu11_syspll0_clock_id' to different enumeration type 'BIOS_CLKID'
>       (aka 'enum atom_smu9_syspll0_clock_id') [-Wenum-conversion]
>         if (!pp_atomfwctrl_get_clk_information_by_clkid(hwmgr,
> SMU11_SYSPLL0_SOCCLK_ID, &frequency))
>
> In this case, that is expected behavior. To make that clear to Clang
> without explicitly casting these values, change id's type to uint8_t
> in pp_atomfwctrl_get_clk_information_by_clkid so no conversion happens.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c | 3 ++-
>  drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
> index d27c1c9df286..4588bddf8b33 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
> @@ -488,7 +488,8 @@ int pp_atomfwctrl_get_gpio_information(struct pp_hwmgr *hwmgr,
>         return 0;
>  }
>
> -int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr, BIOS_CLKID id, uint32_t *frequency)
> +int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr,
> +                                              uint8_t id, uint32_t *frequency)
>  {
>         struct amdgpu_device *adev = hwmgr->adev;
>         struct atom_get_smu_clock_info_parameters_v3_1   parameters;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
> index 22e21668c93a..fe9e8ceef50e 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
> @@ -236,7 +236,7 @@ int pp_atomfwctrl_get_vbios_bootup_values(struct pp_hwmgr *hwmgr,
>  int pp_atomfwctrl_get_smc_dpm_information(struct pp_hwmgr *hwmgr,
>                         struct pp_atomfwctrl_smc_dpm_parameters *param);
>  int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr,
> -                                       BIOS_CLKID id, uint32_t *frequency);
> +                                       uint8_t id, uint32_t *frequency);
>
>  #endif
>
> --
> 2.19.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
