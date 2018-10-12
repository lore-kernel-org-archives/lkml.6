Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F392C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005D920644
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005D920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJMARg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:17:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:38186 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeJMARg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:17:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 09:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="78322500"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 12 Oct 2018 09:44:14 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org,
        viresh.kumar@linaro.org, robert.moore@intel.com,
        erik.schmauss@intel.com
Cc:     juri.lelli@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, devel@acpica.org,
        pprakash@codeaurora.org, george.cherian@cavium.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/3] cpufreq: intel_pstate: Base frequency attribute
Date:   Fri, 12 Oct 2018 09:43:57 -0700
Message-Id: <20181012164400.3479-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series presents base frequency to cpufreq sysfs when intel_pstate
is in use in HWP mode.

Changes:
v3:
- Update documentation
v2
- Removed guaranteed attribute addition to acpi_cppc sysfs
- Using the cppc_acpi interface to get base frequency and present

Srinivas Pandruvada (3):
  ACPI / CPPC: Add support for guaranteed performance
  cpufreq: intel_pstate: Add base_frequency attribute
  Documentation: intel_pstate: Add base_frequency information

 Documentation/admin-guide/pm/intel_pstate.rst |  4 ++
 drivers/acpi/cppc_acpi.c                      |  8 +++-
 drivers/cpufreq/intel_pstate.c                | 38 +++++++++++++++++++
 include/acpi/cppc_acpi.h                      |  1 +
 4 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.17.1

