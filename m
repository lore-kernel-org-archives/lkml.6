Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081B8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10EC2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10EC2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeKQIiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:38:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:20405 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeKQIiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:38:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 14:24:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,241,1539673200"; 
   d="scan'208";a="96936490"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2018 14:24:37 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, yu.c.chen@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] Documentation: intel_pstate: Clarify coordination of P-State limits
Date:   Fri, 16 Nov 2018 14:24:20 -0800
Message-Id: <20181116222420.24260-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181116222420.24260-1-srinivas.pandruvada@linux.intel.com>
References: <20181116222420.24260-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain influence of per-core P-states and hyper threading on the
effective performance.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index ac6f5c597a56..ec0f7c111f65 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -495,7 +495,15 @@ on the following rules, regardless of the current operation mode of the driver:
 
  2. Each individual CPU is affected by its own per-policy limits (that is, it
     cannot be requested to run faster than its own per-policy maximum and it
-    cannot be requested to run slower than its own per-policy minimum).
+    cannot be requested to run slower than its own per-policy minimum). The
+    effective performance depends on whether the platform supports per core
+    P-states, hyper-threading is enabled and on current performance requests
+    from other CPUs. When platform doesn't support per core P-states, the
+    effective performance can be more than the policy limits set on a CPU, if
+    other CPUs are requesting higher performance at that moment. Even with per
+    core P-states support, when hyper-threading is enabled, if the sibling CPU
+    is requesting higher performance, the other siblings will get higher
+    performance than their policy limits.
 
  3. The global and per-policy limits can be set independently.
 
-- 
2.17.1

