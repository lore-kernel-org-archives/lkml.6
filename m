Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83956C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338AB20831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338AB20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLILHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:07:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51225 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLILHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:07:35 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB9B71GB2918366
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 9 Dec 2018 03:07:01 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB9B6vgU2918363;
        Sun, 9 Dec 2018 03:06:57 -0800
Date:   Sun, 9 Dec 2018 03:06:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-829889ac4a7d26858860c297e64051bd27ce8fbe@git.kernel.org>
Cc:     bp@suse.de, richard@nod.at, mpe@ellerman.id.au, x86@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com,
        yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
          mingo@redhat.com, x86@kernel.org, mpe@ellerman.id.au,
          richard@nod.at, bp@suse.de, hpa@zytor.com
In-Reply-To: <1541990120-9643-2-git-send-email-yamada.masahiro@socionext.com>
References: <1541990120-9643-2-git-send-email-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/um: Remove -fno-unit-at-a-time workaround for
 pre-4.0 GCC
Git-Commit-ID: 829889ac4a7d26858860c297e64051bd27ce8fbe
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

Commit-ID:  829889ac4a7d26858860c297e64051bd27ce8fbe
Gitweb:     https://git.kernel.org/tip/829889ac4a7d26858860c297e64051bd27ce8fbe
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Mon, 12 Nov 2018 11:35:19 +0900
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sun, 9 Dec 2018 11:51:11 +0100

x86/um: Remove -fno-unit-at-a-time workaround for pre-4.0 GCC

Commit

  cafa0010cd51 ("Raise the minimum required gcc version to 4.6")

bumped the minimum GCC version to 4.6 for all architectures.

'$(call cc-option,-fno-unit-at-a-time)' is now dead code since
'$(cc-version) -lt 0400' is always false. Remove it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Richard Weinberger <richard@nod.at>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1541990120-9643-2-git-send-email-yamada.masahiro@socionext.com
---
 arch/x86/Makefile.um | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 91085a08de6c..577976b7d1f8 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -26,12 +26,8 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
 # an unresolved reference.
 cflags-y += -ffreestanding
 
-# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
-# a lot more stack due to the lack of sharing of stacklots.  Also, gcc
-# 4.3.0 needs -funit-at-a-time for extern inline functions.
-KBUILD_CFLAGS += $(shell if [ $(cc-version) -lt 0400 ] ; then \
-			echo $(call cc-option,-fno-unit-at-a-time); \
-			else echo $(call cc-option,-funit-at-a-time); fi ;)
+# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
+KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
 
 KBUILD_CFLAGS += $(cflags-y)
 
