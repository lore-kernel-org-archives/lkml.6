Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199DBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFC5222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898203;
	bh=jjsJr85ycDNZC08j8fZp9CY4mRXMDg727QyrDLhsSYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RX/lNzZevp3gN0QiLV8KuyeaU9Fq8pRizGOIYDAvcPt3Eqj3SdxC4kttTkzTXGdFc
	 +W8yJi7o6TYQBiBr/fp4MZo+xqE14VdYGe/Yixuh6x45PIGJgCrxrCiRzwtCiF+yHt
	 lZ1wqcBagh7mNJ0M080K+VeYoiwMUrLHHS2vcrfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403775AbfBKPGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:06:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390476AbfBKPGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:06:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7EC1217D9;
        Mon, 11 Feb 2019 15:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897593;
        bh=jjsJr85ycDNZC08j8fZp9CY4mRXMDg727QyrDLhsSYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/vZTUMxj2mT5hrNuO9CzNLFGOUQ9eXQDhnvATcoIXBRxmZL7vQ4djqg0MWTEAbBv
         VY9alQF4OqPPo3YCnp34pZP5ZXm52o+IaXj2NRWM3HqjEJbib/V6xyIYmGw2y1cPc/
         gJBuy1YjXrL0lOJw2ri+EYkgJ/1jM60AjjZ4zuu0=
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
Subject: [PATCH 4.9 018/137] perf tools: Add Hygon Dhyana support
Date:   Mon, 11 Feb 2019 15:18:19 +0100
Message-Id: <20190211141813.689423294@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index b63d4be655a2..2020e12a856f 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -154,7 +154,7 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
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



