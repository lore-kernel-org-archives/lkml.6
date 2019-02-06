Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A07C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7822075D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfBFKl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:41:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:23275 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbfBFKl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:41:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 02:41:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="115647655"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.56])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2019 02:41:23 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] perf intel-pt: A few fixes
Date:   Wed,  6 Feb 2019 12:39:42 +0200
Message-Id: <20190206103947.15750-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some fixes and a minor improvement for Intel PT.  The first 3
patches are cc stable, but the last 2 are not.


Adrian Hunter (5):
      perf auxtrace: Define auxtrace record alignment
      perf intel-pt: Fix overlap calculation for padding
      perf intel-pt: Fix CYC timestamp calculation after OVF
      perf intel-pt: Packet splitting can happen only on 32-bit
      perf auxtrace: Add timestamp to auxtrace errors

 tools/perf/util/auxtrace.c                         | 26 ++++++++++++---
 tools/perf/util/auxtrace.h                         |  5 ++-
 tools/perf/util/event.h                            |  3 +-
 tools/perf/util/intel-bts.c                        |  4 +--
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 39 +++++++++++++++++++---
 tools/perf/util/intel-pt.c                         | 23 +++++++++----
 tools/perf/util/s390-cpumsf.c                      |  7 ++--
 tools/perf/util/session.c                          |  3 ++
 8 files changed, 88 insertions(+), 22 deletions(-)


Regards
Adrian
