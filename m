Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880B0C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B5020880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B5020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeI3ETp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:19:45 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52147 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728894AbeI3ESi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:38 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6H-0000Gz-Gn; Sat, 29 Sep 2018 22:48:33 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006r1-Vw; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@suse.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.473071918@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 027/131] Documentation/spec_ctrl: Do some minor cleanups
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit dd0792699c4058e63c0715d9a7c2d40226fcdddc upstream.

Fix some typos, improve formulations, end sentences with a fullstop.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/spec_ctrl.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/Documentation/spec_ctrl.rst
+++ b/Documentation/spec_ctrl.rst
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

