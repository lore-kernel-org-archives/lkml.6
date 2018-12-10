Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9977C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B493A2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B493A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbeLJVbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:31:52 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:42628 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeLJVbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:31:52 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4040D72CC66;
        Tue, 11 Dec 2018 00:31:50 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 32FF37CF48F; Tue, 11 Dec 2018 00:31:50 +0300 (MSK)
Date:   Tue, 11 Dec 2018 00:31:50 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] asm-generic/ptrace.h: add a comment about frame_pointer
Message-ID: <20181210213150.GA18226@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been misled by comments in asm-generic/ptrace.h into thinking
that frame_pointer() is universally available across architectures,
which resulted in a wrong design decision.

Add a comment about frame_pointer in a hope that it will help others
to avoid this mistake in the future.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/asm-generic/ptrace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/ptrace.h b/include/asm-generic/ptrace.h
index 82e674f6b337..3186c30bd50d 100644
--- a/include/asm-generic/ptrace.h
+++ b/include/asm-generic/ptrace.h
@@ -59,6 +59,10 @@ static inline void user_stack_pointer_set(struct pt_regs *regs,
 #define SET_FP(regs, val) (GET_FP(regs) = (val))
 #endif
 
+/*
+ * Unlike instruction_pointer and user_stack_pointer,
+ * frame_pointer is not universally available across architectures.
+ */
 static inline unsigned long frame_pointer(struct pt_regs *regs)
 {
 	return GET_FP(regs);
-- 
ldv
