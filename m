Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B914C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E782170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E782170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeHTT2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:28:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34991 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHTT2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:28:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7KGCRlE2126326
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Aug 2018 09:12:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7KGCROO2126323;
        Mon, 20 Aug 2018 09:12:27 -0700
Date:   Mon, 20 Aug 2018 09:12:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-94d7a86c21a3d6046bf4616272313cb7d525075a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        pbonzini@redhat.com, jpoimboe@redhat.com, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: pbonzini@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          jpoimboe@redhat.com
In-Reply-To: <d7ca03ae210d07173452aeed85ffe344301219a5.1534253536.git.jpoimboe@redhat.com>
References: <d7ca03ae210d07173452aeed85ffe344301219a5.1534253536.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/kvm/vmx: Remove duplicate l1d flush
 definitions
Git-Commit-ID: 94d7a86c21a3d6046bf4616272313cb7d525075a
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

Commit-ID:  94d7a86c21a3d6046bf4616272313cb7d525075a
Gitweb:     https://git.kernel.org/tip/94d7a86c21a3d6046bf4616272313cb7d525075a
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Tue, 14 Aug 2018 12:32:19 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 20 Aug 2018 18:04:43 +0200

x86/kvm/vmx: Remove duplicate l1d flush definitions

These are already defined higher up in the file.

Fixes: 7db92e165ac8 ("x86/kvm: Move l1tf setup function")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/d7ca03ae210d07173452aeed85ffe344301219a5.1534253536.git.jpoimboe@redhat.com

---
 arch/x86/kvm/vmx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 46b428c0990e..4be481c72f60 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9726,9 +9726,6 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu)
  * information but as all relevant affected CPUs have 32KiB L1D cache size
  * there is no point in doing so.
  */
-#define L1D_CACHE_ORDER 4
-static void *vmx_l1d_flush_pages;
-
 static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 {
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
