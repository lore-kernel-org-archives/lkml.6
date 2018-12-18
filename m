Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F3CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A2821871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171452;
	bh=wPmZCRcuPajVxY0A5Yqjzwpa8TBaru9F2GaBl6lZTPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CVbNjymUCW4l216prW9QrjfVhDp6by0vmKTK3HcCepq67rBwEy380j5rota+v3Jnc
	 T0HT1ZY7mhJZWUiS8LHOnrQ36e0v7Fi6LMmNm8hvcG/XVtsyNbJDCsAJ2rtUTqhCGc
	 wDJQbdwTp03UcZcNcdPG4xNV1MHrOPGY9Ukak9Sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeLRWRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeLRWRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:17:30 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63EEB217D9;
        Tue, 18 Dec 2018 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171449;
        bh=wPmZCRcuPajVxY0A5Yqjzwpa8TBaru9F2GaBl6lZTPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9A39saO6vj8f/xZS5gOLLFQoNl4276tqSVlZaDC5968iyCTOWowGUzV050FCDGHn
         9JHAQadfEVfx+a6ETnqThVgjI1/bHsDSoEBN36VgthUwaPy4p5orB6hES+3mAf6efa
         awANdxWsW0eCU5zJWpPamIdjshclv4xraviLHcu8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 60/63] perf beauty: Add generator for fadvise64's 'advice' arg constants
Date:   Tue, 18 Dec 2018 19:07:30 -0300
Message-Id: <20181218220733.15839-61-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
	[0] = "NORMAL",
	[1] = "RANDOM",
	[2] = "SEQUENTIAL",
	[3] = "WILLNEED",
	[4] = "DONTNEED",
	[5] = "NOREUSE",
  };
  $

This has a hack wrt the s390 difference.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-tb7jguv01u8p570piq13eioh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fadvise.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tools/perf/trace/beauty/fadvise.sh

diff --git a/tools/perf/trace/beauty/fadvise.sh b/tools/perf/trace/beauty/fadvise.sh
new file mode 100755
index 000000000000..b15ae3875167
--- /dev/null
+++ b/tools/perf/trace/beauty/fadvise.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+
+printf "static const char *fadvise_advices[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+POSIX_FADV_(\w+)[[:space:]]+([[:digit:]]+)[[:space:]]+.*'
+
+egrep $regex ${header_dir}/fadvise.h | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n" | \
+	grep -v "[6].*DONTNEED" | grep -v "[7].*NOREUSE"
+printf "};\n"
+
+# XXX Fix this properly:
+
+# The grep 6/7 DONTNEED/NOREUSE are a hack to filter out the s/390 oddity See
+# tools/include/uapi/linux/fadvise.h for details.
+
+# Probably fix this when generating the string tables per arch so that We can
+# reliably process on arch FOO a perf.data file collected by 'perf trace
+# record' on arch BAR, e.g. collect on s/390 and process on x86.
-- 
2.19.2

