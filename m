Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE23ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C643F214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C643F214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbeISRFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:05:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49223 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbeISRFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:05:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8JBRoqw1143498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Sep 2018 04:27:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8JBRoZW1143495;
        Wed, 19 Sep 2018 04:27:50 -0700
Date:   Wed, 19 Sep 2018 04:27:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Carpenter <tipbot@zytor.com>
Message-ID: <tip-571d0563c8881595f4ab027aef9ed1c55e3e7b7c@git.kernel.org>
Cc:     hpa@zytor.com, jgross@suse.com, dan.carpenter@oracle.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        akataria@vmware.com, peterz@infradead.org
Reply-To: peterz@infradead.org, akataria@vmware.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, dan.carpenter@oracle.com, jgross@suse.com,
          hpa@zytor.com
In-Reply-To: <20180919103553.GD9238@mwanda>
References: <20180919103553.GD9238@mwanda>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/paravirt: Fix some warning messages
Git-Commit-ID: 571d0563c8881595f4ab027aef9ed1c55e3e7b7c
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

Commit-ID:  571d0563c8881595f4ab027aef9ed1c55e3e7b7c
Gitweb:     https://git.kernel.org/tip/571d0563c8881595f4ab027aef9ed1c55e3e7b7c
Author:     Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate: Wed, 19 Sep 2018 13:35:53 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 19 Sep 2018 13:22:04 +0200

x86/paravirt: Fix some warning messages

The first argument to WARN_ONCE() is a condition.

Fixes: 5800dc5c19f3 ("x86/paravirt: Fix spectre-v2 mitigations for paravirt guests")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alok Kataria <akataria@vmware.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: virtualization@lists.linux-foundation.org
Cc: kernel-janitors@vger.kernel.org
Link: https://lkml.kernel.org/r/20180919103553.GD9238@mwanda


---
 arch/x86/kernel/paravirt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index afdb303285f8..8dc69d82567e 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -91,7 +91,7 @@ unsigned paravirt_patch_call(void *insnbuf,
 
 	if (len < 5) {
 #ifdef CONFIG_RETPOLINE
-		WARN_ONCE("Failing to patch indirect CALL in %ps\n", (void *)addr);
+		WARN_ONCE(1, "Failing to patch indirect CALL in %ps\n", (void *)addr);
 #endif
 		return len;	/* call too long for patch site */
 	}
@@ -111,7 +111,7 @@ unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
 
 	if (len < 5) {
 #ifdef CONFIG_RETPOLINE
-		WARN_ONCE("Failing to patch indirect JMP in %ps\n", (void *)addr);
+		WARN_ONCE(1, "Failing to patch indirect JMP in %ps\n", (void *)addr);
 #endif
 		return len;	/* call too long for patch site */
 	}
