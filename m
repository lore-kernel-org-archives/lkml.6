Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9783C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849CF222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191651;
	bh=8E0J6WYbqK8hyOb5yfIGW1B4b4NAEZhT5uBJBnFrung=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BelDjBQHZ7sfKXDDiuwEQLOTdYQee9ZXgYnI0T629sLz9ATbQlYmYb+cwH2w9QARJ
	 Mlc4q9QvJYwqR4Nfzy0h23jw2/FebdKUK7oA4DL7FoHDws1s4gj+hxV/wQkdUo3NBh
	 dt1zWpT542LXPTOMPDT1jJhhSIvJtIVX2Sf/pDS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbfBOAra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:47:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388994AbfBOAr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:47:28 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914B7222D4;
        Fri, 15 Feb 2019 00:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191648;
        bh=8E0J6WYbqK8hyOb5yfIGW1B4b4NAEZhT5uBJBnFrung=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BiCpHYCBI+dGT1OUrQAp+9iHgFyf42R7b1WS/afWWL5zqyYYgK5kJnrSJBi3FT+4L
         dXykeIN5pYqJfw/JP7UznbMIOH8/BwxPt8xuK08pOOxYZhv4TSvAz48WfbxATtx86Z
         8nDP9KfcJs7/Ko/1rH85qmGdv/dUMERo+wum9uyA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/43] perf cs-etm: Remove unused structure field "state"
Date:   Thu, 14 Feb 2019 21:45:19 -0300
Message-Id: <20190215004539.23571-24-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Field "state" in structure cs_etm_queue is no longer used and needs
to be removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-2-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0b11d653cfbe..ebd68eb43da9 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -65,7 +65,6 @@ struct cs_etm_queue {
 	struct thread *thread;
 	struct cs_etm_decoder *decoder;
 	struct auxtrace_buffer *buffer;
-	const struct cs_etm_state *state;
 	union perf_event *event_buf;
 	unsigned int queue_nr;
 	pid_t pid, tid;
-- 
2.19.1

