Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBA1C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364152238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364152238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeHIVMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:12:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48495 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeHIVMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:12:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w79IjwlH2146723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Aug 2018 11:45:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w79Ijv1O2146720;
        Thu, 9 Aug 2018 11:45:57 -0700
Date:   Thu, 9 Aug 2018 11:45:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-a29dba161ad1a01bbfbc80aa184b089ddd169a4e@git.kernel.org>
Cc:     tglx@linutronix.de, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, sedat.dilek@gmail.com, hpa@zytor.com,
        jroedel@suse.de, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org, jroedel@suse.de, hpa@zytor.com,
          sedat.dilek@gmail.com, sfr@canb.auug.org.au, tglx@linutronix.de,
          linux-next@vger.kernel.org
In-Reply-To: <20180809094449.ddmnrkz7qkvo3j2x@suse.de>
References: <20180809094449.ddmnrkz7qkvo3j2x@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/relocs: Add __end_rodata_aligned to S_REL
Git-Commit-ID: a29dba161ad1a01bbfbc80aa184b089ddd169a4e
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

Commit-ID:  a29dba161ad1a01bbfbc80aa184b089ddd169a4e
Gitweb:     https://git.kernel.org/tip/a29dba161ad1a01bbfbc80aa184b089ddd169a4e
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Thu, 9 Aug 2018 11:44:49 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 9 Aug 2018 20:42:07 +0200

x86/relocs: Add __end_rodata_aligned to S_REL

This new symbol needs to be in the workaround-list for buggy
binutils, otherwise the build with gcc-4.6 fails.

Fixes: 39d668e04eda ('x86/mm/pti: Make pti_clone_kernel_text() compile on 32 bit')
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>
Link: https://lkml.kernel.org/r/20180809094449.ddmnrkz7qkvo3j2x@suse.de

---
 arch/x86/tools/relocs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 220e97841e49..3a6c8ebc8032 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -67,6 +67,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"__tracedata_(start|end)|"
 	"__(start|stop)_notes|"
 	"__end_rodata|"
+	"__end_rodata_aligned|"
 	"__initramfs_start|"
 	"(jiffies|jiffies_64)|"
 #if ELF_BITS == 64
