Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AD8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6100F218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeLRNtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:49:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35335 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRNtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:49:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDmKTo2850410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:48:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDmKkY2850407;
        Tue, 18 Dec 2018 05:48:20 -0800
Date:   Tue, 18 Dec 2018 05:48:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vcz4ufzdon7cwy8dm2ua53xk@git.kernel.org>
Cc:     wangnan0@huawei.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        leo.yan@linaro.org, acme@redhat.com, namhyung@kernel.org,
        mingo@kernel.org, jolsa@redhat.com, adrian.hunter@intel.com,
        dsahern@gmail.com, davem@davemloft.net, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: hpa@zytor.com, davem@davemloft.net, dsahern@gmail.com,
          tglx@linutronix.de, jolsa@redhat.com, adrian.hunter@intel.com,
          acme@redhat.com, mingo@kernel.org, namhyung@kernel.org,
          wangnan0@huawei.com, mathieu.poirier@linaro.org,
          linux-kernel@vger.kernel.org, ak@linux.intel.com,
          leo.yan@linaro.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf env: Also consider env->arch == NULL as local
 operation
Git-Commit-ID: 804234f27180dcf9a25cb98a88d5212f65b7f3fd
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
Message-ID: <20181218134820.oYcPgiXfoMD2woY8KspFC0AtYIbp2WfNDi40p9hqhr8@z>

Commit-ID:  804234f27180dcf9a25cb98a88d5212f65b7f3fd
Gitweb:     https://git.kernel.org/tip/804234f27180dcf9a25cb98a88d5212f65b7f3fd
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 27 Nov 2018 11:45:49 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:54:02 -0300

perf env: Also consider env->arch == NULL as local operation

We'll set a new machine field based on env->arch, which for live mode,
like with 'perf top' means we need to use uname() to figure the name of
the arch, fix perf_env__arch() to consider both (env == NULL) and
(env->arch == NULL) as local operation.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org # 4.19
Link: https://lkml.kernel.org/n/tip-vcz4ufzdon7cwy8dm2ua53xk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 59f38c7693f8..4c23779e271a 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -166,7 +166,7 @@ const char *perf_env__arch(struct perf_env *env)
 	struct utsname uts;
 	char *arch_name;
 
-	if (!env) { /* Assume local operation */
+	if (!env || !env->arch) { /* Assume local operation */
 		if (uname(&uts) < 0)
 			return NULL;
 		arch_name = uts.machine;
