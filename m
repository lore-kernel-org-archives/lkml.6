Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98772C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533F52084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533F52084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeJ3C7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:59:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33771 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeJ3C7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:59:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9TI9sWq1642741
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 Oct 2018 11:09:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9TI9sT41642738;
        Mon, 29 Oct 2018 11:09:54 -0700
Date:   Mon, 29 Oct 2018 11:09:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-8af1909580595a303b03d5999e410d407b7a6db7@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, jgross@suse.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, jgross@suse.com,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20181029150116.25372-1-jgross@suse.com>
References: <20181029150116.25372-1-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/paravirt: Remove GPL from pv_ops export
Git-Commit-ID: 8af1909580595a303b03d5999e410d407b7a6db7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8af1909580595a303b03d5999e410d407b7a6db7
Gitweb:     https://git.kernel.org/tip/8af1909580595a303b03d5999e410d407b7a6db7
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Mon, 29 Oct 2018 16:01:16 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Oct 2018 19:04:05 +0100

x86/paravirt: Remove GPL from pv_ops export

Commit 5c83511bdb9832 ("x86/paravirt: Use a single ops structure")
introduced a regression for out-of-tree modules using spinlocks, as
pv_lock_ops was exported via EXPORT_SYMBOL(), while the new pv_ops
structure now containing the pv lock operations is exported via
EXPORT_SYMBOL_GPL().

Change that by using EXPORT_SYMBOL(pv_ops).

Fixes: 5c83511bdb9832 ("x86/paravirt: Use a single ops structure")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: boris.ostrovsky@oracle.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20181029150116.25372-1-jgross@suse.com

---
 arch/x86/kernel/paravirt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index e4d4df37922a..45123b116c05 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -483,5 +483,5 @@ NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
 #endif
 
-EXPORT_SYMBOL_GPL(pv_ops);
+EXPORT_SYMBOL(pv_ops);
 EXPORT_SYMBOL_GPL(pv_info);
