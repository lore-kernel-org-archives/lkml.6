Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05671C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86642173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfAKAFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:05:16 -0500
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:41830 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726217AbfAKAFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:05:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1536F1801C5D0;
        Fri, 11 Jan 2019 00:05:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: snail38_107682c3f5010
X-Filterd-Recvd-Size: 1765
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Jan 2019 00:05:12 +0000 (UTC)
Message-ID: <8b02899853247a2c67669561761f354dd3bd110e.camel@perches.com>
Subject: [PATCH] checkpatch: Verify SPDX comment style
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 10 Jan 2019 16:05:11 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using SPDX commenting style // or /* is specified for
various file types in Documentation/process/license-rules.rst
so add an appropriate test for .[chsS] files because many
proposed file additions and patches do not use the correct style.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 155fa9305166..44c2a876be43 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3039,6 +3039,14 @@ sub process {
 					$comment = '..';
 				}
 
+# check SPDX comment style for .[chsS] files
+				if ($realfile =~ /\.[chsS]$/ &&
+				    $rawline =~ /SPDX-License-Identifier:/ &&
+				    $rawline !~ /^\+\s*\Q$comment\E\s*/) {
+					WARN("SPDX_LICENSE_TAG",
+					     "Improper SPDX comment style for '$realfile', please use '$comment' instead\n" . $herecurr);
+				}
+
 				if ($comment !~ /^$/ &&
 				    $rawline !~ /^\+\Q$comment\E SPDX-License-Identifier: /) {
 					 WARN("SPDX_LICENSE_TAG",


