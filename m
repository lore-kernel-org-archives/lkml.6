Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDYCGK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 22:06:10 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:16837 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750882AbeDYCGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 22:06:07 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="39285205"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/vector: Remove the macro VECTOR_OFFSET_START
Date: Wed, 25 Apr 2018 10:05:53 +0800
Message-ID: <20180425020553.17210-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 00E034B31495.AF39A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, Linux uses matrix allocator for vector assignment, the original
assignment code which used VECTOR_OFFSET_START has been removed.

So remove the stale macro as well

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/include/asm/irq_vectors.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 404c5fdff859..57003074bd7a 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -34,11 +34,6 @@
  * (0x80 is the syscall vector, 0x30-0x3f are for ISA)
  */
 #define FIRST_EXTERNAL_VECTOR		0x20
-/*
- * We start allocating at 0x21 to spread out vectors evenly between
- * priority levels. (0x80 is the syscall vector)
- */
-#define VECTOR_OFFSET_START		1
 
 /*
  * Reserve the lowest usable vector (and hence lowest priority)  0x20 for
-- 
2.14.3
