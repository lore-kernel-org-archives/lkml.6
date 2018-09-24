Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F49FC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7E020877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW1Mmi2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7E020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeIYE7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:59:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38870 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeIYE7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:59:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id z16-v6so5195342wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8sLdqkTKqZHIuee5+IgVnG8a8vdgA11uZG2gCIW8og=;
        b=BW1Mmi2g4+bX7RMDD5f01RzKgc+KNx7E0O/EEb4Wy/fNqwqBRfxPbg5i7awvZ1UCj/
         UVcl3jEbJfJ1rc8xRyAVBIxz695GnZpn/lYUunH2p95QGCFB4Nvg4Z1vY0udlBLkAmU5
         dlguGF8E5PSh49tnCsHWh95ZzbLI0wkbLHSnK+A4q4NzbV86F7lzM1OiwQz6F93a0Z9u
         mAoqUStlIAvWScUo8PZxk4bH97mA85KnQRmf2CkKwaw73l9JYCdNpkA+cZ2QpsEEIXMn
         t3uWHc9kDEHAjS5Vj4j1ue9EQfRbNwoLFAGqZGBq5zi2jik5HbUbyY2hzVmJ6N0J5CDJ
         3EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8sLdqkTKqZHIuee5+IgVnG8a8vdgA11uZG2gCIW8og=;
        b=X1CrMYGxVnTx3S5qggRkwSx3Awf7d3fj/RDnpy0i8HNoaQ3ZHrYYGkWjquWovOpcPF
         2qH9Qbd/1H8wtwhP55DOGbKO+W6Y3Njc2mNYQLwttjL6IqaGkYyotEPOZcftAIHPF8iY
         pDHcd9FgBS2CravYeBqjNSWKDMBlhy9kRiO2anZyMLbvobisxx06ErxIT5MteJWEXS9l
         y4iEXJRgFbURfUT9P+vp9Fq46U2Mrp0yIurrhJqawDuNhOdMmiAak5ZPByhJPmewr9Ts
         u+Q6xBeCjWEakgLCk5NAkyxHTNgpr80M+y6V8FnAOUIqS9egZCLJ58N2jnhXRQLZtoHk
         NllA==
X-Gm-Message-State: ABuFfogUcDBcS2DVd9xlVC36iA6fO+5rjkYTmqIQjpGKeOb010xRSycR
        dIjdmp4WQW7tMTTsOv/2czXYSVd3iQV49PFpYGo=
X-Google-Smtp-Source: ACcGV63rnBPUl2bpOC7C4gcUvOIrBFJqD3tPPTqoPhFIjz66b0nncM9JehG8ULT0QMh8rYzugqu9PoGHHPHPtDZ0DTI=
X-Received: by 2002:a1c:570a:: with SMTP id l10-v6mr295001wmb.56.1537829667137;
 Mon, 24 Sep 2018 15:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180921210106.24310-1-natechancellor@gmail.com> <CAKwvOdkVqQN5M05X4_1YxOSi4LAzw=PXuLqVq0z7SXYWoCG2sA@mail.gmail.com>
In-Reply-To: <CAKwvOdkVqQN5M05X4_1YxOSi4LAzw=PXuLqVq0z7SXYWoCG2sA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Sep 2018 18:54:14 -0400
Message-ID: <CADnq5_OwR8WAztaKgktHc57XtwJtCHcpBbjk9R3ErM1a7Xakdg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Change id parameter type in pp_atomfwctrl_get_clk_information_by_clkid
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 6:07 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 21, 2018 at 2:01 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang generates warnings when one enumerated type is implicitly
> > converted to another.
> >
> > drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/ppatomfwctrl.c:532:57:
> > warning: implicit conversion from enumeration type 'enum
> > atom_smu11_syspll0_clock_id' to different enumeration type 'BIOS_CLKID'
> >       (aka 'enum atom_smu9_syspll0_clock_id') [-Wenum-conversion]
> >         if (!pp_atomfwctrl_get_clk_information_by_clkid(hwmgr,
> > SMU11_SYSPLL0_SOCCLK_ID, &frequency))
>
> Grepping the call sites, via:
> $ grep -r pp_atomfwctrl_get_clk_information_by_clkid
>
> shows that sometimes this function is called with instances of:
>
> enum atom_smu9_syspll0_clock_id
> enum atom_smu11_syspll0_clock_id
>
> before your patch, the function defined to take a BIOS_CLKID, which is
> typedef'd to the *9* enum:
>
> typedef enum atom_smu9_syspll0_clock_id BIOS_CLKID;
>
> While the current values are < 256, the enums are not packed, so you
> should use either int or a union of the two types.
> Do the maintainers have a preference, before sending a v2?

I think the patch is probably fine as is.  For reference, what this
function does it look up a value in the vbios based on the id.  So all
we really need is the numeric value of the id.  The ids are different
between asic families but the vbios interface is the same.

Alex

>
> >
> > In this case, that is expected behavior. To make that clear to Clang
> > without explicitly casting these values, change id's type to uint8_t
> > in pp_atomfwctrl_get_clk_information_by_clkid so no conversion happens.
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c | 3 ++-
> >  drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
> > index d27c1c9df286..4588bddf8b33 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
> > @@ -488,7 +488,8 @@ int pp_atomfwctrl_get_gpio_information(struct pp_hwmgr *hwmgr,
> >         return 0;
> >  }
> >
> > -int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr, BIOS_CLKID id, uint32_t *frequency)
> > +int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr,
> > +                                              uint8_t id, uint32_t *frequency)
> >  {
> >         struct amdgpu_device *adev = hwmgr->adev;
> >         struct atom_get_smu_clock_info_parameters_v3_1   parameters;
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
> > index 22e21668c93a..fe9e8ceef50e 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
> > @@ -236,7 +236,7 @@ int pp_atomfwctrl_get_vbios_bootup_values(struct pp_hwmgr *hwmgr,
> >  int pp_atomfwctrl_get_smc_dpm_information(struct pp_hwmgr *hwmgr,
> >                         struct pp_atomfwctrl_smc_dpm_parameters *param);
> >  int pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr,
> > -                                       BIOS_CLKID id, uint32_t *frequency);
> > +                                       uint8_t id, uint32_t *frequency);
> >
> >  #endif
> >
> > --
> > 2.19.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
