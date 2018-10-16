Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB99C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFA3205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFA3205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeJQAwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:52:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:15627 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeJQAwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:52:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 10:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,389,1534834800"; 
   d="scan'208";a="100736179"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 16 Oct 2018 10:00:54 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Date:   Tue, 16 Oct 2018 09:56:34 -0700
Message-Id: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
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

The tests are in tools/testing/selftests/resctrl in order to have
generic test code for all architectures.

Arshiya Hayatkhan Pathan (2):
  selftests/resctrl: Add mbm test
  selftests/resctrl: Add mba test

Fenghua Yu (1):
  selftests/resctrl: Add the test in MAINTAINERS

Sai Praneeth Prakhya (4):
  selftests/resctrl: Add basic resctrl file system operations and data
  selftests/resctrl: Read memory bandwidth from perf IMC counter and
    from resctrl file system
  selftests/resctrl: Add callback to start a benchmark
  selftests/resctrl: Add built in benchmark

 MAINTAINERS                                     |   1 +
 tools/testing/selftests/resctrl/Makefile        |  16 ++
 tools/testing/selftests/resctrl/fill_buf.c      | 178 ++++++++++++
 tools/testing/selftests/resctrl/mba.c           | 144 ++++++++++
 tools/testing/selftests/resctrl/mbm.c           | 113 ++++++++
 tools/testing/selftests/resctrl/resctrl.c       | 367 ++++++++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl.h       | 107 +++++++
 tools/testing/selftests/resctrl/resctrl_membw.c | 328 +++++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl_membw.h |  49 ++++
 tools/testing/selftests/resctrl/resctrl_tests.c | 104 +++++++
 tools/testing/selftests/resctrl/resctrl_val.c   | 192 +++++++++++++
 11 files changed, 1599 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/Makefile
 create mode 100644 tools/testing/selftests/resctrl/fill_buf.c
 create mode 100644 tools/testing/selftests/resctrl/mba.c
 create mode 100644 tools/testing/selftests/resctrl/mbm.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl.h
 create mode 100644 tools/testing/selftests/resctrl/resctrl_membw.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl_membw.h
 create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl_val.c

-- 
2.5.0

