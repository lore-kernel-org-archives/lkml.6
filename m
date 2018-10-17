Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A17ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6B02086E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6B02086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJRGKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:10:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46583 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeJRGKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:10:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9HMCrEd564002
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 15:12:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9HMCqVh563998;
        Wed, 17 Oct 2018 15:12:52 -0700
Date:   Wed, 17 Oct 2018 15:12:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-711f76a328cbe5b49164bb14bcb593fa52102051@git.kernel.org>
Cc:     tglx@linutronix.de, linux-edac@vger.kernel.org, hpa@zytor.com,
        bp@suse.de, mingo@kernel.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        tony.luck@intel.com
Reply-To: bigeasy@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
          bp@suse.de, linux-edac@vger.kernel.org, hpa@zytor.com,
          mingo@redhat.com, x86@kernel.org, tony.luck@intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181017170554.18841-3-bigeasy@linutronix.de>
References: <20181017170554.18841-3-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mcelog: Remove one mce_helper definition
Git-Commit-ID: 711f76a328cbe5b49164bb14bcb593fa52102051
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

Commit-ID:  711f76a328cbe5b49164bb14bcb593fa52102051
Gitweb:     https://git.kernel.org/tip/711f76a328cbe5b49164bb14bcb593fa52102051
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 17 Oct 2018 19:05:53 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 18 Oct 2018 00:05:04 +0200

x86/mcelog: Remove one mce_helper definition

Commit

  5de97c9f6d85f ("x86/mce: Factor out and deprecate the /dev/mcelog driver")

moved the old interface into one file including mce_helper definition as
static and "extern". Remove one.

Fixes: 5de97c9f6d85f ("x86/mce: Factor out and deprecate the /dev/mcelog driver")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Tony Luck <tony.luck@intel.com>
CC: linux-edac <linux-edac@vger.kernel.org>
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20181017170554.18841-3-bigeasy@linutronix.de
---
 arch/x86/kernel/cpu/mcheck/dev-mcelog.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/dev-mcelog.c b/arch/x86/kernel/cpu/mcheck/dev-mcelog.c
index 97685a0c3175..27f394ac983f 100644
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
