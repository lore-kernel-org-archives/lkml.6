Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F01AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA04208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA04208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeIZOzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:55:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55755 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIZOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:55:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8gr7Y3769650
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:42:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8grAK3769647;
        Wed, 26 Sep 2018 01:42:53 -0700
Date:   Wed, 26 Sep 2018 01:42:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sangwon Hong <tipbot@zytor.com>
Message-ID: <tip-3b9c25c0a04675c5d8d4390d9d9b661135751b27@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, hpa@zytor.com,
        yao.jin@linux.intel.com, tglx@linutronix.de, acme@redhat.com,
        qpakzk@gmail.com
Reply-To: tglx@linutronix.de, acme@redhat.com, yao.jin@linux.intel.com,
          qpakzk@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, jolsa@kernel.org, namhyung@kernel.org
In-Reply-To: <20180919074911.41931-1-qpakzk@gmail.com>
References: <20180919074911.41931-1-qpakzk@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf help: Add missing subcommand `version`
Git-Commit-ID: 3b9c25c0a04675c5d8d4390d9d9b661135751b27
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

Commit-ID:  3b9c25c0a04675c5d8d4390d9d9b661135751b27
Gitweb:     https://git.kernel.org/tip/3b9c25c0a04675c5d8d4390d9d9b661135751b27
Author:     Sangwon Hong <qpakzk@gmail.com>
AuthorDate: Wed, 19 Sep 2018 00:49:11 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 14:53:36 -0300

perf help: Add missing subcommand `version`

There isn't subcommand `version` when typing `perf help`.

Before :

  $ perf help | grep version
   usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

So add perf-version in command-list.txt for listing it when typing `perf
help`.

After :

$ perf help | grep version

 usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
   version         display the version of perf binary

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180919074911.41931-1-qpakzk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/command-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index 2d0caf20ff3a..bc6c585f74fc 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -30,3 +30,4 @@ perf-test			mainporcelain common
 perf-timechart			mainporcelain common
 perf-top			mainporcelain common
 perf-trace			mainporcelain audit
+perf-version			mainporcelain common
