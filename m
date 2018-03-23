Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeCWPNZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751551AbeCWPNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:13:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E742183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180323151322.545146499@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 23 Mar 2018 11:02:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        =?ISO-8859-15?q?Am=C3=A9rico=20Wang?= <xiyou.wangcong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/3] init: Fix initcall0 name as it is "pure" not "early"
References: <20180323150241.878778199@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0001-init-Fix-initcall0-name-as-it-is-pure-not-early.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The early_initcall() functions get assigned to __initcall_start[]. These are
called by do_pre_smp_initcalls(). The initcall_levels[] array starts with
__initcall0_start[], and initcall_levels[] are to match the
initcall_level_names[] array. The first name in that array is "early", but
that is not correct. As pure_initcall() functions get assigned to
__initcall0_start[] array.

Change the first name in initcall_level_names[] array to "pure".

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 969eaf140ef0..0ebdd5f15be8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -874,7 +874,7 @@ static initcall_t *initcall_levels[] __initdata = {
 
 /* Keep these in sync with initcalls in include/linux/init.h */
 static char *initcall_level_names[] __initdata = {
-	"early",
+	"pure",
 	"core",
 	"postcore",
 	"arch",
-- 
2.15.1
