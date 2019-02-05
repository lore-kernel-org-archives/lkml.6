Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51706C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275882145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfBEG2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:28:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46919 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEG2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:28:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x156S5Es736326
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 22:28:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x156S5vT736323;
        Mon, 4 Feb 2019 22:28:05 -0800
Date:   Mon, 4 Feb 2019 22:28:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-8ad382dd11ebed9f87edfeda6e738c472a911203@git.kernel.org>
Cc:     reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org, mingo@redhat.com,
        fenghua.yu@intel.com, tony.luck@intel.com, tglx@linutronix.de,
        x86@kernel.org, bp@suse.de
Reply-To: bp@suse.de, fenghua.yu@intel.com, mingo@redhat.com,
          tony.luck@intel.com, tglx@linutronix.de, x86@kernel.org,
          hpa@zytor.com, mingo@kernel.org, reinette.chatre@intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <ff6b95d9b6ef6f4ac96267f130719ba1af09614b.1549312475.git.reinette.chatre@intel.com>
References: <ff6b95d9b6ef6f4ac96267f130719ba1af09614b.1549312475.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/resctrl: Remove duplicate
 MSR_MISC_FEATURE_CONTROL definition
Git-Commit-ID: 8ad382dd11ebed9f87edfeda6e738c472a911203
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

Commit-ID:  8ad382dd11ebed9f87edfeda6e738c472a911203
Gitweb:     https://git.kernel.org/tip/8ad382dd11ebed9f87edfeda6e738c472a911203
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Mon, 4 Feb 2019 12:41:36 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 5 Feb 2019 07:21:56 +0100

x86/resctrl: Remove duplicate MSR_MISC_FEATURE_CONTROL definition

The definition of MSR_MISC_FEATURE_CONTROL was first introduced in

  98af74599ea0 ("x86 msr_index.h: Define MSR_MISC_FEATURE_CONTROL")

and present in Linux since v4.11.

The Cache Pseudo-Locking code added this duplicate definition in more
recent

  f2a177292bd0 ("x86/intel_rdt: Discover supported platforms via prefetch disable bits"),

available since v4.19.

Remove the duplicate definition from the resctrl subsystem and let that
code obtain the needed definition from the core architecture msr-index.h
instead.

Fixes: f2a177292bd0 ("x86/intel_rdt: Discover supported platforms via prefetch disable bits")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: gavin.hindman@intel.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: jithu.joseph@intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/ff6b95d9b6ef6f4ac96267f130719ba1af09614b.1549312475.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 14bed6af8377..604c0e3bcc83 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -33,13 +33,6 @@
 #define CREATE_TRACE_POINTS
 #include "pseudo_lock_event.h"
 
-/*
- * MSR_MISC_FEATURE_CONTROL register enables the modification of hardware
- * prefetcher state. Details about this register can be found in the MSR
- * tables for specific platforms found in Intel's SDM.
- */
-#define MSR_MISC_FEATURE_CONTROL	0x000001a4
-
 /*
  * The bits needed to disable hardware prefetching varies based on the
  * platform. During initialization we will discover which bits to use.
