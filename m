Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22027C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE5721738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfA1M1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:27:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:21827 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfA1M1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:27:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 04:27:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="139402563"
Received: from elena-thinkpad-x230.fi.intel.com ([10.237.68.34])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2019 04:27:39 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, keescook@chromium.org, tglx@linutronix.de,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 0/3] perf refcount_t conversions
Date:   Mon, 28 Jan 2019 14:27:25 +0200
Message-Id: <1548678448-24458-1-git-send-email-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another set of old patches, rebased and this time the commits
also updated since we merged the docs in past and also
refcount_dec_and_test() gets new acquire ordering on success
very soon, which is also reflected in commit messages.


Elena Reshetova (3):
  perf: convert perf_event_context.refcount to refcount_t
  perf/ring_buffer: convert ring_buffer.refcount to refcount_t
  perf/ring_buffer: convert ring_buffer.aux_refcount to refcount_t

 include/linux/perf_event.h  |  3 ++-
 kernel/events/core.c        | 18 +++++++++---------
 kernel/events/internal.h    |  5 +++--
 kernel/events/ring_buffer.c |  8 ++++----
 4 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.7.4

