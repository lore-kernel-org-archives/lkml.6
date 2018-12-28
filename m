Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEB7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6824420869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbeL1PeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:34:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:47516 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbeL1PeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:34:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 07:34:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,410,1539673200"; 
   d="scan'208";a="133497180"
Received: from dlipka-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.42.217])
  by fmsmga001.fm.intel.com with ESMTP; 28 Dec 2018 07:34:06 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     jani.nikula@intel.com
Subject: [PATCH] kernel.h: unconditionally include asm/div64.h for do_div()
Date:   Fri, 28 Dec 2018 17:34:30 +0200
Message-Id: <20181228153430.23763-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.11.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include asm/div64.h for do_div() usage in DIV_ROUND_DOWN_ULL() and
DIV_ROUND_CLOSEST_ULL(). Remove the old CONFIG_LBDAF=y conditional
include.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75b51ba..20e3a87d31d6 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -14,6 +14,7 @@
 #include <linux/printk.h>
 #include <linux/build_bug.h>
 #include <asm/byteorder.h>
+#include <asm/div64.h>
 #include <uapi/linux/kernel.h>
 
 #define USHRT_MAX	((u16)(~0U))
@@ -204,7 +205,6 @@
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
 
 #ifdef CONFIG_LBDAF
-# include <asm/div64.h>
 # define sector_div(a, b) do_div(a, b)
 #else
 # define sector_div(n, b)( \
-- 
2.11.0

