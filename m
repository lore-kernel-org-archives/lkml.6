Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbeFABH1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:07:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:61910 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbeFABH0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:07:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,464,1520924400";
   d="scan'208";a="46392494"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 0/3] perf script python: Add more PMU fields
Date: Fri,  1 Jun 2018 17:01:00 +0800
Message-Id: <1527843663-32288-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing pmu sampling and then running a script with
perf script -s script.py, the process_event function gets
dictionary with some fields from the perf ring buffer
(like ip, sym, callchain etc).

But we miss quite a few fields we report now, for example,
LBRs,data source,weight,transaction,iregs,uregs,and etc.

This patch adds these fields for perf script python.

Jin Yao (3):
  perf script python: Move dsoname code to a new function
  perf script python: Add more PMU fields
  perf script python: Add fields introduction to Documentation

 tools/perf/Documentation/perf-script-python.txt    |  26 +++
 .../util/scripting-engines/trace-event-python.c    | 250 ++++++++++++++++++++-
 2 files changed, 267 insertions(+), 9 deletions(-)

-- 
2.7.4
