Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25367ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA36121476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA36121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeJRBCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:02:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeJRBCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:02:41 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gCpGg-0003Ud-UC; Wed, 17 Oct 2018 19:05:59 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, linux-kbuild@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        linux-edac <linux-edac@vger.kernel.org>, x86@kernel.org
Subject: [PATCH 2/3] x86/mcelog: Remove one mce_helper definition
Date:   Wed, 17 Oct 2018 19:05:53 +0200
Message-Id: <20181017170554.18841-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017170554.18841-1-bigeasy@linutronix.de>
References: <20181017170554.18841-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5de97c9f6d85f ("x86/mce: Factor out and deprecate the /dev/mcelog
driver") moved the old interface into one file including mce_helper
definition as static and "extern".

Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86@kernel.org
Fixes:  5de97c9f6d85f ("x86/mce: Factor out and deprecate the /dev/mcelog driver")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/mcheck/dev-mcelog.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/dev-mcelog.c b/arch/x86/kernel/cpu/mcheck/dev-mcelog.c
index 97685a0c31751..27f394ac983f6 100644
--- a/arch/x86/kernel/cpu/mcheck/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mcheck/dev-mcelog.c
@@ -38,9 +38,6 @@ static struct mce_log_buffer mcelog = {
 
 static DECLARE_WAIT_QUEUE_HEAD(mce_chrdev_wait);
 
-/* User mode helper program triggered by machine check event */
-extern char			mce_helper[128];
-
 static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 				void *data)
 {
-- 
2.19.1

