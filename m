Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5952AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130F9208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130F9208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753777AbeF1MeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:34:03 -0400
Received: from foss.arm.com ([217.140.101.70]:46694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753714AbeF1MeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:34:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F241C15AD;
        Thu, 28 Jun 2018 05:33:59 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE9133F5C0;
        Thu, 28 Jun 2018 05:33:57 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, andrea.parri@amarulasolutions.com,
        boqun.feng@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, mark.rutland@arm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        stern@rowland.harvard.edu, will.deacon@arm.com
Subject: [PATCH 2/2] tools/memory-model: remove ACCESS_ONCE() from model
Date:   Thu, 28 Jun 2018 13:33:47 +0100
Message-Id: <20180628123347.52963-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180628123347.52963-1-mark.rutland@arm.com>
References: <20180628123347.52963-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit:

  b899a850431e2dd0 ("compiler.h: Remove ACCESS_ONCE()")

... there has been no definition of ACCESS_ONCE() in the kernel tree,
and it has been necessary to use READ_ONCE() or WRITE_ONCE() instead.

Correspondingly, let's remove ACCESS_ONCE() from the kernel memory
model.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/linux-kernel.bell | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 64f5740e0e75..b84fb2f67109 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -13,7 +13,7 @@
 
 "Linux-kernel memory consistency model"
 
-enum Accesses = 'once (*READ_ONCE,WRITE_ONCE,ACCESS_ONCE*) ||
+enum Accesses = 'once (*READ_ONCE,WRITE_ONCE*) ||
 		'release (*smp_store_release*) ||
 		'acquire (*smp_load_acquire*) ||
 		'noreturn (* R of non-return RMW *)
-- 
2.11.0

