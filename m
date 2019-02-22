Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F4CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A843C2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfBVSvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:51:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39688 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfBVSvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:51:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CE4119BF;
        Fri, 22 Feb 2019 10:51:35 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD2AF3F5C1;
        Fri, 22 Feb 2019 10:51:31 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 17/20] scsi: qla1280: Remove stale comment about mmiowb()
Date:   Fri, 22 Feb 2019 18:50:23 +0000
Message-Id: <20190222185026.10973-18-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All mmiowb() invocations have been removed, so there's no need to keep
banging on about it.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/scsi/qla1280.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 93acbc5094f0..327eff67a1ee 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -3363,16 +3363,6 @@ qla1280_isp_cmd(struct scsi_qla_host *ha)
 
 	/*
 	 * Update request index to mailbox4 (Request Queue In).
-	 * The mmiowb() ensures that this write is ordered with writes by other
-	 * CPUs.  Without the mmiowb(), it is possible for the following:
-	 *    CPUA posts write of index 5 to mailbox4
-	 *    CPUA releases host lock
-	 *    CPUB acquires host lock
-	 *    CPUB posts write of index 6 to mailbox4
-	 *    On PCI bus, order reverses and write of 6 posts, then index 5,
-	 *       causing chip to issue full queue of stale commands
-	 * The mmiowb() prevents future writes from crossing the barrier.
-	 * See Documentation/driver-api/device-io.rst for more information.
 	 */
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
 
-- 
2.11.0

