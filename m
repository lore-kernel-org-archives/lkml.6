Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DEDC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE44D20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfAWKDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:03:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:9487 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727181AbfAWKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:03:22 -0500
X-IronPort-AV: E=Sophos;i="5.56,510,1539619200"; 
   d="scan'208";a="52647666"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2019 18:03:19 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id E17664B4030E;
        Wed, 23 Jan 2019 18:03:20 +0800 (CST)
Received: from TSAO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 18:03:19 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/boot: save several bytes in decompressor
Date:   Wed, 23 Jan 2019 18:00:14 +0800
Message-ID: <20190123100014.23721-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: E17664B4030E.AA445
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gdt64 represents the content of GDTR under x86-64, which actually needs
10 bytes only, ".long" & ".word" is superfluous.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/head_64.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 58f6a467f1fa..541358454f10 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -642,8 +642,6 @@ no_longmode:
 	.data
 gdt64:
 	.word	gdt_end - gdt
-	.long	0
-	.word	0
 	.quad   0
 gdt:
 	.word	gdt_end - gdt
-- 
2.17.0



