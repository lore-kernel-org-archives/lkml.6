Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-990257-1522873811-2-7504547188564746751
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
    1522873810; b=Bry7j0k67NKeptsWrbxJNXkDJ8OuEyxJHG20As3oJnGcS28csA
    cc+0lFu1TCZPhT0euW8L7jiBJRSxfTUFbP+UmZiz2/2pZY6x2mOYKT9yqyx5WFdw
    eiOY9OgZ3bQqIBS0+BXNiJuD7l/VlGxkfhTE8mrJanj6KydjT+tiPf0KNQGz3g0n
    g5AJLnf7RtTcjf24Z4IpLMjLlkbc+V5kJ/DCyE+IQwuskOsH8mu6mWoLFEsAx6nj
    FqsWFM85ShDYc5+l2ZOTkOoWN48WpF9siO6JvrKlV/9kCksZJ6I2ciBzYnhpL0r7
    ZIv0HtUFHYEMwYg6i6XnUgi0M+sBcSVwnvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522873810;
    bh=VciGYlp4mlUgulcOPdzdh8k4s5oxIbbR3H2jJcM8NVs=; b=HpKutk2QqO/5
    e8XFyr1hgZ3Iocp7tJh/bSujMOjkUF2MG1GvgJYDmGVomr8dK+lZ/DZSr5PBP6Uv
    zAqAUFSiXqc6wS2W/EdLo5q0Kg2HwEy4Lr2QUJuJ5jyX0/No8sUL25+BzYE0GnjK
    /k04f92eGFZu5f2uaceiKtU8UFxHDiReixkCiQcvXtPVEHVv09MsGNwkwBeaHDCD
    ul/S55mZ83oaEfBrBvGIZhBjHbW5EYz/tSVRR3IPDQ4VErkhtN6BeouUJBUKMH70
    Joi7yV56i/6Q3xzrmrb0nn8Lfgd38b29AUidmXhRJyCYFwAtiRkCUUyTteo6HUII
    lMQhRSE07A==
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
X-CM-Envelope: MS4wfPrRg4SY0C6xVuGEr/N8ajK1wbNHWD2Io+qVHIm+srkWSc+cdnrmjc+K862rjPfhMRtIarf7meNJ0QuxLvNOA7VrwLZT1Hca+icvT4qIttnhQA86hOh2
    roF7bRPCF2xpEnjFOb4JX/xdTuaN5xUaYoKAKf83uraSoeNX5PiTSpkjXVy9GMfx8ajQzvIFDpPV+cRqfp6Gsl2YpY7WoaISwsOqNKE2StUWYjoL79T0FC8e
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=fgeN0leQug2GkSvOKpYA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeDDU3z (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 16:29:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751981AbeDDU3o (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 16:29:44 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>, stable@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/i915: Keep AUX block running when disabling DPMS for MST
Date: Wed,  4 Apr 2018 16:29:31 -0400
Message-Id: <20180404202932.6811-2-lyude@redhat.com>
In-Reply-To: <20180404202932.6811-1-lyude@redhat.com>
References: <20180404202932.6811-1-lyude@redhat.com>
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

Changes since v2:
 - Fix patch name, no functional changes
Changes since v3:
 - acks, t-b's

Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Tested-by: Laura Abbott <labbott@redhat.com>
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
