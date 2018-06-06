Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A7416070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbeFFLoi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:44:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeFFLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:44:36 -0400
Date: Wed, 6 Jun 2018 04:44:30 -0700
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-838d76d63ec4eaeaa12bedfa50f261480f615200@git.kernel.org>
Cc: hpa@zytor.com, douly.fnst@cn.fujitsu.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, douly.fnst@cn.fujitsu.com
In-Reply-To: <20180601065031.21872-1-douly.fnst@cn.fujitsu.com>
References: <20180601065031.21872-1-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/vector: Fix the args of vector_alloc
 tracepoint
Git-Commit-ID: 838d76d63ec4eaeaa12bedfa50f261480f615200
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

Commit-ID:  838d76d63ec4eaeaa12bedfa50f261480f615200
Gitweb:     https://git.kernel.org/tip/838d76d63ec4eaeaa12bedfa50f261480f615200
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Fri, 1 Jun 2018 14:50:31 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 13:38:02 +0200

x86/vector: Fix the args of vector_alloc tracepoint

The vector_alloc tracepont reversed the reserved and ret aggs, that made
the trace print wrong. Exchange them.

Fixes: 8d1e3dca7de6 ("x86/vector: Add tracepoints for vector management")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180601065031.21872-1-douly.fnst@cn.fujitsu.com

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
