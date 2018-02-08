Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751014AbeBHGjz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 01:39:55 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33309 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750810AbeBHGjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 01:39:54 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="36919703"
From: Cao jin <caoj.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>
Subject: [PATCH] x86/linker script: drop superfluous ALIGN
Date: Thu, 8 Feb 2018 14:38:57 +0800
Message-ID: <20180208063857.15197-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 294D848AE922.AA201
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALIGN(8) is superfluous since macro TEXT_TEXT already has one.

bonus: indentation fix, spaces -> tab.
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/vmlinux.lds.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index a4009fb9be87..f4dc9e39ea40 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -96,7 +96,6 @@ SECTIONS
 		_stext = .;
 		/* bootstrapping code */
 		HEAD_TEXT
-		. = ALIGN(8);
 		TEXT_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
@@ -175,7 +174,7 @@ SECTIONS
 		. = __vvar_beginning_hack + PAGE_SIZE;
 	} :data
 
-       . = ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
+	. = ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
 
 	/* Init code and data - will be freed after init */
 	. = ALIGN(PAGE_SIZE);
@@ -343,8 +342,8 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);		/* keep VO_INIT_SIZE page aligned */
 	_end = .;
 
-        STABS_DEBUG
-        DWARF_DEBUG
+	STABS_DEBUG
+	DWARF_DEBUG
 
 	/* Sections to be discarded */
 	DISCARDS
-- 
2.14.3
