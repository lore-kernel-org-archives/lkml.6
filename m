Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDEBECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4711E20837
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4711E20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbeGPQcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:32:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49177 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbeGPQcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:32:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6GG4gBs1189962
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 Jul 2018 09:04:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6GG4f9V1189959;
        Mon, 16 Jul 2018 09:04:41 -0700
Date:   Mon, 16 Jul 2018 09:04:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiang Biao <tipbot@zytor.com>
Message-ID: <tip-21279157efffe5e7258483809942d576cb802768@git.kernel.org>
Cc:     jiang.biao2@zte.com.cn, linux-kernel@vger.kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          jiang.biao2@zte.com.cn, mingo@kernel.org, tglx@linutronix.de,
          dave.hansen@linux.intel.com
In-Reply-To: <1531713820-24544-4-git-send-email-jiang.biao2@zte.com.cn>
References: <1531713820-24544-4-git-send-email-jiang.biao2@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Make pti_set_kernel_image_nonglobal() static
Git-Commit-ID: 21279157efffe5e7258483809942d576cb802768
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

Commit-ID:  21279157efffe5e7258483809942d576cb802768
Gitweb:     https://git.kernel.org/tip/21279157efffe5e7258483809942d576cb802768
Author:     Jiang Biao <jiang.biao2@zte.com.cn>
AuthorDate: Mon, 16 Jul 2018 12:03:38 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 16 Jul 2018 17:59:57 +0200

x86/pti: Make pti_set_kernel_image_nonglobal() static

pti_set_kernel_image_nonglobal() is only used in pti.c, make it static.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: luto@kernel.org
Cc: hpa@zytor.com
Cc: albcamus@gmail.com
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/r/1531713820-24544-4-git-send-email-jiang.biao2@zte.com.cn

---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 4d418e705878..9277e9ba92b5 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -466,7 +466,7 @@ void pti_clone_kernel_text(void)
  * the other set_memory.h functions.  Just extern it.
  */
 extern int set_memory_nonglobal(unsigned long addr, int numpages);
-void pti_set_kernel_image_nonglobal(void)
+static void pti_set_kernel_image_nonglobal(void)
 {
 	/*
 	 * The identity map is created with PMDs, regardless of the
