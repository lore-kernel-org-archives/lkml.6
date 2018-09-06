Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60C9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB31206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB31206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbeIFSYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:24:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35425 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeIFSYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:24:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DmXL1311406
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:48:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DmXUW311403;
        Thu, 6 Sep 2018 06:48:33 -0700
Date:   Thu, 6 Sep 2018 06:48:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-t3684lkugnf1w4lwcmpj9ivm@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, wangnan0@huawei.com,
        acme@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
          dsahern@gmail.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
          wangnan0@huawei.com, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf map: Turn some pr_warning() to pr_debug()
Git-Commit-ID: d8e75a110df7e3318990c9fb207ae0aa7812895a
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

Commit-ID:  d8e75a110df7e3318990c9fb207ae0aa7812895a
Gitweb:     https://git.kernel.org/tip/d8e75a110df7e3318990c9fb207ae0aa7812895a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 4 Sep 2018 10:43:07 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 4 Sep 2018 16:51:12 -0300

perf map: Turn some pr_warning() to pr_debug()

Annoying when using it with --stdio/--stdio2, so just turn them debug,
we can get those using -v.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-t3684lkugnf1w4lwcmpj9ivm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 36d0763311ef..3f07a587c8e6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -320,12 +320,11 @@ int map__load(struct map *map)
 			build_id__sprintf(map->dso->build_id,
 					  sizeof(map->dso->build_id),
 					  sbuild_id);
-			pr_warning("%s with build id %s not found",
-				   name, sbuild_id);
+			pr_debug("%s with build id %s not found", name, sbuild_id);
 		} else
-			pr_warning("Failed to open %s", name);
+			pr_debug("Failed to open %s", name);
 
-		pr_warning(", continuing without symbols\n");
+		pr_debug(", continuing without symbols\n");
 		return -1;
 	} else if (nr == 0) {
 #ifdef HAVE_LIBELF_SUPPORT
@@ -334,12 +333,11 @@ int map__load(struct map *map)
 
 		if (len > sizeof(DSO__DELETED) &&
 		    strcmp(name + real_len + 1, DSO__DELETED) == 0) {
-			pr_warning("%.*s was updated (is prelink enabled?). "
+			pr_debug("%.*s was updated (is prelink enabled?). "
 				"Restart the long running apps that use it!\n",
 				   (int)real_len, name);
 		} else {
-			pr_warning("no symbols found in %s, maybe install "
-				   "a debug package?\n", name);
+			pr_debug("no symbols found in %s, maybe install a debug package?\n", name);
 		}
 #endif
 		return -1;
@@ -701,8 +699,7 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 		if (verbose >= 2) {
 
 			if (use_browser) {
-				pr_warning("overlapping maps in %s "
-					   "(disable tui for more info)\n",
+				pr_debug("overlapping maps in %s (disable tui for more info)\n",
 					   map->dso->name);
 			} else {
 				fputs("overlapping maps:\n", fp);
