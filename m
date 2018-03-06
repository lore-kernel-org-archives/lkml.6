Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932881AbeCFAG1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 19:06:27 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.234]:28046 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932243AbeCFAG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 19:06:26 -0500
Date: Mon, 5 Mar 2018 18:06:24 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] HID: hid-ntrig: use true and false for boolean values
Message-ID: <20180306000624.GA2680@embeddedgus>
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
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1et07d-003xNW-D1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:46252
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/hid/hid-ntrig.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 3d121d8..43b1c72 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -591,8 +591,8 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 	switch (usage->hid) {
 	case 0xff000001:
 		/* Tag indicating the start of a multitouch group */
-		nd->reading_mt = 1;
-		nd->first_contact_touch = 0;
+		nd->reading_mt = true;
+		nd->first_contact_touch = false;
 		break;
 	case HID_DG_TIPSWITCH:
 		nd->tipswitch = value;
@@ -663,7 +663,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 * even if deactivation slack is turned off.
 			 */
 			nd->act_state = deactivate_slack - 1;
-			nd->confidence = 0;
+			nd->confidence = false;
 			break;
 		}
 
@@ -679,7 +679,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 */
 			if (nd->w < nd->min_width ||
 			    nd->h < nd->min_height)
-				nd->confidence = 0;
+				nd->confidence = false;
 		} else
 			break;
 
@@ -758,7 +758,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 		if (!nd->reading_mt) /* Just to be sure */
 			break;
 
-		nd->reading_mt = 0;
+		nd->reading_mt = false;
 
 
 		/*
@@ -910,7 +910,7 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return -ENOMEM;
 	}
 
-	nd->reading_mt = 0;
+	nd->reading_mt = false;
 	nd->min_width = 0;
 	nd->min_height = 0;
 	nd->activate_slack = activate_slack;
-- 
2.7.4
