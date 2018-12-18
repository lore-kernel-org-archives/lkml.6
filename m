Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EB4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347CB218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171434;
	bh=2M3pmp2tmWd2z3xjT1IxORIucBG+cqy8RdO1DHtvUys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o7OFJYYM8cJ728dHetj7baByWkvS/J8qFJp4sdeM9IeLjSR0jHP2r9JceRTGv8K6P
	 GGV6e1qABl/uFoMYVOxsqkwcKQqZG8s8qzS1ZgQuOqEnzXJxM38QXXGjwMsZQPPTCN
	 OoHnILTsYB28ZmLMALh/ppu0RwmYGCro98m0Raio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeLRWRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:17:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeLRWRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:17:12 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF9D217D9;
        Tue, 18 Dec 2018 22:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171432;
        bh=2M3pmp2tmWd2z3xjT1IxORIucBG+cqy8RdO1DHtvUys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEmsrgUM5z6i9haoDmXCNjbYh2B2ZYEC83aA5Gtso396YjPUf/ShedjGg3T+eN3FS
         l0m6rptYupM/cyEZ5FcGXOA3FyP+RfvIJ0MOhAGzrvTRA1cwEktJb1RMVNeea13aKY
         L0xEYANExTGVY6KUHeJ1457Pht8TRHOR4Dmi3vNw=
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
Subject: [PATCH 58/63] perf beauty mmap: Print mmap's 'offset' arg in hexadecimal
Date:   Tue, 18 Dec 2018 19:07:28 -0300
Message-Id: <20181218220733.15839-59-acme@kernel.org>
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

Also to make it match 'strace' output, for regression testing.

Both now produce this option, when 'perf trace' uses a .perfconfig
asking for the strace like output:

  mmap(0x7faf66e6a000, 1363968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) = 0x7faf66e6a000

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-27qhouo1kaac2iyl85nfnsf5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2cc62ca75b2e..ebde59e61133 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -756,7 +756,8 @@ static struct syscall_fmt {
 	.alias = "old_mmap",
 #endif
 	  .arg = { [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
-		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ }, }, },
+		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ },
+		   [5] = { .scnprintf = SCA_HEX,	/* offset */ }, }, },
 	{ .name	    = "mount",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* dev_name */ },
 		   [3] = { .scnprintf = SCA_MOUNT_FLAGS, /* flags */
-- 
2.19.2

