Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1296969-1522884757-2-8354358948782796006
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
    1522884756; b=A+8Mo9QJtCiC3eI4BPHGpfY8J7yxo36LrtoPBDNW7YVP+rW97Y
    Qed5ZCn9nw25IOr3WV0vLymQot8V0HJPHUM/7S0PJ6LkOGhzdbhSfTH6l62ioyhs
    PzAlbIgVnCcotDItTIMs9BRaUWQRSKl7X/0PrMXp76RK/c92WZ75nXR38+AMgN6w
    i3XDODlUMncxlkbqLvQv9R//dtNiid0NepOSWWGTdyLJf7rDwBKcLFM3RRpS7GhA
    1vAU8vrZihDocS50YOrBwWxD7yEG7YiBxfkb4QH7jDZD4hJZXIJw/q5bKFtpUz4B
    3tazGerTAm2dMwmk0KH8BZuyCDdxAbd+0xcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1522884756; bh=K08GuEC3OxETEgg405+03zAaW+C88/
    wZyhUwDF3xVEE=; b=X6ccW2uXyP0dK/r1KVT7+yynRECl71R+ITj3b7k3hEdgWJ
    85bjee+Fur69v6SiwPsRSFXVjgJqFrAKPmF485xda201jlr1k9n+HY6pp5RJn4N7
    qOriXNpAj2x3jWwrKBCniRQj4dwvGGvY6P+/KXY2mAbybrGcy+BvtzNl3cCv1Dys
    yrRWAW3epq7HBMeDHFutHDhw23antyYEAKypgckwbdE167stKBfCcQpF2vAIYdIg
    aGMMb9j/ZKKu3j6ziltzgCvuT1EL5kahhUouaslk0YoiJwwFyxb6wuOuJd4Q54qK
    NvHSzYm644pK2LOLIBdi4Na9S3+aOTXbM5uIshqQ==
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
X-CM-Envelope: MS4wfDhAIfnFKSSdaPQeo8ClwvhxHM+NRKxm8GPNkl6zGgBGT0L8DEL1iFJLimNJWp56KeNg53fh8ZjXPBz3Hy/iY46kZRJmK1cIRGOHkDwmJ+6oBI7i1JV3
    dCf1Vlqle4of4ya0pr/WOtpIGWcXfqZD+tpluW09P/z5VkCbt1uP7GQ7u9Z278+MPO1rVEmKk7celhuybA8QMptv3xSszAVnb/v5V8vyraemPaYZ1jBG7mFk
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=tOHrZ7tblIJAs64MjQ4A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeDDXcf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 19:32:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752395AbeDDXce (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 19:32:34 -0400
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
Subject: [PATCH] [RESEND] drm/i915/dp: Send DPCD ON for MST before phy_up
Date: Wed,  4 Apr 2018 19:32:22 -0400
Message-Id: <20180404233222.31296-1-lyude@redhat.com>
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
