Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3134CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5332177B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394262AbfBOL3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:29:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:63706 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfBOL3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:29:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 03:29:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="138871113"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2019 03:29:44 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH] scripts: gdb: redefine MS_RDONLY
Date:   Fri, 15 Feb 2019 13:29:38 +0200
Message-Id: <20190215112938.25574-1-felipe.balbi@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e262e32d6bde0f77fb0c95d977482fc872c51996 "vfs: Suppress
MS_* flag defs within the kernel unless explicitly enabled", the
generated gdb scripts can't be used anymore. That commit moved the
definition of MS_* flags but forgot to update gdb scripts to use the
new location. This patch includes <uapi/linux/mount.h> to
constants.py.in so gdb scripts are functional again.

Fixes: e262e32d6bde "vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled"
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 scripts/gdb/linux/constants.py.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 7aad82406422..c2a93805d911 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -13,6 +13,7 @@
  */
 
 #include <linux/fs.h>
+#include <uapi/linux/mount.h>
 #include <linux/mount.h>
 #include <linux/of_fdt.h>
 
-- 
2.20.1

