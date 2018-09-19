Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EFBECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B5220671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B5220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbeISRDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:03:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:53385 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbeISRDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:03:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 04:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="74247559"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga007.jf.intel.com with ESMTP; 19 Sep 2018 04:25:25 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] perf intel-pt: Improve the data displayed when using address filters
Date:   Wed, 19 Sep 2018 14:23:32 +0300
Message-Id: <20180919112338.20347-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some Intel PT patches to improve the data displayed when using
address filters - refer patch 6.


Adrian Hunter (6):
      perf script: Enhance sample flags for trace begin / end
      perf db-export: Add trace begin / end branch type variants
      perf tools: Improve thread_stack__event() for trace begin / end
      perf tools: Improve thread_stack__process() for trace begin / end
      perf intel-pt: Add decoder flags for trace begin / end
      perf intel-pt: Implement decoder flags for trace begin / end

 tools/perf/builtin-script.c                        | 36 +++++++++++----
 tools/perf/util/db-export.c                        | 22 ++++++++++
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 34 ++++++++++-----
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  2 +
 tools/perf/util/intel-pt.c                         |  5 +++
 tools/perf/util/thread-stack.c                     | 51 +++++++++++++++++-----
 6 files changed, 118 insertions(+), 32 deletions(-)


Regards
Adrian
