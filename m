Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9BFC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336E9219C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336E9219C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeHFLHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:07:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:43263 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeHFLHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:07:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 01:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,451,1526367600"; 
   d="scan'208";a="80979395"
Received: from mzylowski-dev.igk.intel.com ([10.102.102.210])
  by orsmga002.jf.intel.com with ESMTP; 06 Aug 2018 01:58:37 -0700
From:   Michal Zylowski <michal.zylowski@intel.com>
To:     joe@perches.com, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org, michal.zylowski@intel.com
Subject: [PATCH v3] checkpatch: Check for space after "else" keyword
Date:   Mon,  6 Aug 2018 10:55:53 +0200
Message-Id: <1533545753-8870-1-git-send-email-michal.zylowski@intel.com>
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
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 447857f..f7e135a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4483,11 +4483,11 @@ sub process {
 
 #need space before brace following if, while, etc
 		if (($line =~ /\(.*\)\{/ && $line !~ /\($Type\)\{/) ||
-		    $line =~ /do\{/) {
+		    $line =~ /\b(?:else|do)\{/) {
 			if (ERROR("SPACING",
 				  "space required before the open brace '{'\n" . $herecurr) &&
 			    $fix) {
-				$fixed[$fixlinenr] =~ s/^(\+.*(?:do|\)))\{/$1 {/;
+				$fixed[$fixlinenr] =~ s/^(\+.*(?:do|else|\)))\{/$1 {/;
 			}
 		}
 
-- 
2.7.4

