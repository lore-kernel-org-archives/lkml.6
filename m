Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90DAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C9E21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfBSP1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:27:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:50310 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSP1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:27:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 07:27:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="116110541"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.14])
  by orsmga007.jf.intel.com with ESMTP; 19 Feb 2019 07:27:19 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] docs: Explicitly state that the 'Fixes:' tag shouldn't split lines
Date:   Tue, 19 Feb 2019 07:27:15 -0800
Message-Id: <20190219152715.5674-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...and use a commit with an obnoxiously long summary in the example to
make it abundantly clear that keeping the tag on a single line takes
priority over wrapping at 75 columns.  Without the explicit exemption,
one might assume splitting the tag is acceptable, even encouraged, e.g.
due to being conditioned by checkpatch's line length warning.

Per Stephen's scripts[1] and implied by commit bf4daf12a9fb ("checkpatch:
avoid some commit message long line warnings"), splitting the 'Fixes:'
tag across multiple lines is a no-no, presumably because parsing multi-
line tags is unnecessarily painful.

[1] https://lkml.kernel.org/r/20190216183433.71b7cfa7@canb.auug.org.au

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 Documentation/process/submitting-patches.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 30dc00a364e8..be7d1829c3af 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -182,9 +182,11 @@ change five years from now.
 
 If your patch fixes a bug in a specific commit, e.g. you found an issue using
 ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
-the SHA-1 ID, and the one line summary.  For example::
+the SHA-1 ID, and the one line summary.  Do not split the tag across multiple
+lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
+parsing scripts.  For example::
 
-	Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")
+	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
 
 The following ``git config`` settings can be used to add a pretty format for
 outputting the above style in the ``git log`` or ``git show`` commands::
-- 
2.20.1

