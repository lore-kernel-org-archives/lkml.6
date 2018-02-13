Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934973AbeBMROy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:14:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:30085 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964849AbeBMRAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:00:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,508,1511856000";
   d="scan'208";a="29717731"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 10/18] thunderbolt: Add tb_switch_get()
Date: Tue, 13 Feb 2018 20:00:10 +0300
Message-Id: <20180213170018.9780-11-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes there is need for increasing reference count of a switch as
well. This also follows what we have for xdomains.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 895c57a0a090..c7bd77e9c2c3 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -387,6 +387,13 @@ struct tb_switch *tb_switch_find_by_link_depth(struct tb *tb, u8 link,
 					       u8 depth);
 struct tb_switch *tb_switch_find_by_uuid(struct tb *tb, const uuid_t *uuid);
 
+static inline struct tb_switch *tb_switch_get(struct tb_switch *sw)
+{
+	if (sw)
+		get_device(&sw->dev);
+	return sw;
+}
+
 static inline void tb_switch_put(struct tb_switch *sw)
 {
 	put_device(&sw->dev);
-- 
2.15.1
