Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937949-2-13197756927511585313
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937948; b=btMOfPPouR2SBjRGaGEt0yaJnSwqRudq8FjytXTSiFFXjB/zQb
    jmQHj4W9yNoqp9ejkwcT9v2b9Dsp0OpBoYweGuLY7Tul0uareXW+CRuE7kOQ0fiO
    rxIXMxdXAVvip+2grCPMs14/h3cjXBGi7LFrqemAEFEWh3W7XoHs3DAzrhg+Td3W
    LQZQiILdJGLBv5rDuXySYWuGYlQHrPqAvPEkdC+uN+GtaMKcg3uRB+HS0O8UbWnu
    2BpPT0fjBe1JW1QovT666PImhBm2+SbOxnjyYGqHMg134pENi2qx/PTnQaJE+NFF
    cSjI3FcMJ85AVvfTPDWFjQ8kNwR4PbDyV9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937948; bh=x6Wx8cvYVN+LNShZumrWhcEV3Itbuw
    dRpSV3F6KToxQ=; b=BHXej6nsE8eZK0/gzlWQAhAbVN0r99SwZakuUbMpV4jrK4
    NLKxc1OEqsEoSewtVltGWVFvQ2JtoZeBdbkOoTw/JsdvXTmrbFYe4DIX7audNV/U
    UkaqQWkOTn2AuCZ3X9+Qilx8hRhTcQhdErzUWh7LA5PvErvDaJfjBh8sgB3mKyMK
    cVWeRKdUH4dKdYGDqlLGiLBnjlurAenmtKz8sGs9uZAhR7HTXOZVdz9UjykltU5+
    lKTJ+NnukRuTf5VCBK7gVkKDJpQbslbgwQrT+Tc1Pf3Wk4mpLTZoVrUCP9nj2hC3
    DxBSrMV2kYD06iQkcJMYgyYagh5sEPOsFzR6tRig==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Lr2GtcTH x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Lr2GtcTH x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFA844i0bdcQ8zJLLPcBt7c4YotVFuonz6z8MCbJ2ci5EPwFz7VvyjI2mLCNqAm0YYOMm/Bk0htt7fB6E6U6FO/nb8kOXOwI4Ph+10D41ZUs0wzd/hd7
    LMflB8yssg1jYWxDUYNcL3vxM3QSraS8xzVaH7GNPZdLaGgSdQhNciS6r7akvPtqazvKzHn3HK/SxLF/tZ/37fBs+RdxEob4+OFJ6LXghttbzKomvjxkdoPN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=snBq1zaXqlLkKPC2OVoA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbeEUVZo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754323AbeEUVZl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:25:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 082/110] prctl: Add force disable speculation
Date: Mon, 21 May 2018 23:12:19 +0200
Message-Id: <20180521210513.486334100@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 356e4bfff2c5489e016fdb925adbf12a1e3950ee upstream

For certain use cases it is desired to enforce mitigations so they cannot
be undone afterwards. That's important for loader stubs which want to
prevent a child from disabling the mitigation again. Will also be used for
seccomp(). The extra state preserving of the prctl state for SSB is a
preparatory step for EBPF dymanic speculation control.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/userspace-api/spec_ctrl.rst |   34 ++++++++++++++++++-----------
 arch/x86/kernel/cpu/bugs.c                |   35 +++++++++++++++++++++---------
 fs/proc/array.c                           |    3 ++
 include/linux/sched.h                     |   10 +++++++-
 include/uapi/linux/prctl.h                |    1 
 5 files changed, 59 insertions(+), 24 deletions(-)

--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -25,19 +25,21 @@ PR_GET_SPECULATION_CTRL
 -----------------------
 
 PR_GET_SPECULATION_CTRL returns the state of the speculation misfeature
-which is selected with arg2 of prctl(2). The return value uses bits 0-2 with
+which is selected with arg2 of prctl(2). The return value uses bits 0-3 with
 the following meaning:
 
-==== ================ ===================================================
-Bit  Define           Description
-==== ================ ===================================================
-0    PR_SPEC_PRCTL    Mitigation can be controlled per task by
-                      PR_SET_SPECULATION_CTRL
-1    PR_SPEC_ENABLE   The speculation feature is enabled, mitigation is
-                      disabled
-2    PR_SPEC_DISABLE  The speculation feature is disabled, mitigation is
-                      enabled
-==== ================ ===================================================
+==== ===================== ===================================================
+Bit  Define                Description
+==== ===================== ===================================================
+0    PR_SPEC_PRCTL         Mitigation can be controlled per task by
+                           PR_SET_SPECULATION_CTRL
+1    PR_SPEC_ENABLE        The speculation feature is enabled, mitigation is
+                           disabled
+2    PR_SPEC_DISABLE       The speculation feature is disabled, mitigation is
+                           enabled
+3    PR_SPEC_FORCE_DISABLE Same as PR_SPEC_DISABLE, but cannot be undone. A
+                           subsequent prctl(..., PR_SPEC_ENABLE) will fail.
+==== ===================== ===================================================
 
 If all bits are 0 the CPU is not affected by the speculation misfeature.
 
@@ -47,9 +49,11 @@ misfeature will fail.
 
 PR_SET_SPECULATION_CTRL
 -----------------------
+
 PR_SET_SPECULATION_CTRL allows to control the speculation misfeature, which
 is selected by arg2 of :manpage:`prctl(2)` per task. arg3 is used to hand
