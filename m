Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84BFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86AE218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479010;
	bh=DKSmXO+kDAIJEbDohw5My6vK4pdkjnewWC1gENYWWcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uaxw0HCGdpP20Rd/Gkiuuv7bn1MAGun0iaN25kEoovlY1+TlJBTPiL7YQCEwGNdf+
	 rdC79fLjCAx3edOS/AxKOW5Xw6wUCjR3vImeMpVRtuGKpWtb6FAppmedYhri91HBcU
	 hfsks4VAk5yBZfYbF3qAziVY8OFrGAVJ2p8/aRnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfBFSuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfBFSuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:50:05 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A1C218D4;
        Wed,  6 Feb 2019 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479004;
        bh=DKSmXO+kDAIJEbDohw5My6vK4pdkjnewWC1gENYWWcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=siBsDCfU77iU2RceMfM86/9+EpwAD1T35b78YsdKbA1w3h76y6fImxDo1Iy/955bP
         as28768ISoZp71W2O+LGW6Ts0ZgKd2YGvAxlLFHtDcG4pCyM7Usc+dNsnwfo7N4vkX
         5gwDTns67/GarK0jsbBhX5eaH2ECrXAbrQVo1fvU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 19/53] perf bpf-loader: Remove unecessary includes from bpf-loader.h
Date:   Wed,  6 Feb 2019 15:48:29 -0300
Message-Id: <20190206184903.24054-20-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To cut the header dep tree, to get unecessary object rebuilds to be
reduced when a change happens in headers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ph72xhl9moqa0g1hxcyudwfn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 1 +
 tools/perf/util/bpf-loader.h | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 2f3eb6d293ee..6e68698aa0ad 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include "perf.h"
 #include "debug.h"
+#include "evlist.h"
 #include "bpf-loader.h"
 #include "bpf-prologue.h"
 #include "probe-event.h"
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 62d245a90e1d..3f46856e3330 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -8,11 +8,7 @@
 
 #include <linux/compiler.h>
 #include <linux/err.h>
-#include <string.h>
 #include <bpf/libbpf.h>
-#include "probe-event.h"
-#include "evlist.h"
-#include "debug.h"
 
 enum bpf_loader_errno {
 	__BPF_LOADER_ERRNO__START = __LIBBPF_ERRNO__START - 100,
@@ -44,6 +40,7 @@ enum bpf_loader_errno {
 };
 
 struct perf_evsel;
+struct perf_evlist;
 struct bpf_object;
 struct parse_events_term;
 #define PERF_BPF_PROBE_GROUP "perf_bpf_probe"
@@ -87,6 +84,8 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
 int bpf__strerror_setup_output_event(struct perf_evlist *evlist, int err, char *buf, size_t size);
 #else
 #include <errno.h>
+#include <string.h>
+#include "debug.h"
 
 static inline struct bpf_object *
 bpf__prepare_load(const char *filename __maybe_unused,
-- 
2.20.1

