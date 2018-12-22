Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D7EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B04821927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404874AbeLVA05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:26:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:48590 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403843AbeLVA0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:26:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 16:26:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,383,1539673200"; 
   d="scan'208";a="128134553"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 21 Dec 2018 16:26:29 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 01/10] selftests/resctrl: Add README for resctrl tests
Date:   Fri, 21 Dec 2018 16:20:29 -0800
Message-Id: <1545438038-75107-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
References: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl tests will be implemented. README is added for the tool first.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/README | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/README

diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
new file mode 100644
index 000000000000..f9621d6146df
--- /dev/null
+++ b/tools/testing/selftests/resctrl/README
@@ -0,0 +1,53 @@
+resctrl_tests - resctrl file system test suit
+
+Authors:
+	Fenghua Yu <fenghua.yu@intel.com>
+	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+	Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
+
+resctrl_tests tests various resctrl functionalities and interfaces including
+both software and hardware.
+
+Currently it supports Memory Bandwidth Monitoring test and Memory Bandwidth
+Allocation test on Intel RDT hardware. More tests will be added in the future.
+And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
+as well.
+
+BUILD
+-----
+
+Run "make" to build executable file "resctrl_tests".
+
+RUN
+---
+
+To use resctrl_tests, root or sudoer privileges are required. This is because
+the test needs to mount resctrl file system and change contents in the file
+system.
+
+Executing the test without any parameter will run all supported tests:
+
+	sudo ./resctrl_tests
+
+OVERVIEW OF EXECUTION
+---------------------
+
+A test case has four stages:
+
+  - setup: mount resctrl file system, create group, setup schemata, move test
+    process pids to tasks, start benchmark.
+  - execute: let benchmark run
+  - verify: get resctrl data and verify the data with another source, e.g.
+    perf event.
+  - teardown: umount resctrl and clear temporary files.
+
+ARGUMENTS
+---------
+
+Parameter '-h' shows usage information.
+
+usage: resctrl_tests [-h] [-b "benchmark_cmd [options]"] [-t test list] [-n no_of_bits]
+        -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM default benchmark is builtin fill_buf
+        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cqm, cat
+        -n no_of_bits: run cache tests using specified no of bits in cache bit mask
+        -h: help
-- 
2.19.1

