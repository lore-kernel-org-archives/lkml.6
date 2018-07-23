Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCB1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9355D204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9355D204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbeGWWbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:31:10 -0400
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:41077 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388096AbeGWWbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:31:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 416EC837F24D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 21:28:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: side89_2909cd9177305
X-Filterd-Recvd-Size: 1522
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 21:28:01 +0000 (UTC)
Message-ID: <0753cae7829b98998ac3f5f9fcb52ba1f2475ee1.camel@perches.com>
Subject: [RFC PATCH] checkpatch: Discourage use with --f/--file outside of
 drivers/staging ?
From:   Joe Perches <joe@perches.com>
To:     LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 23 Jul 2018 14:28:00 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps some patch like this could help reduce the
number of ill-considered checkpatch submissions
for files outside of drivers/staging/

Concept and message wordsmithing appreciated...
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 34e4683de7a3..1a93421d5b1d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2483,6 +2483,10 @@ sub process {
 				WARN("OBSOLETE",
 				     "$realfile is marked as 'obsolete' in the MAINTAINERS hierarchy.  No unnecessary modifications please.\n");
 			}
+			if ($file && $filename !~ m@^drivers/staging/@) {
+				WARN("CHECKPATCH_FILE",
+				     "Using -f/--file with '$realfile' may not be appropriate.\n");
+			}
 			if ($realfile =~ m@^(?:drivers/net/|net/|drivers/staging/)@) {
 				$check = 1;
 			} else {

