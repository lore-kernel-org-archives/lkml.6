Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5247AC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14503218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458355;
	bh=GVInxEXPqdbHletbFKoHwzHR4WmF5GmRIMBtOB5UirQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XDk4qytCoGBtCkpjp7VJX2nLpsob8gO63XwweFFnzjkZzgPR0l5m/PJC2LUnrJPX1
	 HqIOblsYoDlwnYY1wXf6vrkRsyy3UO4bcqvqAN2snirV6WrMcZamHjqaoG1rVJvwSh
	 Nbxitbz4Ey1oDZmE7U0RoRR2ofUPEx5nf+OsUodI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfAYXTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbfAYXTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:09 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B48C20844;
        Fri, 25 Jan 2019 23:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458349;
        bh=GVInxEXPqdbHletbFKoHwzHR4WmF5GmRIMBtOB5UirQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UiFu6Q0ztA33JEKP1kjZ0uBiPBiFXuw2uf/2LynibVNacw4Qo8LcX9UZSxLGoUfnb
         66g3cOy6MKIwHut3TUNPEPqIU2yY0NcUdlsnAAD1L3QC/mF75cV1akGcBKALC0UJ9X
         8hx3Hjj1/m1C1OzRjE3pH2sVMp6agaEb5iFxn7UI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 09/29] perf callchain: No need to include perf.h
Date:   Sat, 26 Jan 2019 00:18:23 +0100
Message-Id: <20190125231843.2895-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So ditch it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bodhwdvcds9ahk26dy4w8m71@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 99d38ac019b8..8afe1622edf3 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -2,7 +2,6 @@
 #ifndef __PERF_CALLCHAIN_H
 #define __PERF_CALLCHAIN_H
 
-#include "../perf.h"
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include "event.h"
-- 
2.20.1

