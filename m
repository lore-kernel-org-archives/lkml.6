Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8679DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A712081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896032;
	bh=cuzIz8DLao72/ZuChyPvjAxJzAAnZQwn8iLfD30IjdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1wKvq26PTEVkgNAXzITw5aSxfMWyvRDAzRfhlJftXA85ohL9SzKSaO406QCIn31K+
	 9TvElLSn7I4FoGz6L7JrFvKUzwpDa2EEeOxjVL8IYU2p6IRKWP7ENmp+/2GrISqQCB
	 b8YLc4HjRwCveqAiKQtq10NVu0LH8P24A0WbbJHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfBKOkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:40:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732068AbfBKOk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:40:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C0A920838;
        Mon, 11 Feb 2019 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896025;
        bh=cuzIz8DLao72/ZuChyPvjAxJzAAnZQwn8iLfD30IjdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZsRXQlbbiyTie7bII25RxUFTbh9MOeWfoOt9t4JKyBWmL6q6EZ6tifozeRHe2VISX
         Ihd9aeCPp9s9SR4hQ529AZ8wlnjUszB8SdZyKIrWn1Ps2ShTmEOrrKx6lTT4eo3erX
         Eg1Rt0cxr9hLbvP575xPyZNvNfF5oapFYZhJP88w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pu Wen <puwen@hygon.cn>,
        Borislav Petkov <bp@suse.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 048/313] perf tools: Add Hygon Dhyana support
Date:   Mon, 11 Feb 2019 15:15:28 +0100
Message-Id: <20190211141856.865475521@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
-- 
2.19.1



