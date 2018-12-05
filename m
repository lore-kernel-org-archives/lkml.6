Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DB1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4024720879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZKOHGnEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4024720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeLERGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:06:44 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:38520 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeLERGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:06:40 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 591A124E1686;
        Wed,  5 Dec 2018 09:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544029600; bh=4XRcn4REUHkeWQGTsmdIle/D+obVlEkXO8SDsM3ssNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKOHGnEAomWWsW4olwx7lkjd9sinSQel9O50T7Qbw9J1RqtM2YJgOMN+IsYf3W8N6
         AITkeEqHF6W75/J8OddQWnMgizisVhCL5dwLP+slfU7529ncCedAnc28qfhK6CoRS0
         yJy8G4s+w1HhRWwPt7ibmMUksXwj+FuLfO2EgwGmpPI14Ns583jjE3DKzeuMk6b1Ax
         tdgZ4x9qFnWd/eSygAMrYHI1St6iKyzbHMtSpVrLj3wgnpMFGYv0Vlnx+mEW1CNIK8
         tRxWqjKUukJQBScTquNzf2R/9wcWaMdbl28C8wwxXhw6wi/KZOtDetvW5wO8NsS080
         Jkkj6rg4i2+fQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 83A4159D3;
        Wed,  5 Dec 2018 09:06:37 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 5/5] ARC: perf: remove useless ifdefs
Date:   Wed,  5 Dec 2018 20:06:09 +0300
Message-Id: <20181205170609.18690-6-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
References: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ifdef around 'arc_pmu_match' structure declaration is useless
as we refer to 'arc_pmu_match' in several places which aren't
guarded with ifdef.

Nevertheless 'ARC' option selects 'OF' unconditionally so we
can simply get rid of this ifdef.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/perf_event.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index b6207090aaa7..7786c1f005fb 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -643,14 +643,12 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	return perf_pmu_register(&arc_pmu->pmu, "arc_pmu", PERF_TYPE_RAW);
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id arc_pmu_match[] = {
 	{ .compatible = "snps,arc700-pct" },
 	{ .compatible = "snps,archs-pct" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, arc_pmu_match);
-#endif
 
 static struct platform_driver arc_pmu_driver = {
 	.driver	= {
-- 
2.14.5

