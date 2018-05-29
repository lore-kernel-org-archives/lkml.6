Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932929AbeE2KDO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:03:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932827AbeE2J6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:58:11 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/9] HID: multitouch: make sure the static list of class is not changed
Date: Tue, 29 May 2018 11:57:53 +0200
Message-Id: <20180529095800.13504-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
References: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

const is a magic keyword here :)

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 38c4ca24343e..187d27f26eec 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -211,7 +211,7 @@ static int cypress_compute_slot(struct mt_device *td)
 		return -1;
 }
 
-static struct mt_class mt_classes[] = {
+static const struct mt_class mt_classes[] = {
 	{ .name = MT_CLS_DEFAULT,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE },
@@ -1429,7 +1429,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret, i;
 	struct mt_device *td;
-	struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
+	const struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
 
 	for (i = 0; mt_classes[i].name ; i++) {
 		if (id->driver_data == mt_classes[i].name) {
-- 
2.14.3
