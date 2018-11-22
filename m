Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BA7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597EF20672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597EF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392692AbeKVS0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:26:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:24626 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbeKVS0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:26:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 23:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,264,1539673200"; 
   d="scan'208";a="98189364"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Nov 2018 23:47:52 -0800
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] include: Add lantiq.h in include/linux/
Date:   Thu, 22 Nov 2018 15:47:35 +0800
Message-Id: <20181122074736.417-1-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
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

