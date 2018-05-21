Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937363-2-3200208442646187566
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
    1526937362; b=JXOIiKY7S+G647h1x38b3pRz4nzXokI2hHVNM+PpOK929sIZCD
    DoNBASmpxLwN6zgnNFO2WC9eyeCOgBelpLNODPJnoCBy++iy15WczIBABE9EcR9q
    DnNSaQ50+fbghIraKYq5WgeCFM3vpqah4kN6nK4FklJjyZGLKmVG2mpThVnN+zb9
    XIgIhlrN7BBYpRuNrwds0KTBGizXR/ADQ4ECJtzt6FCsXM1kH0+xpZ9HKBi4QCEq
    ZVN6LAfOBxW9xs3bfLfLNkLJXyOIjvE0ZXN4HtApFPL+9ChjKEWclhK2fLx1Gu8b
    UND4i8LO13Xhhu6IwRlzs0pO1+65UdPww8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937362; bh=32VhyS9Cjcu+auZUP333ngrw/YDdj5
    eIJVH07OOjjjI=; b=E+YnrTHSROgrLGAop5IkPx5JkDP2jt4LbRWJNs2qi1E5HO
    cJ9sBpw9xaTZd5g/4W8GiYrRFAeAdCQGeN8vqN4Aq6awbD3qQ3bjzQDxG1+31Iq3
    dy3GvXh2lVCYw1A4apsb7QvkUpRA+PI6RR3aEQwKYxqfkkfqDxMjY56NiuDzA8iz
    ErAeCDGNC8P2o7CU5pggIQcjhx90ARB2NgBC3Ow5T8NkQENT8wo3NdGxoOCeQpeU
    EubqYDqFJXlogh2bJW2I5vJ35ZV1z9xaoLT9YJcvLnHKUxd47Ht3fw+D6DG0mHNr
    xavmuUOmZ81vCv3DGNdEVpx3uADj1GDFGdaGENoA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=tOL6BngC x-bits=1024 x-keytype=rsa
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
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=tOL6BngC x-bits=1024 x-keytype=rsa
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
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGd6wPzT0Xp9YOq7+8KUPctjTKEHplISc7BjdzKXzPZQ0OYh+Ffw87cVtrjiVRBiLw34WFptyYcxSAttTY7D8+QjzofO/aegX/WvbKQGZ1iYowERU4Q8
    uOtPk9ghuj7Np4H935QeHJz2OmIDzQHHqM1UEIwIdlZm9fXexeGsxuvApY0/JMhkwunfRoTNaJxRrxVOisY3qi2l/UJNsM+9hiTTTjrY4lg4Rb4vU19nCYpw
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pBOR-ozoAAAA:8 a=ag1SF4gXAAAA:8
    a=m6mvUTsYLrbOjcjEJ40A:9 a=8XtiAd7W4JV_ukEN:21 a=lnEqGrVe7ClR6n43:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeEUVQA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752823AbeEUVPw (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:15:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 49/87] prctl: Add speculation control prctls
Date: Mon, 21 May 2018 23:11:25 +0200
Message-Id: <20180521210424.851779323@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit b617cfc858161140d69cc0b5cc211996b557a1c7 upstream

Add two new prctls to control aspects of speculation related vulnerabilites
and their mitigations to provide finer grained control over performance
impacting mitigations.

PR_GET_SPECULATION_CTRL returns the state of the speculation misfeature
which is selected with arg2 of prctl(2). The return value uses bit 0-2 with
the following meaning:

Bit  Define           Description
0    PR_SPEC_PRCTL    Mitigation can be controlled per task by
                      PR_SET_SPECULATION_CTRL
1    PR_SPEC_ENABLE   The speculation feature is enabled, mitigation is
                      disabled
2    PR_SPEC_DISABLE  The speculation feature is disabled, mitigation is
                      enabled

If all bits are 0 the CPU is not affected by the speculation misfeature.

If PR_SPEC_PRCTL is set, then the per task control of the mitigation is
available. If not set, prctl(PR_SET_SPECULATION_CTRL) for the speculation
misfeature will fail.

PR_SET_SPECULATION_CTRL allows to control the speculation misfeature, which
is selected by arg2 of prctl(2) per task. arg3 is used to hand in the
control value, i.e. either PR_SPEC_ENABLE or PR_SPEC_DISABLE.

The common return values are:

EINVAL  prctl is not implemented by the architecture or the unused prctl()
        arguments are not 0
ENODEV  arg2 is selecting a not supported speculation misfeature

PR_SET_SPECULATION_CTRL has these additional return values:

ERANGE  arg3 is incorrect, i.e. it's not either PR_SPEC_ENABLE or PR_SPEC_DISABLE
ENXIO   prctl control of the selected speculation misfeature is disabled

The first supported controlable speculation misfeature is
PR_SPEC_STORE_BYPASS. Add the define so this can be shared between
architectures.

Based on an initial patch from Tim Chen and mostly rewritten.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/spec_ctrl.txt |   86 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nospec.h      |    5 ++
 include/uapi/linux/prctl.h  |   11 +++++
 kernel/sys.c                |   22 +++++++++++
 4 files changed, 124 insertions(+)
 create mode 100644 Documentation/spec_ctrl.txt

