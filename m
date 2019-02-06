Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0133AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C044F206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478982;
	bh=zDxBMNXPW1mSUZTTpxcckJ2BWTXf59gUNDJx8xkpxPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gd4LreZ7vqDZm8IgAeAodVxy8OZdMwtKGaI0FNzgLmRb3kT0WjAFUPzd7RwnI0QWJ
	 4b/Dkp5lh2gQDlLyNPj+L4wVqgQ6oKnaazO/PcQHONxPAW95bvQWVFEC94aRB0AksW
	 c+oZmCs3yP5Zm/z7ysJIJ3a8tfYu/atsDD3dwjC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBFStl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:49:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfBFStj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:39 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E43D2186A;
        Wed,  6 Feb 2019 18:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478978;
        bh=zDxBMNXPW1mSUZTTpxcckJ2BWTXf59gUNDJx8xkpxPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lumnVVO5InMKD6yA274+xJxgvW1FMleNovG+dyoWYIf0HX1wGhLYWsSF6bV3VW5cJ
         UNjZtRnaEvkxXZbpug1vPznbttfhEQdeE+BUTBLeumr59JCve8PLPItF63LcfGnO1U
         QrQkWmAhqCahqwAAEzhXcRjvXBLRBNfxnMpc+RJk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 08/53] perf tests: Add missing headers so far obtained indirectly
Date:   Wed,  6 Feb 2019 15:48:18 -0300
Message-Id: <20190206184903.24054-9-acme@kernel.org>
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

We're going to remove symbol.h from some places and this breaks
some of the perf tests, fix it by adding the required includes.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wpa4b6x0btpnh2kjxzl9no4w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sample-parsing.c | 2 ++
 tools/perf/tests/sdt.c            | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 0e2d00d69e6e..236ce0d6c826 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdbool.h>
 #include <inttypes.h>
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 
+#include "branch.h"
 #include "util.h"
 #include "event.h"
 #include "evsel.h"
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 5059452d27dd..8bfaa630389c 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -3,6 +3,7 @@
 #include <stdio.h>
 #include <sys/epoll.h>
 #include <util/evlist.h>
+#include <util/symbol.h>
 #include <linux/filter.h>
 #include "tests.h"
 #include "debug.h"
-- 
2.20.1

