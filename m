Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEC3C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6EA2177A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr44zRM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6EA2177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbeHMRbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:31:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37655 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbeHMRbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:31:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so9101669wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hJfC5STYzXEphqWEI1QvgCS87bgkTpkqu6GGN8Q+W0Q=;
        b=Dr44zRM9lMTB3NkxyidUDtzj03zm3s8TsChhiMmz7ZccUp6m8g5Y3vEbcNXgffFolM
         cWVbHJcFgrUfS03em9sgDX6BvJo5NHGhNCjomOlRmz7kDStri4I3DaWUatho0dCTTnjF
         rdtqSWOwtr+Hd62FNSqjxiM0SBav0W/vGlUomDpqKxlgxccz0h1Qz79iWIhhfW8GCR/t
         AgwZMZNp57PtrnvLCPhj34S5AxMv36Fmq/R6IHLDeNALjKmLrU9lDm+cQEoLbb95u4++
         fEeZ/mSk6H2Q3n8kdgGSkjKP5OXCKXQ49eduk8CAKX+y7xqAKaeUNiMtVeuQ6tWEuvZp
         vDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hJfC5STYzXEphqWEI1QvgCS87bgkTpkqu6GGN8Q+W0Q=;
        b=NANtxVhLmTqJvrwsOZYnEjIwJ1PF364r8PvvYca/dIdnJFoJB+fdz8kpj/TeevxpLT
         hG16veChKwEaIdYV0Oy4cmmcUTGOYS/Ghdu3PB7mIZb8zUmV94cl5NdRcM7isFEI21OH
         Yz2Fe00FkaWi/ARSxNc1/uAz8Z2vhEWsbcH+i0M9xAr/LlUHI7XKULo36FT16VIy7qI6
         k3f6nvxF1Kdxzh0+hRxOCc1+icErjOFNkk2LrfhiK2wj76M6FxRyCoExQBYEuTLVbuwT
         NgzhAgGgyWCFM0V/2EPtDE+cuzT4mPQ+qXEav1V7Mx1MqOwHUv0Dkf8XsDgdlVmW29by
         x9nQ==
X-Gm-Message-State: AOUpUlEtBH0D+x9jTI+Q5OjXmgbZjDI0btyYCWlQfpFvwj044uHNCoxl
        JqsekFajImLl9Wl/ARex6mnuj9Joz3qKeNN8jfM=
X-Google-Smtp-Source: AA+uWPx0v0zsskschu5zqcwXga0y0Dp/iSh/H41XOQ+CQdimmaAbfFuRMEIU1i9wqv8lPLsojcwP/VTwvJvcw6kubhM=
X-Received: by 2002:a1c:4b0c:: with SMTP id y12-v6mr7704804wma.22.1534171750755;
 Mon, 13 Aug 2018 07:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180811155554.3382650-1-arnd@arndb.de> <593dd8e1-fa23-3216-3550-274401d88bcb@gmail.com>
