Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C070C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5138E2190A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbeLVA0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:26:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:48590 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbeLVA03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:26:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 16:26:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,383,1539673200"; 
   d="scan'208";a="128134551"
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
Subject: [PATCH v4 00/10] selftests/resctrl: Add resctrl selftest
Date:   Fri, 21 Dec 2018 16:20:28 -0800
Message-Id: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With more and more resctrl features are being added by Intel, AMD
and ARM, a test tool is becoming more and more useful to validate
that both hardware and software functionalities work as expected.

We introduce resctrl selftest to cover resctrl features on both
X86 and ARM architectures. It first implements MBM (Memory Bandwidth
Monitoring) and MBA (Memory Bandwidth Allocation) tests. We can enhance
the selftest tool to include more functionality tests in future.

There is an existing resctrl test suite 'intel_cmt_cat'. But the major
purpose of the tool is to test Intel(R) RDT hardware via writing and
reading MSR registers. It does access resctrl file system; but the
functionalities are very limited. And it doesn't support automatic test
and a lot of manual verifications are involved.

So the selftest tool we are introducing here provides a convenient
tool which does automatic resctrl testing, is easily available in kernel
tree, and will be extended to AMD QoS and ARM MPAM.

The selftest tool is in tools/testing/selftests/resctrl in order to have
generic test code for all architectures.

Changelog:
v4: 
- address comments from Balu and Randy
- Add CAT and CQM tests

v3:
- Change code based on comments from Babu Moger
- Remove some unnessary code and use pipe to communicate b/w processes

v2:
- Change code based on comments from Babu Moger
- Clean up other places.

Arshiya Hayatkhan Pathan (4):
  selftests/resctrl: Add MBM test
  selftests/resctrl: Add MBA test
  selftests/resctrl Add Cache QoS Monitoring (CQM) selftest
  selftests/resctrl: Add Cache Allocation Technology (CAT) selftest

Fenghua Yu (2):
  selftests/resctrl: Add README for resctrl tests
  selftests/resctrl: Add the test in MAINTAINERS

Sai Praneeth Prakhya (4):
  selftests/resctrl: Add basic resctrl file system operations and data
  selftests/resctrl: Read memory bandwidth from perf IMC counter and
    from resctrl file system
  selftests/resctrl: Add callback to start a benchmark
  selftests/resctrl: Add built in benchmark

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/resctrl/Makefile      |  16 +
 tools/testing/selftests/resctrl/README        |  53 ++
 tools/testing/selftests/resctrl/cache.c       | 275 +++++++
 tools/testing/selftests/resctrl/cat_test.c    | 243 ++++++
 tools/testing/selftests/resctrl/cqm_test.c    | 169 ++++
 tools/testing/selftests/resctrl/fill_buf.c    | 198 +++++
 tools/testing/selftests/resctrl/mba_test.c    | 174 +++++
 tools/testing/selftests/resctrl/mbm_test.c    | 146 ++++
 tools/testing/selftests/resctrl/resctrl.h     | 104 +++
 .../testing/selftests/resctrl/resctrl_tests.c | 175 +++++
 tools/testing/selftests/resctrl/resctrl_val.c | 727 ++++++++++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 643 ++++++++++++++++
 13 files changed, 2924 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/Makefile
 create mode 100644 tools/testing/selftests/resctrl/README
 create mode 100644 tools/testing/selftests/resctrl/cache.c
 create mode 100644 tools/testing/selftests/resctrl/cat_test.c
 create mode 100644 tools/testing/selftests/resctrl/cqm_test.c
 create mode 100644 tools/testing/selftests/resctrl/fill_buf.c
 create mode 100644 tools/testing/selftests/resctrl/mba_test.c
 create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl.h
 create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl_val.c
 create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c

-- 
2.19.1

