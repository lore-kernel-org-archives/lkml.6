Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB1BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0233E2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfAIHSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:18:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50615 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbfAIHSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:18:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x097HxXJ3856589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 23:17:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x097Hx8G3856586;
        Tue, 8 Jan 2019 23:17:59 -0800
Date:   Tue, 8 Jan 2019 23:17:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ls19h376xukeouxrw9dswkcn@git.kernel.org>
Cc:     wangnan0@huawei.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, lclaudio@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, adrian.hunter@intel.com,
        dhowells@redhat.com, namhyung@kernel.org
Reply-To: jolsa@kernel.org, dhowells@redhat.com, adrian.hunter@intel.com,
          namhyung@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, wangnan0@huawei.com,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          lclaudio@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf beauty: Switch from using uapi/linux/fs.h to
 uapi/linux/mount.h
Git-Commit-ID: 1c23397d2a6a077ab32f01c01406c2fe61b7b3a4
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

Commit-ID:  1c23397d2a6a077ab32f01c01406c2fe61b7b3a4
Gitweb:     https://git.kernel.org/tip/1c23397d2a6a077ab32f01c01406c2fe61b7b3a4
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 8 Jan 2019 13:46:43 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 8 Jan 2019 14:09:33 -0300

perf beauty: Switch from using uapi/linux/fs.h to uapi/linux/mount.h

As now we'll update our fs.h copy and what tools/perf/trace/beauty/mount_flags.sh
needs just got moved to mount.h, use that instead.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ls19h376xukeouxrw9dswkcn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mount_flags.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/mount_flags.sh b/tools/perf/trace/beauty/mount_flags.sh
index 45547573a1db..847850b2ef6c 100755
--- a/tools/perf/trace/beauty/mount_flags.sh
+++ b/tools/perf/trace/beauty/mount_flags.sh
@@ -5,11 +5,11 @@
 
 printf "static const char *mount_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+([[:digit:]]+)[[:space:]]*.*'
-egrep $regex ${header_dir}/fs.h | egrep -v '(MSK|VERBOSE|MGC_VAL)\>' | \
+egrep $regex ${header_dir}/mount.h | egrep -v '(MSK|VERBOSE|MGC_VAL)\>' | \
 	sed -r "s/$regex/\2 \2 \1/g" | sort -n | \
 	xargs printf "\t[%s ? (ilog2(%s) + 1) : 0] = \"%s\",\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+\(1<<([[:digit:]]+)\)[[:space:]]*.*'
-egrep $regex ${header_dir}/fs.h | \
+egrep $regex ${header_dir}/mount.h | \
 	sed -r "s/$regex/\2 \1/g" | \
 	xargs printf "\t[%s + 1] = \"%s\",\n"
 printf "};\n"
