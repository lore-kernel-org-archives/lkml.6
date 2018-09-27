Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6402C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647DF21564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647DF21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeI0XVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:21:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49089 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeI0XVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:21:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RH29Qj099896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 10:02:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RH29jh099893;
        Thu, 27 Sep 2018 10:02:09 -0700
Date:   Thu, 27 Sep 2018 10:02:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-39dc6f154dac134e4612827cb5283934c1862cb8@git.kernel.org>
Cc:     bp@suse.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, puwen@hygon.cn, tglx@linutronix.de
Reply-To: mingo@kernel.org, puwen@hygon.cn, bp@suse.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <8246f81648d014601de3812ade40e85d9c50d9b3.1537533369.git.puwen@hygon.cn>
References: <8246f81648d014601de3812ade40e85d9c50d9b3.1537533369.git.puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpu/mtrr: Support TOP_MEM2 and get MTRR number
Git-Commit-ID: 39dc6f154dac134e4612827cb5283934c1862cb8
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

Commit-ID:  39dc6f154dac134e4612827cb5283934c1862cb8
Gitweb:     https://git.kernel.org/tip/39dc6f154dac134e4612827cb5283934c1862cb8
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Sun, 23 Sep 2018 17:34:16 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 18:28:57 +0200

x86/cpu/mtrr: Support TOP_MEM2 and get MTRR number

The Hygon Dhyana CPU has a special MSR way to force WB for memory >4GB,
and support TOP_MEM2. Therefore, it is necessary to add Hygon Dhyana
support in amd_special_default_mtrr().

The number of variable MTRRs for Hygon is 2 as AMD's.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: thomas.lendacky@amd.com
Link: https://lkml.kernel.org/r/8246f81648d014601de3812ade40e85d9c50d9b3.1537533369.git.puwen@hygon.cn
---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 3 ++-
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 765afd599039..3668c5df90c6 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -831,7 +831,8 @@ int __init amd_special_default_mtrr(void)
 {
 	u32 l, h;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return 0;
 	if (boot_cpu_data.x86 < 0xf)
 		return 0;
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 9a19c800fe40..507039c20128 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -127,7 +127,7 @@ static void __init set_num_var_ranges(void)
 
 	if (use_intel())
 		rdmsr(MSR_MTRRcap, config, dummy);
-	else if (is_cpu(AMD))
+	else if (is_cpu(AMD) || is_cpu(HYGON))
 		config = 2;
 	else if (is_cpu(CYRIX) || is_cpu(CENTAUR))
 		config = 8;
