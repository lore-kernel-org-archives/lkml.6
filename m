Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338AFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFD720873
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFD720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeICTRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:17:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52469 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:17:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83EvD8m3340081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 07:57:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83EvDlr3340076;
        Mon, 3 Sep 2018 07:57:13 -0700
Date:   Mon, 3 Sep 2018 07:57:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-7e4372028929e43a1f986438572a533b728dd266@git.kernel.org>
Cc:     mingo@kernel.org, jgross@suse.com, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, jgross@suse.com
In-Reply-To: <20180828074026.820-6-jgross@suse.com>
References: <20180828074026.820-6-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Make paravirt_patch_call() and
 paravirt_patch_jmp() static
Git-Commit-ID: 7e4372028929e43a1f986438572a533b728dd266
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

Commit-ID:  7e4372028929e43a1f986438572a533b728dd266
Gitweb:     https://git.kernel.org/tip/7e4372028929e43a1f986438572a533b728dd266
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 28 Aug 2018 09:40:16 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 16:50:34 +0200

x86/paravirt: Make paravirt_patch_call() and paravirt_patch_jmp() static

paravirt_patch_call() and paravirt_patch_jmp() are used in paravirt.c
only. Convert them to static.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: boris.ostrovsky@oracle.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180828074026.820-6-jgross@suse.com

---
 arch/x86/include/asm/paravirt_types.h |  6 ------
 arch/x86/kernel/paravirt.c            | 12 ++++++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 4b75acc23b30..7d13197d760b 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -373,12 +373,6 @@ extern struct pv_lock_ops pv_lock_ops;
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len);
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
-unsigned paravirt_patch_call(void *insnbuf,
-			     const void *target, u16 tgt_clobbers,
-			     unsigned long addr, u16 site_clobbers,
-			     unsigned len);
-unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
-			    unsigned long addr, unsigned len);
 unsigned paravirt_patch_default(u8 type, u16 clobbers, void *insnbuf,
 				unsigned long addr, unsigned len);
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index afdb303285f8..1abdbde35049 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -81,10 +81,10 @@ struct branch {
 	u32 delta;
 } __attribute__((packed));
 
-unsigned paravirt_patch_call(void *insnbuf,
-			     const void *target, u16 tgt_clobbers,
-			     unsigned long addr, u16 site_clobbers,
-			     unsigned len)
+static unsigned paravirt_patch_call(void *insnbuf,
+				    const void *target, u16 tgt_clobbers,
+				    unsigned long addr, u16 site_clobbers,
+				    unsigned len)
 {
 	struct branch *b = insnbuf;
 	unsigned long delta = (unsigned long)target - (addr+5);
@@ -103,8 +103,8 @@ unsigned paravirt_patch_call(void *insnbuf,
 	return 5;
 }
 
-unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
-			    unsigned long addr, unsigned len)
+static unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
+				   unsigned long addr, unsigned len)
 {
 	struct branch *b = insnbuf;
 	unsigned long delta = (unsigned long)target - (addr+5);
