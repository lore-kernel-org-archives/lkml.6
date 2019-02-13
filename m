Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93668C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD2F2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394908AbfBMVhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:37:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:41474 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389703AbfBMVg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:36:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 13:36:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="274859816"
Received: from chang-linux-2.sc.intel.com ([10.3.52.165])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2019 13:36:56 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v6 02/12] kbuild: Raise the minimum required binutils version to 2.21
Date:   Wed, 13 Feb 2019 13:36:14 -0800
Message-Id: <20190213213624.14354-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213213624.14354-1-chang.seok.bae@intel.com>
References: <20190213213624.14354-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It helps to use some new instructions directly in assembly code.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linux Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 Documentation/process/changes.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 18735dc460a0..0a18075c485e 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with isdn4k-utils.
 ====================== ===============  ========================================
 GNU C                  4.6              gcc --version
 GNU make               3.81             make --version
-binutils               2.20             ld -v
+binutils               2.21             ld -v
 flex                   2.5.35           flex --version
 bison                  2.0              bison --version
 util-linux             2.10o            fdformat --version
@@ -77,9 +77,7 @@ You will need GNU make 3.81 or later to build the kernel.
 Binutils
 --------
 
-The build system has, as of 4.13, switched to using thin archives (`ar T`)
-rather than incremental linking (`ld -r`) for built-in.a intermediate steps.
-This requires binutils 2.20 or newer.
+Binutils 2.21 or newer is needed to build the kernel.
 
 pkg-config
 ----------
-- 
2.19.1