--- /dev/null
+++ b/Documentation/spec_ctrl.txt
@@ -0,0 +1,86 @@
+===================
+Speculation Control
+===================
+
+Quite some CPUs have speculation related misfeatures which are in fact
+vulnerabilites causing data leaks in various forms even accross privilege
+domains.
+
+The kernel provides mitigation for such vulnerabilities in various
+forms. Some of these mitigations are compile time configurable and some on
+the kernel command line.
+
+There is also a class of mitigations which are very expensive, but they can
+be restricted to a certain set of processes or tasks in controlled
+environments. The mechanism to control these mitigations is via
+:manpage:`prctl(2)`.
+
+There are two prctl options which are related to this:
+
+ * PR_GET_SPECULATION_CTRL
+
+ * PR_SET_SPECULATION_CTRL
+
+PR_GET_SPECULATION_CTRL
+-----------------------
+
+PR_GET_SPECULATION_CTRL returns the state of the speculation misfeature
+which is selected with arg2 of prctl(2). The return value uses bits 0-2 with
+the following meaning:
+
+==== ================ ===================================================
+Bit  Define           Description
+==== ================ ===================================================
+0    PR_SPEC_PRCTL    Mitigation can be controlled per task by
+                      PR_SET_SPECULATION_CTRL
+1    PR_SPEC_ENABLE   The speculation feature is enabled, mitigation is
+                      disabled
+2    PR_SPEC_DISABLE  The speculation feature is disabled, mitigation is
+                      enabled
+==== ================ ===================================================
+
+If all bits are 0 the CPU is not affected by the speculation misfeature.
+
+If PR_SPEC_PRCTL is set, then the per task control of the mitigation is
+available. If not set, prctl(PR_SET_SPECULATION_CTRL) for the speculation
+misfeature will fail.
+
+PR_SET_SPECULATION_CTRL
+-----------------------
+PR_SET_SPECULATION_CTRL allows to control the speculation misfeature, which
+is selected by arg2 of :manpage:`prctl(2)` per task. arg3 is used to hand
+in the control value, i.e. either PR_SPEC_ENABLE or PR_SPEC_DISABLE.
+
+Common error codes
+------------------
+======= =================================================================
+Value   Meaning
+======= =================================================================
+EINVAL  The prctl is not implemented by the architecture or unused
+        prctl(2) arguments are not 0
+
+ENODEV  arg2 is selecting a not supported speculation misfeature
+======= =================================================================
+
+PR_SET_SPECULATION_CTRL error codes
+-----------------------------------
+======= =================================================================
+Value   Meaning
+======= =================================================================
+0       Success
+
+ERANGE  arg3 is incorrect, i.e. it's neither PR_SPEC_ENABLE nor
+        PR_SPEC_DISABLE
+
+ENXIO   Control of the selected speculation misfeature is not possible.
+        See PR_GET_SPECULATION_CTRL.
+======= =================================================================
+
+Speculation misfeature controls
+-------------------------------
+- PR_SPEC_STORE_BYPASS: Speculative Store Bypass
+
+  Invocations:
+   * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, 0, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_ENABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_DISABLE, 0, 0);
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -55,4 +55,9 @@ static inline unsigned long array_index_
 									\
 	(typeof(_i)) (_i & _mask);					\
 })
+
+/* Speculation control prctl */
+int arch_prctl_spec_ctrl_get(unsigned long which);
+int arch_prctl_spec_ctrl_set(unsigned long which, unsigned long ctrl);
+
 #endif /* _LINUX_NOSPEC_H */
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -197,4 +197,15 @@ struct prctl_mm_map {
 # define PR_CAP_AMBIENT_LOWER		3
 # define PR_CAP_AMBIENT_CLEAR_ALL	4
 
+/* Per task speculation control */
+#define PR_GET_SPECULATION_CTRL		52
+#define PR_SET_SPECULATION_CTRL		53
+/* Speculation control variants */
+# define PR_SPEC_STORE_BYPASS		0
+/* Return and control values for PR_SET/GET_SPECULATION_CTRL */
+# define PR_SPEC_NOT_AFFECTED		0
+# define PR_SPEC_PRCTL			(1UL << 0)
+# define PR_SPEC_ENABLE			(1UL << 1)
+# define PR_SPEC_DISABLE		(1UL << 2)
+
 #endif /* _LINUX_PRCTL_H */
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -53,6 +53,8 @@
 #include <linux/uidgid.h>
 #include <linux/cred.h>
 
+#include <linux/nospec.h>
+
 #include <linux/kmsg_dump.h>
 /* Move somewhere else to avoid recompiling? */
 #include <generated/utsrelease.h>
@@ -2072,6 +2074,16 @@ static int prctl_get_tid_address(struct
 }
 #endif
 
+int __weak arch_prctl_spec_ctrl_get(unsigned long which)
+{
+	return -EINVAL;
+}
+
+int __weak arch_prctl_spec_ctrl_set(unsigned long which, unsigned long ctrl)
+{
+	return -EINVAL;
+}
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2270,6 +2282,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 	case PR_GET_FP_MODE:
 		error = GET_FP_MODE(me);
 		break;
+	case PR_GET_SPECULATION_CTRL:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_prctl_spec_ctrl_get(arg2);
+		break;
+	case PR_SET_SPECULATION_CTRL:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = arch_prctl_spec_ctrl_set(arg2, arg3);
+		break;
 	default:
 		error = -EINVAL;
 		break;
