Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2757788-1519128212-2-2777997618091153106
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519128212; b=uqw746/aFcCXZPp1jXTyudLNGZZrEHF5O74XRg8v5fckzfe
    H155iL5r/hkSBFW15wCM5c49J2SIaBCFPeuh5qtRf6h2zQLAIhyd36D4LY/r4ulg
    YAkcYeqjQtyQ6z32PMgcTY/IYse02mu3WDnR0kLAOHiy0r2BOj80eQdOOLXHuLPZ
    5/cMMIkRNJYkUt4ZWWoOhXCpVs+22plpMDm3RfawRilBieqDTp8GHkBkDPU4Stgl
    nZb19BicKZ2Zp0avt2eSlXq54CkQ9mSA4Kn9BjCq9uL/N7E/6KhUfcH2tVgeHLsz
    n6eXlGszCME7Z7niOPmYjiN8izJEILbWBCvmuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519128212;
    bh=3z/Y/d8Q3BnVhcdP1Cwdr0eKS5jDCtD/KRoGoEM+9T8=; b=OhpPqUP9Mrjw
    FEq4rWfCtvpTIwjHQzVEnc/BQo6j4zetpK98mKsNTyuvu/6qLgEOwZOOFWtMKZaG
    7LJVtHmdzKzPO/8YiEq6dUU5681FUDvJ5WmoNow5WbAlBqUsWg6MmwcaP5dwR0E6
    /eGo4o5pdCZrILdCW36+OJoy3ppw2RYyo25hEUW706RMGBLa1wfcutl9JAGlj/eM
    ZHD2bNBHRMxm7jCxeDwbccBgYMVUzGyxQFoudwYyQPKzG+yKzTACm4J2TrMNtk5v
    kP1+q284JOw5VpqVhyKmO4EpZot3Arc2aezm9dl5ogYRa29o4zvqIkIPkAQn3aeJ
    7RkeZ50SIA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbeBTMDS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 07:03:18 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:53787 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeBTMAN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 07:00:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sudip Mukherjee <sudip@vectorindia.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [4.4-stable 21/22] drm/gma500: remove helper function
Date: Tue, 20 Feb 2018 12:55:08 +0100
Message-Id: <20180220115527.1806578-22-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:q/p4+NBZRq4lpLvRnDACsxnQoUi1HDUYwMf3+uPNidiWY/9maG4
 uih5VdyfaJ18xkiu93PBoJKcEnwVISlciF2xVkCNZYgdEYM7Hxz/uELE263n0euUVtwY/Wg
 gnE00x6TTV4iKwKAfuWWBjIRfSm2FPFGkKCEV+Ep5n/t0p4xHLHdmvxUWMIbAgZTVIzBwoL
 jjmiKCB6HTHuRaFcZihlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/0l0t03mXDo=:LVZOwjOXLKCRGb9Xf/WROU
 rIFkelDNZ5W1iGXH/tclW9wPaAqKftTEvUHO/UKZNbXBRGhgE4ZfN2+KGr3FSkARFwZsUYVE0
 hKYnMR2pm/Csp3XKvsd74ZOEKEl4s3FAaIxGZ/ze7PuKEM1QOxHLkz/lfDJUbJl2K8r73m167
 bnQBHcAMF0C+kSbeD1jj+q4w5EOZiSZvYDviFHobTUhmBizWRq8XDzW3IgDwLyIHmyDfblnjR
 TLOaNL/kxQNrdk7ily65hsG32dK/JI7V/XCO3WeRUj+yTkfPKzOfWK97YJNWgHzi9dnh79u8Z
 cTe2fcbJIOx4K6YyqeXRak7OEC4zLHrf5X6twSSd51o6ju/qBg84s6cdL4PeFaJm8IT4Zt1sq
 swB+7xsArldShz3KslCMiHDDBp1mMr6mLY0h5ZTjUEV8PT9YZn29b04nLfo5f3vGA7FxyWBZ+
 oNH+hwsn98HpnUNtBuM5nexDAaqbdfoWImazZikEo7IX1hRlWbTzxSAllmVOMhKVdG1fw1if/
 JQKbvPeO2iC5BitLx7DQnoKlCxgIi459XoX5HzGS96XnL2Ye11iBzCq9p0wpG96opWMF0Ty1x
 P2H+f3WuR3EknSsE5P1ph1vfv50pMjfOW1laTVO00qGrygBUEmGtaCKQYEMEUUFwm6l1tyS0F
 jPykB4Hh+2mkr8D1pKjPhYzVgH0f7AyvdicuOYeyBxnhetPYDGKG94Alwktnsl0apmDW/2gh+
 khl+9mDglF68tpl/HdIRKVLiVOcepesrQlNQFA==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

commit db9b60400f9253c25ae639797df2d0ff7a35d9d8 upstream.

We were getting build warning about:
drivers/gpu/drm/gma500/mdfld_dsi_output.c:407:2: warning: initialization
	from incompatible pointer type

The callback to dpms was pointing to a helper function which had a
return type of void, whereas the callback should point to a function
which has a return type of int.
On closer look it turned out that we do not need the helper function
since if we call drm_helper_connector_dpms() directly, the first check
that drm_helper_connector_dpms() does is: if (mode == connector->dpms)

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Link: http://patchwork.freedesktop.org/patch/msgid/1454393155-13142-1-git-send-email-sudipm.mukherjee@gmail.com
Acked-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
[arnd: rebased to 4.4]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/gma500/mdfld_dsi_output.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mdfld_dsi_output.c b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
index 89f705c3a5eb..910a2f253990 100644
--- a/drivers/gpu/drm/gma500/mdfld_dsi_output.c
+++ b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
@@ -382,16 +382,6 @@ static int mdfld_dsi_connector_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-static void mdfld_dsi_connector_dpms(struct drm_connector *connector, int mode)
-{
-	if (mode == connector->dpms)
-		return;
-
-	/*first, execute dpms*/
-
-	drm_helper_connector_dpms(connector, mode);
-}
-
 static struct drm_encoder *mdfld_dsi_connector_best_encoder(
 				struct drm_connector *connector)
 {
@@ -404,7 +394,7 @@ static struct drm_encoder *mdfld_dsi_connector_best_encoder(
 
 /*DSI connector funcs*/
 static const struct drm_connector_funcs mdfld_dsi_connector_funcs = {
-	.dpms = /*drm_helper_connector_dpms*/mdfld_dsi_connector_dpms,
+	.dpms = drm_helper_connector_dpms,
 	.save = mdfld_dsi_connector_save,
 	.restore = mdfld_dsi_connector_restore,
 	.detect = mdfld_dsi_connector_detect,
-- 
2.9.0
