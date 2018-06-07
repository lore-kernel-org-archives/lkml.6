Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3QASIW1EGVtwFAAAmS7hNA
	; Thu, 07 Jun 2018 14:43:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1978F608C1; Thu,  7 Jun 2018 14:43:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7F763602FC;
	Thu,  7 Jun 2018 14:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F763602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934869AbeFGOnd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:43:33 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40680 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934069AbeFGOna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:43:30 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvba-0005Zo-HY; Thu, 07 Jun 2018 15:09:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb8-00035n-SA; Thu, 07 Jun 2018 15:09:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Mario Kleiner" <mario.kleiner.de@gmail.com>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.825512326@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 264/410] drm/edid: Add 6 bpc quirk for CPT panel in
 Asus UX303LA
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 06998a756a3865817b87a129a7e5d5bb66dc1ec3 upstream.

Similar to commit e10aec652f31 ("drm/edid: Add 6 bpc quirk for display
AEO model 0."), the EDID reports "DFP 1.x compliant TMDS" but it support
6bpc instead of 8 bpc.

Hence, use 6 bpc quirk for this panel.

Fixes: 196f954e2509 ("drm/i915/dp: Revert "drm/i915/dp: fall back to 18 bpp when sink capability is unknown"")
BugLink: https://bugs.launchpad.net/bugs/1749420
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20180218085359.7817-1-kai.heng.feng@canonical.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/drm_edid.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -105,6 +105,9 @@ static struct edid_quirk {
 	/* AEO model 0 reports 8 bpc, but is a 6 bpc panel */
 	{ "AEO", 0, EDID_QUIRK_FORCE_6BPC },
 
+	/* CPT panel of Asus UX303LA reports 8 bpc, but is a 6 bpc panel */
+	{ "CPT", 0x17df, EDID_QUIRK_FORCE_6BPC },
+
 	/* Belinea 10 15 55 */
 	{ "MAX", 1516, EDID_QUIRK_PREFER_LARGE_60 },
 	{ "MAX", 0x77e, EDID_QUIRK_PREFER_LARGE_60 },
