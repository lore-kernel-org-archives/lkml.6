Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FECC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBBC2083C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jWaHHy3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBBC2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbeHOTLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:11:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbeHOTLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1IZUNF4mK/++8fJ38r8VHIgdIfAslkne+3tgesHeekQ=; b=jWaHHy3MuKlmWxD0EU+zyQbzY
        WH/F6OKAucMGJ/7nkN/afWmc9A0QgPidVO/fUuB3eRld4nGH8t8R+ojNDmWH9z2Flsxd5tM1+BJPH
        fyXDquzgolcU7J4PwsyBcTCKMG9w+0VBAim2NVEai0kL6DjgNNlhrEt10V6dJIYGSEEqmqX4FMU62
        KyjjlWc6Uc8XTdg2PEWr06ei4vHDzEZn0KtQ/QAkdQmLyNzzAE/91xHP6c0C/YsjD4mVRtKGYjoO6
        pLRtoXkFIKK72cLJCwxr59wV2e02LKoIhI0FyLWr1a/0LLHYOfSIUjK0IJ7fzSPB6vJhv0ICxRZ0g
        2+DHSF+ig==;
Received: from 177.17.130.144.dynamic.adsl.gvt.net.br ([177.17.130.144] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpyVU-0001vT-Pj; Wed, 15 Aug 2018 16:18:49 +0000
Date:   Wed, 15 Aug 2018 13:18:44 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@amd.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Shirish S <shirish.s@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: allmodconfig/allyesconfig doesn't work with Kernel 4.18 - Was: Re:
 [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
Message-ID: <20180815131844.52669784@coco.lan>
In-Reply-To: <20180811155554.3382650-1-arnd@arndb.de>
References: <20180811155554.3382650-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 11 Aug 2018 17:54:12 +0200
Arnd Bergmann <arnd@arndb.de> escreveu:

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

Here, I'm getting this with allyesconfig and allmodconfig, on x86_64, with
gcc (GCC) 8.1.1 20180712 (Red Hat 8.1.1-5), with Kernel 4.18.

Please apply this patch upstream - or some other approach that would allow
allyesconfig/allmodconfig to work again, as not being able to build the
Kernel with those prevents us to see potential bugs on other drivers.

See ktest.pl relevant logs:

TEST 1 OPTIONS
ARCH[1] = x86_64
BUILD_TYPE[1] = allmodconfig
...
RUNNING TEST 1 of 19 (x86_64 ) with option build allmodconfig
...
Kernel: arch/x86/boot/bzImage is ready  (#1)
ERROR: "__sanitizer_cov_trace_cmpd" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__sanitizer_cov_trace_cmpf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
make[2]: *** [/devel/v4l/to_next/scripts/Makefile.modpost:92: __modpost] Error 1
make[1]: *** [/devel/v4l/to_next/Makefile:1208: modules] Error 2
make[1]: Leaving directory '/devel/v4l/ktests/ktest-cross-compile'
make: *** [Makefile:146: sub-make] Error 2
[679 seconds] FAILED!
FAILED: failed build
...
TEST 8 OPTIONS
ARCH[8] = x86_64
BUILD_TYPE[8] = allyesconfig
CROSS[8] = 
MAKE_CMD[8] = make ARCH=x86_64 KCONFIG_ALLCONFIG=/devel/v4l/ktests/config-compiletest
...
MODPOST vmlinux.o
drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_bw_calc_rq_dlg_ttu':
dcn_calcs.c:(.text+0x214): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calcs.c:(.text+0x54a): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calcs.c:(.text+0x611): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_find_dcfclk_suits_all':
dcn_calcs.c:(.text+0xea6): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calcs.c:(.text+0xeef): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calcs.c:(.text+0xf38): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calcs.c:(.text+0xf7a): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calcs.c:(.text+0x1014): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o:dcn_calcs.c:(.text+0x105d): more undefined references to `__sanitizer_cov_trace_cmpf' follow
drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_validate_bandwidth':
dcn_calcs.c:(.text+0x6d2b): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calcs.c:(.text+0x6e6f): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calcs.c:(.text+0x6ef7): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calcs.c:(.text+0x6f77): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calcs.c:(.text+0x7181): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calcs.c:(.text+0x7673): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o:dcn_calc_math.c:(.text+0x27): more undefined references to `__sanitizer_cov_trace_cmpf' follow
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_ceil2':
dcn_calc_math.c:(.text+0x34d): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_max3':
dcn_calc_math.c:(.text+0x3cd): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_math.c:(.text+0x3f8): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_math.c:(.text+0x41b): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_math.c:(.text+0x43e): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_math.c:(.text+0x47d): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o:dcn_calc_math.c:(.text+0x49d): more undefined references to `__sanitizer_cov_trace_cmpf' follow
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_log':
dcn_calc_math.c:(.text+0xb5e): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_math.c:(.text+0xb8c): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `scaler_settings_calculation':
dcn_calc_auto.c:(.text+0x164): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x1cb): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x49a): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x55b): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x586): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o:dcn_calc_auto.c:(.text+0x6f4): more undefined references to `__sanitizer_cov_trace_cmpf' follow
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
dcn_calc_auto.c:(.text+0xb99): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x182e): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x1980): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x19af): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x1b49): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x1cab): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x1cd6): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x1e0c): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x1e8b): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x20c2): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x223f): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x266e): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x26a5): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x27c8): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x2901): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x2965): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x2c54): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x3265): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x32a2): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x3321): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x34d4): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o:dcn_calc_auto.c:(.text+0x35d7): more undefined references to `__sanitizer_cov_trace_cmpf' follow
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
dcn_calc_auto.c:(.text+0x4363): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x4682): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x494b): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x49ce): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x4d78): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x4f1c): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o:dcn_calc_auto.c:(.text+0x4f65): more undefined references to `__sanitizer_cov_trace_cmpf' follow
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
dcn_calc_auto.c:(.text+0x5091): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x578b): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x598f): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x67e0): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x6d5e): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x733f): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x73a1): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x745a): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x74bc): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x76b6): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x775e): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x77c0): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x7879): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x78db): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x80b7): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x8c6a): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x8ce9): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x8d2f): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x8d6f): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o:dcn_calc_auto.c:(.text+0x8dd9): more undefined references to `__sanitizer_cov_trace_cmpf' follow
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
dcn_calc_auto.c:(.text+0xacfa): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0xb1ed): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xbd73): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `display_pipe_configuration':
dcn_calc_auto.c:(.text+0xc51d): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xc6a5): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0xc732): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xcb77): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xd351): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xd376): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xd3d6): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
dcn_calc_auto.c:(.text+0xda16): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xdab4): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xde82): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xeb8c): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xed71): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xedb6): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0xf399): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xf627): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xf7f5): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xf8c3): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0xfd1b): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o:dcn_calc_auto.c:(.text+0x1019d): more undefined references to `__sanitizer_cov_trace_cmpf' follow
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
dcn_calc_auto.c:(.text+0x1380c): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x1389c): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x1391b): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x13981): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x13a0f): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x1429e): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x14555): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x146bd): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x14772): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o:dcn_calc_auto.c:(.text+0x147b3): more undefined references to `__sanitizer_cov_trace_cmpf' follow
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
dcn_calc_auto.c:(.text+0x14e7e): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x15068): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x150e1): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x15225): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x157a0): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x157c8): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x1580f): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x15cc5): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x15cf6): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x15d8b): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x15e55): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x15e99): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o:dcn_calc_auto.c:(.text+0x1622d): more undefined references to `__sanitizer_cov_trace_cmpf' follow
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
dcn_calc_auto.c:(.text+0x16835): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_auto.c:(.text+0x169a4): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x169cd): undefined reference to `__sanitizer_cov_trace_cmpf'
dcn_calc_auto.c:(.text+0x16af3): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_refcyc_per_delivery.isra.0':
dml1_display_rq_dlg_calc.c:(.text+0x187): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_vratio_pre.isra.2':
dml1_display_rq_dlg_calc.c:(.text+0x431): undefined reference to `__sanitizer_cov_trace_cmpd'
dml1_display_rq_dlg_calc.c:(.text+0x4ae): undefined reference to `__sanitizer_cov_trace_cmpd'
dml1_display_rq_dlg_calc.c:(.text+0x4e2): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_swath_need.isra.4':
dml1_display_rq_dlg_calc.c:(.text+0x713): undefined reference to `__sanitizer_cov_trace_cmpf'
dml1_display_rq_dlg_calc.c:(.text+0x73e): undefined reference to `__sanitizer_cov_trace_cmpf'
dml1_display_rq_dlg_calc.c:(.text+0x7ce): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_extract_rq_regs':
dml1_display_rq_dlg_calc.c:(.text+0x2fbe): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_rq_dlg_get_dlg_params':
dml1_display_rq_dlg_calc.c:(.text+0x3d0f): undefined reference to `__sanitizer_cov_trace_cmpd'
dml1_display_rq_dlg_calc.c:(.text+0x47c7): undefined reference to `__sanitizer_cov_trace_cmpd'
dml1_display_rq_dlg_calc.c:(.text+0x4f7b): undefined reference to `__sanitizer_cov_trace_cmpd'
dml1_display_rq_dlg_calc.c:(.text+0x4fa1): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o:dml1_display_rq_dlg_calc.c:(.text+0x4fd7): more undefined references to `__sanitizer_cov_trace_cmpd' follow
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_rq_dlg_get_dlg_params':
dml1_display_rq_dlg_calc.c:(.text+0x5e2e): undefined reference to `__sanitizer_cov_trace_cmpf'
dml1_display_rq_dlg_calc.c:(.text+0x5ee1): undefined reference to `__sanitizer_cov_trace_cmpd'
dml1_display_rq_dlg_calc.c:(.text+0x5fff): undefined reference to `__sanitizer_cov_trace_cmpd'
dml1_display_rq_dlg_calc.c:(.text+0x745d): undefined reference to `__sanitizer_cov_trace_cmpd'
dml1_display_rq_dlg_calc.c:(.text+0x74ac): undefined reference to `__sanitizer_cov_trace_cmpd'
dml1_display_rq_dlg_calc.c:(.text+0x7821): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o:dml1_display_rq_dlg_calc.c:(.text+0x785e): more undefined references to `__sanitizer_cov_trace_cmpd' follow
make[1]: *** [/devel/v4l/to_next/Makefile:1006: vmlinux] Error 1
make[1]: Leaving directory '/devel/v4l/ktests/ktest-cross-compile'
make: *** [Makefile:146: sub-make] Error 2
[686 seconds] FAILED!
FAILED: failed build

With Arnd's patch applied, allmodconfig/allyesconfig works again:

RUNNING TEST 1 of 19 (x86_64 ) with option build allmodconfig
KTEST RESULT: TEST 1 (x86_64 ) SUCCESS!!!!         **
RUNNING TEST 8 of 19 (x86_64 ) with option build allyesconfig
KTEST RESULT: TEST 8 (x86_64 ) SUCCESS!!!!         **



> ---
>  drivers/gpu/drm/amd/display/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 325083b0297e..b132d434e572 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -3,6 +3,7 @@ menu "Display Engine Configuration"
>  
>  config DRM_AMD_DC
>  	bool "AMD DC - Enable new display engine"
> +	depends on !X86 || !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS) || BROKEN
>  	default y
>  	help
>  	  Choose this option if you want to use the new display engine



Thanks,
Mauro
