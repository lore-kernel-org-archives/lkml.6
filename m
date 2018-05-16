Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeEPTaT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:30:19 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39836 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeEPTaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:30:18 -0400
X-Google-Smtp-Source: AB8JxZqfVWgCzctQLbmjxwX7N+oWaas+d72nd0UgHGnJJgbh0EoklA4okOmy/qMKN4MxitMJ7aRL9w==
From: Mathieu Malaterre <malat@debian.org>
To: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Mathieu Malaterre <malat@debian.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?tracing:=20make=20function=20=E2=80=98ftrace=5F?= =?UTF-8?q?exports=E2=80=99=20static?=
Date: Wed, 16 May 2018 21:30:12 +0200
Message-Id: <20180516193012.25390-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 478409dd683d ("tracing: Add hook to function tracing for other
subsystems to use"), a new function ‘ftrace_exports’ was added. Since
this function can be made static, make it so.

Silence the following warning triggered using W=1:

  kernel/trace/trace.c:2451:6: warning: no previous prototype for ‘ftrace_exports’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 414d7210b2ec..76b96f453cf7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2448,7 +2448,7 @@ static inline void ftrace_exports_disable(void)
 	static_branch_disable(&ftrace_exports_enabled);
 }
 
-void ftrace_exports(struct ring_buffer_event *event)
+static void ftrace_exports(struct ring_buffer_event *event)
 {
 	struct trace_export *export;
 
-- 
2.11.0
