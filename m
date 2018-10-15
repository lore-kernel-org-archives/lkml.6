Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EC3C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853A620881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853A620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeJPBXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:23:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:10068 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbeJPBXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:23:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 10:37:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,385,1534834800"; 
   d="scan'208";a="88528385"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Oct 2018 10:37:26 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org,
        viresh.kumar@linaro.org, robert.moore@intel.com,
        erik.schmauss@intel.com
Cc:     juri.lelli@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, devel@acpica.org,
        pprakash@codeaurora.org, george.cherian@cavium.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 3/3] Documentation: intel_pstate: Add base_frequency information
Date:   Mon, 15 Oct 2018 10:37:21 -0700
Message-Id: <20181015173721.66147-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181015173721.66147-1-srinivas.pandruvada@linux.intel.com>
References: <20181015173721.66147-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated documentation to explain base_frequency attribute.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 8f1d3de449b5..ac6f5c597a56 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -465,6 +465,13 @@ Next, the following policy attributes have special meaning if
 	policy for the time interval between the last two invocations of the
 	driver's utilization update callback by the CPU scheduler for that CPU.
 
+One more policy attribute is present if the `HWP feature is enabled in the
+processor <Active Mode With HWP_>`_:
+
+``base_frequency``
+	Shows the base frequency of the CPU. Any frequency above this will be
+	in the turbo frequency range.
+
 The meaning of these attributes in the `passive mode <Passive Mode_>`_ is the
 same as for other scaling drivers.
 
-- 
2.17.1

