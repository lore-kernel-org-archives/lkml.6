Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E482C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B652088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B652088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbeHBXQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:16:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:55346 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeHBXQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:16:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 14:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,436,1526367600"; 
   d="scan'208";a="59269375"
Received: from mzylowski-dev.igk.intel.com ([10.102.102.210])
  by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2018 14:23:36 -0700
From:   Michal Zylowski <michal.zylowski@intel.com>
To:     joe@perches.com, apw@canonical.com
Cc:     michal.zylowski@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: Check for space after "else" keyword
Date:   Thu,  2 Aug 2018 23:20:21 +0200
Message-Id: <1533244821-31004-1-git-send-email-michal.zylowski@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current checkpatch implementation permits notation like:
} else{
in kernel code.
It looks like oversight and inconsistency in checkpatch rules (e.g.
instruction like 'do' is tested).

Add regex for checking space after 'else' keyword and trigger error if
space is not present.

Signed-off-by: Michal Zylowski <michal.zylowski@intel.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e16d671..2e3f41e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4479,6 +4479,7 @@ sub process {
 
 #need space before brace following if, while, etc
 		if (($line =~ /\(.*\)\{/ && $line !~ /\($Type\)\{/) ||
+		    $line =~ /else\{/ ||
 		    $line =~ /do\{/) {
 			if (ERROR("SPACING",
 				  "space required before the open brace '{'\n" . $herecurr) &&
-- 
2.7.4

