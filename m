Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeCWTw7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:52:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43733 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbeCWTw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:52:58 -0400
Date: Fri, 23 Mar 2018 12:52:30 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-b7fa07460b0f0e9fbe6d9319a0864c145bd59bcb@git.kernel.org>
Cc: mulix@mulix.org, joro@8bytes.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, konrad.wilk@oracle.com, hch@lst.de,
        thomas.lendacky@amd.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        jdmason@kudzu.us, mingo@kernel.org
Reply-To: mulix@mulix.org, tglx@linutronix.de, joro@8bytes.org, hpa@zytor.com,
        peterz@infradead.org, hch@lst.de, konrad.wilk@oracle.com,
        thomas.lendacky@amd.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        jdmason@kudzu.us, mingo@kernel.org
In-Reply-To: <20180319103826.12853-11-hch@lst.de>
References: <20180319103826.12853-11-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/dma] set_memory.h: Provide set_memory_{en,de}crypted()
 stubs
Git-Commit-ID: b7fa07460b0f0e9fbe6d9319a0864c145bd59bcb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b7fa07460b0f0e9fbe6d9319a0864c145bd59bcb
Gitweb:     https://git.kernel.org/tip/b7fa07460b0f0e9fbe6d9319a0864c145bd59bcb
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon, 19 Mar 2018 11:38:22 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 10:01:58 +0100

set_memory.h: Provide set_memory_{en,de}crypted() stubs

... to make these APIs more universally available.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: iommu@lists.linux-foundation.org
Link: http://lkml.kernel.org/r/20180319103826.12853-11-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
