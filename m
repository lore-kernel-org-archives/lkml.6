Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325134-2-2280649814175220665
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325134; b=PrXIEZjVBChJDDxDIosBa6ZLSwIzoxXTU+MqatN228GHBwa
    b0pOEQZoDIgPOLPzExHjgPzOrnlcR6jDJafCP07C3wRTsGWWVKbbqv90KlMSHUs1
    ntN5XcsiEO/JjHHUerrFAuRRyjMFzE63SXpEnUfN8U3Jx1XHtu0DYQ4nrHGO9WhQ
    G2mTXf/SP/lpc1or0KLqWCkAV3KlcH1ZecPutWZpI9iGmlk3/hv8ADu/pUH/8kQh
    m3CuHuRuKsuY6N9VGkFS4jN6nsldTDiZ+fcBLmfMaYlO46+6I4GolpnZJkTQfFPe
    uYREUivg4xElumr+GoMhQaxvE7addyJN1/PLp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325134; bh=sa1wKXkKLT7kjcRGNLf
    MBxmYBFbdjdIBXt1/gCK/Sko=; b=IJWMieZf1EFUeEpfpbchnm/1zhFWwNqF5Sp
    j/95B+f39wQ6QC/OCDYfBxc0KTaW8cL0L1jq37206eNNgqRz1G6d3VfkdfZ76jSY
    RNKW9uigmidAodRj2u00EDOxB0KINJPQwYOjcjKgvg095QkGtGmz26KBaMfRh2h9
    M9hJ8428vpkKnAb/qRuCtFqC+2dFdM7LefxMgTJuH0COq/bWL/obmKZrQLZPzMyn
    e4xvSrPOnOQRZntVs51N96NJrJ/QsYDZfYGgqjmvr15dtAcooHt+wrbL4M67O7Fo
    Tqzc2KqyU80+YQDkJT2M5aen82MEonIus1OXrHRiJ/pn6AYUgtg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753810AbeBKE6u (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:58:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41678 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752779AbeBKEd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Manasi Navare" <manasi.d.navare@intel.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Jani Nikula" <jani.nikula@intel.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.27137932@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 009/136] drm/i915/edp: Get the Panel Power Off
 timestamp after panel is off
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Manasi Navare <manasi.d.navare@intel.com>

commit cbacf02e7796fea02e5c6e46c90ed7cbe9e6f2c0 upstream.

Kernel stores the time in jiffies at which the eDP panel is turned
off. This should be obtained after the panel is off (after the
wait_panel_off). When we next attempt to turn the panel on, we use the
difference between the timestamp at which we want to turn the panel on
and timestamp at which panel was turned off to ensure that this is equal
to panel power cycle delay and if not we wait for the remaining
time. Not waiting for the panel power cycle delay can cause the panel to
not turn on giving rise to AUX timeouts for the attempted AUX
transactions.

v2:
* Separate lines for bugzilla (Jani Nikula)
* Suggested by tag (Daniel Vetter)

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=101518
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=101144
Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Manasi Navare <manasi.d.navare@intel.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1507135706-17147-1-git-send-email-manasi.d.navare@intel.com
[bwh: Backported to 3.16: We really do use jiffies here, and the field in
 struct intel_dp has a different name]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -1365,8 +1365,8 @@ void intel_edp_panel_off(struct intel_dp
 	I915_WRITE(pp_ctrl_reg, pp);
 	POSTING_READ(pp_ctrl_reg);
 
-	intel_dp->last_power_cycle = jiffies;
 	wait_panel_off(intel_dp);
+	intel_dp->last_power_cycle = jiffies;
 
 	/* We got a reference when we enabled the VDD. */
 	power_domain = intel_display_port_power_domain(intel_encoder);
