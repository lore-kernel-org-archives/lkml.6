Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CCCC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C87727473
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C87727473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964817AbeF2IYM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:24:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:55528 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934876AbeF2IYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:24:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 01:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="68296855"
Received: from jnikula-mobl2.fi.intel.com (HELO localhost) ([10.237.72.62])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2018 01:23:58 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/i915: Mark expected switch fall-throughs
In-Reply-To: <20180628223541.GA17665@embeddedor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180628223541.GA17665@embeddedor.com>
Date:   Fri, 29 Jun 2018 11:23:46 +0300
Message-ID: <87efgqrofh.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Addresses-Coverity-ID: 141432
> Addresses-Coverity-ID: 141433
> Addresses-Coverity-ID: 141434
> Addresses-Coverity-ID: 141435
> Addresses-Coverity-ID: 141436
> Addresses-Coverity-ID: 1357360
> Addresses-Coverity-ID: 1357403
> Addresses-Coverity-ID: 1357433
> Addresses-Coverity-ID: 1392622
> Addresses-Coverity-ID: 1415273
> Addresses-Coverity-ID: 1435752
> Addresses-Coverity-ID: 1441500
> Addresses-Coverity-ID: 1454596
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Jani Nikula <jani.nikula@intel.com>

I'll let others chime in before merging.

BR,
Jani.


