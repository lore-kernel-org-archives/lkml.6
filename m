Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427758AbeCBMlx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:41:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:3942 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427649AbeCBMjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:39:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="204989815"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jeremy McNicoll <jmcnicol@redhat.com>,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 10/18] thunderbolt: Add tb_switch_get()
Date: Fri,  2 Mar 2018 15:38:44 +0300
Message-Id: <20180302123852.50463-11-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
References: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes there is need for increasing reference count of a switch as
well. This also follows what we have for xdomains.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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
2.16.1
