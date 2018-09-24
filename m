Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C52C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F8620883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hFNkUHJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F8620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeIYEGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:06:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45989 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeIYEGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:06:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id t70-v6so5103852pgd.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPV1aLJ6bJEDYEFJf72AxNXcK+eRM5MX/KECwT/7Mg8=;
        b=hFNkUHJcDFVHIf54Kc5p2nCYVKlokQ1bbV69sxNxssiU8vUDVrPEvzJsGT+cBLG0z1
         znMOcH/x9ikuNnFlhp3pAWjXYcgpjB2Q/xN/qtwag+cmWn2BlXQLJX1rt8DwjbOYD8GY
         LnLcQD/ZztcRqt55SUjCFTnDn7fwmDafzj+5JtbITCp9GOXHGZtEFFCLdsY6Aazr1bbi
         iONshjPINPhZRZwZADqxM38CN7vZxL3xAbfsmsEWQxbr7igkxzbnGwMVEgPx32/3bTLx
         Qfh/pSs+gNvV/8pti1E8DcBjzNedx+7BzguGoATszaeibvga6WQ4wiZ2Age1O1yhklND
         sW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPV1aLJ6bJEDYEFJf72AxNXcK+eRM5MX/KECwT/7Mg8=;
        b=FSfp9VTK3MpinCfoTsZ/zKm24O2ts57y0MucpsYbLWU/v1lnaR1hlRbilZzkOYjsCd
         RpTXRokGnqOyTH1/KDPEdTkW4AEzc5wIEh5K6ubUUi2iDl7OQ0s5E2H0uEw1KucJIWZN
         5ZczadZLKqPB2BxT/H1GGlZCIds2Pwgc1+m4Umy25cv8TG0C1ZrvLE1g200f2hJo3Vfq
         YYY9kLEVio2sFyEwYQpt90fzQaFHFccSbBPF5QlaGb6G9lrF2Wwsf2W5ck8FmuZXAtUi
         3qs2vrO3qslW6Pueu0Gh5vsSQvA/EZImXxunfLAkeaLOC8UzNX86vVA9MbG1DXpSh/4h
         59Sw==
X-Gm-Message-State: ABuFfohd4wADarIaldIl3qo9+ppoBrNa4nvb+P3/7btC3CXI4A7otFuY
        aHhNMXKCZQE40H3W+oMogqqHt4ScPm+ZFu/mkSIoGA==
X-Google-Smtp-Source: ACcGV60PSrwrJLaG1aTfzlxb1CYrMTz/KyNvRh/MlH6XI/+iBicqVJPJJ/mon5I6B79LEDzOa+CBX036Hi2q4yMlXMs=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr617057pgl.302.1537826532923;
 Mon, 24 Sep 2018 15:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180921210106.24310-1-natechancellor@gmail.com>
In-Reply-To: <20180921210106.24310-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Sep 2018 15:02:01 -0700
Message-ID: <CAKwvOdkVqQN5M05X4_1YxOSi4LAzw=PXuLqVq0z7SXYWoCG2sA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Change id parameter type in pp_atomfwctrl_get_clk_information_by_clkid
To:     natechancellor@gmail.com
Cc:     rex.zhu@amd.com, evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 2:01 PM Nathan Chancellor
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

Grepping the call sites, via:
$ grep -r pp_atomfwctrl_get_clk_information_by_clkid

shows that sometimes this function is called with instances of:

enum atom_smu9_syspll0_clock_id
enum atom_smu11_syspll0_clock_id

before your patch, the function defined to take a BIOS_CLKID, which is
typedef'd to the *9* enum:

typedef enum atom_smu9_syspll0_clock_id BIOS_CLKID;

While the current values are < 256, the enums are not packed, so you
should use either int or a union of the two types.
Do the maintainers have a preference, before sending a v2?

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


--
Thanks,
~Nick Desaulniers
