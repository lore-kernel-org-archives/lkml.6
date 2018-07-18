Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07776ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19062075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19062075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbeGRCQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:16:51 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:35838
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731368AbeGRCQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:16:51 -0400
X-ASG-Debug-ID: 1531878081-093b7e2c7ced810001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id XhA8BpWbYVwAsHfM (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO); Wed, 18 Jul 2018 09:41:21 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from y.localdomain (10.5.21.109) by HXTBJIDCEMVIW01.hxtcorp.net
 (10.128.0.14) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 18 Jul
 2018 09:41:26 +0800
From:   Shunyong Yang <shunyong.yang@hxt-semitech.com>
To:     <bhelgaas@google.com>
CC:     <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH v2] PCI: Unify pci and normal dma direction definition
Date:   Wed, 18 Jul 2018 09:40:35 +0800
X-ASG-Orig-Subj: [PATCH v2] PCI: Unify pci and normal dma direction definition
Message-ID: <1531878035-33147-1-git-send-email-shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1531878081
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6578 1.0000 1.0712
X-Barracuda-Spam-Score: 1.07
X-Barracuda-Spam-Status: No, SCORE=1.07 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.53880
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current DMA direction definitions in pci-dma-compat.h and dma-direction.h
are mirrored in value. Unifying them to enhance readability and avoid
possible inconsistency.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---

v2:
  Remove unnecessary comments and  braces according to Christoph's
  comments.

---
 include/linux/dma-direction.h  | 6 ++----
 include/linux/pci-dma-compat.h | 8 ++++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/dma-direction.h b/include/linux/dma-direction.h
index 3649a031893a..9c96e30e6a0b 100644
--- a/include/linux/dma-direction.h
+++ b/include/linux/dma-direction.h
@@ -1,14 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_DMA_DIRECTION_H
 #define _LINUX_DMA_DIRECTION_H
-/*
- * These definitions mirror those in pci.h, so they can be used
- * interchangeably with their PCI_ counterparts.
- */
+
 enum dma_data_direction {
 	DMA_BIDIRECTIONAL = 0,
 	DMA_TO_DEVICE = 1,
 	DMA_FROM_DEVICE = 2,
 	DMA_NONE = 3,
 };
+
 #endif
diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
index 0dd1a3f7b309..c3f1b44ade29 100644
--- a/include/linux/pci-dma-compat.h
+++ b/include/linux/pci-dma-compat.h
@@ -8,10 +8,10 @@
 #include <linux/dma-mapping.h>
 
 /* This defines the direction arg to the DMA mapping routines. */
-#define PCI_DMA_BIDIRECTIONAL	0
-#define PCI_DMA_TODEVICE	1
-#define PCI_DMA_FROMDEVICE	2
-#define PCI_DMA_NONE		3
+#define PCI_DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL
+#define PCI_DMA_TODEVICE	DMA_TO_DEVICE
+#define PCI_DMA_FROMDEVICE	DMA_FROM_DEVICE
+#define PCI_DMA_NONE		DMA_NONE
 
 static inline void *
 pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
-- 
1.8.3.1

