Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeCNRxF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:53:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeCNRxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:53:02 -0400
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] set_memory.h: provide set_memory_{en,de}crypted stubs
Date: Wed, 14 Mar 2018 18:52:09 +0100
Message-Id: <20180314175213.20256-11-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180314175213.20256-1-hch@lst.de>
References: <20180314175213.20256-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/set_memory.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index e5140648f638..da5178216da5 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -17,4 +17,16 @@ static inline int set_memory_x(unsigned long addr,  int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
+#ifndef CONFIG_ARCH_HAS_MEM_ENCRYPT
+static inline int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	return 0;
+}
+
+static inline int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	return 0;
+}
+#endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
+
 #endif /* _LINUX_SET_MEMORY_H_ */
-- 
2.14.2
