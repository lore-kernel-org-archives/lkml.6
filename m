Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeDHLg6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 07:36:58 -0400
Received: from m50-133.163.com ([123.125.50.133]:39143 "EHLO m50-133.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbeDHLg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 07:36:57 -0400
From: yuan linyu <cugyly@163.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
        yuan linyu <Linyu.Yuan@alcatel-sbell.com.cn>
Subject: [PATCH for-next v2] tracing: optimize trace_buffer_iter()
Date: Sun,  8 Apr 2018 19:36:31 +0800
Message-Id: <20180408113631.3947-1-cugyly@163.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DdGowAAXfSLQ_slaTxpYAw--.44370S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFyxAFyktw4xGF4xXF43Wrg_yoW3KFc_Za
        4DW3ZrKr4jkF1qya13JaykXryjvwn8XF1Fkw4DtFZ8Aw1UJwn5Xw1rXr90yr98ua4vqFy2
        qrsIgr40vFn3WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU81q2tUUUUU==
X-Originating-IP: [180.157.30.106]
X-CM-SenderInfo: pfxj5zr16rljoofrz/xtbB0xEi41XldhpcsQAAsy
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuan linyu <Linyu.Yuan@alcatel-sbell.com.cn>

use conditional operation.

Signed-off-by: yuan linyu <Linyu.Yuan@alcatel-sbell.com.cn>
---
 kernel/trace/trace.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6fb46a06c9dc..bda717ab2095 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -582,9 +582,7 @@ static __always_inline void trace_clear_recursion(int bit)
 static inline struct ring_buffer_iter *
 trace_buffer_iter(struct trace_iterator *iter, int cpu)
 {
-	if (iter->buffer_iter && iter->buffer_iter[cpu])
-		return iter->buffer_iter[cpu];
-	return NULL;
+	return iter->buffer_iter ? iter->buffer_iter[cpu] : NULL;
 }
 
 int tracer_init(struct tracer *t, struct trace_array *tr);
-- 
2.14.1
