Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 74952C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CD0208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CD0208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756292AbeFOOnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:43:10 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35726 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756236AbeFOOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:43:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id F0BE418188FCB;
        Fri, 15 Jun 2018 16:43:06 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/3] um: Remove update_debugregs()
Date:   Fri, 15 Jun 2018 16:42:55 +0200
Message-Id: <20180615144256.13343-2-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180615144256.13343-1-richard@nod.at>
References: <20180615144256.13343-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is nowhere used, let's get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/shared/sysdep/ptrace_32.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/ptrace_32.h b/arch/x86/um/shared/sysdep/ptrace_32.h
index ae00d22bce02..db8478a83a09 100644
--- a/arch/x86/um/shared/sysdep/ptrace_32.h
+++ b/arch/x86/um/shared/sysdep/ptrace_32.h
@@ -8,8 +8,6 @@
 
 #define MAX_FP_NR HOST_FPX_SIZE
 
-static inline void update_debugregs(int seq) {}
-
 void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
-- 
2.13.6

