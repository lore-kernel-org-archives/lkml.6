Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5E6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992F020865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992F020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392478AbeKVRvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:51:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38119 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbeKVRvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:51:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM7CTa73692265
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:12:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM7CTM43692262;
        Wed, 21 Nov 2018 23:12:29 -0800
Date:   Wed, 21 Nov 2018 23:12:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-4787eff3fa88f62fede6ed7afa06477ae6bf984d@git.kernel.org>
Cc:     namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        bp@suse.de, acme@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, puwen@hygon.cn, jolsa@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          puwen@hygon.cn, jolsa@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, bp@suse.de, acme@redhat.com,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org
In-Reply-To: <1542008451-31735-1-git-send-email-puwen@hygon.cn>
References: <1542008451-31735-1-git-send-email-puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add Hygon Dhyana support
Git-Commit-ID: 4787eff3fa88f62fede6ed7afa06477ae6bf984d
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

Commit-ID:  4787eff3fa88f62fede6ed7afa06477ae6bf984d
Gitweb:     https://git.kernel.org/tip/4787eff3fa88f62fede6ed7afa06477ae6bf984d
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Mon, 12 Nov 2018 15:40:51 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 22:39:56 -0300

perf tools: Add Hygon Dhyana support

The tool perf is useful for the performance analysis on the Hygon Dhyana
platform. But right now there is no Hygon support for it to analyze the
KVM guest os data. So add Hygon Dhyana support to it by checking vendor
string to share the code path of AMD.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Acked-by: Borislav Petkov <bp@suse.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1542008451-31735-1-git-send-email-puwen@hygon.cn
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/kvm-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index b32409a0e546..081353d7b095 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -156,7 +156,7 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
 	if (strstr(cpuid, "Intel")) {
 		kvm->exit_reasons = vmx_exit_reasons;
 		kvm->exit_reasons_isa = "VMX";
-	} else if (strstr(cpuid, "AMD")) {
+	} else if (strstr(cpuid, "AMD") || strstr(cpuid, "Hygon")) {
 		kvm->exit_reasons = svm_exit_reasons;
 		kvm->exit_reasons_isa = "SVM";
 	} else
