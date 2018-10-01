Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3B8C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932C22089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932C22089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeJANLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:11:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:10732 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbeJANLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:11:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2018 23:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,326,1534834800"; 
   d="scan'208";a="77466470"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2018 23:30:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/19] perf scripts python: call-graph-from-sql.py / exported-sql-viewer.py disassembly
Date:   Mon,  1 Oct 2018 09:28:34 +0300
Message-Id: <20181001062853.28285-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some patches to the call-graph-from-sql.py script which is renamed
exported-sql-viewer.py in patch 12 "perf scripts python: 
call-graph-from-sql.py: Rename to exported-sql-viewer.py".  The purpose of
these patches is to add support for disassembly - refer patch 23 "perf
scripts python: exported-sql-viewer.py: Add All branches report"


Adrian Hunter (19):
      perf scripts python: call-graph-from-sql.py: Use SPDX license identifier
      perf scripts python: call-graph-from-sql.py: Provide better default column sizes
      perf scripts python: call-graph-from-sql.py: Set a minimum window size
      perf scripts python: call-graph-from-sql.py: Change icon
      perf scripts python: call-graph-from-sql.py: Make a "Main" function
      perf scripts python: call-graph-from-sql.py: Separate the database details into a class
      perf scripts python: call-graph-from-sql.py: Add a class for global data
      perf scripts python: call-graph-from-sql.py: Remove use of setObjectName()
      perf scripts python: call-graph-from-sql.py: Factor out CallGraphModel from TreeModel
      perf scripts python: call-graph-from-sql.py: Add data helper functions
      perf scripts python: call-graph-from-sql.py: Refactor TreeItem class
      perf scripts python: call-graph-from-sql.py: Rename to exported-sql-viewer.py
      perf scripts python: exported-sql-viewer.py: Add support for multiple sub-windows
      perf scripts python: exported-sql-viewer.py: Add ability to find symbols in the call-graph
      perf scripts python: exported-sql-viewer.py: Add ability to shrink / enlarge font
      perf scripts python: exported-sql-viewer.py: Add ability to display all the database tables
      perf scripts python: exported-sql-viewer.py: Add All branches report
      perf scripts python: exported-sql-viewer.py: Add Selected branches report
      perf scripts python: exported-sql-viewer.py: Add help window

 tools/perf/Documentation/intel-pt.txt             |    2 +-
 tools/perf/scripts/python/call-graph-from-sql.py  |  339 ---
 tools/perf/scripts/python/export-to-postgresql.py |    2 +-
 tools/perf/scripts/python/export-to-sqlite.py     |    2 +-
 tools/perf/scripts/python/exported-sql-viewer.py  | 2536 +++++++++++++++++++++
 5 files changed, 2539 insertions(+), 342 deletions(-)
 delete mode 100644 tools/perf/scripts/python/call-graph-from-sql.py
 create mode 100755 tools/perf/scripts/python/exported-sql-viewer.py


Regards
Adrian
