Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9303C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93A620869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMSrlAa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbeLTQvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:51:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40100 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeLTQvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:51:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so2485581wrt.7;
        Thu, 20 Dec 2018 08:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XDoEcsphJfLSHO2kmblU3CciXCLkxepn3KxsEQxQ7sI=;
        b=vMSrlAa8sQpLYvNn1jSaSLsG7NhUrjnuCPba2GizpOFrWFeXMU1ESfVSQi4CboCiGv
         hR6k22PD7Xj/kkozxUuGv6o2mZXi7cbvmO07fFogtVU7TjaNBrasHK+1jJss6UcndCTq
         OnfUhTo136kBJDEICnASvJ3uf3BX2Cfhsk2WMP9oovYlpc0Pq8ol8IVeDXZrceSfwZOn
         2olbe7Maa6IdaZJtlRL9/hPNVsaBL/YfDuBKa4NGaConzWy1dKmD9naKV4ZRpC5GKJyS
         ebiY1Qh1iXyigJAYdilZsiS1IGmN2f8dsyTU644Zb4rMkzIWtY3dKito+/l5PsTLoAMc
         /Zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XDoEcsphJfLSHO2kmblU3CciXCLkxepn3KxsEQxQ7sI=;
        b=dFD7CGSqdX507tlTlRrQ7m9/Whjv2C6RBPwOQSsvkp010TfRZFS9VByIrr0bnJFwDh
         j4ZOGd0p9krN0cz9pshOFKUtdZpQ35P5LZjAswChfeYLsVg9JXCtCExKgXJLnRBBakKZ
         9fgLuiiXjYM9k7IHzVJUwcuZH9XcWePszw7ViTVhgpQxvZVhV6F9kacUw9fjZwAzqwBc
         arnRrkDkm+b2Tvf1IwdWOLbIUOlcy8If8RaCtSYA9XxrVv2SfgnEXg9ou6LXfTE5/fcF
         3Ayujk126l93Jk/ONXWXdc2EyjYHOxe+58fQ7GIYmTTHA1JxVP2XSN9aDPJCsqGl1sWO
         sNNQ==
X-Gm-Message-State: AA+aEWYInhHDaTSTI3Hg6uePhOTMMoF1itQqvW6xRHsRbbcmG6jrYBKo
        wQgctXGPyTjKT5jJyDP4H8v+MOuMFTUo4OI8CLU=
X-Google-Smtp-Source: AFSGD/VdW3S4p1VqN7kkNShTd+XFFbLrL3ULEzq3GvPgEXe39HdQQCKxYUej1x68ZOhV+hXDh0DhOSC/QvezWTWf2zY=
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr22513120wrh.317.1545324680035;
 Thu, 20 Dec 2018 08:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20181218130554.28992-1-colin.king@canonical.com>
In-Reply-To: <20181218130554.28992-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Dec 2018 11:51:08 -0500
Message-ID: <CADnq5_OFWmLvm_QXN0w=sf+xLViNE=uf6XYFLrXLCWEoBdwDyA@mail.gmail.com>
Subject: Re: [PATCH][next] amdgpu/dc: remove various variables that are
 defined but never used
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 8:06 AM Colin King <colin.king@canonical.com> wrote=
:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are several variables that are defined and never used and hence can
> be removed. Remove them. Cleans up clang -Wunused-const-variable warnings=
:
>
> warning: =E2=80=98dvi_hdmi_dongle_signature_str=E2=80=99 defined but not =
used
> warning: =E2=80=98dce11_one_lpt_channel_max_resolution=E2=80=99 defined b=
ut not used
> warning: =E2=80=98ddc_hw_status_addr=E2=80=99 defined but not used
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

applied.  thanks!

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c      |  1 -
>  .../gpu/drm/amd/display/dc/dce110/dce110_compressor.c  |  2 --
>  .../amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c  | 10 ----------
>  3 files changed, 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_link_ddc.c
> index 506a97e16956..99a314b79850 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> @@ -42,7 +42,6 @@
>  #define CV_SMART_DONGLE_ADDRESS 0x20
>  /* DVI-HDMI dongle slave address for retrieving dongle signature*/
>  #define DVI_HDMI_DONGLE_ADDRESS 0x68
> -static const int8_t dvi_hdmi_dongle_signature_str[] =3D "6140063500G";
>  struct dvi_hdmi_dongle_signature_data {
>         int8_t vendor[3];/* "AMD" */
>         uint8_t version[2];
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
> index 52d50e24a995..7b23239d33fe 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
> @@ -62,8 +62,6 @@ static const struct dce110_compressor_reg_offsets reg_o=
ffsets[] =3D {
>  }
>  };
>
> -static const uint32_t dce11_one_lpt_channel_max_resolution =3D 2560 * 16=
00;
> -
>  static uint32_t align_to_chunks_number_per_line(uint32_t pixels)
>  {
>         return 256 * ((pixels + 255) / 256);
> diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dc=
e80.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c
> index 4853ee26096a..c9d6cf08e8ab 100644
> --- a/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c
> +++ b/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c
> @@ -50,16 +50,6 @@
>   * This unit
>   */
>
> -static const uint32_t ddc_hw_status_addr[] =3D {
> -       mmDC_I2C_DDC1_HW_STATUS,
> -       mmDC_I2C_DDC2_HW_STATUS,
> -       mmDC_I2C_DDC3_HW_STATUS,
> -       mmDC_I2C_DDC4_HW_STATUS,
> -       mmDC_I2C_DDC5_HW_STATUS,
> -       mmDC_I2C_DDC6_HW_STATUS,
> -       mmDC_I2C_DDCVGA_HW_STATUS
> -};
> -
>  /*
>   * @brief
>   * Cast 'struct i2c_sw_engine *'
> --
> 2.19.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
