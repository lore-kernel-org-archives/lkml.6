Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6FDC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1EF222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550061208;
	bh=JuudGN5LNIH5IjhqBQxD3Dv/iX89GEMo0eQjEGRNPk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C7zYQ7+pxNlQVejM5UK7pXancNrB5VRNgrcItqdkivmwKS+NkxFofe8Us/yNFwxPl
	 PUfM25vBfWLMYsmrCXudMKgzBjEdPt4HaRRC93h7VoJFDhN04mimdnTRoQ8P8q8oDN
	 EaPTqN26Amww0WV4hh3cPlg0RT0p0r+CHwNrnduM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392116AbfBMMd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:33:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392093AbfBMMdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:33:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E70C4CE84;
        Wed, 13 Feb 2019 12:33:01 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D53B860857;
        Wed, 13 Feb 2019 12:32:59 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 07/10] perf header: Get rid of write_it label
Date:   Wed, 13 Feb 2019 13:32:43 +0100
Message-Id: <20190213123246.4015-8-jolsa@kernel.org>
In-Reply-To: <20190213123246.4015-1-jolsa@kernel.org>
References: <20190213123246.4015-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 13 Feb 2019 12:33:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And simplify the code a bit.

Link: http://lkml.kernel.org/n/tip-0sck74jqk84u60i37wychoec@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/header.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7bebf9a34edd..06e11e9ad05e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1042,11 +1042,9 @@ static int write_cpuid(struct feat_fd *ff,
 	int ret;
 
 	ret = get_cpuid(buffer, sizeof(buffer));
-	if (!ret)
-		goto write_it;
+	if (ret)
+		return -1;
 
-	return -1;
-write_it:
 	return do_write_string(ff, buffer);
 }
 
-- 
2.17.2

