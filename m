Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DFEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2481218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfB0VRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:17:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfB0VRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 16:17:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01FFC19FB2;
        Wed, 27 Feb 2019 21:17:51 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CE0E4B3;
        Wed, 27 Feb 2019 21:17:50 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        x86@kernel.org
Cc:     Jiri Slaby <jslaby@suse.cz>, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/stacktrace: export save_stack_trace_tsk_reliable
Date:   Wed, 27 Feb 2019 16:17:48 -0500
Message-Id: <20190227211748.9545-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 27 Feb 2019 21:17:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ppc64le implementation of save_stack_trace_tsk_reliable() is
exported, so do the same with x86.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 arch/x86/kernel/stacktrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 5c2d71a1dc06..ad9b38dabf6a 100644

We could do the inverse and remove the symbol export from
arch/powerpc/kernel/stacktrace.c, but I figured the other
save_stack_trace_tsk variants are already exported for both
arches, so add this one, too.  -- JL

--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -163,6 +163,7 @@ int save_stack_trace_tsk_reliable(struct task_struct *tsk,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk_reliable);
 #endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
 
 /* Userspace stacktrace - based on kernel/trace/trace_sysprof.c */
-- 
2.20.1

