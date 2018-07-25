Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03BEC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780D920671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780D920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeGYVzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:55:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44403 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730623AbeGYVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:55:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKfTlS498542
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:41:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKfTSI498539;
        Wed, 25 Jul 2018 13:41:29 -0700
Date:   Wed, 25 Jul 2018 13:41:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-6cd4ac6a02c9bc6560faf567ac013902ab9cd039@git.kernel.org>
Cc:     hpa@zytor.com, kim.phillips@arm.com, acme@redhat.com,
        mingo@kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, robert.walker@arm.com,
        tglx@linutronix.de, jolsa@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, leo.yan@linaro.org
Reply-To: peterz@infradead.org, leo.yan@linaro.org,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, jolsa@redhat.com, tglx@linutronix.de,
          robert.walker@arm.com, mike.leach@linaro.org, mingo@kernel.org,
          mathieu.poirier@linaro.org, kim.phillips@arm.com,
          acme@redhat.com, hpa@zytor.com
In-Reply-To: <1529298599-3876-3-git-send-email-leo.yan@linaro.org>
References: <1529298599-3876-3-git-send-email-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Bail out immediately for instruction
 sample failure
Git-Commit-ID: 6cd4ac6a02c9bc6560faf567ac013902ab9cd039
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

Commit-ID:  6cd4ac6a02c9bc6560faf567ac013902ab9cd039
Gitweb:     https://git.kernel.org/tip/6cd4ac6a02c9bc6560faf567ac013902ab9cd039
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Mon, 18 Jun 2018 13:09:55 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:48:32 -0300

perf cs-etm: Bail out immediately for instruction sample failure

If the instruction sample failure has happened, it isn't necessary to
execute to the end of the function cs_etm__flush().  This commit is to
bail out immediately and return the error code.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1529298599-3876-3-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 822ba915d144..8b2c099e750a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -939,6 +939,9 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 		err = cs_etm__synth_instruction_sample(
 			etmq, addr,
 			etmq->period_instructions);
+		if (err)
+			return err;
+
 		etmq->period_instructions = 0;
 
 		/*
