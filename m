Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BA8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DE62082C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693592;
	bh=lxXm3U8MgpH0TpRFsz7deIZoDImEz8QCdQJmHWKOTtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qLDG6CXY+JeCx+M4SLh5hveCYEkbtCaL4ff9DWVly3AZZrNkQ5epSnFWnQygBKkQf
	 IfI2fMS3Ip+OUFgjpeW3kf8iAdD2K/ROCToFsUbHns+5N1SlvmRC/IotmBqSHB3dEL
	 /TJT67j7DIdFoL/KHcqqlzkWZXKQfLYYk1Q2P1jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390066AbfA1Qju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:39:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:32978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389677AbfA1QY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895072084A;
        Mon, 28 Jan 2019 16:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692668;
        bh=lxXm3U8MgpH0TpRFsz7deIZoDImEz8QCdQJmHWKOTtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KC3h6IamO9jqV1yc2reh9B0SBB8crsI5sjYRkC1oHNeo7lHlSTCvscn+Wn5AihE4W
         xLBd4IRABazs5nkQymh7FKJ/+NxfvfXU7zP/WDfTyy6We7V66FU0+Ede1EiDIp4YQN
         8BkiyIu+CXszGVcctZpVI9f8k2Mr0cjksCHAk2/4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pu Wen <puwen@hygon.cn>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 18/80] perf tools: Add Hygon Dhyana support
Date:   Mon, 28 Jan 2019 11:22:59 -0500
Message-Id: <20190128162401.58841-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pu Wen <puwen@hygon.cn>

[ Upstream commit 4787eff3fa88f62fede6ed7afa06477ae6bf984d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/arch/x86/util/kvm-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 14e4e668fad7..f97696a418cc 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -146,7 +146,7 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
 	if (strstr(cpuid, "Intel")) {
 		kvm->exit_reasons = vmx_exit_reasons;
 		kvm->exit_reasons_isa = "VMX";
-	} else if (strstr(cpuid, "AMD")) {
+	} else if (strstr(cpuid, "AMD") || strstr(cpuid, "Hygon")) {
 		kvm->exit_reasons = svm_exit_reasons;
 		kvm->exit_reasons_isa = "SVM";
 	} else
-- 
2.19.1

