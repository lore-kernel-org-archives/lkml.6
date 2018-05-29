Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967270AbeE2VJv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:09:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:53956 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937050AbeE2VA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:00:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60127682"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 05/38] x86/intel_rdt: Introduce test to determine if closid is in use
Date: Tue, 29 May 2018 05:57:30 -0700
Message-Id: <26e0715da4e5945b72230c0f72a4399c94bbc2d5.1527593970.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During CAT feature discovery the capacity bitmasks (CBMs) associated
with all the classes of service are initialized to all ones, even if the
class of service is not in use. Introduce a test that can be used to
determine if a class of service is in use. This test enables code
interested in parsing the CBMs to know if its values are meaningful or
can be ignored.

Temporarily mark the function as unused to silence compile warnings
until it is used.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index eac60602c87b..fdc55357251b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -127,6 +127,18 @@ static void closid_free(int closid)
 }
 
 /**
+ * closid_allocated - test if provided closid is in use
+ * @closid: closid to be tested
+ *
+ * Return: true if @closid is currently associated with a resource group,
+ * false if @closid is free
+ */
+static bool __attribute__ ((unused)) closid_allocated(unsigned int closid)
+{
+	return (closid_free_map & (1 << closid)) == 0;
+}
+
+/**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
  *
-- 
2.13.6
