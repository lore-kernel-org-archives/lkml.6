Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeCFDrq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:47:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:42932 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752857AbeCFDrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:47:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="22835506"
From: changbin.du@intel.com
To: acme@kernel.org, jolsa@redhat.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH v2 0/2] perf sched map: re-annotate shortname if thread comm changed
Date: Tue,  6 Mar 2018 11:37:35 +0800
Message-Id: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

v2:
  o add a patch to move thread::shortname to thread_runtime
  o add function perf_sched__process_comm() to process PERF_RECORD_COMM event.

Changbin Du (2):
  perf sched: move thread::shortname to thread_runtime
  perf sched map: re-annotate shortname if thread comm changed

 tools/perf/builtin-sched.c | 132 ++++++++++++++++++++++++++++++---------------
 tools/perf/util/thread.h   |   1 -
 2 files changed, 90 insertions(+), 43 deletions(-)

-- 
2.7.4
