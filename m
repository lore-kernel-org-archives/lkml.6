Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D87C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2158520878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2158520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJHSLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:11:00 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:53122 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeJHSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:11:00 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id kyzo1y00X3XaVaC06yzotU; Mon, 08 Oct 2018 12:59:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9TGO-0004ye-Qo; Mon, 08 Oct 2018 12:59:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9TGO-0006Zf-OY; Mon, 08 Oct 2018 12:59:48 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] lib/vsprintf: Remove %pCr remnant in comment
Date:   Mon,  8 Oct 2018 12:59:46 +0200
Message-Id: <20181008105946.25230-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for "%pCr" was removed, but a reference in a comment was
forgotten.

Fixes: 666902e42fd8344b ("lib/vsprintf: Remove atomic-unsafe support for %pCr")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Probably this wasn't noticed due to commit 5e4ee7b13b522d07 ("printk:
synchronize %p formatting documentation") removing another reference.
---
 lib/vsprintf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b1909ca755932539..095a677f89c02442 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1832,7 +1832,6 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
  *       (legacy clock framework) of the clock
  * - 'Cn' For a clock, it prints the name (Common Clock Framework) or address
  *        (legacy clock framework) of the clock
- * - 'Cr' For a clock, it prints the current rate of the clock
  * - 'G' For flags to be printed as a collection of symbolic strings that would
  *       construct the specific value. Supported flags given by option:
  *       p page flags (see struct page) given as pointer to unsigned long
-- 
2.17.1