-in the control value, i.e. either PR_SPEC_ENABLE or PR_SPEC_DISABLE.
+in the control value, i.e. either PR_SPEC_ENABLE or PR_SPEC_DISABLE or
+PR_SPEC_FORCE_DISABLE.
 
 Common error codes
 ------------------
@@ -70,10 +74,13 @@ Value   Meaning
 0       Success
 
 ERANGE  arg3 is incorrect, i.e. it's neither PR_SPEC_ENABLE nor
-        PR_SPEC_DISABLE
+        PR_SPEC_DISABLE nor PR_SPEC_FORCE_DISABLE
 
 ENXIO   Control of the selected speculation misfeature is not possible.
         See PR_GET_SPECULATION_CTRL.
+
+EPERM   Speculation was disabled with PR_SPEC_FORCE_DISABLE and caller
+        tried to enable it again.
 ======= =================================================================
 
 Speculation misfeature controls
@@ -84,3 +91,4 @@ Speculation misfeature controls
    * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, 0, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_ENABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_DISABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_FORCE_DISABLE, 0, 0);
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -533,21 +533,37 @@ static void ssb_select_mitigation()
 
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
-	bool rds = !!test_tsk_thread_flag(task, TIF_RDS);
+	bool update;
 
 	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL)
 		return -ENXIO;
 
-	if (ctrl == PR_SPEC_ENABLE)
-		clear_tsk_thread_flag(task, TIF_RDS);
-	else
-		set_tsk_thread_flag(task, TIF_RDS);
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		/* If speculation is force disabled, enable is not allowed */
+		if (task_spec_ssb_force_disable(task))
+			return -EPERM;
+		task_clear_spec_ssb_disable(task);
+		update = test_and_clear_tsk_thread_flag(task, TIF_RDS);
+		break;
+	case PR_SPEC_DISABLE:
+		task_set_spec_ssb_disable(task);
+		update = !test_and_set_tsk_thread_flag(task, TIF_RDS);
+		break;
+	case PR_SPEC_FORCE_DISABLE:
+		task_set_spec_ssb_disable(task);
+		task_set_spec_ssb_force_disable(task);
+		update = !test_and_set_tsk_thread_flag(task, TIF_RDS);
+		break;
+	default:
+		return -ERANGE;
+	}
 
 	/*
 	 * If being set on non-current task, delay setting the CPU
 	 * mitigation until it is next scheduled.
 	 */
-	if (task == current && rds != !!test_tsk_thread_flag(task, TIF_RDS))
+	if (task == current && update)
 		speculative_store_bypass_update();
 
 	return 0;
@@ -559,7 +575,9 @@ static int ssb_prctl_get(struct task_str
 	case SPEC_STORE_BYPASS_DISABLE:
 		return PR_SPEC_DISABLE;
 	case SPEC_STORE_BYPASS_PRCTL:
-		if (test_tsk_thread_flag(task, TIF_RDS))
+		if (task_spec_ssb_force_disable(task))
+			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
+		if (task_spec_ssb_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
 	default:
@@ -572,9 +590,6 @@ static int ssb_prctl_get(struct task_str
 int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 			     unsigned long ctrl)
 {
-	if (ctrl != PR_SPEC_ENABLE && ctrl != PR_SPEC_DISABLE)
-		return -ERANGE;
-
 	switch (which) {
 	case PR_SPEC_STORE_BYPASS:
 		return ssb_prctl_set(task, ctrl);
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -356,6 +356,9 @@ static inline void task_seccomp(struct s
 	case PR_SPEC_NOT_AFFECTED:
 		seq_printf(m, "not vulnerable");
 		break;
+	case PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE:
+		seq_printf(m, "thread force mitigated");
+		break;
 	case PR_SPEC_PRCTL | PR_SPEC_DISABLE:
 		seq_printf(m, "thread mitigated");
 		break;
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1365,7 +1365,8 @@ static inline bool is_percpu_thread(void
 #define PFA_NO_NEW_PRIVS		0	/* May not gain new privileges. */
 #define PFA_SPREAD_PAGE			1	/* Spread page cache over cpuset */
 #define PFA_SPREAD_SLAB			2	/* Spread some slab caches over cpuset */
-
+#define PFA_SPEC_SSB_DISABLE		3	/* Speculative Store Bypass disabled */
+#define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1390,6 +1391,13 @@ TASK_PFA_TEST(SPREAD_SLAB, spread_slab)
 TASK_PFA_SET(SPREAD_SLAB, spread_slab)
 TASK_PFA_CLEAR(SPREAD_SLAB, spread_slab)
 
+TASK_PFA_TEST(SPEC_SSB_DISABLE, spec_ssb_disable)
+TASK_PFA_SET(SPEC_SSB_DISABLE, spec_ssb_disable)
+TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ssb_disable)
+
+TASK_PFA_TEST(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
+TASK_PFA_SET(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
+
 static inline void
 current_restore_flags(unsigned long orig_flags, unsigned long flags)
 {
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -217,5 +217,6 @@ struct prctl_mm_map {
 # define PR_SPEC_PRCTL			(1UL << 0)
 # define PR_SPEC_ENABLE			(1UL << 1)
 # define PR_SPEC_DISABLE		(1UL << 2)
+# define PR_SPEC_FORCE_DISABLE		(1UL << 3)
 
 #endif /* _LINUX_PRCTL_H */
