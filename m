Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3393218-1520954926-2-2089546053048131751
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520954926; b=bOkCh3XpLoJHZeR0K0ABIwgmSj4AnhRcQi3LHv77CxFmR0F
    xagGloZgFa0qkxI71lYVblbrXqsId2RfjazC0TlkqVWKgCFhR/WCf77g4zEtamAQ
    5MkJ/RO+DguaXZ8diW5dJKlZL8cUvDFrKVrzE+CHwU3kYAbX3IF4V+0vfgqpaQbB
    1lWtgWRMh4Hx4YOPpuouD6AI4ePYb64hcBDtdEP/VaCyfSVM1HWTEM2+UZqoL78O
    MhtJ6fBp2yOGeGLBaqyxPZoNIJQ7yUyXDr5KWdsOhEiY4NryADO+sr6nc8fwj/8O
    fMHsxwiI538XsyaFIx8A6ATC8o4hqhbduqHF77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520954926; bh=vXxYE361ktjdCUpw0VzN/IOBzS
    XHwvpVBdXlR8fEhJA=; b=XMXfS5+tZyY4p6DqndXlI/QAqsfBiax0+Dfu/SpKwA
    +f+n+o5ExI+foCt6UwE8VJeEs7WiFO6zGKT8Dj8fZdqfyn5a/Y2Zdj4bE9Fa9dX4
    AjCYlND1tyNdY/bEHMbBN6wagxH2syKL1qe3hxGIB5H3mOJGlFmqe5Q/BZd36dVw
    othB9lgHmpAM/QEyeWP2pYBgwT3jvoK9HfKsJV/RE5RrUTV5AXqxNgJ1Cv1TYVB/
    kg0MA+D+ItcB6K5nUZelLX+gait622acXWbOZP7dpj2AVQg1hmON6pyNnLSjyiT1
    MeJui4ywA7skCXCAYQGVnRqmYnsgRvrgbPlvlj5qFvUA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeCMP2l (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:28:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58102 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932793AbeCMP2j (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:28:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 028/146] Revert "drm/radeon/pm: autoswitch power state when in balanced mode"
Date: Tue, 13 Mar 2018 16:23:15 +0100
Message-Id: <20180313152322.681532066@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 53bf277b487eb5ae6695db01bede0fe406792119 upstream.

This reverts commit 1c331f75aa6ccbf64ebcc5a019183e617c9d818a.

Breaks resume on some systems.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=100759
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_pm.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -47,7 +47,6 @@ static bool radeon_pm_in_vbl(struct rade
 static bool radeon_pm_debug_check_in_vbl(struct radeon_device *rdev, bool finish);
 static void radeon_pm_update_profile(struct radeon_device *rdev);
 static void radeon_pm_set_clocks(struct radeon_device *rdev);
-static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev);
 
 int radeon_pm_get_type_index(struct radeon_device *rdev,
 			     enum radeon_pm_state_type ps_type,
@@ -80,8 +79,6 @@ void radeon_pm_acpi_event_handler(struct
 				radeon_dpm_enable_bapm(rdev, rdev->pm.dpm.ac_power);
 		}
 		mutex_unlock(&rdev->pm.mutex);
-		/* allow new DPM state to be picked */
-		radeon_pm_compute_clocks_dpm(rdev);
 	} else if (rdev->pm.pm_method == PM_METHOD_PROFILE) {
 		if (rdev->pm.profile == PM_PROFILE_AUTO) {
 			mutex_lock(&rdev->pm.mutex);
@@ -885,8 +882,7 @@ static struct radeon_ps *radeon_dpm_pick
 		dpm_state = POWER_STATE_TYPE_INTERNAL_3DPERF;
 	/* balanced states don't exist at the moment */
 	if (dpm_state == POWER_STATE_TYPE_BALANCED)
-		dpm_state = rdev->pm.dpm.ac_power ?
-			POWER_STATE_TYPE_PERFORMANCE : POWER_STATE_TYPE_BATTERY;
+		dpm_state = POWER_STATE_TYPE_PERFORMANCE;
 
 restart_search:
 	/* Pick the best power state based on current conditions */
