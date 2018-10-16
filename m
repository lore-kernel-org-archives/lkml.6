Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615EEC5ACC7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE56205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE56205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJPRJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:09:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:23695 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeJPRJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:09:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 02:20:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="95614644"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga002.fm.intel.com with ESMTP; 16 Oct 2018 02:20:20 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     gregkh@linuxfoundation.org, paul.burton@mips.com, jslaby@suse.com,
        Songjun Wu <songjun.wu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 11/14] include: Add lantiq.h in include/linux/
Date:   Tue, 16 Oct 2018 17:19:12 +0800
Message-Id: <20181016091915.19909-12-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181016091915.19909-1-songjun.wu@linux.intel.com>
References: <20181016091915.19909-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some existing lantiq driver, the C codes include lantiq_soc.h
header file directly.

./arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
./arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h

Those drivers need to be extended to support more platform.
lantiq.h is added in include/linux/ to make it
globally available and provides some wrapper codes.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 include/linux/lantiq.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 include/linux/lantiq.h

diff --git a/include/linux/lantiq.h b/include/linux/lantiq.h
new file mode 100644
index 000000000000..67921169d84d
--- /dev/null
+++ b/include/linux/lantiq.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_LANTIQ_H
+#define __LINUX_LANTIQ_H
+
+#ifdef CONFIG_LANTIQ
+#include <lantiq_soc.h>
+#else
+
+#ifndef LTQ_EARLY_ASC
+#define LTQ_EARLY_ASC 0
+#endif
+
+#ifndef CPHYSADDR
+#define CPHYSADDR(a) 0
+#endif
+
+static inline struct clk *clk_get_fpi(void)
+{
+	return NULL;
+}
+#endif /* CONFIG_LANTIQ */
+#endif /* __LINUX_LANTIQ_H */
-- 
2.11.0

