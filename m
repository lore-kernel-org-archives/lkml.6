Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3756588-1522960603-2-4045496484642846304
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
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
    1522960602; b=dWcCqIey2lJn22kCBdCEIYL/oCj7tgDTfCUuURGU+GCFT/MnXy
    JAO0c6xRF+8nDdll/1Q93kMvZecNIl4VXOXSuzJBgZPfawKpQdiMLf7q9MjjHe7q
    2DsYwgKxd+ugcbL31Rn5Hu2752rXtF2c6K3XzBmZQP9mI5KUTUw9bEfGs+DZXV/Q
    ndH6z8rYynkmTf8+3gpXynu8sFnVwc+9eJFZuthIUmG7AsCKXgr247t59KjEt5lF
    suPC0SOWycYhLVftF9jR+Go8C9Jed+vhmcA5WDgoKPmEkCK+K0msMTLaJprRgh49
    vY2MFRug92dXMhJDEOVxc4hSG9Jg8PQdxK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1522960602; bh=xPQvpSvRzR4rx9Yy15BT6WiP8cbMc5
    gxPS2sjzbit6k=; b=b15d8IUtXDPp8nJtEjvC/PRubd69xNL90OQNJTfEVwjRtg
    s3kypFKpNB2DpWyV0DXUU18+26ACE+f+WcHQT6iPJuewXpztTtAoNfACRIsR/Muu
    xJjaMuGRb5ixkgggphjEoywKh3r1qpGhk3gsgIvJfVyR7Q/+mpZeU7XkTx16rbaS
    rHg5mJV0wO8FrDU5ZnP31Qs/SYaZnuUir5SgHOb9kAXoWudks/TPyDWkssPJ+xhk
    Lm281g4fqt0no+LrEFdIMndu16oa5K5MbYmtStbn4wTVd5hfYh9WkHMJmVGBhSdl
    AjmTRHj6iRnO2StttZTwtus4IV76nqZKe+ta5axQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfF6yVm/5rbtnJMLJSaYTMajOOkU7sj7CwPlVmXBbDcWouJ9fMNXmy2oTPob1GEo/o9ALQDjTXl/aDPY4PGmgtmf6ao75+YgzQyCcV7P9ZezXNSB/UV2l
    IyKuVxF7YbHydlEUGY3UUOpHr2mo0cwH6z+z63YyC0Ahar/6rPLvd31278dSDlTuaxr+AjufWlqcDl5CeBVdl5nbdZtBg5ZOuIdQvIl69AG8p3DrSkhzPcMg
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=KYDh_RRHI3FUnStEhLQA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeDEUgL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 16:36:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751344AbeDEUgK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 16:36:10 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>, Laura Abbott <labbott@redhat.com>,
        stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915/dp: Send DPCD ON for MST before phy_up
Date: Thu,  5 Apr 2018 16:36:01 -0400
Message-Id: <20180405203601.23242-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When doing a modeset where the sink is transitioning from D3 to D0 , it
would sometimes be possible for the initial power_up_phy() to start
timing out. This would only be observed in the last action before the
sink went into D3 mode was intel_dp_sink_dpms(DRM_MODE_DPMS_OFF). We
originally thought this might be an issue with us accidentally shutting
off the aux block when putting the sink into D3, but since the DP spec
mandates that sinks must wake up within 1ms while we have 100ms to
respond to an ESI irq, this didn't really add up. Turns out that the
problem is more subtle then that:

It turns out that the timeout is from us not enabling DPMS on the MST
hub before actually trying to initiate sideband communications. This
would cause the first sideband communication (power_up_phy()), to start
timing out because the sink wasn't ready to respond. Afterwards, we
would call intel_dp_sink_dpms(DRM_MODE_DPMS_ON) in
intel_ddi_pre_enable_dp(), which would actually result in waking up the
sink so that sideband requests would work again.

Since DPMS is what lets us actually bring the hub up into a state where
sideband communications become functional again, we just need to make
sure to enable DPMS on the display before attempting to perform sideband
communications.

Changes since v1:
- Remove comment above if (!intel_dp->is_mst) - vsryjala
- Move intel_dp_sink_dpms() for MST into intel_dp_post_disable_mst() to
  keep enable/disable paths symmetrical
- Improve commit message - dhnkrn

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: stable@vger.kernel.org
Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.")
---
This email should hopefully actually be picked up by patchwork this
time, hooray!

 drivers/gpu/drm/i915/intel_ddi.c    | 6 ++++--
 drivers/gpu/drm/i915/intel_dp_mst.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
index a6672a9abd85..c0bf7419e1c1 100644
--- a/drivers/gpu/drm/i915/intel_ddi.c
+++ b/drivers/gpu/drm/i915/intel_ddi.c
@@ -2324,7 +2324,8 @@ static void intel_ddi_pre_enable_dp(struct intel_encoder *encoder,
 		intel_prepare_dp_ddi_buffers(encoder, crtc_state);
 
 	intel_ddi_init_dp_buf_reg(encoder);
-	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
+	if (!intel_dp->is_mst)
+		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
 	intel_dp_start_link_train(intel_dp);
 	if (port != PORT_A || INTEL_GEN(dev_priv) >= 9)
 		intel_dp_stop_link_train(intel_dp);
@@ -2427,7 +2428,8 @@ static void intel_ddi_post_disable_dp(struct intel_encoder *encoder,
 	 * Power down sink before disabling the port, otherwise we end
 	 * up getting interrupts from the sink on detecting link loss.
 	 */
-	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
+	if (!intel_dp->is_mst)
+		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
 
 	intel_disable_ddi_buf(encoder);
 
diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index c3de0918ee13..2493bd1e0e59 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -176,6 +176,7 @@ static void intel_mst_post_disable_dp(struct intel_encoder *encoder,
 	 */
 	drm_dp_send_power_updown_phy(&intel_dp->mst_mgr, connector->port,
 				     false);
+	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
 
 	intel_dp->active_mst_links--;
 
@@ -223,6 +224,7 @@ static void intel_mst_pre_enable_dp(struct intel_encoder *encoder,
 
 	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
 
+	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
 	drm_dp_send_power_updown_phy(&intel_dp->mst_mgr, connector->port, true);
 	if (intel_dp->active_mst_links == 0)
 		intel_dig_port->base.pre_enable(&intel_dig_port->base,
-- 
2.14.3
