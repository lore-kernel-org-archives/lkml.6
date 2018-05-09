Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934120AbeEIKQN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:16:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52999 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933950AbeEIKQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:16:12 -0400
From: Colin King <colin.king@canonical.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] drm/i915/dp: fix spelling mistakes: "seqeuncer" and "seqeuencer"
Date: Wed,  9 May 2018 11:16:06 +0100
Message-Id: <20180509101606.17483-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in WARN warning message text and
in comments:

"seqeuncer", "seqeuencer" -> "sequencer"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Also fix seqeuencer in comments

---
 drivers/gpu/drm/i915/intel_dp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index dde92e4af5d3..2cc58596ff5a 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -513,7 +513,7 @@ vlv_power_sequencer_kick(struct intel_dp *intel_dp)
 	uint32_t DP;
 
 	if (WARN(I915_READ(intel_dp->output_reg) & DP_PORT_EN,
-		 "skipping pipe %c power seqeuncer kick due to port %c being active\n",
+		 "skipping pipe %c power sequencer kick due to port %c being active\n",
 		 pipe_name(pipe), port_name(intel_dig_port->base.port)))
 		return;
 
@@ -554,7 +554,7 @@ vlv_power_sequencer_kick(struct intel_dp *intel_dp)
 	/*
 	 * Similar magic as in intel_dp_enable_port().
 	 * We _must_ do this port enable + disable trick
-	 * to make this power seqeuencer lock onto the port.
+	 * to make this power sequencer lock onto the port.
 	 * Otherwise even VDD force bit won't work.
 	 */
 	I915_WRITE(intel_dp->output_reg, DP);
@@ -3066,11 +3066,11 @@ static void vlv_detach_power_sequencer(struct intel_dp *intel_dp)
 	edp_panel_vdd_off_sync(intel_dp);
 
 	/*
-	 * VLV seems to get confused when multiple power seqeuencers
+	 * VLV seems to get confused when multiple power sequencers
 	 * have the same port selected (even if only one has power/vdd
 	 * enabled). The failure manifests as vlv_wait_port_ready() failing
 	 * CHV on the other hand doesn't seem to mind having the same port
-	 * selected in multiple power seqeuencers, but let's clear the
+	 * selected in multiple power sequencers, but let's clear the
 	 * port select always when logically disconnecting a power sequencer
 	 * from a port.
 	 */
@@ -5698,7 +5698,7 @@ intel_dp_init_panel_power_sequencer_registers(struct intel_dp *intel_dp,
 
 	/*
 	 * On some VLV machines the BIOS can leave the VDD
-	 * enabled even on power seqeuencers which aren't
+	 * enabled even on power sequencers which aren't
 	 * hooked up to any port. This would mess up the
 	 * power domain tracking the first time we pick
 	 * one of these power sequencers for use since
@@ -5706,7 +5706,7 @@ intel_dp_init_panel_power_sequencer_registers(struct intel_dp *intel_dp,
 	 * already on and therefore wouldn't grab the power
 	 * domain reference. Disable VDD first to avoid this.
 	 * This also avoids spuriously turning the VDD on as
-	 * soon as the new power seqeuencer gets initialized.
+	 * soon as the new power sequencer gets initialized.
 	 */
 	if (force_disable_vdd) {
 		u32 pp = ironlake_get_pp_control(intel_dp);
-- 
2.17.0
