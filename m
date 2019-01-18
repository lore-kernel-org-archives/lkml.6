Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8EFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBA520883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfARPtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:49:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfARPtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:49:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0IFmxLv1253423
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 18 Jan 2019 07:48:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0IFmxMT1253420;
        Fri, 18 Jan 2019 07:48:59 -0800
Date:   Fri, 18 Jan 2019 07:48:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiaxun Yang <tipbot@zytor.com>
Message-ID: <tip-0237199186e7a4aa5310741f0a6498a20c820fd7@git.kernel.org>
Cc:     suravee.suthikulpanit@amd.com, jiaxun.yang@flygoat.com,
        tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        sherry.hurwitz@amd.com, mingo@redhat.com, bp@suse.de,
        mingo@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com
Reply-To: bp@suse.de, mingo@kernel.org, thomas.lendacky@amd.com,
          hpa@zytor.com, tglx@linutronix.de, jiaxun.yang@flygoat.com,
          suravee.suthikulpanit@amd.com, x86@kernel.org,
          sherry.hurwitz@amd.com, linux-kernel@vger.kernel.org,
          mingo@redhat.com
In-Reply-To: <20181120030018.5185-1-jiaxun.yang@flygoat.com>
References: <20181120030018.5185-1-jiaxun.yang@flygoat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/CPU/AMD: Set the CPB bit unconditionally on F17h
Git-Commit-ID: 0237199186e7a4aa5310741f0a6498a20c820fd7
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

Commit-ID:  0237199186e7a4aa5310741f0a6498a20c820fd7
Gitweb:     https://git.kernel.org/tip/0237199186e7a4aa5310741f0a6498a20c820fd7
Author:     Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate: Tue, 20 Nov 2018 11:00:18 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 18 Jan 2019 16:44:03 +0100

x86/CPU/AMD: Set the CPB bit unconditionally on F17h

Some F17h models do not have CPB set in CPUID even though the CPU
supports it. Set the feature bit unconditionally on all F17h.

 [ bp: Rewrite commit message and patch. ]

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181120030018.5185-1-jiaxun.yang@flygoat.com
---
 arch/x86/kernel/cpu/amd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 69f6bbb41be0..01004bfb1a1b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -819,11 +819,9 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 static void init_amd_zn(struct cpuinfo_x86 *c)
 {
 	set_cpu_cap(c, X86_FEATURE_ZEN);
-	/*
-	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
-	 * all up to and including B1.
-	 */
-	if (c->x86_model <= 1 && c->x86_stepping <= 1)
+
+	/* Fix erratum 1076: CPB feature bit not being set in CPUID. */
+	if (!cpu_has(c, X86_FEATURE_CPB))
 		set_cpu_cap(c, X86_FEATURE_CPB);
 }
 
