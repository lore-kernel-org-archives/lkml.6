Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeCIMhO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932166AbeCIMhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:37:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDDF206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Yang Bo <yangbo@deepin.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH -tip 3/9] kprobes: Remove jprobe data structure and interfaces
Date: Fri,  9 Mar 2018 21:36:47 +0900
Message-Id: <152059900768.4214.1382786082808054746.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152059891712.4214.9539716544254881611.stgit@devbox>
References: <152059891712.4214.9539716544254881611.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all interfaces of jprobe since it is no more
used.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |   44 --------------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index b520baa65682..f7a6c398b4bf 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -155,24 +155,6 @@ static inline int kprobe_ftrace(struct kprobe *p)
 }
 
 /*
- * Special probe type that uses setjmp-longjmp type tricks to resume
- * execution at a specified entry with a matching prototype corresponding
- * to the probed function - a trick to enable arguments to become
- * accessible seamlessly by probe handling logic.
- * Note:
- * Because of the way compilers allocate stack space for local variables
- * etc upfront, regardless of sub-scopes within a function, this mirroring
- * principle currently works only for probes placed on function entry points.
- */
-struct jprobe {
-	struct kprobe kp;
-	void *entry;	/* probe handling code to jump to */
-};
-
-/* For backward compatibility with old code using JPROBE_ENTRY() */
-#define JPROBE_ENTRY(handler)	(handler)
-
-/*
  * Function-return probe -
  * Note:
  * User needs to provide a handler function, and initialize maxactive.
@@ -436,9 +418,6 @@ static inline void unregister_kprobe(struct kprobe *p)
 static inline void unregister_kprobes(struct kprobe **kps, int num)
 {
 }
-static inline void jprobe_return(void)
-{
-}
 static inline int register_kretprobe(struct kretprobe *rp)
 {
 	return -ENOSYS;
@@ -465,20 +444,6 @@ static inline int enable_kprobe(struct kprobe *kp)
 	return -ENOSYS;
 }
 #endif /* CONFIG_KPROBES */
-static inline int register_jprobe(struct jprobe *p)
-{
-	return -ENOSYS;
-}
-static inline int register_jprobes(struct jprobe **jps, int num)
-{
-	return -ENOSYS;
-}
-static inline void unregister_jprobe(struct jprobe *p)
-{
-}
-static inline void unregister_jprobes(struct jprobe **jps, int num)
-{
-}
 static inline int disable_kretprobe(struct kretprobe *rp)
 {
 	return disable_kprobe(&rp->kp);
@@ -487,15 +452,6 @@ static inline int enable_kretprobe(struct kretprobe *rp)
 {
 	return enable_kprobe(&rp->kp);
 }
-static inline int disable_jprobe(struct jprobe *jp)
-{
-	return -ENOSYS;
-}
-static inline int enable_jprobe(struct jprobe *jp)
-{
-	return -ENOSYS;
-}
-
 #ifndef CONFIG_KPROBES
 static inline bool is_kprobe_insn_slot(unsigned long addr)
 {
