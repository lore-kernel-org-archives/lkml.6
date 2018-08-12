Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ACAC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 07:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D426E2174A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 07:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Loe2Y6Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D426E2174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeHLKcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 06:32:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40477 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeHLKcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 06:32:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id y9-v6so5780650wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 00:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XoyvlWW++pDGbqS1UAE7FII3f6DTgzcVlA1aQ/ijrmo=;
        b=Loe2Y6Ep09s1jfPIqj949MbF/rHgjZVEF9BvHF1srm9WO3M82zDXaCoQdmv2OKl+U7
         x8+8A6lEj6RVKcnuATlECrYZTF5S0nOJqqOTcGBtv0mIcocI4bOsDee2Svhm0LJ5ssN3
         lwYOqbBXKAGFJ/skIJrcdq3jxiFFh5FKtE6fsqM5Ft783v8vZzs9gkwrCAECcVlrWg65
         yS5mkY/3rAxAU2NpX6MvXRQfEdvtZWHaoz2TAWZ0F+TBHOUfTM+D0mg2xdE0STp5Zq5C
         G6l4YioOhCc224m8TL+hmD/j+9EEtbVnhl6SdtW/Dqrb/L+MDzr6bYNS1vROnLMlAmFL
         i6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=XoyvlWW++pDGbqS1UAE7FII3f6DTgzcVlA1aQ/ijrmo=;
        b=Xn6kEmTmgxPqLJ/4Fi/nPt6rf9JJabRWJZ1KovxMOccu2mgRTm2IpVzEVL6ec2lC54
         behC+X4Eik2d11gP+g4kB2vhAq3uKTFwwu+w+/8SbsIRBiAyUlDaKcxKovuQHDxAcu1v
         +pyYhnrr0+mOmsujM4x/OwZUS2zjP87R8SMfMypLgcoe1xRVPoHjpe7B+ih2gpCR/8Qh
         jP6j1DRh8f5A8QdOGRO9kGbyKkT6FKeehorzaglEnNmCrKt1TmdZXE/bB6qzxqpvY7y0
         6g3VftfMnnWWlxcUnlf/BhgowbvFp3Skov1JytVZH6/hEVDCb0R0SUxvWrrAudgvPWIz
         D3hQ==
X-Gm-Message-State: AOUpUlHFBttFo+keQ6v6SBZt/zYv7gkogsBBNErtYniZ9eWDruL2MVCz
        eT8w7tdFZJfHMm+lCbrtfvv+tdAT
X-Google-Smtp-Source: AA+uWPw65K0DbnGrxlx00nKFY3e/oNznehAYknFP5zTbuiaxzaSl5D1OVtAbYgabMhNcSHKUWc2EdA==
X-Received: by 2002:a1c:ea17:: with SMTP id i23-v6mr5516856wmh.29.1534060513478;
        Sun, 12 Aug 2018 00:55:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id m35-v6sm30918209wrf.41.2018.08.12.00.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 00:55:12 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
To:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>
Cc:     David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Shirish S <shirish.s@amd.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        dri-devel@lists.freedesktop.org
References: <20180811155554.3382650-1-arnd@arndb.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <593dd8e1-fa23-3216-3550-274401d88bcb@gmail.com>
Date:   Sun, 12 Aug 2018 09:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180811155554.3382650-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Harry as well.

