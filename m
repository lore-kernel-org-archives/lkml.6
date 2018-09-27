Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1C5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB5E21564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB5E21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeI0XXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:23:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42781 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeI0XXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:23:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RH3pDG100180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 10:03:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RH3ptB100177;
        Thu, 27 Sep 2018 10:03:51 -0700
Date:   Thu, 27 Sep 2018 10:03:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-c3fecca457c1aa1c1a2f81bfe68393af244a263e@git.kernel.org>
Cc:     tglx@linutronix.de, puwen@hygon.cn, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, bp@suse.de
Reply-To: bp@suse.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, puwen@hygon.cn, hpa@zytor.com
In-Reply-To: <79e76c3173716984fe5fdd4a8e2c798bf4193205.1537533369.git.puwen@hygon.cn>
References: <79e76c3173716984fe5fdd4a8e2c798bf4193205.1537533369.git.puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/alternative: Init ideal_nops for Hygon Dhyana
Git-Commit-ID: c3fecca457c1aa1c1a2f81bfe68393af244a263e
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

Commit-ID:  c3fecca457c1aa1c1a2f81bfe68393af244a263e
Gitweb:     https://git.kernel.org/tip/c3fecca457c1aa1c1a2f81bfe68393af244a263e
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Sun, 23 Sep 2018 17:35:01 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 18:28:58 +0200

x86/alternative: Init ideal_nops for Hygon Dhyana

The ideal_nops for Hygon Dhyana CPU should be p6_nops.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: thomas.lendacky@amd.com
Link: https://lkml.kernel.org/r/79e76c3173716984fe5fdd4a8e2c798bf4193205.1537533369.git.puwen@hygon.cn
---
 arch/x86/kernel/alternative.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b9d5e7c9ef43..184e9a06b0ff 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -222,6 +222,10 @@ void __init arch_init_ideal_nops(void)
 		}
 		break;
 
+	case X86_VENDOR_HYGON:
+		ideal_nops = p6_nops;
+		return;
+
 	case X86_VENDOR_AMD:
 		if (boot_cpu_data.x86 > 0xf) {
 			ideal_nops = p6_nops;
