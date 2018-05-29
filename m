Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937091AbeE2VA6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:00:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:53956 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933414AbeE2VAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:00:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60127672"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 02/38] x86/intel_rdt: Introduce RDT resource group mode
Date: Tue, 29 May 2018 05:57:27 -0700
Message-Id: <ccdbc11e14508ce3800ac4370e788374d3855aee.1527593970.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
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
index 39752825e376..c08eee73ecd3 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -81,6 +81,22 @@ enum rdt_group_type {
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
