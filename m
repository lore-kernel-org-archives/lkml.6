Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeA3K3r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:29:47 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.234]:35259 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751360AbeA3K3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:29:45 -0500
Date: Tue, 30 Jan 2018 04:05:28 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] drm/edid: use true and false for boolean values
Message-ID: <20180130100528.GA7154@training>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.201.65
X-Source-L: No
X-Exim-ID: 1egSnC-001c6V-D5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (training) [189.152.201.65]:39924
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Use true for boolean value in add_detailed_mode as suggested by Daniel
   Vetter.
 - Update subject.

 drivers/gpu/drm/drm_edid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index ddd5379..b1cb262 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2767,7 +2767,7 @@ do_detailed_mode(struct detailed_timing *timing, void *c)
 
 		drm_mode_probed_add(closure->connector, newmode);
 		closure->modes++;
-		closure->preferred = 0;
+		closure->preferred = false;
 	}
 }
 
@@ -2784,7 +2784,7 @@ add_detailed_modes(struct drm_connector *connector, struct edid *edid,
 	struct detailed_mode_closure closure = {
 		.connector = connector,
 		.edid = edid,
-		.preferred = 1,
+		.preferred = true,
 		.quirks = quirks,
 	};
 
-- 
2.7.4