In-Reply-To: <593dd8e1-fa23-3216-3550-274401d88bcb@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Aug 2018 10:48:57 -0400
Message-ID: <CADnq5_PCyKb72-BjFG3B4p_+bctNKoswAibw8C687_fpystSJA@mail.gmail.com>
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
To:     Christian Koenig <christian.koenig@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        "Daenzer, Michel" <michel.daenzer@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "S, Shirish" <shirish.s@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 3:55 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Adding Harry as well.
>
> Am 11.08.2018 um 17:54 schrieb Arnd Bergmann:
> > Building the DCN 1.0 Raven display driver with CONFIG_KCOV_INSTRUMENT_A=
LL=3Dy
> > and CONFIG_KCOV_ENABLE_COMPARISONS=3Dy results in warnings about many f=
unctions
> > that do a comparison of floating-point variables:
> >
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_bw_c=
alc_rq_dlg_ttu':
> > dcn_calcs.c:(.text+0x263): undefined reference to `__sanitizer_cov_trac=
e_cmpf'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `hack_for=
ce_pipe_split':
> > dcn_calcs.c:(.text+0x155b): undefined reference to `__sanitizer_cov_tra=
ce_cmpf'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_find=
_dcfclk_suits_all':
> > dcn_calcs.c:(.text+0x190e): undefined reference to `__sanitizer_cov_tra=
ce_cmpf'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_vali=
date_bandwidth':
> > dcn_calcs.c:(.text+0xe121): undefined reference to `__sanitizer_cov_tra=
ce_cmpd'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_=
bw_mod':
> > dcn_calc_math.c:(.text+0x22): undefined reference to `__sanitizer_cov_t=
race_cmpf'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_=
bw_min2':
> > dcn_calc_math.c:(.text+0xb2): undefined reference to `__sanitizer_cov_t=
race_cmpf'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_=
bw_ceil2':
> > dcn_calc_math.c:(.text+0x2a0): undefined reference to `__sanitizer_cov_=
trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_=
bw_max3':
> > dcn_calc_math.c:(.text+0x325): undefined reference to `__sanitizer_cov_=
trace_cmpf'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_=
bw_max5':
> > dcn_calc_math.c:(.text+0x3c3): undefined reference to `__sanitizer_cov_=
trace_cmpf'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_=
bw_log':
> > dcn_calc_math.c:(.text+0x54e): undefined reference to `__sanitizer_cov_=
trace_cmpd'
> > dcn_calc_math.c:(.text+0x57c): undefined reference to `__sanitizer_cov_=
trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `scal=
er_settings_calculation':
> > dcn_calc_auto.c:(.text+0x5c5): undefined reference to `__sanitizer_cov_=
trace_cmpf'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode=
_support_and_system_configuration':
> > dcn_calc_auto.c:(.text+0x137c): undefined reference to `__sanitizer_cov=
_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode=
_support_and_system_configuration':
> > dcn_calc_auto.c:(.text+0x9233): undefined reference to `__sanitizer_cov=
_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode=
_support_and_system_configuration':
> > dcn_calc_auto.c:(.text+0xb70f): undefined reference to `__sanitizer_cov=
_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode=
_support_and_system_configuration':
> > dcn_calc_auto.c:(.text+0x121fd): undefined reference to `__sanitizer_co=
v_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `disp=
lay_pipe_configuration':
> > dcn_calc_auto.c:(.text+0x15a2f): undefined reference to `__sanitizer_co=
v_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `disp=
clkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_c=
alculation':
> > dcn_calc_auto.c:(.text+0x17c2d): undefined reference to `__sanitizer_co=
v_trace_cmpf'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `disp=
clkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_c=
alculation':
> > dcn_calc_auto.c:(.text+0x19362): undefined reference to `__sanitizer_co=
v_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `disp=
clkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_c=
alculation':
> > dcn_calc_auto.c:(.text+0x25575): undefined reference to `__sanitizer_co=
v_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `disp=
clkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_c=
alculation':
> > dcn_calc_auto.c:(.text+0x27f33): undefined reference to `__sanitizer_co=
v_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `=
get_refcyc_per_delivery':
> > display_rq_dlg_calc.c:(.text+0xb5): undefined reference to `__sanitizer=
_cov_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `=
calculate_ttu_cursor.isra.1':
> > display_rq_dlg_calc.c:(.text+0x9f6): undefined reference to `__sanitize=
r_cov_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `=
dml_rq_dlg_get_dlg_params':
> > display_rq_dlg_calc.c:(.text+0x82cc): undefined reference to `__sanitiz=
er_cov_trace_cmpf'
> > drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In funct=
ion `get_refcyc_per_delivery.isra.0':
> > dml1_display_rq_dlg_calc.c:(.text+0x6c4): undefined reference to `__san=
itizer_cov_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In funct=
ion `get_vratio_pre.isra.2':
> > dml1_display_rq_dlg_calc.c:(.text+0x957): undefined reference to `__san=
itizer_cov_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In funct=
ion `get_swath_need.isra.3':
> > dml1_display_rq_dlg_calc.c:(.text+0xc8e): undefined reference to `__san=
itizer_cov_trace_cmpf'
> > drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In funct=
ion `dml1_extract_rq_regs':
> > dml1_display_rq_dlg_calc.c:(.text+0x30a8): undefined reference to `__sa=
nitizer_cov_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In funct=
ion `dml1_rq_dlg_get_dlg_params':
> > dml1_display_rq_dlg_calc.c:(.text+0x41ee): undefined reference to `__sa=
nitizer_cov_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In funct=
ion `dml1_rq_dlg_get_dlg_params':
> > dml1_display_rq_dlg_calc.c:(.text+0x8f95): undefined reference to `__sa=
nitizer_cov_trace_cmpf'
> > drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.o: In function `dml_=
round':
> > dml_common_defs.c:(.text+0x77): undefined reference to `__sanitizer_cov=
_trace_cmpd'
> > drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.o: In function `adj=
ust_ReturnBW':
> > display_mode_vba.c:(.text+0x4490): undefined reference to `__sanitizer_=
cov_trace_cmpd'
> >
> > We already prevent the driver from being built on non-x86 architectures
> > because of its use of floating-point arithmetic, this extends the
> > dependency to also cover Kcov-enabled builds, which arguably is a much
> > more severe limitation.
> >
> > I tried implementing the two functions in KCOV: __sanitizer_cov_trace_c=
mpd
> > and __sanitizer_cov_trace_cmpf, but that fails to build on architecture=
s
> > that do not support any floating-point functions, or would require maki=
ng
> > that code x86 specific as well.  I also looked at what it would take to
> > convert the code to fixed-point arithmetic, but quickly gave up. This
> > is probably the right approach, but it requires a non-trivial amount of
> > work and certainly won't be appropriate as a bugfix.
> >
> > Fixes: bf2e2e2e0ea9 ("drm/amd/display: Limit DCN to x86 arch")
> > Fixes: 4841203102a3 ("drm/amdgpu/display: Replace CONFIG_DRM_AMD_DC_DCN=
1_0 with CONFIG_X86")

Maybe it would be better to revert 4841203102a3 so we can limit the
scope of this to DCN support.

Alex


> > Link: drm: amd: dc: don't use FP math when Kcov is enabled
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v3: rebase on top of 4841203102a3, which removed the option for
> > CONFIG_DRM_AMD_DC_DCN1_0. The problem still gets hit occasionally
> > in randconfig testing.
> > ---
> >   drivers/gpu/drm/amd/display/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/=
display/Kconfig
> > index 325083b0297e..b132d434e572 100644
> > --- a/drivers/gpu/drm/amd/display/Kconfig
> > +++ b/drivers/gpu/drm/amd/display/Kconfig
> > @@ -3,6 +3,7 @@ menu "Display Engine Configuration"
> >
> >   config DRM_AMD_DC
> >       bool "AMD DC - Enable new display engine"
> > +     depends on !X86 || !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISO=
NS) || BROKEN
> >       default y
> >       help
> >         Choose this option if you want to use the new display engine
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
