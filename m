Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4103318-1526051158-2-10513117065067310010
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526051157; b=JghPaDbMlCg5OMvI9lffCQackYzhy+cTCL/YoV4wJ1EqqBcHC8
    0F6PGosy+KUufwamTv+Xg6UXxyP4TGf/gtCRlLCA6Et844d9NynCibS2ab4W51hU
    bL/rY8sVH37TmbdRIjnXWXog+e+8ufyrEfmopt9tzqzcmUVYsm2go6YvTGJuhFKF
    6kSrLDlq5fUtbplx0A5a98wtrL9dEcWCG5PKeaqWRAC1Jlw4ZNaQmgIupAnYuain
    FHHkdrLodHuj1jWvd8/yTluxpK0IX/93hGraxJeRTkTOdimmqiNr/j9SPzdGIrwu
    wjD3s+UsWKL+8gVvKEmImDYw36VCglHBp9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526051157; bh=
    hh1CaIinupGHZpQcq2kwNRbqLeccCvBnJmAflYvFtYw=; b=PBP7I/43UCbXoeNn
    GGhN92pDE+DfmR4FOcjrvZE3g7a+lssmopgeNYT302m35iEFkyxPqwuIfytKQHuj
    ZbximF8y6k9CEGJf0ThPIu51crIlGgfpF649vKO71mb5R23CSS2GWhElOgHfhgrl
    uZqPH+FsIL3gCrVq0SQ3vMt0aVoyCytwPn8mddwmNU/d8qO9emeMCg+GzruZ5K/h
    1+Cp6Cvtyjj2rF8FKuPQ1zXEcMnVtti71zuszt4Q+dnWbNOGrbwTDbQnl74YAb+U
    UB7v1wOb34jWZ8bZ2smxivOq6klVf8FkVYV0rG7quUxUhe2GDNbWLoOr6Mnwm/8y
    LFJ16w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCYDjW9hbpEtYUIkz9ZRWKpneT2iKSBAfQI6PFsDI3lz0gXcl2rSG98kJ3bcQrd3ojDx/eh8Pz+4WUZ0WqE8DTPZZn015v5OjzeY0FclkW5BnpHAo6qF
    GUA9Cw187EfuJ3ONiRd2ZTBgqM1NkVN22Njr/tZZPbbPam09N3/fR8Wp2vhuWQSgO/Y0r+mFRfl8DXdDQzii8Zr5BZBEt6FjIsn3ahTOTxzCRcdIqAVxl+5V
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7CQSdrXTAAAA:8
    a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=meVymXHHAAAA:8 a=pE4TgV8UHm7zwFFQi6kA:9
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbeEKPFz (ORCPT <rfc822;linux@kroah.com>);
        Fri, 11 May 2018 11:05:55 -0400
Received: from foss.arm.com ([217.140.101.70]:43150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753145AbeEKPFy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 May 2018 11:05:54 -0400
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Subject: [PATCH REPOST 1/5] thread_info: Port core code to use update_thread_flag() helpers
Date: Fri, 11 May 2018 16:05:00 +0100
Message-Id: <1526051104-15995-2-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
References: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch ports a couple of relevant bits of the core kernel to
use the new update_thread_flag() helpers.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 include/trace/syscall.h |  6 ++----
 kernel/ptrace.c         | 13 +++++--------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index dc8ac27..dcc9bdf 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -37,10 +37,8 @@ struct syscall_metadata {
 #if defined(CONFIG_TRACEPOINTS) && defined(CONFIG_HAVE_SYSCALL_TRACEPOINTS)
 static inline void syscall_tracepoint_update(struct task_struct *p)
 {
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		set_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
-	else
-		clear_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
+	update_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT,
+			       test_thread_flag(TIF_SYSCALL_TRACEPOINT));
 }
 #else
 static inline void syscall_tracepoint_update(struct task_struct *p)
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 21fec73..7a2bd8d 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -785,16 +785,13 @@ static int ptrace_resume(struct task_struct *child, long request,
 	if (!valid_signal(data))
 		return -EIO;
 
-	if (request == PTRACE_SYSCALL)
-		set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-	else
-		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+	update_tsk_thread_flag(child, TIF_SYSCALL_TRACE,
+			       request == PTRACE_SYSCALL);
 
 #ifdef TIF_SYSCALL_EMU
-	if (request == PTRACE_SYSEMU || request == PTRACE_SYSEMU_SINGLESTEP)
-		set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-	else
-		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+	update_tsk_thread_flag(child, TIF_SYSCALL_EMU,
+			       request == PTRACE_SYSEMU ||
+			       request == PTRACE_SYSEMU_SINGLESTEP);
 #endif
 
 	if (is_singleblock(request)) {
-- 
2.1.4
