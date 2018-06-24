Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD0C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CC624EC3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CC624EC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeFXLqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 07:46:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44862 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeFXLqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 07:46:08 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX3T5-0004SR-3W; Sun, 24 Jun 2018 13:46:07 +0200
Date:   Sun, 24 Jun 2018 13:46:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] core updates for 4.18
Message-ID: <alpine.DEB.2.21.1806241344340.8650@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

Two tiny fixes:

 - Add the missing machine_real_restart() to objtools noreturn list so it
   stops complaining

 - Fix a trivial comment typo

Thanks,

	tglx

------------------>
Josh Poimboeuf (1):
      objtool: Add machine_real_restart() to the noreturn list

Wei Wang (1):
      kernel.h: Fix a typo in comment


 include/linux/kernel.h | 2 +-
 tools/objtool/check.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d23123238534..941dc0a5a877 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -666,7 +666,7 @@ do {									\
  * your code. (Extra memory is used for special buffers that are
  * allocated when trace_printk() is used.)
  *
- * A little optization trick is done here. If there's only one
+ * A little optimization trick is done here. If there's only one
  * argument, there's no need to scan the string for printf formats.
  * The trace_puts() will suffice. But how can we take advantage of
  * using trace_puts() when trace_printk() has only one argument?
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 38047c6aa575..f4a25bd1871f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -164,6 +164,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"lbug_with_loc",
 		"fortify_panic",
 		"usercopy_abort",
+		"machine_real_restart",
 	};
 
 	if (func->bind == STB_WEAK)
