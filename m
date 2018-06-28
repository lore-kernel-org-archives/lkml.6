Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D94C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC58127A47
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC58127A47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754993AbeF1W5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:57:22 -0400
Received: from gateway36.websitewelcome.com ([192.185.186.5]:17813 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753832AbeF1W5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:57:21 -0400
X-Greylist: delayed 1297 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2018 18:57:21 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 116DE401129F0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 16:36:10 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YfVvf6DEwSjJAYfVvfc5go; Thu, 28 Jun 2018 17:35:43 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=35422 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fYfVu-001tAM-NQ; Thu, 28 Jun 2018 17:35:42 -0500
Date:   Thu, 28 Jun 2018 17:35:41 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/i915: Mark expected switch fall-throughs
Message-ID: <20180628223541.GA17665@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fYfVu-001tAM-NQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:35422
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 141432
Addresses-Coverity-ID: 141433
Addresses-Coverity-ID: 141434
Addresses-Coverity-ID: 141435
Addresses-Coverity-ID: 141436
Addresses-Coverity-ID: 1357360
Addresses-Coverity-ID: 1357403
Addresses-Coverity-ID: 1357433
Addresses-Coverity-ID: 1392622
Addresses-Coverity-ID: 1415273
Addresses-Coverity-ID: 1435752
Addresses-Coverity-ID: 1441500
Addresses-Coverity-ID: 1454596
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/i915_gem.c         | 1 +
 drivers/gpu/drm/i915/i915_gem_stolen.c  | 1 +
 drivers/gpu/drm/i915/intel_cdclk.c      | 5 +++++
 drivers/gpu/drm/i915/intel_ddi.c        | 1 +
 drivers/gpu/drm/i915/intel_display.c    | 2 ++
 drivers/gpu/drm/i915/intel_dpll_mgr.c   | 3 +++
 drivers/gpu/drm/i915/intel_drv.h        | 1 +
 drivers/gpu/drm/i915/intel_engine_cs.c  | 1 +
 drivers/gpu/drm/i915/intel_runtime_pm.c | 1 +
 drivers/gpu/drm/i915/intel_sdvo.c       | 6 ++++++
 10 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 4cb720b..ed7bb24 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -2114,6 +2114,7 @@ vm_fault_t i915_gem_fault(struct vm_fault *vmf)
 		 */
 		if (!i915_terminally_wedged(&dev_priv->gpu_error))
 			return VM_FAULT_SIGBUS;
+		/* else: fall through */
 	case -EAGAIN:
 		/*
 		 * EAGAIN means the gpu is hung and we'll wait for the error
diff --git a/drivers/gpu/drm/i915/i915_gem_stolen.c b/drivers/gpu/drm/i915/i915_gem_stolen.c
index 79a34729..055f868 100644
--- a/drivers/gpu/drm/i915/i915_gem_stolen.c
+++ b/drivers/gpu/drm/i915/i915_gem_stolen.c
@@ -254,6 +254,7 @@ static void vlv_get_stolen_reserved(struct drm_i915_private *dev_priv,
 	switch (reg_val & GEN7_STOLEN_RESERVED_SIZE_MASK) {
 	default:
 		MISSING_CASE(reg_val & GEN7_STOLEN_RESERVED_SIZE_MASK);
+		/* fall through */
 	case GEN7_STOLEN_RESERVED_1M:
 		*size = 1024 * 1024;
 		break;
diff --git a/drivers/gpu/drm/i915/intel_cdclk.c b/drivers/gpu/drm/i915/intel_cdclk.c
index bf9433d..29075c7 100644
--- a/drivers/gpu/drm/i915/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/intel_cdclk.c
@@ -316,6 +316,7 @@ static void pnv_get_cdclk(struct drm_i915_private *dev_priv,
 		break;
 	default:
 		DRM_ERROR("Unknown pnv display core clock 0x%04x\n", gcfgc);
+		/* fall through */
 	case GC_DISPLAY_CLOCK_133_MHZ_PNV:
 		cdclk_state->cdclk = 133333;
 		break;
@@ -1797,6 +1798,7 @@ static int icl_calc_cdclk(int min_cdclk, unsigned int ref)
 	switch (ref) {
 	default:
 		MISSING_CASE(ref);
+		/* fall through */
 	case 24000:
 		ranges = ranges_24;
 		break;
@@ -1824,6 +1826,7 @@ static int icl_calc_cdclk_pll_vco(struct drm_i915_private *dev_priv, int cdclk)
 	switch (cdclk) {
 	default:
 		MISSING_CASE(cdclk);
+		/* fall through */
 	case 307200:
 	case 556800:
 	case 652800:
@@ -1896,6 +1899,7 @@ static u8 icl_calc_voltage_level(int cdclk)
 		return 1;
 	default:
 		MISSING_CASE(cdclk);
+		/* fall through */
 	case 652800:
 	case 648000:
 		return 2;
@@ -1913,6 +1917,7 @@ static void icl_get_cdclk(struct drm_i915_private *dev_priv,
 	switch (val & ICL_DSSM_CDCLK_PLL_REFCLK_MASK) {
 	default:
 		MISSING_CASE(val);
+		/* fall through */
 	case ICL_DSSM_CDCLK_PLL_REFCLK_24MHz:
 		cdclk_state->ref = 24000;
 		break;
diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
index 0319825..c74b01a 100644
--- a/drivers/gpu/drm/i915/intel_ddi.c
+++ b/drivers/gpu/drm/i915/intel_ddi.c
@@ -1069,6 +1069,7 @@ static uint32_t icl_pll_to_ddi_pll_sel(struct intel_encoder *encoder,
 	switch (id) {
 	default:
 		MISSING_CASE(id);
+		/* fall through */
 	case DPLL_ID_ICL_DPLL0:
 	case DPLL_ID_ICL_DPLL1:
 		return DDI_CLK_SEL_NONE;
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index eaa0663..d3f2cf6 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -9359,6 +9359,7 @@ static bool hsw_get_transcoder_state(struct intel_crtc *crtc,
 		switch (tmp & TRANS_DDI_EDP_INPUT_MASK) {
 		default:
 			WARN(1, "unknown pipe linked to edp transcoder\n");
+			/* fall through */
 		case TRANS_DDI_EDP_INPUT_A_ONOFF:
 		case TRANS_DDI_EDP_INPUT_A_ON:
 			trans_edp_pipe = PIPE_A;
@@ -11023,6 +11024,7 @@ static bool check_digital_port_conflicts(struct drm_atomic_state *state)
 		case INTEL_OUTPUT_DDI:
 			if (WARN_ON(!HAS_DDI(to_i915(dev))))
 				break;
+			/* else: fall through */
 		case INTEL_OUTPUT_DP:
 		case INTEL_OUTPUT_HDMI:
 		case INTEL_OUTPUT_EDP:
diff --git a/drivers/gpu/drm/i915/intel_dpll_mgr.c b/drivers/gpu/drm/i915/intel_dpll_mgr.c
index 5734236..058696b 100644
--- a/drivers/gpu/drm/i915/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/intel_dpll_mgr.c
@@ -2566,6 +2566,7 @@ int icl_calc_dp_combo_pll_link(struct drm_i915_private *dev_priv,
 	switch (index) {
 	default:
 		MISSING_CASE(index);
+		/* fall through */
 	case 0:
 		link_clock = 540000;
 		break;
@@ -2639,6 +2640,7 @@ static bool icl_mg_pll_find_divisors(int clock_khz, bool is_dp, bool use_ssc,
 			switch (div1) {
 			default:
 				MISSING_CASE(div1);
+				/* fall through */
 			case 2:
 				hsdiv = 0;
 				break;
@@ -2903,6 +2905,7 @@ static i915_reg_t icl_pll_id_to_enable_reg(enum intel_dpll_id id)
 	switch (id) {
 	default:
 		MISSING_CASE(id);
+		/* fall through */
 	case DPLL_ID_ICL_DPLL0:
 	case DPLL_ID_ICL_DPLL1:
 		return CNL_DPLL_ENABLE(id);
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index a6ff260..3cb6e87 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -1254,6 +1254,7 @@ enc_to_dig_port(struct drm_encoder *encoder)
 	switch (intel_encoder->type) {
 	case INTEL_OUTPUT_DDI:
 		WARN_ON(!HAS_DDI(to_i915(encoder->dev)));
+		/* fall through */
 	case INTEL_OUTPUT_DP:
 	case INTEL_OUTPUT_EDP:
 	case INTEL_OUTPUT_HDMI:
diff --git a/drivers/gpu/drm/i915/intel_engine_cs.c b/drivers/gpu/drm/i915/intel_engine_cs.c
index d3264bd..d2ed44d 100644
--- a/drivers/gpu/drm/i915/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/intel_engine_cs.c
@@ -230,6 +230,7 @@ __intel_engine_context_size(struct drm_i915_private *dev_priv, u8 class)
 		break;
 	default:
 		MISSING_CASE(class);
+		/* fall through */
 	case VIDEO_DECODE_CLASS:
 	case VIDEO_ENHANCEMENT_CLASS:
 	case COPY_ENGINE_CLASS:
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index d81b2cf..6b5aa3b 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -3212,6 +3212,7 @@ static void cnl_set_procmon_ref_values(struct drm_i915_private *dev_priv,
 	switch (val & (PROCESS_INFO_MASK | VOLTAGE_INFO_MASK)) {
 	default:
 		MISSING_CASE(val);
+		/* fall through */
 	case VOLTAGE_INFO_0_85V | PROCESS_INFO_DOT_0:
 		procmon = &cnl_procmon_values[PROCMON_0_85V_DOT_0];
 		break;
diff --git a/drivers/gpu/drm/i915/intel_sdvo.c b/drivers/gpu/drm/i915/intel_sdvo.c
index e6a64b3..a7f4a56 100644
--- a/drivers/gpu/drm/i915/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/intel_sdvo.c
@@ -1340,6 +1340,7 @@ static void intel_sdvo_pre_enable(struct intel_encoder *intel_encoder,
 	switch (crtc_state->pixel_multiplier) {
 	default:
 		WARN(1, "unknown pixel multiplier specified\n");
+		/* fall through */
 	case 1: rate = SDVO_CLOCK_RATE_MULT_1X; break;
 	case 2: rate = SDVO_CLOCK_RATE_MULT_2X; break;
 	case 4: rate = SDVO_CLOCK_RATE_MULT_4X; break;
@@ -2316,14 +2317,19 @@ intel_sdvo_guess_ddc_bus(struct intel_sdvo *sdvo)
 	switch (sdvo->controlled_output) {
 	case SDVO_OUTPUT_LVDS1:
 		mask |= SDVO_OUTPUT_LVDS1;
+		/* fall through */
 	case SDVO_OUTPUT_LVDS0:
 		mask |= SDVO_OUTPUT_LVDS0;
+		/* fall through */
 	case SDVO_OUTPUT_TMDS1:
 		mask |= SDVO_OUTPUT_TMDS1;
+		/* fall through */
 	case SDVO_OUTPUT_TMDS0:
 		mask |= SDVO_OUTPUT_TMDS0;
+		/* fall through */
 	case SDVO_OUTPUT_RGB1:
 		mask |= SDVO_OUTPUT_RGB1;
+		/* fall through */
 	case SDVO_OUTPUT_RGB0:
 		mask |= SDVO_OUTPUT_RGB0;
 		break;
-- 
2.7.4

