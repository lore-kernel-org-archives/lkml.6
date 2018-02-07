Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754781AbeBGRQd convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:16:33 -0500
Received: from zimbra.linuxprofi.at ([93.83.54.199]:45630 "EHLO
        zimbra.linuxprofi.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754392AbeBGRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:16:32 -0500
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph@boehmwalder.at>
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph@boehmwalder.at>
Subject: [PATCH 3/3] hid: logitech-dj: delete unnecessary error messages
Date: Wed,  7 Feb 2018 18:08:00 +0100
Message-Id: <20180207170800.15015-4-christoph@boehmwalder.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180207170800.15015-1-christoph@boehmwalder.at>
References: <20180207170800.15015-1-christoph@boehmwalder.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some "out of memory" messages that are considered useless.

Signed-off-by: Christoph Böhmwalder <christoph@boehmwalder.at>
---
 drivers/hid/hid-logitech-dj.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 59c54cb4bc64..ba5239840cda 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -414,11 +414,8 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 
 	dj_dev = kzalloc(sizeof(*dj_dev), GFP_KERNEL);
 
-	if (!dj_dev) {
-		dev_err(&djrcv_hdev->dev, "%s: failed allocating dj_device\n",
-			__func__);
+	if (!dj_dev)
 		goto dj_device_allocate_fail;
-	}
 
 	dj_dev->reports_supported =
 		get_unaligned_le32(dj_report->report_params
@@ -1015,11 +1012,9 @@ static int logi_dj_probe(struct hid_device *hdev,
 	/* Treat interface 2 */
 
 	djrcv_dev = kzalloc(sizeof(*djrcv_dev), GFP_KERNEL);
-	if (!djrcv_dev) {
-		dev_err(&hdev->dev,
-			"%s:failed allocating dj_receiver_dev\n", __func__);
+	if (!djrcv_dev)
 		return -ENOMEM;
-	}
+
 	djrcv_dev->hdev = hdev;
 	INIT_WORK(&djrcv_dev->work, delayedwork_callback);
 	spin_lock_init(&djrcv_dev->lock);
-- 
2.13.6
