Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E09C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85F021907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBHAIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:08:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:65458 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbfBHAIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:08:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 16:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,346,1544515200"; 
   d="scan'208";a="122851385"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 07 Feb 2019 16:08:53 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v6 01/13] selftests/resctrl: Add README for resctrl tests
Date:   Thu,  7 Feb 2019 16:01:29 -0800
Message-Id: <1549584101-85811-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1549584101-85811-1-git-send-email-fenghua.yu@intel.com>
References: <1549584101-85811-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl tests will be implemented. README is added for the tool first.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/README | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/README

diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
new file mode 100644
index 000000000000..2bcd8739f1c6
--- /dev/null
+++ b/tools/testing/selftests/resctrl/README
@@ -0,0 +1,54 @@
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
+        -p cpu_no: specify CPU number to run the test. 1 is default
+        -h: help
-- 
2.7.4

