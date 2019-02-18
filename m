Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC1FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBD821905
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfBRHXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:23:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:1259 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfBRHXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:23:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2019 23:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,383,1544515200"; 
   d="scan'208";a="319903549"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga006.fm.intel.com with ESMTP; 17 Feb 2019 23:23:36 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH v2] scripts: gdb: redefine MS_RDONLY
Date:   Mon, 18 Feb 2019 09:23:34 +0200
Message-Id: <20190218072334.27527-1-felipe.balbi@linux.intel.com>
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

While at that, also remove <linux/fs.h> since it's no longer
necessary.

Fixes: e262e32d6bde "vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled"
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---

Changes since v1:
	- keep alphabetical order of included headers
	- remove <linux/fs.h>

 scripts/gdb/linux/constants.py.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 7aad82406422..ad7c8047970c 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -12,9 +12,9 @@
  *
  */
 
-#include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/of_fdt.h>
+#include <uapi/linux/mount.h>
 
 /* We need to stringify expanded macros so that they can be parsed */
 
-- 
2.20.1

