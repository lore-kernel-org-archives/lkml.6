Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7871FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C99222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550061189;
	bh=UrOo8NQR9LYtpN+bNYVSY18sb8a42uyFKXmzchnm+7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NkesN96d7uyO1GspGyCCldPAZuC5irBgGu1aWciygnPNJLGhGROh1q5bYae1zv+X8
	 sT0ZJLMCo/2yOGfCorcR/ZUb+ygC0BeP/l2cRjN37V9NdKzBdo2Wbce71kgYQ+S9Z4
	 esiPsz2kLVt+xPwRtQp+6I5j+zXuODSx6W/qN+o0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404190AbfBMMdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:33:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392099AbfBMMdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:33:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3098181E06;
        Wed, 13 Feb 2019 12:33:03 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA1C160856;
        Wed, 13 Feb 2019 12:33:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 08/10] perf header: Remove cpu_nr from struct cpu_topo
Date:   Wed, 13 Feb 2019 13:32:44 +0100
Message-Id: <20190213123246.4015-9-jolsa@kernel.org>
In-Reply-To: <20190213123246.4015-1-jolsa@kernel.org>
References: <20190213123246.4015-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 13 Feb 2019 12:33:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not used.

Link: http://lkml.kernel.org/n/tip-f39nvd0w3xr7c3xugz6bosk5@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/header.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 06e11e9ad05e..c66f26ec557a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -563,7 +563,6 @@ static int write_cmdline(struct feat_fd *ff,
 	"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list"
 
 struct cpu_topo {
-	u32 cpu_nr;
 	u32 core_sib;
 	u32 thread_sib;
 	char **core_siblings;
@@ -679,7 +678,6 @@ static struct cpu_topo *build_cpu_topology(void)
 		goto out_free;
 
 	tp = addr;
-	tp->cpu_nr = nr;
 	addr += sizeof(*tp);
 	tp->core_siblings = addr;
 	addr += sz;
-- 
2.17.2

