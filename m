Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911BBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FED421920
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394565AbfBOL5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:57:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:25055 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730972AbfBOL5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:57:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 03:57:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="134556841"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2019 03:57:05 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v0 0/2] perf: Address range filtering fixes
Date:   Fri, 15 Feb 2019 13:56:53 +0200
Message-Id: <20190215115655.63469-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

These are bugfixes for the address range filtering. One had been posted
before [1], but fell through the cracks. One was discovered and originally
patched by Adrian recently. Both can be theoretically backported all the
way to v4.7, but that may require manual conflict resolution and the
benefits are not clear.

[1] https://marc.info/?l=linux-kernel&m=153900881208142

Alexander Shishkin (2):
  perf: Copy parent's address filter offsets on clone
  perf, pt, coresight: Fix address filters for vmas with non-zero offset

 arch/x86/events/intel/pt.c                    |  9 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |  7 +-
 include/linux/perf_event.h                    |  7 +-
 kernel/events/core.c                          | 90 ++++++++++++-------
 4 files changed, 74 insertions(+), 39 deletions(-)

-- 
2.20.1

