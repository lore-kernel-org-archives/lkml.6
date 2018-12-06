Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7D7C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5B42146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131757;
	bh=ITO8IADVekSRkSvaJwj5tE6WRlMX/EnMIazWQeS1x0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zw+Fe+tSgX3+1ttAX+sfiSuxAXsTV5YB4MK3bDmIxuY+xv24slYUK7LY1cGeGC8l7
	 E3uroOsxRPH2O/fowErrD6MRoHtch4GeGDpGeHCPCIExd77AsD8RjRMtMo12YSuNCC
	 y02pI6jh8rVurQvwagSoLJ7SecqrXiMMt3oDTCGI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5B42146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeLFV3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:29:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbeLFV3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:29:13 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF9712082B;
        Thu,  6 Dec 2018 21:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131753;
        bh=ITO8IADVekSRkSvaJwj5tE6WRlMX/EnMIazWQeS1x0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILy8B/byiqndY1D1w8Av3w8rPFsd+BzU3zBoZB3RGuV/+xiCit8tMyCDxNye1Oj52
         jlB/IgRcgt7aCJW0NeKkxj58B+SYSpCT+SFtM9qfMyk5wefXkpgHfzINPj5BybbiPy
         jUAQtNOayJlQhTi6sb6sNeFd3oHP21DNCH4CduTo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 40/75] perf bpf-loader: Fix debugging message typo
Date:   Thu,  6 Dec 2018 18:25:27 -0300
Message-Id: <20181206212602.20474-41-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease cherry
picking and/or backporting, split this into multiple patches.

This one has information that is presented to the user, albeit in debug
mode.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 9a280647d829..2f3eb6d293ee 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -99,7 +99,7 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 			if (err)
 				return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
 		} else
-			pr_debug("bpf: successfull builtin compilation\n");
+			pr_debug("bpf: successful builtin compilation\n");
 		obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, filename);
 
 		if (!IS_ERR_OR_NULL(obj) && llvm_param.dump_obj)
-- 
2.19.2

