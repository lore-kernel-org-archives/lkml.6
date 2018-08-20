Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78113C43615
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3692C2170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3692C2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeHTT1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:27:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41141 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeHTT1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:27:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7KGAm8D2126026
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Aug 2018 09:10:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7KGAllk2126023;
        Mon, 20 Aug 2018 09:10:47 -0700
Date:   Mon, 20 Aug 2018 09:10:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-704ae091b061082b37a9968621af4c290c641d50@git.kernel.org>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, tglx@linutronix.de,
        hpa@zytor.com, nstange@suse.de, linux-kernel@vger.kernel.org,
        bp@suse.de, mingo@kernel.org
Reply-To: nstange@suse.de, linux-kernel@vger.kernel.org, bp@suse.de,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          arnd@arndb.de, gregkh@linuxfoundation.org
In-Reply-To: <20180817100156.3009043-1-arnd@arndb.de>
References: <20180817100156.3009043-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mce: Add notifier_block forward declaration
Git-Commit-ID: 704ae091b061082b37a9968621af4c290c641d50
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

Commit-ID:  704ae091b061082b37a9968621af4c290c641d50
Gitweb:     https://git.kernel.org/tip/704ae091b061082b37a9968621af4c290c641d50
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 17 Aug 2018 12:01:36 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 20 Aug 2018 18:04:42 +0200

x86/mce: Add notifier_block forward declaration

Without linux/irq.h, there is no declaration of notifier_block, leading to
a build warning:

In file included from arch/x86/kernel/cpu/mcheck/threshold.c:10:
arch/x86/include/asm/mce.h:151:46: error: 'struct notifier_block' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]

It's sufficient to declare the struct tag here, which avoids pulling in
more header files.

Fixes: 447ae3166702 ("x86: Don't include linux/irq.h from asm/hardirq.h")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nicolai Stange <nstange@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20180817100156.3009043-1-arnd@arndb.de

---
 arch/x86/include/asm/mce.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 8c7b3e5a2d01..3a17107594c8 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -148,6 +148,7 @@ enum mce_notifier_prios {
 	MCE_PRIO_LOWEST		= 0,
 };
 
+struct notifier_block;
 extern void mce_register_decode_chain(struct notifier_block *nb);
 extern void mce_unregister_decode_chain(struct notifier_block *nb);
 
