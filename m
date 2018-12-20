Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89510C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680A6218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbeLTSOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:14:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732677AbeLTSOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:14:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIE3OA3682535
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:14:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIE2kH3682532;
        Thu, 20 Dec 2018 10:14:02 -0800
Date:   Thu, 20 Dec 2018 10:14:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-cfc1d4276b0453a752d8b31daf34f7f2dbd55e82@git.kernel.org>
Cc:     hpa@zytor.com, robert.walker@arm.com, tglx@linutronix.de,
        leo.yan@linaro.org, acme@redhat.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org
Reply-To: mingo@kernel.org, alexander.shishkin@linux.intel.com,
          mathieu.poirier@linaro.org, mike.leach@linaro.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          acme@redhat.com, jolsa@redhat.com, leo.yan@linaro.org,
          tglx@linutronix.de, robert.walker@arm.com, hpa@zytor.com
In-Reply-To: <1544513908-16805-5-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-5-git-send-email-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Refactor enumeration
 cs_etm_sample_type
Git-Commit-ID: cfc1d4276b0453a752d8b31daf34f7f2dbd55e82
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

Commit-ID:  cfc1d4276b0453a752d8b31daf34f7f2dbd55e82
Gitweb:     https://git.kernel.org/tip/cfc1d4276b0453a752d8b31daf34f7f2dbd55e82
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 11 Dec 2018 15:38:24 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:59 -0300

perf cs-etm: Refactor enumeration cs_etm_sample_type

The values in enumeration cs_etm_sample_type are defined with setting
bit N for each packet type, this is not suggested in the usual case.

This patch refactor cs_etm_sample_type by converting from bit shifting
values to continuous numbers.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-5-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index b295dd2b8292..3819a04a2c27 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -23,9 +23,9 @@ struct cs_etm_buffer {
 };
 
 enum cs_etm_sample_type {
-	CS_ETM_EMPTY = 0,
-	CS_ETM_RANGE = 1 << 0,
-	CS_ETM_TRACE_ON = 1 << 1,
+	CS_ETM_EMPTY,
+	CS_ETM_RANGE,
+	CS_ETM_TRACE_ON,
 };
 
 enum cs_etm_isa {
