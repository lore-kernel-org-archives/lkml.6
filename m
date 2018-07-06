Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D2FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B81D21CFA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B81D21CFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932470AbeGFImM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:42:12 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:44574 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeGFImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:42:10 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id 7Li71y00P3XaVaC06Li7lr; Fri, 06 Jul 2018 10:42:07 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fbMJb-0004py-7P; Fri, 06 Jul 2018 10:42:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fbMJb-0006s8-5E; Fri, 06 Jul 2018 10:42:07 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 resend] checkpatch: Update section keywords
Date:   Fri,  6 Jul 2018 10:42:05 +0200
Message-Id: <20180706084205.26367-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit bd721ea73e1f9655 ("treewide: replace obsolete _refok by
__ref"), __init_refok no longer exists, so it can be removed.
While at it, add the modern variants that were still missing.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Joe Perches <joe@perches.com>
---
v2:
  - Add Acked-by,
  - Improve one-line summary.
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c05506e325fc84..8d0bad190c25e2e0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -346,9 +346,10 @@ our $Sparse	= qr{
 			__force|
 			__iomem|
 			__must_check|
-			__init_refok|
 			__kprobes|
 			__ref|
+			__refconst|
+			__refdata|
 			__rcu|
 			__private
 		}x;
-- 
2.17.1

