Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbeCGODV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:03:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:30688 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753168AbeCGODS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:03:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="36206779"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] perf intel-pt: Some fixes and preparation for AUX area sampling
Date: Wed,  7 Mar 2018 16:02:20 +0200
Message-Id: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are 4 fixes for Intel PT plus 5 more patches in preparation for
supporting AUX area sampling.


Adrian Hunter (9):
      perf intel-pt: Fix overlap detection to identify consecutive buffers correctly
      perf intel-pt: Fix sync_switch
      perf intel-pt: Fix error recovery from missing TIP packet
      perf intel-pt: Fix timestamp following overflow
      perf intel-pt/bts: In auxtrace_record__init_intel() evlist is never NULL
      perf intel-pt: Get rid of intel_pt_use_buffer_pid_tid()
      perf intel-pt: Tidy old_buffer handling in intel_pt_get_trace()
      perf intel-pt: Remove a check for sampling mode
      perf intel-pt: Adjust overlap-checking to support sampling mode

 tools/perf/arch/x86/util/auxtrace.c                |  14 +--
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  64 ++++++------
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   2 +-
 tools/perf/util/intel-pt.c                         | 110 +++++++++------------
 4 files changed, 84 insertions(+), 106 deletions(-)


Regards
Adrian
