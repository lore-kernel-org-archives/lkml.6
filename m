Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E5CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A23218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeLRXKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:10:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60519 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbeLRXKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:10:03 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIN9qQi3003785
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 15:09:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIN9pEg3003782;
        Tue, 18 Dec 2018 15:09:51 -0800
Date:   Tue, 18 Dec 2018 15:09:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-72a8f089c382c078f8c7c1c759cb726de80d4284@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        mingo@kernel.org, bp@suse.de, hpa@zytor.com, tglx@linutronix.de,
        tony.luck@intel.com
Reply-To: tglx@linutronix.de, tony.luck@intel.com, hpa@zytor.com,
          bp@suse.de, mingo@kernel.org, linux-edac@vger.kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181218182546.GA21386@zn.tnic>
References: <20181218182546.GA21386@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Restore MCE injector's module name
Git-Commit-ID: 72a8f089c382c078f8c7c1c759cb726de80d4284
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

Commit-ID:  72a8f089c382c078f8c7c1c759cb726de80d4284
Gitweb:     https://git.kernel.org/tip/72a8f089c382c078f8c7c1c759cb726de80d4284
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 18 Dec 2018 19:25:46 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 19 Dec 2018 00:04:36 +0100

x86/mce: Restore MCE injector's module name

It was mce-inject.ko but it turned into inject.ko since the containing
source file got renamed. Restore it.

Fixes: 21afaf181362 ("x86/mce: Streamline MCE subsystem's naming")
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20181218182546.GA21386@zn.tnic
---
 arch/x86/kernel/cpu/mce/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Makefile
index 765759765ab7..9f020c994154 100644
--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -5,7 +5,9 @@ obj-$(CONFIG_X86_ANCIENT_MCE)	+= winchip.o p5.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= intel.o
 obj-$(CONFIG_X86_MCE_AMD)	+= amd.o
 obj-$(CONFIG_X86_MCE_THRESHOLD) += threshold.o
-obj-$(CONFIG_X86_MCE_INJECT)	+= inject.o
+
+mce-inject-y			:= inject.o
+obj-$(CONFIG_X86_MCE_INJECT)	+= mce-inject.o
 
 obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
 
