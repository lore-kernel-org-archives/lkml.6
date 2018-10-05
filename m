Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7C8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CE92087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CE92087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbeJEXUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:20:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48045 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbeJEXUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:20:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w95GLCHU3206718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Oct 2018 09:21:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w95GLC4u3206715;
        Fri, 5 Oct 2018 09:21:12 -0700
Date:   Fri, 5 Oct 2018 09:21:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Milian Wolff <tipbot@zytor.com>
Message-ID: <tip-7a8a8fcf7b860e4b2d4edc787c844d41cad9dfcf@git.kernel.org>
Cc:     ravi.bangoria@linux.ibm.com, acme@redhat.com,
        milian.wolff@kdab.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        yao.jin@linux.intel.com, namhyung@kernel.org,
        sandipan@linux.ibm.com, mingo@kernel.org
Reply-To: sandipan@linux.ibm.com, mingo@kernel.org, namhyung@kernel.org,
          yao.jin@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
          milian.wolff@kdab.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, ravi.bangoria@linux.ibm.com, acme@redhat.com
In-Reply-To: <20181002073949.3297-1-milian.wolff@kdab.com>
References: <20180926135207.30263-2-milian.wolff@kdab.com>
        <20181002073949.3297-1-milian.wolff@kdab.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Use unmapped IP for inline callchain
 cursors
Git-Commit-ID: 7a8a8fcf7b860e4b2d4edc787c844d41cad9dfcf
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

Commit-ID:  7a8a8fcf7b860e4b2d4edc787c844d41cad9dfcf
Gitweb:     https://git.kernel.org/tip/7a8a8fcf7b860e4b2d4edc787c844d41cad9dfcf
Author:     Milian Wolff <milian.wolff@kdab.com>
AuthorDate: Wed, 26 Sep 2018 15:52:06 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 5 Oct 2018 11:18:09 -0300

perf record: Use unmapped IP for inline callchain cursors

Only use the mapped IP to find inline frames, but keep using the
unmapped IP for the callchain cursor. This ensures we properly show the
unmapped IP when displaying a frame we received via the
dso__parse_addr_inlines API for a module which does not contain
sufficient debug symbols to show the srcline.

This is another follow-up to commit 19610184693c ("perf script: Show
virtual addresses instead of offsets").

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Fixes: 19610184693c ("perf script: Show virtual addresses instead of offsets")
Link: http://lkml.kernel.org/r/20180926135207.30263-2-milian.wolff@kdab.com
Link: http://lkml.kernel.org/r/20181002073949.3297-1-milian.wolff@kdab.com
[ Squashed a fix from Milian for a problem reported by Ravi, fixed up space damage ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0cb4f8bf3ca7..111ae858cbcb 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2286,7 +2286,8 @@ static int append_inlines(struct callchain_cursor *cursor,
 	if (!symbol_conf.inline_name || !map || !sym)
 		return ret;
 
-	addr = map__rip_2objdump(map, ip);
+	addr = map__map_ip(map, ip);
+	addr = map__rip_2objdump(map, addr);
 
 	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
 	if (!inline_node) {
