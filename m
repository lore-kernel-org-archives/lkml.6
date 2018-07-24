Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D12ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FBF20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FBF20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbeGXQIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:08:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50487 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388538AbeGXQIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:08:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6OF0tZW032036
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 Jul 2018 08:00:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6OF0tHl032033;
        Tue, 24 Jul 2018 08:00:55 -0700
Date:   Tue, 24 Jul 2018 08:00:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-2397134ce2d73dcf1d4846579f594c9f3880b2ec@git.kernel.org>
Cc:     hpa@zytor.com, yuehaibing@huawei.com, peterz@infradead.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, yuehaibing@huawei.com, peterz@infradead.org,
          mingo@kernel.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20180720073213.14996-1-yuehaibing@huawei.com>
References: <20180720073213.14996-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/platform/pcspeaker: Use PTR_ERR_OR_ZERO() to
 fix ptr_ret.cocci warning
Git-Commit-ID: 2397134ce2d73dcf1d4846579f594c9f3880b2ec
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

Commit-ID:  2397134ce2d73dcf1d4846579f594c9f3880b2ec
Gitweb:     https://git.kernel.org/tip/2397134ce2d73dcf1d4846579f594c9f3880b2ec
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Fri, 20 Jul 2018 15:32:13 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 24 Jul 2018 09:46:42 +0200

x86/platform/pcspeaker: Use PTR_ERR_OR_ZERO() to fix ptr_ret.cocci warning

The ptr_ret.cocci script generates the following warning:

  arch/x86/kernel/pcspeaker.c:12:8-14: WARNING: PTR_ERR_OR_ZERO can be used

Use PTR_ERR_OR_ZERO() rather than an open-coded version to fix this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org
Cc: pombredanne@nexb.com
Link: http://lkml.kernel.org/r/20180720073213.14996-1-yuehaibing@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/pcspeaker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pcspeaker.c b/arch/x86/kernel/pcspeaker.c
index da5190a1ea16..4a710ffffd9a 100644
--- a/arch/x86/kernel/pcspeaker.c
+++ b/arch/x86/kernel/pcspeaker.c
@@ -9,6 +9,6 @@ static __init int add_pcspkr(void)
 
 	pd = platform_device_register_simple("pcspkr", -1, NULL, 0);
 
-	return IS_ERR(pd) ? PTR_ERR(pd) : 0;
+	return PTR_ERR_OR_ZERO(pd);
 }
 device_initcall(add_pcspkr);
