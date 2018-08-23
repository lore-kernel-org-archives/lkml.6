Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937C9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5802E2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5802E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbeHWMO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:14:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56971 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbeHWMO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:14:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8jvko3191242
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:45:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8jvxo3191239;
        Thu, 23 Aug 2018 01:45:57 -0700
Date:   Thu, 23 Aug 2018 01:45:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-31fb4c0d7b88f036edb96a6a3bd791289ea2f931@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        acme@redhat.com, namhyung@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        hpa@zytor.com, jskarvad@redhat.com, peterz@infradead.org,
        jmario@redhat.com
Reply-To: peterz@infradead.org, jmario@redhat.com, jskarvad@redhat.com,
          mingo@kernel.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, namhyung@kernel.org, jolsa@kernel.org,
          acme@redhat.com, dsahern@gmail.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <20180817114556.28000-2-jolsa@kernel.org>
References: <20180817114556.28000-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mmap: Store real cpu number in 'struct
 perf_mmap'
Git-Commit-ID: 31fb4c0d7b88f036edb96a6a3bd791289ea2f931
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

Commit-ID:  31fb4c0d7b88f036edb96a6a3bd791289ea2f931
Gitweb:     https://git.kernel.org/tip/31fb4c0d7b88f036edb96a6a3bd791289ea2f931
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 13:45:55 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf mmap: Store real cpu number in 'struct perf_mmap'

Store the real cpu number in 'struct perf_mmap', which will be used by
python interface that allows user to read a particular memory map for
given cpu.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jaroslav Škarvada <jskarvad@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817114556.28000-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/mmap.c   | 3 ++-
 tools/perf/util/mmap.h   | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e7a4b31a84fb..be440df29615 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -803,7 +803,7 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 		if (*output == -1) {
 			*output = fd;
 
-			if (perf_mmap__mmap(&maps[idx], mp, *output)  < 0)
+			if (perf_mmap__mmap(&maps[idx], mp, *output, evlist_cpu) < 0)
 				return -1;
 		} else {
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index fc832676a798..215f69f41672 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -164,7 +164,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
 
-int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
+int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
@@ -191,6 +191,7 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 		return -1;
 	}
 	map->fd = fd;
+	map->cpu = cpu;
 
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
 				&mp->auxtrace_mp, map->base, fd))
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index d82294db1295..05a6d47c7956 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -18,6 +18,7 @@ struct perf_mmap {
 	void		 *base;
 	int		 mask;
 	int		 fd;
+	int		 cpu;
 	refcount_t	 refcnt;
 	u64		 prev;
 	u64		 start;
@@ -60,7 +61,7 @@ struct mmap_params {
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd);
+int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu);
 void perf_mmap__munmap(struct perf_mmap *map);
 
 void perf_mmap__get(struct perf_mmap *map);
