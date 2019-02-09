Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AA0C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA8F218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfBIM2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:28:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfBIM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:28:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CS2gw2627423
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:28:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CS1el2627420;
        Sat, 9 Feb 2019 04:28:01 -0800
Date:   Sat, 9 Feb 2019 04:28:01 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-j1nyksegpnz36wi3qx2p46i1@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com,
        namhyung@kernel.org, jolsa@kernel.org, hpa@zytor.com,
        sukadev@linux.vnet.ibm.com, mingo@kernel.org,
        adrian.hunter@intel.com, naveen.n.rao@linux.vnet.ibm.com,
        maynard@us.ibm.com, acme@redhat.com, sandipan@linux.ibm.com,
        tglx@linutronix.de
Reply-To: sandipan@linux.ibm.com, acme@redhat.com, maynard@us.ibm.com,
          tglx@linutronix.de, namhyung@kernel.org,
          ravi.bangoria@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
          adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
          jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf powerpc: Add missing headers to
 skip-callchain-idx.c
Git-Commit-ID: d6e4ae499f25729c440714b0d902ed245a67c18f
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

Commit-ID:  d6e4ae499f25729c440714b0d902ed245a67c18f
Gitweb:     https://git.kernel.org/tip/d6e4ae499f25729c440714b0d902ed245a67c18f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 6 Feb 2019 09:55:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf powerpc: Add missing headers to skip-callchain-idx.c

It uses several structs but don't explicitely includes the headers where
they are defined, getting them by sheer luck from one of the headers it
includes, since those are being streamlined to avoid unnecessary
rebuilds when changes are made to a random header, they will break, fix
them now so that they continue to build.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Maynard Johnson <maynard@us.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/n/tip-j1nyksegpnz36wi3qx2p46i1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 7c6eeb4633fe..2918bb16c892 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -16,6 +16,9 @@
 #include "util/thread.h"
 #include "util/callchain.h"
 #include "util/debug.h"
+#include "util/dso.h"
+#include "util/map.h"
+#include "util/symbol.h"
 
 /*
  * When saving the callchain on Power, the kernel conservatively saves
