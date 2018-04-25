Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932126AbeDYSMj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:12:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:41705 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755758AbeDYSM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243610"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 02/39] x86/intel_rdt: Introduce RDT resource group mode
Date: Wed, 25 Apr 2018 03:09:38 -0700
Message-Id: <880692e9b0cc1b7a3edc2d7902448fc943a7ce18.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this time there are no constraints on how bitmasks represented by
schemata can be associated with closids represented by resource groups.
A bitmask of one class of service can without any objections overlap
with the bitmask of another class of service.

The concept of "mode" is introduced in preparation for support of
control over whether cache regions can be shared between classes of
service. At this time the only mode reflects the current cache allocations
where all can potentially be shared.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 3fd7a70ee04a..ecc32eb6a91e 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -80,6 +80,22 @@ enum rdt_group_type {
 };
 
 /**
+ * enum rdtgrp_mode - Mode of a RDT resource group
+ * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
+ *
+ * The mode of a resource group enables control over the allowed overlap
+ * between allocations associated with different resource groups (classes
+ * of service). User is able to modify the mode of a resource group by
+ * writing to the "mode" resctrl file associated with the resource group.
+ */
+enum rdtgrp_mode {
+	RDT_MODE_SHAREABLE = 0,
+
+	/* Must be last */
+	RDT_NUM_MODES,
+};
+
+/**
  * struct mongroup - store mon group's data in resctrl fs.
  * @mon_data_kn		kernlfs node for the mon_data directory
  * @parent:			parent rdtgrp
-- 
2.13.6