> ---
>  drivers/gpu/drm/i915/i915_gem.c         | 1 +
>  drivers/gpu/drm/i915/i915_gem_stolen.c  | 1 +
>  drivers/gpu/drm/i915/intel_cdclk.c      | 5 +++++
>  drivers/gpu/drm/i915/intel_ddi.c        | 1 +
>  drivers/gpu/drm/i915/intel_display.c    | 2 ++
>  drivers/gpu/drm/i915/intel_dpll_mgr.c   | 3 +++
>  drivers/gpu/drm/i915/intel_drv.h        | 1 +
>  drivers/gpu/drm/i915/intel_engine_cs.c  | 1 +
>  drivers/gpu/drm/i915/intel_runtime_pm.c | 1 +
>  drivers/gpu/drm/i915/intel_sdvo.c       | 6 ++++++
>  10 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
> index 4cb720b..ed7bb24 100644
> --- a/drivers/gpu/drm/i915/i915_gem.c
> +++ b/drivers/gpu/drm/i915/i915_gem.c
> @@ -2114,6 +2114,7 @@ vm_fault_t i915_gem_fault(struct vm_fault *vmf)
>  		 */
>  		if (!i915_terminally_wedged(&dev_priv->gpu_error))
>  			return VM_FAULT_SIGBUS;
> +		/* else: fall through */
>  	case -EAGAIN:
>  		/*
>  		 * EAGAIN means the gpu is hung and we'll wait for the error
> diff --git a/drivers/gpu/drm/i915/i915_gem_stolen.c b/drivers/gpu/drm/i915/i915_gem_stolen.c
> index 79a34729..055f868 100644
> --- a/drivers/gpu/drm/i915/i915_gem_stolen.c
> +++ b/drivers/gpu/drm/i915/i915_gem_stolen.c
> @@ -254,6 +254,7 @@ static void vlv_get_stolen_reserved(struct drm_i915_private *dev_priv,
>  	switch (reg_val & GEN7_STOLEN_RESERVED_SIZE_MASK) {
>  	default:
>  		MISSING_CASE(reg_val & GEN7_STOLEN_RESERVED_SIZE_MASK);
> +		/* fall through */
>  	case GEN7_STOLEN_RESERVED_1M:
>  		*size = 1024 * 1024;
>  		break;
> diff --git a/drivers/gpu/drm/i915/intel_cdclk.c b/drivers/gpu/drm/i915/intel_cdclk.c
> index bf9433d..29075c7 100644
> --- a/drivers/gpu/drm/i915/intel_cdclk.c
> +++ b/drivers/gpu/drm/i915/intel_cdclk.c
> @@ -316,6 +316,7 @@ static void pnv_get_cdclk(struct drm_i915_private *dev_priv,
>  		break;
>  	default:
>  		DRM_ERROR("Unknown pnv display core clock 0x%04x\n", gcfgc);
> +		/* fall through */
>  	case GC_DISPLAY_CLOCK_133_MHZ_PNV:
>  		cdclk_state->cdclk = 133333;
>  		break;
> @@ -1797,6 +1798,7 @@ static int icl_calc_cdclk(int min_cdclk, unsigned int ref)
>  	switch (ref) {
>  	default:
>  		MISSING_CASE(ref);
> +		/* fall through */
>  	case 24000:
>  		ranges = ranges_24;
>  		break;
> @@ -1824,6 +1826,7 @@ static int icl_calc_cdclk_pll_vco(struct drm_i915_private *dev_priv, int cdclk)
>  	switch (cdclk) {
>  	default:
>  		MISSING_CASE(cdclk);
> +		/* fall through */
>  	case 307200:
>  	case 556800:
>  	case 652800:
> @@ -1896,6 +1899,7 @@ static u8 icl_calc_voltage_level(int cdclk)
>  		return 1;
>  	default:
>  		MISSING_CASE(cdclk);
> +		/* fall through */
>  	case 652800:
>  	case 648000:
>  		return 2;
> @@ -1913,6 +1917,7 @@ static void icl_get_cdclk(struct drm_i915_private *dev_priv,
>  	switch (val & ICL_DSSM_CDCLK_PLL_REFCLK_MASK) {
>  	default:
>  		MISSING_CASE(val);
> +		/* fall through */
>  	case ICL_DSSM_CDCLK_PLL_REFCLK_24MHz:
>  		cdclk_state->ref = 24000;
>  		break;
> diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
> index 0319825..c74b01a 100644
> --- a/drivers/gpu/drm/i915/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/intel_ddi.c
> @@ -1069,6 +1069,7 @@ static uint32_t icl_pll_to_ddi_pll_sel(struct intel_encoder *encoder,
>  	switch (id) {
>  	default:
>  		MISSING_CASE(id);
> +		/* fall through */
>  	case DPLL_ID_ICL_DPLL0:
>  	case DPLL_ID_ICL_DPLL1:
>  		return DDI_CLK_SEL_NONE;
> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> index eaa0663..d3f2cf6 100644
> --- a/drivers/gpu/drm/i915/intel_display.c
> +++ b/drivers/gpu/drm/i915/intel_display.c
> @@ -9359,6 +9359,7 @@ static bool hsw_get_transcoder_state(struct intel_crtc *crtc,
>  		switch (tmp & TRANS_DDI_EDP_INPUT_MASK) {
>  		default:
>  			WARN(1, "unknown pipe linked to edp transcoder\n");
> +			/* fall through */
>  		case TRANS_DDI_EDP_INPUT_A_ONOFF:
>  		case TRANS_DDI_EDP_INPUT_A_ON:
>  			trans_edp_pipe = PIPE_A;
> @@ -11023,6 +11024,7 @@ static bool check_digital_port_conflicts(struct drm_atomic_state *state)
>  		case INTEL_OUTPUT_DDI:
>  			if (WARN_ON(!HAS_DDI(to_i915(dev))))
>  				break;
> +			/* else: fall through */
>  		case INTEL_OUTPUT_DP:
>  		case INTEL_OUTPUT_HDMI:
>  		case INTEL_OUTPUT_EDP:
> diff --git a/drivers/gpu/drm/i915/intel_dpll_mgr.c b/drivers/gpu/drm/i915/intel_dpll_mgr.c
> index 5734236..058696b 100644
> --- a/drivers/gpu/drm/i915/intel_dpll_mgr.c
> +++ b/drivers/gpu/drm/i915/intel_dpll_mgr.c
> @@ -2566,6 +2566,7 @@ int icl_calc_dp_combo_pll_link(struct drm_i915_private *dev_priv,
>  	switch (index) {
>  	default:
>  		MISSING_CASE(index);
> +		/* fall through */
>  	case 0:
>  		link_clock = 540000;
>  		break;
> @@ -2639,6 +2640,7 @@ static bool icl_mg_pll_find_divisors(int clock_khz, bool is_dp, bool use_ssc,
>  			switch (div1) {
>  			default:
>  				MISSING_CASE(div1);
> +				/* fall through */
>  			case 2:
>  				hsdiv = 0;
>  				break;
> @@ -2903,6 +2905,7 @@ static i915_reg_t icl_pll_id_to_enable_reg(enum intel_dpll_id id)
>  	switch (id) {
>  	default:
>  		MISSING_CASE(id);
> +		/* fall through */
>  	case DPLL_ID_ICL_DPLL0:
>  	case DPLL_ID_ICL_DPLL1:
>  		return CNL_DPLL_ENABLE(id);
> diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
> index a6ff260..3cb6e87 100644
> --- a/drivers/gpu/drm/i915/intel_drv.h
> +++ b/drivers/gpu/drm/i915/intel_drv.h
> @@ -1254,6 +1254,7 @@ enc_to_dig_port(struct drm_encoder *encoder)
>  	switch (intel_encoder->type) {
>  	case INTEL_OUTPUT_DDI:
>  		WARN_ON(!HAS_DDI(to_i915(encoder->dev)));
> +		/* fall through */
>  	case INTEL_OUTPUT_DP:
>  	case INTEL_OUTPUT_EDP:
>  	case INTEL_OUTPUT_HDMI:
> diff --git a/drivers/gpu/drm/i915/intel_engine_cs.c b/drivers/gpu/drm/i915/intel_engine_cs.c
> index d3264bd..d2ed44d 100644
> --- a/drivers/gpu/drm/i915/intel_engine_cs.c
> +++ b/drivers/gpu/drm/i915/intel_engine_cs.c
> @@ -230,6 +230,7 @@ __intel_engine_context_size(struct drm_i915_private *dev_priv, u8 class)
>  		break;
>  	default:
>  		MISSING_CASE(class);
> +		/* fall through */
>  	case VIDEO_DECODE_CLASS:
>  	case VIDEO_ENHANCEMENT_CLASS:
>  	case COPY_ENGINE_CLASS:
> diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
> index d81b2cf..6b5aa3b 100644
> --- a/drivers/gpu/drm/i915/intel_runtime_pm.c
> +++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
> @@ -3212,6 +3212,7 @@ static void cnl_set_procmon_ref_values(struct drm_i915_private *dev_priv,
>  	switch (val & (PROCESS_INFO_MASK | VOLTAGE_INFO_MASK)) {
>  	default:
>  		MISSING_CASE(val);
> +		/* fall through */
>  	case VOLTAGE_INFO_0_85V | PROCESS_INFO_DOT_0:
>  		procmon = &cnl_procmon_values[PROCMON_0_85V_DOT_0];
>  		break;
> diff --git a/drivers/gpu/drm/i915/intel_sdvo.c b/drivers/gpu/drm/i915/intel_sdvo.c
> index e6a64b3..a7f4a56 100644
> --- a/drivers/gpu/drm/i915/intel_sdvo.c
> +++ b/drivers/gpu/drm/i915/intel_sdvo.c
> @@ -1340,6 +1340,7 @@ static void intel_sdvo_pre_enable(struct intel_encoder *intel_encoder,
>  	switch (crtc_state->pixel_multiplier) {
>  	default:
>  		WARN(1, "unknown pixel multiplier specified\n");
> +		/* fall through */
>  	case 1: rate = SDVO_CLOCK_RATE_MULT_1X; break;
>  	case 2: rate = SDVO_CLOCK_RATE_MULT_2X; break;
>  	case 4: rate = SDVO_CLOCK_RATE_MULT_4X; break;
> @@ -2316,14 +2317,19 @@ intel_sdvo_guess_ddc_bus(struct intel_sdvo *sdvo)
>  	switch (sdvo->controlled_output) {
>  	case SDVO_OUTPUT_LVDS1:
>  		mask |= SDVO_OUTPUT_LVDS1;
> +		/* fall through */
>  	case SDVO_OUTPUT_LVDS0:
>  		mask |= SDVO_OUTPUT_LVDS0;
> +		/* fall through */
>  	case SDVO_OUTPUT_TMDS1:
>  		mask |= SDVO_OUTPUT_TMDS1;
> +		/* fall through */
>  	case SDVO_OUTPUT_TMDS0:
>  		mask |= SDVO_OUTPUT_TMDS0;
> +		/* fall through */
>  	case SDVO_OUTPUT_RGB1:
>  		mask |= SDVO_OUTPUT_RGB1;
> +		/* fall through */
>  	case SDVO_OUTPUT_RGB0:
>  		mask |= SDVO_OUTPUT_RGB0;
>  		break;

-- 
Jani Nikula, Intel Open Source Graphics Center
