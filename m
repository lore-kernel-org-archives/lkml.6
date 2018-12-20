Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9D1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF13218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbeLTSNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:13:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49269 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeLTSNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:13:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIDSrv3682424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:13:28 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIDSID3682420;
        Thu, 20 Dec 2018 10:13:28 -0800
Date:   Thu, 20 Dec 2018 10:13:28 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-cee7a6a212ddb514d6e2ac1f9733501c43d63d0a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        acme@redhat.com, namhyung@kernel.org, jolsa@redhat.com,
        leo.yan@linaro.org, robert.walker@arm.com, mingo@kernel.org,
        mathieu.poirier@linaro.org
Reply-To: mathieu.poirier@linaro.org, leo.yan@linaro.org, mingo@kernel.org,
          robert.walker@arm.com, namhyung@kernel.org, jolsa@redhat.com,
          acme@redhat.com, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, mike.leach@linaro.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <1544513908-16805-4-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-4-git-send-email-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Remove unused 'trace_on' in
 cs_etm_decoder
Git-Commit-ID: cee7a6a212ddb514d6e2ac1f9733501c43d63d0a
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

Commit-ID:  cee7a6a212ddb514d6e2ac1f9733501c43d63d0a
Gitweb:     https://git.kernel.org/tip/cee7a6a212ddb514d6e2ac1f9733501c43d63d0a
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 11 Dec 2018 15:38:23 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:59 -0300

perf cs-etm: Remove unused 'trace_on' in cs_etm_decoder

cs_etm_decoder::trace_on is being assigned when TRACE_ON or NO_SYNC
element is coming, but it is never used hence it is redundant and can
be removed.

So let's remove 'trace_on' field from cs_etm_decoder struct.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-4-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 0b4c8629f578..97b39b1f5759 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -36,7 +36,6 @@
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg);
-	bool trace_on;
 	dcd_tree_handle_t dcd_tree;
 	cs_etm_mem_cb_type mem_access;
 	ocsd_datapath_resp_t prev_return;
@@ -411,12 +410,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
-		decoder->trace_on = false;
 		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
 		resp = cs_etm_decoder__buffer_trace_on(decoder,
 						       trace_chan_id);
-		decoder->trace_on = true;
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
 		resp = cs_etm_decoder__buffer_range(decoder, elem,
