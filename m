Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB24C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E5B21A13
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E5B21A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeHKSan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 14:30:43 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbeHKSam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 14:30:42 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LbJdK-1gCLXq0seY-00ktti; Sat, 11 Aug 2018 17:55:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Shirish S <shirish.s@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
Date:   Sat, 11 Aug 2018 17:54:12 +0200
Message-Id: <20180811155554.3382650-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:xadu5Mbisj0rdRv1SpZEDEGE/0LZVTOXKYr4TUKiBp2UotWWysF
 FbVRI+Fxl94VafIaaUyFnT5o1hCoQItOh8KqDP3+5bG7EiFqCuFQXbH380Lw2HfL9kPJJCv
 VpDXR9O4dZFnl1wPjGjEVLwsVOmapOrtRg2bH1ow2sT/3WGcK1A/ytUkjW2mxLm+MRbrBbB
 Kiha0AaRUHNGDXWJi6Tdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VYG+L64LzqE=:TNIlA1yBgeNESs0leETm6B
 /YusAmR8pmFJZznl9diTwQiJuxZGaOsC5ok63cghNBIQ1qMHWy6BO/FB4uM7mvz0nImBe0OZW
 F8ZQz5RpmUdB6lKfMhvXzGYtb2OivwifTjIak2vmi7vvSKqjmSMTQNRfJal+77X5TykrDd6zL
 MymjflEQ3ed08BPOgQV6YqVaLNba+OSNxdiQ284N2WOsDwz6p5VDdCHxwLS0gbT9gv01sSIvt
 mKOLp0SW3wRIVvUlWU6Hf8AtHa6UJE/ZAoIQ5Iw2y4wx6PtYBaI8hnbCKDgEcyl8XORJP1p8U
 Ln8w16yoCm/4CxlqZPnRF2uVGy0diF8wkmwLxMjrXvjfl0nJEnJmayzfTdSskDQpCaRh/RhrS
 YCT3N652BKkU4SP7IBBFKiqiFVLYzztxCVu9NC60NQxdnYiOt5g+giAHuXzVsX4u4Y5T7sqUn
 oqXIL3wrGbQoyTQVzTKNOzvvfUPrSk2OlThX0Nv7SDUZO0UWu5NFTU0VDsJ6MHlyzFIRmzpjI
 sQONdDMpBu+jdSgH7PBtIAgIWtLMKHGQ16xqeLJfitELOVx+Q8FAbYRdgHa5SRjbpH0hTvrun
 LHVzYZZJsWiYHJf7HIvBg1zeLfZj58huHQZ+lwKAYlCytfkX0p5CK7v6x4X5gc+q8xlAJB1uq
 nNlk/r4srwSaZiDFd49vtjN5jCWgC+CyTzgXKZe6FYZnjqIDGbMDc9NcmCXRwQfUzreg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the DCN 1.0 Raven display driver with CONFIG_KCOV_INSTRUMENT_ALL=y
and CONFIG_KCOV_ENABLE_COMPARISONS=y results in warnings about many functions
that do a comparison of floating-point variables:

drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_bw_calc_rq_dlg_ttu':
dcn_calcs.c:(.text+0x263): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `hack_force_pipe_split':
dcn_calcs.c:(.text+0x155b): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_find_dcfclk_suits_all':
dcn_calcs.c:(.text+0x190e): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_validate_bandwidth':
dcn_calcs.c:(.text+0xe121): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_mod':
dcn_calc_math.c:(.text+0x22): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_min2':
dcn_calc_math.c:(.text+0xb2): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_ceil2':
dcn_calc_math.c:(.text+0x2a0): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_max3':
dcn_calc_math.c:(.text+0x325): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_max5':
dcn_calc_math.c:(.text+0x3c3): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_log':
dcn_calc_math.c:(.text+0x54e): undefined reference to `__sanitizer_cov_trace_cmpd'
dcn_calc_math.c:(.text+0x57c): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `scaler_settings_calculation':
dcn_calc_auto.c:(.text+0x5c5): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
dcn_calc_auto.c:(.text+0x137c): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
dcn_calc_auto.c:(.text+0x9233): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
dcn_calc_auto.c:(.text+0xb70f): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
dcn_calc_auto.c:(.text+0x121fd): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `display_pipe_configuration':
dcn_calc_auto.c:(.text+0x15a2f): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
dcn_calc_auto.c:(.text+0x17c2d): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
dcn_calc_auto.c:(.text+0x19362): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
dcn_calc_auto.c:(.text+0x25575): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
dcn_calc_auto.c:(.text+0x27f33): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `get_refcyc_per_delivery':
display_rq_dlg_calc.c:(.text+0xb5): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `calculate_ttu_cursor.isra.1':
display_rq_dlg_calc.c:(.text+0x9f6): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `dml_rq_dlg_get_dlg_params':
display_rq_dlg_calc.c:(.text+0x82cc): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_refcyc_per_delivery.isra.0':
dml1_display_rq_dlg_calc.c:(.text+0x6c4): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_vratio_pre.isra.2':
dml1_display_rq_dlg_calc.c:(.text+0x957): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_swath_need.isra.3':
dml1_display_rq_dlg_calc.c:(.text+0xc8e): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_extract_rq_regs':
dml1_display_rq_dlg_calc.c:(.text+0x30a8): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_rq_dlg_get_dlg_params':
dml1_display_rq_dlg_calc.c:(.text+0x41ee): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_rq_dlg_get_dlg_params':
dml1_display_rq_dlg_calc.c:(.text+0x8f95): undefined reference to `__sanitizer_cov_trace_cmpf'
drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.o: In function `dml_round':
dml_common_defs.c:(.text+0x77): undefined reference to `__sanitizer_cov_trace_cmpd'
drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.o: In function `adjust_ReturnBW':
display_mode_vba.c:(.text+0x4490): undefined reference to `__sanitizer_cov_trace_cmpd'

We already prevent the driver from being built on non-x86 architectures
because of its use of floating-point arithmetic, this extends the
dependency to also cover Kcov-enabled builds, which arguably is a much
more severe limitation.

I tried implementing the two functions in KCOV: __sanitizer_cov_trace_cmpd
and __sanitizer_cov_trace_cmpf, but that fails to build on architectures
that do not support any floating-point functions, or would require making
that code x86 specific as well.  I also looked at what it would take to
convert the code to fixed-point arithmetic, but quickly gave up. This
is probably the right approach, but it requires a non-trivial amount of
work and certainly won't be appropriate as a bugfix.

Fixes: bf2e2e2e0ea9 ("drm/amd/display: Limit DCN to x86 arch")
Fixes: 4841203102a3 ("drm/amdgpu/display: Replace CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86")
Link: drm: amd: dc: don't use FP math when Kcov is enabled
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: rebase on top of 4841203102a3, which removed the option for
CONFIG_DRM_AMD_DC_DCN1_0. The problem still gets hit occasionally
in randconfig testing.
---
 drivers/gpu/drm/amd/display/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 325083b0297e..b132d434e572 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -3,6 +3,7 @@ menu "Display Engine Configuration"
 
 config DRM_AMD_DC
 	bool "AMD DC - Enable new display engine"
+	depends on !X86 || !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS) || BROKEN
 	default y
 	help
 	  Choose this option if you want to use the new display engine
-- 
2.18.0

