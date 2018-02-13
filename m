Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965458AbeBMRMi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:12:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:47869 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965351AbeBMRA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:00:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,508,1511856000";
   d="scan'208";a="174656477"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 13/18] thunderbolt: Add constant for approval timeout
Date: Tue, 13 Feb 2018 20:00:13 +0300
Message-Id: <20180213170018.9780-14-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will be using this from Titan Ridge support code as well so make it
constant.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 55006994b517..a707a3b60f90 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -41,7 +41,8 @@
 #define PHY_PORT_CS1_LINK_STATE_MASK	GENMASK(29, 26)
 #define PHY_PORT_CS1_LINK_STATE_SHIFT	26
 
-#define ICM_TIMEOUT			5000 /* ms */
+#define ICM_TIMEOUT			5000	/* ms */
+#define ICM_APPROVE_TIMEOUT		10000	/* ms */
 #define ICM_MAX_LINK			4
 #define ICM_MAX_DEPTH			6
 
@@ -260,7 +261,7 @@ static int icm_fr_approve_switch(struct tb *tb, struct tb_switch *sw)
 	memset(&reply, 0, sizeof(reply));
 	/* Use larger timeout as establishing tunnels can take some time */
 	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
-			  1, 10000);
+			  1, ICM_APPROVE_TIMEOUT);
 	if (ret)
 		return ret;
 
-- 
2.15.1
