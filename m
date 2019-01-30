Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460C4C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230DE20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfA3LS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:18:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:23826 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbfA3LS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:18:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 03:18:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="129725718"
Received: from elena-thinkpad-x230.fi.intel.com ([10.237.68.34])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jan 2019 03:18:57 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        andrea.parri@amarulasolutions.com, stern@rowland.harvard.edu,
        keescook@chromium.org, Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH v2] Adding smp_acquire__after_ctrl_dep barrier
Date:   Wed, 30 Jan 2019 13:18:50 +0200
Message-Id: <1548847131-27854-1-git-send-email-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - hopefully fixed all (at least to my eye and to checkpatch)
   errors on whitespacing, etc.
 - changed text on ACQUIRE guarantees pointed by Andrea and
   Dmitry
 - removed mentioning of control dependency on dec/sub_and_test
   variants

I also have to send it now with a cover letter, because I think
it is Intel mailer that malformed the patch last time for god knows
what reason...

Elena Reshetova (1):
  refcount_t: add ACQUIRE ordering on success for dec(sub)_and_test
    variants

 Documentation/core-api/refcount-vs-atomic.rst | 24 +++++++++++++++++++++---
 arch/x86/include/asm/refcount.h               | 22 ++++++++++++++++++----
 lib/refcount.c                                | 18 +++++++++++++-----
 3 files changed, 52 insertions(+), 12 deletions(-)

-- 
2.7.4

