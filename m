Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646FEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2B820881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfA2VNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:13:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58695 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbfA2VNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:13:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0TLDWht2099524
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 13:13:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0TLDW5x2099520;
        Tue, 29 Jan 2019 13:13:32 -0800
Date:   Tue, 29 Jan 2019 13:13:32 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Cao jin <tipbot@zytor.com>
Message-ID: <tip-0a278662f53159354a0391a17741a20db736256a@git.kernel.org>
Cc:     caoj.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org, kirill.shutemov@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de
Reply-To: bp@alien8.de, kirill.shutemov@linux.intel.com,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          caoj.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190123100014.23721-1-caoj.fnst@cn.fujitsu.com>
References: <20190123100014.23721-1-caoj.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/boot: Save several bytes in decompressor
Git-Commit-ID: 0a278662f53159354a0391a17741a20db736256a
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

Commit-ID:  0a278662f53159354a0391a17741a20db736256a
Gitweb:     https://git.kernel.org/tip/0a278662f53159354a0391a17741a20db736256a
Author:     Cao jin <caoj.fnst@cn.fujitsu.com>
AuthorDate: Wed, 23 Jan 2019 18:00:14 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 29 Jan 2019 22:09:12 +0100

x86/boot: Save several bytes in decompressor

gdt64 represents the content of GDTR under x86-64, which actually needs
10 bytes only, ".long" & ".word" is superfluous.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: <bp@alien8.de>
Cc: <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20190123100014.23721-1-caoj.fnst@cn.fujitsu.com

---
 arch/x86/boot/compressed/head_64.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 64037895b085..b27b338d2f6d 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -645,8 +645,6 @@ no_longmode:
 	.data
 gdt64:
 	.word	gdt_end - gdt
-	.long	0
-	.word	0
 	.quad   0
 gdt:
 	.word	gdt_end - gdt
