Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7608BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483AB2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483AB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeLCRTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:19:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58993 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbeLCRTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:19:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB3HItXs527836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Dec 2018 09:18:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB3HItLY527833;
        Mon, 3 Dec 2018 09:18:55 -0800
Date:   Mon, 3 Dec 2018 09:18:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-0abbbc63d0251a25d3df6c8a56ab3d3c20af082c@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        bp@suse.de, ricardo.neri-calderon@linux.intel.com,
        tglx@linutronix.de, mingo@redhat.com
Reply-To: mingo@redhat.com, tglx@linutronix.de,
          ricardo.neri-calderon@linux.intel.com,
          linux-kernel@vger.kernel.org, bp@suse.de, hpa@zytor.com,
          mingo@kernel.org
In-Reply-To: <20181127205936.30331-1-bp@alien8.de>
References: <20181127205936.30331-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/umip: Print UMIP line only once
Git-Commit-ID: 0abbbc63d0251a25d3df6c8a56ab3d3c20af082c
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

Commit-ID:  0abbbc63d0251a25d3df6c8a56ab3d3c20af082c
Gitweb:     https://git.kernel.org/tip/0abbbc63d0251a25d3df6c8a56ab3d3c20af082c
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 27 Nov 2018 21:54:18 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 3 Dec 2018 16:59:10 +0100

x86/umip: Print UMIP line only once

... instead of issuing it per CPU and flooding dmesg unnecessarily.
Streamline the formulation, while at it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20181127205936.30331-1-bp@alien8.de
---
 arch/x86/kernel/cpu/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ffb181f959d2..2c56b8066280 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -353,7 +353,7 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 
 	cr4_set_bits(X86_CR4_UMIP);
 
-	pr_info("x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature\n");
+	pr_info_once("x86/cpu: Intel User Mode Instruction Prevention (UMIP) activated\n");
 
 	return;
 
