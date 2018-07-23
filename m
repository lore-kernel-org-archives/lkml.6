Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87440ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4906820846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4906820846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbeGWJcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:32:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:12449 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387925AbeGWJcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:32:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 01:32:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,392,1526367600"; 
   d="scan'208";a="73662981"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2018 01:31:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 643FAB2; Mon, 23 Jul 2018 11:31:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] tracing: Trivia spelling fix containerof() -> container_of()
Date:   Mon, 23 Jul 2018 11:31:59 +0300
Message-Id: <20180723083159.82112-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only location on kernel that has wrong spelling
of the container_of() helper. Fix it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/trace/trace_printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 50f44b7b2b32..3cd7b0fcacc6 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -114,7 +114,7 @@ static int module_trace_bprintk_format_notify(struct notifier_block *self,
  * section, then we need to read the link list pointers. The trick is
  * we pass the address of the string to the seq function just like
  * we do for the kernel core formats. To get back the structure that
- * holds the format, we simply use containerof() and then go to the
+ * holds the format, we simply use container_of() and then go to the
  * next format in the list.
  */
 static const char **
-- 
2.18.0

