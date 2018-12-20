Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4267C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B122C218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbeLTS1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:27:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35157 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731963AbeLTS1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:27:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIRDrh3686364
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:27:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIRD6t3686361;
        Thu, 20 Dec 2018 10:27:13 -0800
Date:   Thu, 20 Dec 2018 10:27:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-w0fux1psivphhx6rve8kn3vq@git.kernel.org>
Cc:     lclaudio@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
        jolsa@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, namhyung@kernel.org,
          wangnan0@huawei.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, lclaudio@redhat.com,
          adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty: Add a string table generator for x86's
 'arch_prctl' codes
Git-Commit-ID: ff4cb769bc2dcc9a74a1c29e403bcfaf789365ef
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

Commit-ID:  ff4cb769bc2dcc9a74a1c29e403bcfaf789365ef
Gitweb:     https://git.kernel.org/tip/ff4cb769bc2dcc9a74a1c29e403bcfaf789365ef
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 17 Dec 2018 16:11:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:15:18 -0300

perf beauty: Add a string table generator for x86's 'arch_prctl' codes

  $ tools/perf/trace/beauty/x86_arch_prctl.sh
  #define x86_arch_prctl_codes_1_offset 0x1001
  static const char *x86_arch_prctl_codes_1[] = {
	[0x1001 - 0x1001]= "SET_GS",
	[0x1002 - 0x1001]= "SET_FS",
	[0x1003 - 0x1001]= "GET_FS",
	[0x1004 - 0x1001]= "GET_GS",
	[0x1011 - 0x1001]= "GET_CPUID",
	[0x1012 - 0x1001]= "SET_CPUID",
  };

  #define x86_arch_prctl_codes_2_offset 0x2001
  static const char *x86_arch_prctl_codes_2[] = {
	[0x2001 - 0x2001]= "MAP_VDSO_X32",
	[0x2002 - 0x2001]= "MAP_VDSO_32",
	[0x2003 - 0x2001]= "MAP_VDSO_64",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-w0fux1psivphhx6rve8kn3vq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/x86_arch_prctl.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/trace/beauty/x86_arch_prctl.sh b/tools/perf/trace/beauty/x86_arch_prctl.sh
new file mode 100755
index 000000000000..7372d3cab959
--- /dev/null
+++ b/tools/perf/trace/beauty/x86_arch_prctl.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && x86_header_dir=$1 || x86_header_dir=tools/arch/x86/include/uapi/asm/
+
+prctl_arch_header=${x86_header_dir}/prctl.h
+
+print_range () {
+	local idx=$1
+	local prefix=$2
+	local first_entry=$3
+
+	printf "#define x86_arch_prctl_codes_%d_offset %s\n" $idx $first_entry
+	printf "static const char *x86_arch_prctl_codes_%d[] = {\n" $idx
+	regex=`printf '^[[:space:]]*#[[:space:]]*define[[:space:]]+ARCH_([[:alnum:]_]+)[[:space:]]+(%s[[:xdigit:]]+).*' ${prefix}`
+	fmt="\t[%#x - ${first_entry}]= \"%s\",\n"
+	egrep -q $regex ${prctl_arch_header} && \
+	(egrep $regex ${prctl_arch_header} | \
+		sed -r "s/$regex/\2 \1/g"	| \
+		xargs printf "$fmt")
+	printf "};\n\n"
+}
+
+print_range 1 0x1 0x1001
+print_range 2 0x2 0x2001