Am 11.08.2018 um 17:54 schrieb Arnd Bergmann:
> Building the DCN 1.0 Raven display driver with CONFIG_KCOV_INSTRUMENT_ALL=y
> and CONFIG_KCOV_ENABLE_COMPARISONS=y results in warnings about many functions
> that do a comparison of floating-point variables:
>
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_bw_calc_rq_dlg_ttu':
> dcn_calcs.c:(.text+0x263): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `hack_force_pipe_split':
> dcn_calcs.c:(.text+0x155b): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_find_dcfclk_suits_all':
> dcn_calcs.c:(.text+0x190e): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_validate_bandwidth':
> dcn_calcs.c:(.text+0xe121): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_mod':
> dcn_calc_math.c:(.text+0x22): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_min2':
> dcn_calc_math.c:(.text+0xb2): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_ceil2':
> dcn_calc_math.c:(.text+0x2a0): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_max3':
> dcn_calc_math.c:(.text+0x325): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_max5':
> dcn_calc_math.c:(.text+0x3c3): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_log':
> dcn_calc_math.c:(.text+0x54e): undefined reference to `__sanitizer_cov_trace_cmpd'
> dcn_calc_math.c:(.text+0x57c): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `scaler_settings_calculation':
> dcn_calc_auto.c:(.text+0x5c5): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
> dcn_calc_auto.c:(.text+0x137c): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
> dcn_calc_auto.c:(.text+0x9233): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
> dcn_calc_auto.c:(.text+0xb70f): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
> dcn_calc_auto.c:(.text+0x121fd): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `display_pipe_configuration':
> dcn_calc_auto.c:(.text+0x15a2f): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
> dcn_calc_auto.c:(.text+0x17c2d): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
> dcn_calc_auto.c:(.text+0x19362): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
> dcn_calc_auto.c:(.text+0x25575): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
> dcn_calc_auto.c:(.text+0x27f33): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `get_refcyc_per_delivery':
> display_rq_dlg_calc.c:(.text+0xb5): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `calculate_ttu_cursor.isra.1':
> display_rq_dlg_calc.c:(.text+0x9f6): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `dml_rq_dlg_get_dlg_params':
> display_rq_dlg_calc.c:(.text+0x82cc): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_refcyc_per_delivery.isra.0':
> dml1_display_rq_dlg_calc.c:(.text+0x6c4): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_vratio_pre.isra.2':
> dml1_display_rq_dlg_calc.c:(.text+0x957): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_swath_need.isra.3':
> dml1_display_rq_dlg_calc.c:(.text+0xc8e): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_extract_rq_regs':
> dml1_display_rq_dlg_calc.c:(.text+0x30a8): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_rq_dlg_get_dlg_params':
> dml1_display_rq_dlg_calc.c:(.text+0x41ee): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_rq_dlg_get_dlg_params':
> dml1_display_rq_dlg_calc.c:(.text+0x8f95): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.o: In function `dml_round':
> dml_common_defs.c:(.text+0x77): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.o: In function `adjust_ReturnBW':
> display_mode_vba.c:(.text+0x4490): undefined reference to `__sanitizer_cov_trace_cmpd'
>
> We already prevent the driver from being built on non-x86 architectures
> because of its use of floating-point arithmetic, this extends the
> dependency to also cover Kcov-enabled builds, which arguably is a much
> more severe limitation.
>
> I tried implementing the two functions in KCOV: __sanitizer_cov_trace_cmpd
> and __sanitizer_cov_trace_cmpf, but that fails to build on architectures
> that do not support any floating-point functions, or would require making
> that code x86 specific as well.  I also looked at what it would take to
> convert the code to fixed-point arithmetic, but quickly gave up. This
> is probably the right approach, but it requires a non-trivial amount of
> work and certainly won't be appropriate as a bugfix.
>
> Fixes: bf2e2e2e0ea9 ("drm/amd/display: Limit DCN to x86 arch")
> Fixes: 4841203102a3 ("drm/amdgpu/display: Replace CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86")
> Link: drm: amd: dc: don't use FP math when Kcov is enabled
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3: rebase on top of 4841203102a3, which removed the option for
> CONFIG_DRM_AMD_DC_DCN1_0. The problem still gets hit occasionally
> in randconfig testing.
> ---
>   drivers/gpu/drm/amd/display/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 325083b0297e..b132d434e572 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -3,6 +3,7 @@ menu "Display Engine Configuration"
>   
>   config DRM_AMD_DC
>   	bool "AMD DC - Enable new display engine"
> +	depends on !X86 || !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS) || BROKEN
>   	default y
>   	help
>   	  Choose this option if you want to use the new display engine

