Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00C1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA3D218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478999;
	bh=uxoszMB0spLSOFcPexmRbI0KcXQo5yVIcPRAlYJciMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zi/QgNLV6Lgd5Q668nvNYuYxGWEBz2FOO0m6l9pnvi5Zcb+Y5uizVKSiL0NLRyAwQ
	 v39VUXdY8wbYb3eI3px1h9VxKSPlLJsRd9VrkkSkl0QcLeLhVjeiVrsx8DC24byWB3
	 jqcFakMmMkgV4iAQ/KHw2CGPbyuF8GokjpA9IxM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfBFSt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:49:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbfBFStz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:55 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B1002186A;
        Wed,  6 Feb 2019 18:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478995;
        bh=uxoszMB0spLSOFcPexmRbI0KcXQo5yVIcPRAlYJciMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1yyeO/TMWQxkVxYHtGF5sq6BGB2SQaIOWq0dmxPV9OZHuCn5hBhBmliL8GuXGikBa
         QRqAVDKPlU5ZCsT2NODCoxmLerzyeeKOHnDPOleb+hKtvKaWpBOtmzaV8qXdKzX4CO
         aSEPowR+lw20TKXDrjOSEvZx9Y+zU8wUmQNJsOMM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 15/53] perf tests pmu: Add missing headers
Date:   Wed,  6 Feb 2019 15:48:25 -0300
Message-Id: <20190206184903.24054-16-acme@kernel.org>
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

It needs the definitions for PATH_MAX and snprintf, was getting it
by luck from headers it included and that are now being sanitized.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7bbh3kk0h5mywvfqm64nhv28@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 7bedf8608fdd..14a78898d79e 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -4,7 +4,9 @@
 #include "util.h"
 #include "tests.h"
 #include <errno.h>
+#include <stdio.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 
 /* Simulated format definitions. */
 static struct test_format {
-- 
2.20.1

