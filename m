Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5A8C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB30219A2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB30219A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeHEWvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:51:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:20555 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbeHEWvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:51:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2018 13:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,449,1526367600"; 
   d="scan'208";a="246322100"
Received: from mzylowski-dev.igk.intel.com ([10.102.102.210])
  by orsmga005.jf.intel.com with ESMTP; 05 Aug 2018 13:45:10 -0700
From:   Michal Zylowski <michal.zylowski@intel.com>
To:     joe@perches.com, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org, michal.zylowski@intel.com
Subject: [PATCH v2] checkpatch: Check for space after "else" keyword
Date:   Sun,  5 Aug 2018 22:42:20 +0200
Message-Id: <1533501740-451-1-git-send-email-michal.zylowski@intel.com>
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
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 447857f..81617b8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4483,7 +4483,7 @@ sub process {
 
 #need space before brace following if, while, etc
 		if (($line =~ /\(.*\)\{/ && $line !~ /\($Type\)\{/) ||
-		    $line =~ /do\{/) {
+		    $line =~ /\b(?:else|do)\{/) {
 			if (ERROR("SPACING",
 				  "space required before the open brace '{'\n" . $herecurr) &&
 			    $fix) {
-- 
2.7.4

