Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3CBC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7C221984
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7C221984
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeHEWj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:39:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52363 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbeHEWjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:39:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w75KXp78590855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Aug 2018 13:33:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w75KXnlp590852;
        Sun, 5 Aug 2018 13:33:49 -0700
Date:   Sun, 5 Aug 2018 13:33:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nick Desaulniers <tipbot@zytor.com>
Message-ID: <tip-208cbb32558907f68b3b2a081ca2337ac3744794@git.kernel.org>
Cc:     mingo@kernel.org, jdelvare@suse.de, ndesaulniers@google.com,
        hpa@zytor.com, tglx@linutronix.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, david.laight@aculab.com,
          linux-kernel@vger.kernel.org, ndesaulniers@google.com,
          jdelvare@suse.de, mingo@kernel.org
In-Reply-To: <20180803170550.164688-1-ndesaulniers@google.com>
References: <20180803170550.164688-1-ndesaulniers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/irqflags: Provide a declaration for
 native_save_fl
Git-Commit-ID: 208cbb32558907f68b3b2a081ca2337ac3744794
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

Commit-ID:  208cbb32558907f68b3b2a081ca2337ac3744794
Gitweb:     https://git.kernel.org/tip/208cbb32558907f68b3b2a081ca2337ac3744794
Author:     Nick Desaulniers <ndesaulniers@google.com>
AuthorDate: Fri, 3 Aug 2018 10:05:50 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 5 Aug 2018 22:30:37 +0200

x86/irqflags: Provide a declaration for native_save_fl

It was reported that the commit d0a8d9378d16 is causing users of gcc < 4.9
to observe -Werror=missing-prototypes errors.

Indeed, it seems that:
extern inline unsigned long native_save_fl(void) { return 0; }

compiled with -Werror=missing-prototypes produces this warning in gcc <
4.9, but not gcc >= 4.9.

Fixes: d0a8d9378d16 ("x86/paravirt: Make native_save_fl() extern inline").
Reported-by: David Laight <david.laight@aculab.com>
Reported-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Cc: jgross@suse.com
Cc: kstewart@linuxfoundation.org
Cc: gregkh@linuxfoundation.org
Cc: boris.ostrovsky@oracle.com
Cc: astrachan@google.com
Cc: mka@chromium.org
Cc: arnd@arndb.de
Cc: tstellar@redhat.com
Cc: sedat.dilek@gmail.com
Cc: David.Laight@aculab.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180803170550.164688-1-ndesaulniers@google.com

---
 arch/x86/include/asm/irqflags.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c4fc17220df9..c14f2a74b2be 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -13,6 +13,8 @@
  * Interrupt control:
  */
 
+/* Declaration required for gcc < 4.9 to prevent -Werror=missing-prototypes */
+extern inline unsigned long native_save_fl(void);
 extern inline unsigned long native_save_fl(void)
 {
 	unsigned long flags;
