Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6FAC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CDA20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CDA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeJDQyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:54:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55781 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeJDQyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:54:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94A0un22701268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 03:00:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94A0tZs2701265;
        Thu, 4 Oct 2018 03:00:55 -0700
Date:   Thu, 4 Oct 2018 03:00:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-35e76b99ddf20405a6196bb7c9eb152675c93106@git.kernel.org>
Cc:     tglx@linutronix.de, jcmvbkbc@gmail.com, hpa@zytor.com,
        yamada.masahiro@socionext.com, peterz@infradead.org, bp@alien8.de,
        namit@vmware.com, michal.lkml@markovi.net,
        torvalds@linux-foundation.org, mingo@kernel.org, chris@zankel.net,
        linux-kernel@vger.kernel.org
Reply-To: namit@vmware.com, michal.lkml@markovi.net, peterz@infradead.org,
          bp@alien8.de, chris@zankel.net, linux-kernel@vger.kernel.org,
          mingo@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
          tglx@linutronix.de, jcmvbkbc@gmail.com,
          yamada.masahiro@socionext.com
In-Reply-To: <20181003213100.189959-2-namit@vmware.com>
References: <20181003213100.189959-2-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] kbuild/arch/xtensa: Define LINKER_SCRIPT for the
 linker script
Git-Commit-ID: 35e76b99ddf20405a6196bb7c9eb152675c93106
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

Commit-ID:  35e76b99ddf20405a6196bb7c9eb152675c93106
Gitweb:     https://git.kernel.org/tip/35e76b99ddf20405a6196bb7c9eb152675c93106
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Wed, 3 Oct 2018 14:30:51 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 4 Oct 2018 10:05:38 +0200

kbuild/arch/xtensa: Define LINKER_SCRIPT for the linker script

Define the LINKER_SCRIPT when building the linker script as being done
in other architectures. This is required, because upcoming Makefile changes
would otherwise break things.

Signed-off-by: Nadav Amit <namit@vmware.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-xtensa@linux-xtensa.org
Link: http://lkml.kernel.org/r/20181003213100.189959-2-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/xtensa/kernel/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/kernel/Makefile b/arch/xtensa/kernel/Makefile
index 91907590d183..8dff506caf07 100644
--- a/arch/xtensa/kernel/Makefile
+++ b/arch/xtensa/kernel/Makefile
@@ -35,8 +35,8 @@ sed-y = -e ':a; s/\*(\([^)]*\)\.text\.unlikely/*(\1.literal.unlikely .{text}.unl
 	-e 's/\.{text}/.text/g'
 
 quiet_cmd__cpp_lds_S = LDS     $@
-cmd__cpp_lds_S = $(CPP) $(cpp_flags) -P -C -Uxtensa -D__ASSEMBLY__ $<    \
-                 | sed $(sed-y) >$@
+cmd__cpp_lds_S = $(CPP) $(cpp_flags) -P -C -Uxtensa -D__ASSEMBLY__ \
+		 -DLINKER_SCRIPT $< | sed $(sed-y) >$@
 
 $(obj)/vmlinux.lds: $(src)/vmlinux.lds.S FORCE
 	$(call if_changed_dep,_cpp_lds_S)
