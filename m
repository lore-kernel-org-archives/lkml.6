Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27C3C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4EB20844
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfA3MtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:49:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:44152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731010AbfA3Mr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:47:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5AAA4AFC5;
        Wed, 30 Jan 2019 12:47:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     mingo@redhat.com
Cc:     bp@alien8.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: [PATCH v7 13/28] um: annotate data appropriatelly
Date:   Wed, 30 Jan 2019 13:46:56 +0100
Message-Id: <20190130124711.12463-14-jslaby@suse.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new SYM_DATA_START and SYM_DATA_END_LABEL macros for vdso_start.

We get:
  0000  2376 OBJECT  GLOBAL DEFAULT    4 vdso_start
  0948     0 OBJECT  GLOBAL DEFAULT    4 vdso_end

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net
---
 arch/x86/um/vdso/vdso.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/vdso/vdso.S b/arch/x86/um/vdso/vdso.S
index a4a3870dc059..a6eaf293a73b 100644
--- a/arch/x86/um/vdso/vdso.S
+++ b/arch/x86/um/vdso/vdso.S
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/init.h>
+#include <linux/linkage.h>
 
 __INITDATA
 
-	.globl vdso_start, vdso_end
-vdso_start:
+SYM_DATA_START(vdso_start)
 	.incbin "arch/x86/um/vdso/vdso.so"
-vdso_end:
+SYM_DATA_END_LABEL(vdso_start, SYM_L_GLOBAL, vdso_end)
 
 __FINIT
-- 
2.20.1

