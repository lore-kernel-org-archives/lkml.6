Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F21E2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F21E2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbeKTAXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:23:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:52194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728258AbeKTAXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:23:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69C02AC4B;
        Mon, 19 Nov 2018 13:59:47 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/xen: cleanup includes in arch/x86/xen/spinlock.c
Date:   Mon, 19 Nov 2018 14:59:45 +0100
Message-Id: <20181119135945.9985-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/xen/spinlock.c includes several headers which are not needed.
Remove the #includes.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/spinlock.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 1c8a8816a402..3776122c87cc 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -3,22 +3,17 @@
  * Split spinlock implementation out into its own file, so it can be
  * compiled in a FTRACE-compatible way.
  */
-#include <linux/kernel_stat.h>
+#include <linux/kernel.h>
 #include <linux/spinlock.h>
-#include <linux/debugfs.h>
-#include <linux/log2.h>
-#include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/atomic.h>
 
 #include <asm/paravirt.h>
 #include <asm/qspinlock.h>
 
-#include <xen/interface/xen.h>
 #include <xen/events.h>
 
 #include "xen-ops.h"
-#include "debugfs.h"
 
 static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
 static DEFINE_PER_CPU(char *, irq_name);
-- 
2.16.4

