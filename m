Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6387CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6D020665
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6D020665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeK2GSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:18:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50727 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeK2GSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:18:53 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASJFvP02433464
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 11:15:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASJFsde2433461;
        Wed, 28 Nov 2018 11:15:54 -0800
Date:   Wed, 28 Nov 2018 11:15:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mattias Jacobsson <tipbot@zytor.com>
Message-ID: <tip-69be4efeb959147ff86f22e35aea9526f9b86715@git.kernel.org>
Cc:     bp@suse.de, mingo@kernel.org, 2pi@mok.nu,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, 2pi@mok.nu,
          linux-kernel@vger.kernel.org, bp@suse.de, mingo@kernel.org
In-Reply-To: <20181128161607.10973-1-2pi@mok.nu>
References: <20181128161607.10973-1-2pi@mok.nu>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Add missing va_end() to die()
Git-Commit-ID: 69be4efeb959147ff86f22e35aea9526f9b86715
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

Commit-ID:  69be4efeb959147ff86f22e35aea9526f9b86715
Gitweb:     https://git.kernel.org/tip/69be4efeb959147ff86f22e35aea9526f9b86715
Author:     Mattias Jacobsson <2pi@mok.nu>
AuthorDate: Wed, 28 Nov 2018 17:16:07 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 28 Nov 2018 20:06:07 +0100

x86/boot: Add missing va_end() to die()

Each call to va_start() must have a corresponding call to va_end()
before the end of the function. Add the missing va_end().

Found with Coccinelle.

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20181128161607.10973-1-2pi@mok.nu
---
 arch/x86/boot/tools/build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index bf0e82400358..a93d44e58f9c 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -132,6 +132,7 @@ static void die(const char * str, ...)
 	va_list args;
 	va_start(args, str);
 	vfprintf(stderr, str, args);
+	va_end(args);
 	fputc('\n', stderr);
 	exit(1);
 }
