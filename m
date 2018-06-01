Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeFAGup (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:50:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:28531 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750903AbeFAGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:50:42 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40641734"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/vector: Fix the args of vector_alloc tracepoint
Date: Fri, 1 Jun 2018 14:50:31 +0800
Message-ID: <20180601065031.21872-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: BA92248AE92A.A2E36
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vector_alloc tracepont reversed the reserved and ret aggs, that made
the trace print wrong. Exchange them.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/include/asm/trace/irq_vectors.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index 22647a642e98..0af81b590a0c 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -236,7 +236,7 @@ TRACE_EVENT(vector_alloc,
 	TP_PROTO(unsigned int irq, unsigned int vector, bool reserved,
 		 int ret),
 
-	TP_ARGS(irq, vector, ret, reserved),
+	TP_ARGS(irq, vector, reserved, ret),
 
 	TP_STRUCT__entry(
 		__field(	unsigned int,	irq		)
-- 
2.14.3
