Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC3EC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C24321700
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C24321700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbeHNU06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:26:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730437AbeHNU05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:26:57 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF41AD4A;
        Tue, 14 Aug 2018 17:38:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 079/104] Documentation/l1tf: Fix typos
Date:   Tue, 14 Aug 2018 19:17:33 +0200
Message-Id: <20180814171520.369506110@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

commit 1949f9f49792d65dba2090edddbe36a5f02e3ba3 upstream

Fix spelling and other typos

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/l1tf.rst |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/Documentation/admin-guide/l1tf.rst
+++ b/Documentation/admin-guide/l1tf.rst
@@ -17,7 +17,7 @@ vulnerability is not present on:
    - Older processor models, where the CPU family is < 6
 
    - A range of Intel ATOM processors (Cedarview, Cloverview, Lincroft,
-     Penwell, Pineview, Slivermont, Airmont, Merrifield)
+     Penwell, Pineview, Silvermont, Airmont, Merrifield)
 
    - The Intel Core Duo Yonah variants (2006 - 2008)
 
@@ -113,7 +113,7 @@ Attack scenarios
    deployment scenario. The mitigations, their protection scope and impact
    are described in the next sections.
 
-   The default mitigations and the rationale for chosing them are explained
+   The default mitigations and the rationale for choosing them are explained
    at the end of this document. See :ref:`default_mitigations`.
 
 .. _l1tf_sys_info:
@@ -191,15 +191,15 @@ Guest mitigation mechanisms
     - unconditional ('always')
 
    The conditional mode avoids L1D flushing after VMEXITs which execute
-   only audited code pathes before the corresponding VMENTER. These code
-   pathes have beed verified that they cannot expose secrets or other
+   only audited code paths before the corresponding VMENTER. These code
+   paths have been verified that they cannot expose secrets or other
    interesting data to an attacker, but they can leak information about the
    address space layout of the hypervisor.
 
    Unconditional mode flushes L1D on all VMENTER invocations and provides
    maximum protection. It has a higher overhead than the conditional
    mode. The overhead cannot be quantified correctly as it depends on the
-   work load scenario and the resulting number of VMEXITs.
+   workload scenario and the resulting number of VMEXITs.
 
    The general recommendation is to enable L1D flush on VMENTER. The kernel
    defaults to conditional mode on affected processors.
@@ -262,7 +262,7 @@ Guest mitigation mechanisms
    Whether the interrupts with are affine to CPUs, which run untrusted
    guests, provide interesting data for an attacker depends on the system
    configuration and the scenarios which run on the system. While for some
-   of the interrupts it can be assumed that they wont expose interesting
+   of the interrupts it can be assumed that they won't expose interesting
    information beyond exposing hints about the host OS memory layout, there
    is no way to make general assumptions.
 
@@ -299,7 +299,7 @@ Guest mitigation mechanisms
 		 to be brought up at least partially and are then shut down
 		 again.  "nosmt" can be undone via the sysfs interface.
 
-     nosmt=force Has the same effect as "nosmt' but it does not allow to
+     nosmt=force Has the same effect as "nosmt" but it does not allow to
 		 undo the SMT disable via the sysfs interface.
      =========== ==========================================================
 


