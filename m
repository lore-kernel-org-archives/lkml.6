Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3868303-1522704131-2-3666061254993534353
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522704130; b=PZLrYVZkwIjnTAY5dUCf2I3KG6BsuMbjyG4Bd37bg/6sp2bzXS
    EsdPlXArmT6q57dTajJU4vZG+wyrwgtibyqPsPLnV3RIvO3IxtAOLRyV4FrTwWz0
    E2/0b3F7/Wld/myX1NNEbJH70WXrCpFORduTbp9K2+e9kA+oy8S6jLkzdKooDn0w
    3/a2UWABsDBoFYxxrG7fdjVgTSz3/e2ejd02NJ5cJ2d7R5KCDdAJJhy2e/6bwbjI
    VPpsXiBTI1VG/4EFDZaPZvMkYDTcxraCm91EYHmrRsXLxlq1GupqbRuidwRzlmsU
    DqG77uu/fGh0N60QU9/ypPMcRLYpcGPexBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1522704130; bh=an6XexS36+dViML+r/QtluAyC9cRG3
    RAO+9zwBwV+bA=; b=YiT5IZ6CRdfTULnHuiRZvag70mEz8T3h7v/DXZVIltsOyP
    vqygxLb/4WMhDyZxKsCAeXGmuJhjIP5ONdXgnUjf3ZVMaP6B2r3Pb3hJE3UlnbnQ
    rKmVgT4hViyHuzHqpvrDs2TRjA+7tazDh7pONqJlIEtknY581RvDd0Z2uVJiENLn
    OykiCdyhHotZr2Adt/Pzhbhjt9nZaOYiRgVRtda+QJWBDiw0ROhUpg/H9pci5Sl2
    0+dRedZtPX9L94Q0qSZ40NEgAJbN3UNtV5GWFayhnnwPje9+PQEr910eQPIERN3H
    5Y4uFaMm3e5hPg01Ll4+cF4WrX+2qdTr8y7ckUQA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfHxQbWOHUreq5aOMqitGnqN21bP/G7L6bWIVvfFAb/F+rvzZtU2k2QlSz3NjI1e6hQyGTAyWt3eSXHOq2bVuSE+HrCzwCs+XIe6c9NWil4DNizvFmvAt
    3wOtddMbc0m9E6441fQC+XSpoGIetfN0/YdccehrY4Q8+hsCxvz1O5EDpQcRGK3A/onZZvBcbX2S76ebHJG02mbfK0tSykb32JBXpkmpc+rlLnCXjazo+lI4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=fgeN0leQug2GkSvOKpYA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeDBVWH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 17:22:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752311AbeDBVWH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 2 Apr 2018 17:22:07 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Laura Abbott <labbott@redhat.com>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>, stable@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i915/dp_mst: Keep AUX block running when disabling DPMS
Date: Mon,  2 Apr 2018 17:21:41 -0400
Message-Id: <20180402212142.19841-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

While enabling/disabling DPMS before link training with MST hubs is
perfectly valid; unfortunately disabling DPMS results in some devices
disabling their AUX CH block as well. For SST this isn't as much of a
problem, but for MST we need to be able to continue handling aux
transactions even when none of the sinks are turned on since it's
possible for us to have a single atomic commit which results in
disabling each downstream sink, followed by subsequently re-enabling
each sink.

If we don't do this, we'll end up stalling any pending ESI interrupts
from the sink for up to 1ms. Unfortunately, dropping ESIs during this
timespan makes it so that link fallback retraining for MST (which I will
be submitting to the ML shortly) fails due to the channel EQ failure
interrupts potentially getting dropped. Additionally, when performing a
modeset that brings the hub status's link status from bad -> good having
ESIs disabled for that long causes us to miss the hub's response to us
trying to start link training as well.

Since any sink with MST is going to support DisplayPort 1.2 anyway, save
us the hassle of trying to wait until the sink comes back up and just
never shut the aux block down.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: stable@vger.kernel.org
Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.")
---
 drivers/gpu/drm/i915/intel_dp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index 62f82c4298ac..0479c377981b 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -2589,11 +2589,13 @@ void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
 		return;
 
 	if (mode != DRM_MODE_DPMS_ON) {
+		unsigned char data = intel_dp->is_mst ?
+			DP_SET_POWER_D3_AUX_ON : DP_SET_POWER_D3;
+
 		if (downstream_hpd_needs_d0(intel_dp))
 			return;
 
-		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_SET_POWER,
-					 DP_SET_POWER_D3);
+		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_SET_POWER, data);
 	} else {
 		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
 
-- 
2.14.3
