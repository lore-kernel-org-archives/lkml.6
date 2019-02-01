Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B5BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE45D218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfBAK6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:58:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39251 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbfBAK6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:58:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x11Avw5R3280887
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 1 Feb 2019 02:57:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x11AvwP43280884;
        Fri, 1 Feb 2019 02:57:58 -0800
Date:   Fri, 1 Feb 2019 02:57:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-ac09c5f43cf613939850cc38d7a34ae6556016ba@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, bp@suse.de,
        hpa@zytor.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, bp@suse.de,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190130112238.GB18383@zn.tnic>
References: <20190130112238.GB18383@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Build the command line parsing code
 unconditionally
Git-Commit-ID: ac09c5f43cf613939850cc38d7a34ae6556016ba
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

Commit-ID:  ac09c5f43cf613939850cc38d7a34ae6556016ba
Gitweb:     https://git.kernel.org/tip/ac09c5f43cf613939850cc38d7a34ae6556016ba
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 30 Jan 2019 11:19:37 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 1 Feb 2019 11:51:01 +0100

x86/boot: Build the command line parsing code unconditionally

Just drop the three-item ifdeffery and build it in unconditionally.
Early cmdline parsing is needed more often than not.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: bhe@redhat.com
Cc: hpa@zytor.com
Cc: indou.takao@jp.fujitsu.com
Cc: kasong@redhat.com
Cc: keescook@chromium.org
Cc: mingo@redhat.com
Cc: msys.mizuma@gmail.com
Cc: tglx@linutronix.de
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190130112238.GB18383@zn.tnic
---
 arch/x86/boot/compressed/cmdline.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index af6cda0b7900..f1add5d85da9 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
 
-#if CONFIG_EARLY_PRINTK || CONFIG_RANDOMIZE_BASE || CONFIG_X86_5LEVEL
-
 static unsigned long fs;
 static inline void set_fs(unsigned long seg)
 {
@@ -30,5 +28,3 @@ int cmdline_find_option_bool(const char *option)
 {
 	return __cmdline_find_option_bool(get_cmd_line_ptr(), option);
 }
-
-#endif
