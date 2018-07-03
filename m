Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED18C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AD824C34
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AD824C34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933710AbeGCHxH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:53:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60175 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932338AbeGCHxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:53:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w637qiAN202224
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 00:52:44 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w637qiHb202221;
        Tue, 3 Jul 2018 00:52:44 -0700
Date:   Tue, 3 Jul 2018 00:52:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-c5fcdbf15523f6bbbaeb822e3be6003e60f9d3b7@git.kernel.org>
Cc:     hpa@zytor.com, yamada.masahiro@socionext.com, peterz@infradead.org,
        luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, luto@kernel.org, hpa@zytor.com,
          yamada.masahiro@socionext.com, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <1530582614-5173-3-git-send-email-yamada.masahiro@socionext.com>
References: <1530582614-5173-3-git-send-email-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/build/vdso: Simplify 'cmd_vdso2c'
Git-Commit-ID: c5fcdbf15523f6bbbaeb822e3be6003e60f9d3b7
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

Commit-ID:  c5fcdbf15523f6bbbaeb822e3be6003e60f9d3b7
Gitweb:     https://git.kernel.org/tip/c5fcdbf15523f6bbbaeb822e3be6003e60f9d3b7
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue, 3 Jul 2018 10:50:14 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 09:20:08 +0200

x86/build/vdso: Simplify 'cmd_vdso2c'

No reason to use 'define' directive here.  Just use the = operator.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1530582614-5173-3-git-send-email-yamada.masahiro@socionext.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 261802b1cc50..b9ed1aa53a26 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -58,9 +58,7 @@ HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(src
 hostprogs-y			+= vdso2c
 
 quiet_cmd_vdso2c = VDSO2C  $@
-define cmd_vdso2c
-	$(obj)/vdso2c $< $(<:%.dbg=%) $@
-endef
+      cmd_vdso2c = $(obj)/vdso2c $< $(<:%.dbg=%) $@
 
 $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 	$(call if_changed,vdso2c)
