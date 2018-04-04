Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1296969-1522885054-2-13561366129073045939
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522885054; b=L27kqxkNd4Hg1C27+w9P/HLxSAqvb9M9+TZxKrxB5iRGi5Q32O
    hSr/Hf3Nah+eTIG7aHRa23Urpb/KIvL50cuM1WH8axiVv8BPft+NRB2+6swMaSzj
    O2NhVcp1gE1g0pJ80GUlwrInCK9ZuuTjZkmdq5ebDAGxInCJJgUQTJ7wmeKf0M+l
    gJwDIWaqbLugFhzUPwc2VPgsEFfQ1wtAMyz892X5ig3Qc3EHwlIP51Irr409EfcP
    gWWm8X0Hx6rb4NvrMUMZKSGfa9bsXXInipH27JW5XYAqUUxIvHuga+e68/uV7aO8
    T5vULl8ojf4Q0QdrY0RnasHz27J4xsh1xGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1522885054; bh=Qa5n/SmZVHQaB5lhODqLZSWlEBUlN5
    h5PbjKeg63gxw=; b=vZQvAvc5xj6Ir56pw9eGG6k+cQglnvtQPKRY9+CsCl6YGd
    HfCl1GgqwcE95bJUIVjhYtVKKrLLpFEdOcMImDpxyDkC1c7gc7XXOKwM46GbbBtq
    HJSiI5rdd8t4l3C6xaQ0lzSNS+5OierEn5IAELn3QFnmSNgYadrqsNXaBYVE3CAO
    Cyo+l+U0d//AlyMUTfuIS2zpfW1BalTgxCVm3qYx4RVGhYmF6VehSn5EmsgFS3Nd
    5NSb7UTZxxQwCHXCBSIiHUYO/gQAJDUooD3rrJ7BihPfZAr9u0bClhWezIZNJmZt
    DwyH5OZPA27/XeSelB0QG6O7PbrpZIGPqZppspqA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL7D2kTadRn9pnEcNr/svW8zXF9/Fty+9mKRBACPk7F8TFj5i8rgXI1llw5JtmhpFLBhW3dyvVaNpqTCofXfjALrQ2Ndv1qrVm/E/TXBM+N6zpKK9qps
    A4KaQ1UcLJG+MerAm4ZOqNOJ0toS7Vz0yhbwqjlw+ucqFD/J9YAJcet+RnNI5Hv2KfcaHzrx26VNVKsincYLiZ/I7LUeF9aFxulP/T3Bli9NzpHx41b4Aro/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=kk7d1kDmNODlaC0gsZIA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeDDXhc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 19:37:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752395AbeDDXha (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 19:37:30 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>, Laura Abbott <labbott@redhat.com>,
        stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] drm/i915/dp: Send DPCD ON for MST before phy_up
Date: Wed,  4 Apr 2018 19:37:12 -0400
Message-Id: <20180404233712.1075-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As it turns out, the aux block being off was not the real problem here,
as transition from D3 to D0 is mandated by the DP spec to take a maximum
of 1ms, whereas we're allowed a 100ms timeframe to respond to ESI irqs.
The real problem here is a bit more subtle.

When doing a modeset where the problem of the sink timing out to our
sideband requests when transitioning from D3 to D0 occurs, the timeout
is from the aux block not coming on. However, nothing else times out
other than the initial phy_up message because the DPCD on call in
intel_ddi_enable_dp() ends up waking up the AUX block on the hub, not
the phy_up sideband message. This means that the real fix we need is to
use the DPMS on before sending a phy_up to ensure that the hub is ready
to accept sideband messages.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: stable@vger.kernel.org
Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.")
---
Sorry for all the spam guys! This is my last attempt at getting this
patch to actually come up on intel-gfx's patchwork page instead of
dri-devel. I have no idea what is going on with patchwork right now :|,
but maybe removing dri-devel from the CC entirely will help.


 drivers/gpu/drm/i915/intel_ddi.c    | 6 +++++-
 drivers/gpu/drm/i915/intel_dp_mst.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
index a6672a9abd85..9bd675f73f7b 100644
--- a/drivers/gpu/drm/i915/intel_ddi.c
+++ b/drivers/gpu/drm/i915/intel_ddi.c
@@ -2324,7 +2324,11 @@ static void intel_ddi_pre_enable_dp(struct intel_encoder *encoder,
 		intel_prepare_dp_ddi_buffers(encoder, crtc_state);
 
 	intel_ddi_init_dp_buf_reg(encoder);
-	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
+	/* for MST, we do DPMS_ON outside of here so that DPMS_ON can happen
+	 * before drm_dp_send_power_updown_phy()
+	 */
+	if (!intel_dp->is_mst)
+		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
 	intel_dp_start_link_train(intel_dp);
 	if (port != PORT_A || INTEL_GEN(dev_priv) >= 9)
 		intel_dp_stop_link_train(intel_dp);
diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index c3de0918ee13..eff9a4eae1f0 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -223,6 +223,7 @@ static void intel_mst_pre_enable_dp(struct intel_encoder *encoder,
 
 	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
 
+	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
 	drm_dp_send_power_updown_phy(&intel_dp->mst_mgr, connector->port, true);
 	if (intel_dp->active_mst_links == 0)
 		intel_dig_port->base.pre_enable(&intel_dig_port->base,
-- 
2.14.3
