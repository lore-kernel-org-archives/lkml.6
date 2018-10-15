Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419A5C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1AE2148C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1AE2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJPBXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:23:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:10068 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbeJPBXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:23:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 10:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,385,1534834800"; 
   d="scan'208";a="88528356"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Oct 2018 10:37:24 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org,
        viresh.kumar@linaro.org, robert.moore@intel.com,
        erik.schmauss@intel.com
Cc:     juri.lelli@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, devel@acpica.org,
        pprakash@codeaurora.org, george.cherian@cavium.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 0/3] cpufreq: intel_pstate: Base frequency attribute
Date:   Mon, 15 Oct 2018 10:37:18 -0700
Message-Id: <20181015173721.66147-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series presents base frequency to cpufreq sysfs when intel_pstate
is in use in HWP mode.

Changes:
v4:
- Documentation update only as suggested by Rafael

v3:
- Update documentation
v2
- Removed guaranteed attribute addition to acpi_cppc sysfs
- Using the cppc_acpi interface to get base frequency and present

Srinivas Pandruvada (3):
  ACPI / CPPC: Add support for guaranteed performance
  cpufreq: intel_pstate: Add base_frequency attribute
  Documentation: intel_pstate: Add base_frequency information

 Documentation/admin-guide/pm/intel_pstate.rst |  7 ++++
 drivers/acpi/cppc_acpi.c                      |  8 +++-
 drivers/cpufreq/intel_pstate.c                | 38 +++++++++++++++++++
 include/acpi/cppc_acpi.h                      |  1 +
 4 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.17.1

