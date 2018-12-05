Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6471CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A13E2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Qh3ZS+1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A13E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeLERGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:06:35 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:38508 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeLERGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:06:34 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DC60824E16F3;
        Wed,  5 Dec 2018 09:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544029593; bh=Aonb1wRnhhqi3cKe8TCfp0JXJDv7qWLdhu5rM0BOnUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qh3ZS+1ZlRfqk0Hp9FW3JFyG9zwoUxkq1APDIuznp8vLGnCO1Y+hWF0/9NNs4SbYF
         Rkkt/Q6VrmXhuclSZtCS4RmQp8rlRAp7FwZZY332/jzEgeYYhQ9JqQlq02+y9j2kKW
         /nr79xgDMqAgsBrFpqEgTzkdkK1egoq+QYDr/44KfVuObgXjZQ6QB3AcEE7Qyh15Rq
         oZiraPwSutecf9gXfbiGIAOK6qa9R8xxTEEneCck7EzC+kg60kbfIW1Zb5ICWYjzA2
         VwLvcHobcxrFVbWy1Tc6+owZwW081Jq8HcC9AdONmaoUd8k45l8vXKQ9zWbZvkdoce
         6wRuuD+19mzTg==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 65666595B;
        Wed,  5 Dec 2018 09:06:30 -0800 (PST)
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
Subject: [PATCH 3/5] ARC: perf: fix of kernel data types using
Date:   Wed,  5 Dec 2018 20:06:07 +0300
Message-Id: <20181205170609.18690-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
References: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use u32, u64, s64 instead of uint32_t, uint64_t, int64_t

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/perf_event.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 97b88b00c418..8c88837fcd83 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -101,10 +101,10 @@ static struct arc_pmu *arc_pmu;
 static DEFINE_PER_CPU(struct arc_pmu_cpu, arc_pmu_cpu);
 
 /* read counter #idx; note that counter# != event# on ARC! */
-static uint64_t arc_pmu_read_counter(int idx)
+static u64 arc_pmu_read_counter(int idx)
 {
-	uint32_t tmp;
-	uint64_t result;
+	u32 tmp;
+	u64 result;
 
 	/*
 	 * ARC supports making 'snapshots' of the counters, so we don't
@@ -113,7 +113,7 @@ static uint64_t arc_pmu_read_counter(int idx)
 	write_aux_reg(ARC_REG_PCT_INDEX, idx);
 	tmp = read_aux_reg(ARC_REG_PCT_CONTROL);
 	write_aux_reg(ARC_REG_PCT_CONTROL, tmp | ARC_REG_PCT_CONTROL_SN);
-	result = (uint64_t) (read_aux_reg(ARC_REG_PCT_SNAPH)) << 32;
+	result = (u64) (read_aux_reg(ARC_REG_PCT_SNAPH)) << 32;
 	result |= read_aux_reg(ARC_REG_PCT_SNAPL);
 
 	return result;
@@ -122,9 +122,9 @@ static uint64_t arc_pmu_read_counter(int idx)
 static void arc_perf_event_update(struct perf_event *event,
 				  struct hw_perf_event *hwc, int idx)
 {
-	uint64_t prev_raw_count = local64_read(&hwc->prev_count);
-	uint64_t new_raw_count = arc_pmu_read_counter(idx);
-	int64_t delta = new_raw_count - prev_raw_count;
+	u64 prev_raw_count = local64_read(&hwc->prev_count);
+	u64 new_raw_count = arc_pmu_read_counter(idx);
+	s64 delta = new_raw_count - prev_raw_count;
 
 	/*
 	 * We aren't afraid of hwc->prev_count changing beneath our feet
@@ -231,7 +231,7 @@ static int arc_pmu_event_init(struct perf_event *event)
 /* starts all counters */
 static void arc_pmu_enable(struct pmu *pmu)
 {
-	uint32_t tmp;
+	u32 tmp;
 	tmp = read_aux_reg(ARC_REG_PCT_CONTROL);
 	write_aux_reg(ARC_REG_PCT_CONTROL, (tmp & 0xffff0000) | 0x1);
 }
@@ -239,7 +239,7 @@ static void arc_pmu_enable(struct pmu *pmu)
 /* stops all counters */
 static void arc_pmu_disable(struct pmu *pmu)
 {
-	uint32_t tmp;
+	u32 tmp;
 	tmp = read_aux_reg(ARC_REG_PCT_CONTROL);
 	write_aux_reg(ARC_REG_PCT_CONTROL, (tmp & 0xffff0000) | 0x0);
 }
@@ -544,7 +544,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 
 	union cc_name {
 		struct {
-			uint32_t word0, word1;
+			u32 word0, word1;
 			char sentinel;
 		} indiv;
 		char str[ARCPMU_EVENT_NAME_LEN];
-- 
2.14.5

