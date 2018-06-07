Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sLisIhLoGFsnTgAAmS7hNA
	; Thu, 07 Jun 2018 08:08:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AD5A76089E; Thu,  7 Jun 2018 08:08:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 14DB4607E7;
	Thu,  7 Jun 2018 08:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14DB4607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeFGII4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:08:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753477AbeFGIIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:08:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5788hrX2124393
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:08:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5788hPW2124390;
        Thu, 7 Jun 2018 01:08:43 -0700
Date: Thu, 7 Jun 2018 01:08:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2g0vwqnc49wl4ttjk8dvpgcc@git.kernel.org>
Cc: hpa@zytor.com, wangnan0@huawei.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, dsahern@gmail.com,
        acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: hpa@zytor.com, wangnan0@huawei.com, jolsa@kernel.org,
          namhyung@kernel.org, adrian.hunter@intel.com, dsahern@gmail.com,
          acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Add comment about
 annotated_src->nr_histograms
Git-Commit-ID: 9132d3d92d8953ee79690408a9a24d938be22cd8
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

Commit-ID:  9132d3d92d8953ee79690408a9a24d938be22cd8
Gitweb:     https://git.kernel.org/tip/9132d3d92d8953ee79690408a9a24d938be22cd8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 25 May 2018 11:27:38 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:52 -0300

perf annotate: Add comment about annotated_src->nr_histograms

When we have multiple groups in an evlist, say:

  $ perf stat -e '{cycles,instructions},{cache-references,cache-misses}' sleep 1

   Performance counter stats for 'sleep 1':

           343,134      cycles:u
           249,292      instructions:u            #    0.73  insn per cycle
            15,556      cache-references:u
             8,925      cache-misses:u            #   57.373 % of all cache refs

       1.000957550 seconds time elapsed

  $

Then the perf_evsel instances for the two group leaders ("cycles" and
"cache-references") will have evsel->nr_members set to 2, while all the
evsel->evlist->nr_entries will be set to 4, so we can't use
evsel->evlist->nr_entries everywhere, as event groups need to be taken
into account.

But this probably requires us to audit at least the forced-group code,
where we want all of the events to be in a "group", to see them all in
the screen, one column for each, even knowing that they were not
necessarily scheduled to count at the same time by the kernel perf
subsystem.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2g0vwqnc49wl4ttjk8dvpgcc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 7ad503fbff74..3dc4ca1d6c08 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -202,6 +202,10 @@ struct cyc_hist {
 /** struct annotated_source - symbols with hits have this attached as in sannotation
  *
  * @histograms: Array of addr hit histograms per event being monitored
+ * nr_histograms: This may not be the same as evsel->evlist->nr_entries if
+ * 		  we have more than a group in a evlist, where we will want
+ * 		  to see each group separately, that is why symbol__annotate2()
+ * 		  sets src->nr_histograms to evsel->nr_members.
  * @lines: If 'print_lines' is specified, per source code line percentages
  * @source: source parsed from a disassembler like objdump -dS
  * @cyc_hist: Average cycles per basic block
