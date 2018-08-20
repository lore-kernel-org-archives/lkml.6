Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42688C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AAC2170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AAC2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHTT14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:27:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46843 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHTT1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:27:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7KGBMqE2126078
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Aug 2018 09:11:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7KGBMPr2126075;
        Mon, 20 Aug 2018 09:11:22 -0700
Date:   Mon, 20 Aug 2018 09:11:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rian Hunter <tipbot@zytor.com>
Message-ID: <tip-dc76803e57cc86589c4efcb5362918f9b0c0436f@git.kernel.org>
Cc:     rian@alum.mit.edu, hpa@zytor.com, bpetkov@suse.de,
        tglx@linutronix.de, luto@kernel.org, vkuznets@redhat.com,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org, jroedel@suse.de,
        mingo@kernel.org, dima@arista.com
Reply-To: mingo@kernel.org, dima@arista.com, linux-kernel@vger.kernel.org,
          jroedel@suse.de, tglx@linutronix.de, luto@kernel.org,
          vkuznets@redhat.com, jpoimboe@redhat.com, rian@alum.mit.edu,
          hpa@zytor.com, bpetkov@suse.de
In-Reply-To: <20180819230854.7275-1-rian@alum.mit.edu>
References: <20180819230854.7275-1-rian@alum.mit.edu>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/process: Re-export start_thread()
Git-Commit-ID: dc76803e57cc86589c4efcb5362918f9b0c0436f
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

Commit-ID:  dc76803e57cc86589c4efcb5362918f9b0c0436f
Gitweb:     https://git.kernel.org/tip/dc76803e57cc86589c4efcb5362918f9b0c0436f
Author:     Rian Hunter <rian@alum.mit.edu>
AuthorDate: Sun, 19 Aug 2018 16:08:53 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 20 Aug 2018 18:04:42 +0200

x86/process: Re-export start_thread()

The consolidation of the start_thread() functions removed the export
unintentionally. This breaks binfmt handlers built as a module.

Add it back.

Fixes: e634d8fc792c ("x86-64: merge the standard and compat start_thread() functions")
Signed-off-by: Rian Hunter <rian@alum.mit.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180819230854.7275-1-rian@alum.mit.edu

---
 arch/x86/kernel/process_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 476e3ddf8890..a451bc374b9b 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -384,6 +384,7 @@ start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 	start_thread_common(regs, new_ip, new_sp,
 			    __USER_CS, __USER_DS, 0);
 }
+EXPORT_SYMBOL_GPL(start_thread);
 
 #ifdef CONFIG_COMPAT
 void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp)
