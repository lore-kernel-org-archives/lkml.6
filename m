Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E0CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C51220856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C51220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbeGWNwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:52:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389443AbeGWNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:55 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 64A42CBD;
        Mon, 23 Jul 2018 12:46:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 078/107] Documentation/spec_ctrl: Do some minor cleanups
Date:   Mon, 23 Jul 2018 14:42:12 +0200
Message-Id: <20180723122417.326278460@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit dd0792699c4058e63c0715d9a7c2d40226fcdddc upstream

Fix some typos, improve formulations, end sentences with a fullstop.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 Documentation/spec_ctrl.txt |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/Documentation/spec_ctrl.txt
+++ b/Documentation/spec_ctrl.txt
@@ -2,13 +2,13 @@
 Speculation Control
 ===================
 
-Quite some CPUs have speculation related misfeatures which are in fact
-vulnerabilites causing data leaks in various forms even accross privilege
-domains.
+Quite some CPUs have speculation-related misfeatures which are in
+fact vulnerabilities causing data leaks in various forms even across
+privilege domains.
 
 The kernel provides mitigation for such vulnerabilities in various
-forms. Some of these mitigations are compile time configurable and some on
-the kernel command line.
+forms. Some of these mitigations are compile-time configurable and some
+can be supplied on the kernel command line.
 
 There is also a class of mitigations which are very expensive, but they can
 be restricted to a certain set of processes or tasks in controlled
@@ -32,18 +32,18 @@ the following meaning:
 Bit  Define                Description
 ==== ===================== ===================================================
 0    PR_SPEC_PRCTL         Mitigation can be controlled per task by
-                           PR_SET_SPECULATION_CTRL
+                           PR_SET_SPECULATION_CTRL.
 1    PR_SPEC_ENABLE        The speculation feature is enabled, mitigation is
-                           disabled
+                           disabled.
 2    PR_SPEC_DISABLE       The speculation feature is disabled, mitigation is
-                           enabled
+                           enabled.
 3    PR_SPEC_FORCE_DISABLE Same as PR_SPEC_DISABLE, but cannot be undone. A
                            subsequent prctl(..., PR_SPEC_ENABLE) will fail.
 ==== ===================== ===================================================
 
 If all bits are 0 the CPU is not affected by the speculation misfeature.
 
-If PR_SPEC_PRCTL is set, then the per task control of the mitigation is
+If PR_SPEC_PRCTL is set, then the per-task control of the mitigation is
 available. If not set, prctl(PR_SET_SPECULATION_CTRL) for the speculation
 misfeature will fail.
 
@@ -61,9 +61,9 @@ Common error codes
 Value   Meaning
 ======= =================================================================
 EINVAL  The prctl is not implemented by the architecture or unused
-        prctl(2) arguments are not 0
+        prctl(2) arguments are not 0.
 
-ENODEV  arg2 is selecting a not supported speculation misfeature
+ENODEV  arg2 is selecting a not supported speculation misfeature.
 ======= =================================================================
 
 PR_SET_SPECULATION_CTRL error codes
@@ -74,7 +74,7 @@ Value   Meaning
 0       Success
 
 ERANGE  arg3 is incorrect, i.e. it's neither PR_SPEC_ENABLE nor
-        PR_SPEC_DISABLE nor PR_SPEC_FORCE_DISABLE
+        PR_SPEC_DISABLE nor PR_SPEC_FORCE_DISABLE.
 
 ENXIO   Control of the selected speculation misfeature is not possible.
         See PR_GET_SPECULATION_CTRL.


